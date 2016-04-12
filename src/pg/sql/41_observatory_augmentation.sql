
--For Longer term Dev


--Break out table definitions to types
--Automate type creation from a script, something like
----CREATE OR REPLACE FUNCTION OBS_Get<%=tag_name%>(geom GEOMETRY)
----RETURNS TABLE(
----<%=get_dimensions_for_tag(tag_name)%>
----AS $$
----DECLARE
----target_cols text[];
----names text[];
----vals numeric[];-
----q text;
----BEGIN
----target_cols := Array[<%=get_dimensions_for_tag(tag_name)%>],


--Functions for augmenting specific tables
--------------------------------------------------------------------------------

-- Creates a table of demographic snapshot
-- TODO: Remove since it does address geocoding?

CREATE OR REPLACE FUNCTION OBS_GetDemographicSnapshot(geom geometry)
RETURNS TABLE(
  total_pop NUMERIC,
  female_pop NUMERIC,
  male_pop NUMERIC,
  median_age NUMERIC,
  white_pop NUMERIC,
  black_pop NUMERIC,
  asian_pop NUMERIC,
  hispanic_pop NUMERIC,
  not_us_citizen_pop NUMERIC,
  workers_16_and_over NUMERIC,
  commuters_by_car_truck_van NUMERIC,
  commuters_by_public_transportation NUMERIC,
  commuters_by_bus NUMERIC,
  commuters_by_subway_or_elevated NUMERIC,
  walked_to_work NUMERIC,
  worked_at_home NUMERIC,
  children NUMERIC,
  households NUMERIC,
  population_3_years_over NUMERIC,
  in_school NUMERIC,
  in_grades_1_to_4 NUMERIC,
  in_grades_5_to_8 NUMERIC,
  in_grades_9_to_12 NUMERIC,
  in_undergrad_college NUMERIC,
  pop_25_years_over NUMERIC,
  high_school_diploma NUMERIC,
  bachelors_degree NUMERIC,
  masters_degree NUMERIC,
  pop_5_years_over NUMERIC,
  speak_only_english_at_home NUMERIC,
  speak_spanish_at_home NUMERIC,
  pop_determined_poverty_status NUMERIC,
  poverty NUMERIC,
  median_income NUMERIC,
  gini_index NUMERIC,
  income_per_capita NUMERIC,
  housing_units NUMERIC,
  vacant_housing_units NUMERIC,
  vacant_housing_units_for_rent NUMERIC,
  vacant_housing_units_for_sale NUMERIC,
  median_rent NUMERIC,
  percent_income_spent_on_rent NUMERIC,
  owner_occupied_housing_units NUMERIC,
  million_dollar_housing_units NUMERIC,
  mortgaged_housing_unit NUMERIC)
AS $$
DECLARE
 target_cols text[];
 names text[];
 vals numeric[];
 q text;
 BEGIN
 target_cols := Array[
                 'total_pop',
                 'female_pop',
                 'male_pop',
                 'median_age',
                 'white_pop',
                 'black_pop',
                 'asian_pop',
                 'hispanic_pop',
                 'not_us_citizen_pop',
                 'workers_16_and_over',
                 'commuters_by_car_truck_van',
                 'commuters_by_public_transportation',
                 'commuters_by_bus',
                 'commuters_by_subway_or_elevated',
                 'walked_to_work',
                 'worked_at_home',
                 'children',
                 'households',
                 'population_3_years_over',
                 'in_school',
                 'in_grades_1_to_4',
                 'in_grades_5_to_8',
                 'in_grades_9_to_12',
                 'in_undergrad_college',
                 'pop_25_years_over',
                 'high_school_diploma',
                 'bachelors_degree',
                 'masters_degree',
                 'pop_5_years_over',
                 'speak_only_english_at_home',
                 'speak_spanish_at_home',
                 'pop_determined_poverty_status',
                 'poverty',
                 'median_income',
                 'gini_index',
                 'income_per_capita',
                 'housing_units',
                 'vacant_housing_units',
                 'vacant_housing_units_for_rent',
                 'vacant_housing_units_for_sale',
                 'median_rent',
                 'percent_income_spent_on_rent',
                 'owner_occupied_housing_units',
                 'million_dollar_housing_units',
                 'mortgaged_housing_unit'
                ];

  q = 'WITH a As (
         SELECT
           dimension As names,
           dimension_value As vals
        FROM OBS_GetCensus($1,$2)
      )' ||
      OBS_BuildSnapshotQuery(target_cols) ||
      ' FROM  a';

  RETURN QUERY
  EXECUTE
    q
  USING geom, target_cols;

  RETURN;
