
-- Returns the table name with geoms for the given geometry_id
-- TODO probably needs to take in the column_id array to get the relevant
-- table where there is multiple sources for a column from multiple
-- geometries.
CREATE OR REPLACE FUNCTION cdb_observatory._OBS_GeomTable(
  geom geometry(Geometry, 4326),
  geometry_id text,
  time_span text DEFAULT NULL
)
  RETURNS TEXT
AS $$
DECLARE
  result text;
BEGIN
  EXECUTE '
    SELECT tablename FROM observatory.OBS_table
    WHERE id IN (
      SELECT table_id
      FROM observatory.OBS_table tab,
           observatory.OBS_column_table coltable,
           observatory.OBS_column col
      WHERE type ILIKE ''geometry''
        AND coltable.column_id = col.id
        AND coltable.table_id = tab.id
        AND col.id = $1
        AND CASE WHEN $3::TEXT IS NOT NULL THEN timespan ILIKE $3::TEXT ELSE TRUE END
      ORDER BY timespan DESC LIMIT 1
    )
    '
  USING geometry_id, geom, time_span
  INTO result;

  return result;

END;
$$ LANGUAGE plpgsql;



-- A function that gets the column data for multiple columns
-- Old: OBS_GetColumnData
CREATE OR REPLACE FUNCTION cdb_observatory._OBS_GetColumnData(
  geometry_id text,
  column_ids text[],
  timespan text
)
RETURNS SETOF JSON
AS $$
BEGIN

  -- figure out highest-weight geometry_id/timespan pair for the first data column
  -- TODO this should be done for each data column separately
  IF geometry_id IS NULL OR timespan IS NULL THEN
    EXECUTE '
      SELECT data_t.timespan timespan, geom_c.id boundary_id
      FROM observatory.obs_table data_t,
           observatory.obs_column_table data_ct,
           observatory.obs_column data_c,
           observatory.obs_column_table geoid_ct,
           observatory.obs_column_to_column c2c,
           observatory.obs_column geom_c
      WHERE data_c.id = $2
           AND data_ct.column_id = data_c.id
           AND data_ct.table_id = data_t.id
           AND geoid_ct.table_id = data_t.id
           AND geoid_ct.column_id = c2c.source_id
           AND c2c.reltype = ''geom_ref''
           AND geom_c.id = c2c.target_id
           AND CASE WHEN $3 IS NULL THEN True ELSE $3 = timespan END
           AND CASE WHEN $1 IS NULL THEN True ELSE $1 = geom_c.id END
      ORDER BY geom_c.weight DESC,
               data_t.timespan DESC
      LIMIT 1
    ' INTO timespan, geometry_id
    USING geometry_id, (column_ids)[1], timespan;
  END IF;

  RETURN QUERY
  EXECUTE '
  WITH geomref AS (
    SELECT ct.table_id id
    FROM observatory.OBS_column_to_column c2c,
         observatory.OBS_column_table ct
    WHERE c2c.reltype = ''geom_ref''
      AND c2c.target_id = $1
      AND c2c.source_id = ct.column_id
    ),
  column_ids as (
    select row_number() over () as no, a.column_id as column_id from (select unnest($2) as column_id) a
  )
 SELECT row_to_json(a) from (
   select  colname,
            tablename,
            aggregate,
            name,
            type,
            c.description,
            $1 AS boundary_id
           FROM column_ids, observatory.OBS_column c, observatory.OBS_column_table ct, observatory.OBS_table t
           WHERE column_ids.column_id  = c.id
             AND c.id = ct.column_id
             AND t.id = ct.table_id
             AND t.timespan = $3
             AND t.id in (SELECT id FROM geomref)
          order by column_ids.no
    ) a
 '
 USING geometry_id, column_ids, timespan
 RETURN;

END;
$$ LANGUAGE plpgsql;

--Test point cause Stuart always seems to make random points in the water
CREATE OR REPLACE FUNCTION cdb_observatory._TestPoint()
  RETURNS geometry(Point, 4326)
AS $$
BEGIN
  -- new york city
  RETURN ST_SetSRID(ST_Point( -73.936669, 40.704512), 4326);
END;
$$ LANGUAGE plpgsql;

--Test polygon cause Stuart always seems to make random points in the water
-- TODO: remove as it's not used anywhere?
CREATE OR REPLACE FUNCTION cdb_observatory._TestArea()
  RETURNS geometry(Geometry, 4326)
AS $$
BEGIN
  -- Buffer NYC point by 500 meters
  RETURN ST_Buffer(cdb_observatory._TestPoint()::geography, 500)::geometry;

END;
$$ LANGUAGE plpgsql;

--Used to expand a column based response to a table based one. Give it the desired
--columns and it will return a partial query for rolling them out to a table.
CREATE OR REPLACE FUNCTION cdb_observatory._OBS_BuildSnapshotQuery(names text[])
RETURNS TEXT
AS $$
DECLARE
  q text;
  i numeric;
BEGIN

  q := 'SELECT ';

  FOR i IN 1..array_upper(names,1)
  LOOP
    q = q || format(' vals[%s] As %I', i, names[i]);
    IF i < array_upper(names, 1) THEN
      q= q || ',';
    END IF;
  END LOOP;
  RETURN q;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cdb_observatory._OBS_GetRelatedColumn(columns_ids text[], reltype text )
RETURNS TEXT[]
AS $$
DECLARE
  result TEXT[];
BEGIN
  EXECUTE '
    With ids as (
      select row_number() over() as no, id from (select unnest($1) as id) t
    )
    select array_agg(target_id order by no)
    FROM  ids
    LEFT JOIN observatory.obs_column_to_column
    on  source_id  = id
    where reltype = $2 or reltype is null
  '
  INTO result
  using columns_ids, reltype;
  return result;
END;
$$ LANGUAGE plpgsql;

-- Function that replaces all non digits or letters with _ trims and lowercases the
-- passed measure name

CREATE OR REPLACE FUNCTION cdb_observatory._OBS_StandardizeMeasureName(measure_name text)
RETURNS text
AS $$
DECLARE
  result text;
BEGIN
  -- Turn non letter or digits to _
  result = regexp_replace(measure_name, '[^\dA-Za-z]+','_', 'g');
  -- Remove duplicate _'s
  result = regexp_replace(result,'_{2,}','_', 'g');
  -- Trim _'s from beginning and end
  result = trim(both  '_' from result);
  result = lower(result);
  RETURN result;
END;
$$ LANGUAGE plpgsql;

-- Function that returns the currently deployed obs_dump_version from the
-- remote table of the same name.

CREATE OR REPLACE FUNCTION cdb_observatory.OBS_DumpVersion(
)
  RETURNS TEXT
AS $$
DECLARE
  result text;
BEGIN
  EXECUTE '
    SELECT MAX(dump_id) FROM observatory.obs_dump_version
  ' INTO result;
  RETURN result;
END;
$$ LANGUAGE plpgsql;
