CREATE TYPE cdb_observatory.ds_fdw_metadata as (schemaname text, tabname text, servername text);
CREATE TYPE cdb_observatory.ds_return_metadata as (colnames text[], coltypes text[]);

CREATE OR REPLACE FUNCTION cdb_observatory._OBS_ConnectUserTable(username text, orgname text, user_db_role text, input_schema text, dbname text, host_addr text, table_name text)
RETURNS cdb_observatory.ds_fdw_metadata
AS $$
DECLARE
  fdw_server text;
  fdw_import_schema text;
  connection_str json;
  import_foreign_schema_q text;
  epoch_timestamp text;
BEGIN

  SELECT extract(epoch from now() at time zone 'utc')::int INTO epoch_timestamp;
  fdw_server := 'fdw_server_' || username || '_' || epoch_timestamp;
  fdw_import_schema:= fdw_server;

  -- Import foreign table
  EXECUTE FORMAT ('SELECT cdb_observatory._OBS_ConnectRemoteTable(%L, %L, %L, %L, %L, %L, %L)', fdw_server, fdw_import_schema, dbname, host_addr, user_db_role, table_name, input_schema);

  RETURN (fdw_import_schema::text, table_name::text, fdw_server::text);

EXCEPTION
  WHEN others THEN
    -- Disconnect user imported table. Delete schema and FDW server.
    EXECUTE 'DROP FOREIGN TABLE IF EXISTS ' || fdw_import_schema || '.' || table_name;
    EXECUTE 'DROP SCHEMA IF EXISTS ' || fdw_import_schema || ' CASCADE';
    EXECUTE 'DROP SERVER IF EXISTS ' || fdw_server || ' CASCADE;';
    RETURN (null, null, null);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION cdb_observatory._OBS_GetReturnMetadata(username text, orgname text, function_name text, params json)
RETURNS cdb_observatory.ds_return_metadata
AS $$
DECLARE
  colnames text[];
  coltypes text[];
BEGIN
  EXECUTE FORMAT('SELECT r.colnames::text[], r.coltypes::text[] FROM cdb_observatory._%sResultMetadata(%L::json) r', function_name, params::text)
  INTO colnames, coltypes;

  RETURN (colnames::text[], coltypes::text[]);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cdb_observatory._OBS_GetMeasureResultMetadata(params json)
RETURNS cdb_observatory.ds_return_metadata
AS $$
DECLARE
  colnames text[]; -- Array to store the name of the measures to be returned
  coltypes text[]; -- Array to store the type of the measures to be returned
  requested_measures text[];
  measure_id text;
BEGIN
  -- By definition, all the measure results for the OBS_GetMeasure API are numeric values
    SELECT ARRAY(SELECT json_array_elements_text(params->'measure_id'))::text[] INTO requested_measures;

  FOREACH measure_id IN ARRAY requested_measures
  LOOP
    SELECT array_append(colnames, measure_id) INTO colnames;
    SELECT array_append(coltypes, 'numeric'::text) INTO coltypes;
  END LOOP;

  RETURN (colnames::text[], coltypes::text[]);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cdb_observatory._OBS_FetchJoinFdwTableData(username text, orgname text, table_schema text, table_name text, function_name text, params json)
RETURNS SETOF record
AS $$
DECLARE
  data_query text;
  rec RECORD;
BEGIN

    IF function_name ILIKE 'OBS_GetMeasure' THEN
        SELECT cdb_observatory._OBS_GetMeasureQuery(table_schema, table_name, params) INTO data_query;
    ELSE
        RAISE 'Function not supported';
    END IF;


    FOR rec IN EXECUTE data_query
    LOOP
        RETURN NEXT rec;
    END LOOP;
  RETURN;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION cdb_observatory._OBS_GetMeasureQuery(table_schema text, table_name text, params json)
RETURNS text
AS $$
DECLARE
  data_query text;
  measure_ids_arr text[];
  measure_id text;
  measures_list text;
  measures_query text;
  normalize text;
  boundary_id text;
  time_span text;
  geom_table_name text;
  data_table_name text;
BEGIN
    measures_query := '';
    -- SELECT table_name from obs_meta WHERE boundary_id = {bound} AND [...] INTO geom_table_name
    geom_table_name := 'observatory.obs_c6fb99c47d61289fbb8e561ff7773799d3fcc308';
    -- SELECT table_name from obs_meta WHERE time_span = {time} AND [...] INTO data_table_name
    data_table_name := 'observatory.obs_1a098da56badf5f32e336002b0a81708c40d29cd';

    -- Get measure_ids array from JSON
    SELECT ARRAY(SELECT json_array_elements_text(params->'measure_id'))::text[] INTO measure_ids_arr;

    -- Get a comma-separated list of measures ("total_pop, over_16_pop") to be used in SELECTs
    SELECT array_to_string(measure_ids_arr, ',') INTO measures_list;

    FOREACH measure_id IN ARRAY measure_ids_arr
    LOOP
      -- Build query to compute each value and normalize
      -- Assumes the default normalization method, the normalize parameter given in the JSON
      -- should be checked in order to build the final query
      SELECT measures_query || ' sum(' || measure_id || '/fraction)::numeric as ' || measure_id || ', ' INTO measures_query;
    END LOOP;

    -- Data query should select the measures and the cartodb_id of the user table, in that order.
    data_query := '(WITH _areas AS(SELECT ST_Area(a.the_geom::geography)'
        || '/ (1000 * 1000) as fraction, a.geoid, b.cartodb_id FROM '
        || geom_table_name || ' as a, '
        || table_schema || '.' || table_name || ' AS b '
        || 'WHERE b.the_geom && a.the_geom ), values AS (SELECT geoid, '
        || measures_list
        || ' FROM ' || data_table_name || ' ) '
        || 'SELECT '
        || measures_query
        || ' cartodb_id::int FROM _areas, values '
        || 'WHERE values.geoid = _areas.geoid GROUP BY cartodb_id);';
    RETURN data_query;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cdb_observatory._OBS_DisconnectUserTable(username text, orgname text, table_schema text, table_name text, servername text)
RETURNS boolean
AS $$
BEGIN
    EXECUTE 'DROP FOREIGN TABLE IF EXISTS "' || table_schema || '".' || table_name;
    EXECUTE 'DROP SCHEMA IF EXISTS ' || table_schema || ' CASCADE';
    EXECUTE 'DROP SERVER IF EXISTS ' || servername || ' CASCADE;';
    RETURN true;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