END;
$$ LANGUAGE plpgsql;


--Base functions for performing augmentation
----------------------------------------------------------------------------------------


--Returns arrays of values for the given census dimension names for a given
--point or polygon
CREATE OR REPLACE FUNCTION OBS_GetCensus(
  geom geometry,
  dimension_names text[],
  time_span text DEFAULT '2009 - 2013',
  geometry_level text DEFAULT '"us.census.tiger".census_tract'
)
RETURNS TABLE(dimension text[], dimension_value numeric[])
AS $$
DECLARE
  ids text[];
BEGIN

  ids  = OBS_LookupCensusHuman(dimension_names);

  RETURN QUERY SELECT unnest(names), unnest(vals)
               FROM OBS_Get(geom, ids, time_span, geometry_level);
END;
$$ LANGUAGE plpgsql;



-- Base augmentation fucntion.
CREATE OR REPLACE FUNCTION OBS_Get(
  geom geometry,
  column_ids text[],
  time_span text,
  geometry_level text
)
RETURNS TABLE(names text[], vals NUMERIC[])
AS $$
DECLARE
  results numeric[];
  geom_table_name text;
  names text[];
  query text;
  data_table_info OBS_ColumnData[];
BEGIN

  geom_table_name := OBS_GeomTable(geom, geometry_level);

  IF geom_table_name IS NULL
  THEN
     RAISE EXCEPTION 'Point % is outside of the data region', geom;
  END IF;

  data_table_info := OBS_GetColumnData(geometry_level,
                                       column_ids,
                                       time_span);

  names := (SELECT array_agg((d).colname)
            FROM unnest(data_table_info) As d);

  IF ST_GeometryType(geom) = 'ST_Point'
  THEN
    results := OBS_GetPoints(geom,
                             geom_table_name,
                             data_table_info);

  ELSIF ST_GeometryType(geom) IN ('ST_Polygon', 'ST_MultiPolygon')
  THEN
    results := OBS_GetPolygons(geom,
                               geom_table_name,
                               data_table_info);
  END IF;

  IF results IS NULL
  THEN
    results := Array[];
  END IF;

  RETURN QUERY (SELECT names, results);
END;
$$ LANGUAGE plpgsql;


-- If the variable of interest is just a rate return it as such,
--  otherwise normalize it to the census block area and return that
CREATE OR REPLACE FUNCTION OBS_GetPoints(
  geom geometry,
  geom_table_name text,
  data_table_info OBS_ColumnData[]

) RETURNS NUMERIC[] AS $$
DECLARE
  result NUMERIC[];
  query  text;
  i int;
  geoid text;
  area  numeric;
BEGIN

  EXECUTE
    format('SELECT geoid
            FROM observatory.%I
            WHERE the_geom && $1',
            geom_table_name)
  USING geom
  INTO geoid;

  EXECUTE
    format('SELECT ST_Area(the_geom::geography) / (1000 * 1000)
            FROM observatory.%I
            WHERE geoid = %L',
            geom_table_name,
            geoid)
  INTO area;


  query := 'SELECT ARRAY[';
  FOR i IN 1..array_upper(data_table_info, 1)
  LOOP
    IF ((data_table_info)[i]).aggregate != 'sum'
    THEN
      query = query || format('%I ', ((data_table_info)[i]).colname);
    ELSE
      query = query || format('%I/%s ',
        ((data_table_info)[i]).colname,
        area);
    END IF;

    IF i <  array_upper(data_table_info, 1)
    THEN
      query = query || ',';
    END IF;
  END LOOP;

  query = query || format(' ]
    FROM observatory.%I
    WHERE %I.geoid  = %L
  ',
  ((data_table_info)[1]).tablename,
  ((data_table_info)[1]).tablename,
  geoid
  );

  EXECUTE
    query
  INTO result
  USING geom;

  RETURN result;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION OBS_GetPolygons (
  geom geometry,
  geom_table_name text,
  data_table_info OBS_ColumnData[]
) returns numeric[] AS $$
DECLARE
  result numeric[];
  q_select text;
  q_sum text;
  q text;
  i numeric;
BEGIN

  q_select := 'select geoid, ';
  q_sum    := 'select Array[';

  FOR i IN 1..array_upper(data_table_info, 1)
  LOOP
    q_select = q_select || format( '%I ', ((data_table_info)[i]).colname);

    IF ((data_table_info)[i]).aggregate ='sum'
    THEN
      q_sum    = q_sum || format('sum(overlap_fraction * COALESCE(%I, 0)) ',((data_table_info)[i]).colname,((data_table_info)[i]).colname);
    ELSE
      q_sum    = q_sum || ' null ';
    END IF;

    IF i < array_upper(data_table_info,1)
    THEN
      q_select = q_select || format(',');
      q_sum     = q_sum || format(',');
    END IF;
 END LOOP;

  q = format('
    WITH _overlaps As (
      SELECT ST_Area(
        ST_Intersection($1, a.the_geom)
      ) / ST_Area(a.the_geom) As overlap_fraction,
      geoid
      FROM observatory.%I As a
      WHERE $1 && a.the_geom
    ),
    values As (
    ', geom_table_name);

  q = q || q_select || format('FROM observatory.%I ', ((data_table_info)[1].tablename));

  q = q || ' ) ' || q_sum || ' ] FROM _overlaps, values
  WHERE values.geoid = _overlaps.geoid';

  EXECUTE
    q
  INTO result
  USING geom;

  RETURN result;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION OBS_GetSegmentSnapshot(
  geom geometry,
  geometry_level text DEFAULT '"us.census.tiger".census_tract'
 )
RETURNS TABLE(
  segment_name TEXT,
  total_pop_quantile Numeric,
  male_pop_quantile Numeric,
  female_pop_quantile Numeric,
  median_age_quantile Numeric,
  white_pop_quantile Numeric,
  black_pop_quantile Numeric,
  asian_pop_quantile Numeric,
  hispanic_pop_quantile Numeric,
  not_us_citizen_pop_quantile Numeric,
  workers_16_and_over_quantile Numeric,
  commuters_by_car_truck_van_quantile Numeric,
  commuters_by_public_transportation_quantile Numeric,
  commuters_by_bus_quantile Numeric,
  commuters_by_subway_or_elevated_quantile Numeric,
  walked_to_work_quantile Numeric,
  worked_at_home_quantile Numeric,
  children_quantile Numeric,
  households_quantile Numeric,
  population_3_years_over_quantile Numeric,
  in_school_quantile Numeric,
  in_grades_1_to_4_quantile Numeric,
  in_grades_5_to_8_quantile Numeric,
  in_grades_9_to_12_quantile Numeric,
  in_undergrad_college_quantile Numeric,
  pop_25_years_over_quantile Numeric,
  high_school_diploma_quantile Numeric,
  bachelors_degree_quantile Numeric,
  masters_degree_quantile Numeric,
  pop_5_years_over_quantile Numeric,
  speak_only_english_at_home_quantile Numeric,
  speak_spanish_at_home_quantile Numeric,
  pop_determined_poverty_status_quantile Numeric,
  poverty_quantile Numeric,
  median_income_quantile Numeric,
  gini_index_quantile Numeric,
  income_per_capita_quantile Numeric,
  housing_units_quantile Numeric,
  vacant_housing_units_quantile Numeric,
  vacant_housing_units_for_rent_quantile Numeric,
  vacant_housing_units_for_sale_quantile Numeric,
  median_rent_quantile Numeric,
  percent_income_spent_on_rent_quantile Numeric,
  owner_occupied_housing_units_quantile Numeric,
  million_dollar_housing_units_quantile Numeric

) AS $$
DECLARE
  target_cols text[];
  seg_name    Text;
  geom_id     Text;
  q           Text;
BEGIN
target_cols := Array[
          '"us.census.acs"."us.census.acs".B01001001_quantile',
          '"us.census.acs"."us.census.acs".B01001002_quantile',
          '"us.census.acs"."us.census.acs".B01001026_quantile',
          '"us.census.acs"."us.census.acs".B01002001_quantile',
          '"us.census.acs"."us.census.acs".B03002003_quantile',
          '"us.census.acs"."us.census.acs".B03002004_quantile',
          '"us.census.acs"."us.census.acs".B03002006_quantile',
          '"us.census.acs"."us.census.acs".B03002012_quantile',
          '"us.census.acs"."us.census.acs".B05001006_quantile',
          '"us.census.acs"."us.census.acs".B08006001_quantile',
          '"us.census.acs"."us.census.acs".B08006002_quantile',
          '"us.census.acs"."us.census.acs".B08006008_quantile',
          '"us.census.acs"."us.census.acs".B08006009_quantile',
          '"us.census.acs"."us.census.acs".B08006011_quantile',
          '"us.census.acs"."us.census.acs".B08006015_quantile',
          '"us.census.acs"."us.census.acs".B08006017_quantile',
          '"us.census.acs"."us.census.acs".B09001001_quantile',
          '"us.census.acs"."us.census.acs".B11001001_quantile',
          '"us.census.acs"."us.census.acs".B14001001_quantile',
          '"us.census.acs"."us.census.acs".B14001002_quantile',
          '"us.census.acs"."us.census.acs".B14001005_quantile',
          '"us.census.acs"."us.census.acs".B14001006_quantile',
          '"us.census.acs"."us.census.acs".B14001007_quantile',
          '"us.census.acs"."us.census.acs".B14001008_quantile',
          '"us.census.acs"."us.census.acs".B15003001_quantile',
          '"us.census.acs"."us.census.acs".B15003017_quantile',
          '"us.census.acs"."us.census.acs".B15003022_quantile',
          '"us.census.acs"."us.census.acs".B15003023_quantile',
          '"us.census.acs"."us.census.acs".B16001001_quantile',
          '"us.census.acs"."us.census.acs".B16001002_quantile',
          '"us.census.acs"."us.census.acs".B16001003_quantile',
          '"us.census.acs"."us.census.acs".B17001001_quantile',
          '"us.census.acs"."us.census.acs".B17001002_quantile',
          '"us.census.acs"."us.census.acs".B19013001_quantile',
          '"us.census.acs"."us.census.acs".B19083001_quantile',
          '"us.census.acs"."us.census.acs".B19301001_quantile',
          '"us.census.acs"."us.census.acs".B25001001_quantile',
          '"us.census.acs"."us.census.acs".B25002003_quantile',
          '"us.census.acs"."us.census.acs".B25004002_quantile',
          '"us.census.acs"."us.census.acs".B25004004_quantile',
          '"us.census.acs"."us.census.acs".B25058001_quantile',
          '"us.census.acs"."us.census.acs".B25071001_quantile',
          '"us.census.acs"."us.census.acs".B25075001_quantile',
          '"us.census.acs"."us.census.acs".B25075025_quantile'
               ];

    EXECUTE
      $query$
      select (categories)[1]
                      from OBS_GetCategories($1,Array['"us.census.spielman_singleton_segments".X10'])
                      limit 1
      $query$
    INTO segment_name

    USING geom;

    q =
      format( $query$
      WITH a As (
           SELECT
             names As names,
             vals As vals
          FROM OBS_Get($1,
                       $2,
                       '2009 - 2013',
                       $3)

        ), percentiles as (
           %s
         FROM  a)
        select $4, percentiles.*
          from percentiles
       $query$, OBS_BuildSnapshotQuery(target_cols) );

    RETURN QUERY
    EXECUTE
      q
    USING geom, target_cols, geometry_level, segment_name ;

END $$ LANGUAGE plpgsql  ;

--Get categorical variables from point

CREATE OR REPLACE FUNCTION OBS_GetCategories(
  geom geometry,
  dimension_names text[],
  geometry_level text DEFAULT '"us.census.tiger".census_tract',
  time_span text DEFAULT '2009 - 2013'
)
returns TABLE(names text[], categories text[]) as $$
DECLARE
  geom_table_name text;
  geoid text;
  names text[];
  results text[];
  query text;
  data_table_info OBS_ColumnData[];
BEGIN

  geom_table_name := OBS_GeomTable(geom, geometry_level);
  IF geom_table_name IS NULL
  THEN
     RAISE EXCEPTION 'Point % is outside of the data region', geom;
  END IF;

  data_table_info := OBS_GetColumnData(geometry_level,
                                       dimension_names,
                                       time_span);


  names := (SELECT array_agg((d).colname)
            FROM unnest(data_table_info) As d);


  EXECUTE
    format('SELECT geoid
            FROM observatory.%I
            WHERE the_geom && $1',
            geom_table_name)
  USING geom
  INTO geoid;

  query := 'SELECT ARRAY[';
  FOR i IN 1..array_upper(data_table_info, 1)
  LOOP
    query = query || format('%I ', lower(((data_table_info)[i]).colname));
    IF i <  array_upper(data_table_info, 1)
    THEN
      query = query || ',';
    END IF;
  END LOOP;

  query = query || format(' ]
    FROM observatory.%I
    WHERE %I.geoid  = %L
  ',
  ((data_table_info)[1]).tablename,
  ((data_table_info)[1]).tablename,
  geoid
  );

  EXECUTE
    query
  INTO results
  USING geom;

  RETURN QUERY
    select names,results
  RETURN;

END
$$ LANGUAGE plpgsql;