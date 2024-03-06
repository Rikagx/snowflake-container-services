CREATE APPLICATION ROLE IF NOT EXISTS nae_app_role;

CREATE SCHEMA IF NOT EXISTS utils;
CREATE SCHEMA IF NOT EXISTS services;

GRANT USAGE ON SCHEMA utils TO APPLICATION ROLE nae_app_role;
GRANT USAGE ON SCHEMA services TO APPLICATION ROLE nae_app_role;

CREATE OR REPLACE PROCEDURE utils.start_app(pool_name varchar, eai_name varchar)
RETURNS VARCHAR
LANGUAGE PYTHON
PACKAGES = ('snowflake-snowpark-python')
RUNTIME_VERSION = 3.9
HANDLER = 'main'
AS $$
def main(session, pool_name, eai_name):
    session.sql(f""" 
        CREATE SERVICE services.workbench
        IN COMPUTE POOL {pool_name}
        SPECIFICATION_FILE='spec.yaml'
        EXTERNAL_ACCESS_INTEGRATIONS = ({eai_name.upper()})
    """).collect()

    session.sql(f"GRANT USAGE ON SERVICE services.workbench TO APPLICATION ROLE nae_app_role").collect()
    session.sql(f"GRANT MONITOR ON SERVICE services.workbench TO APPLICATION ROLE nae_app_role").collect()

    return 'Service successfully created';
$$;

CREATE OR REPLACE PROCEDURE utils.get_endpoint()
  RETURNS TABLE()
  LANGUAGE SQL
  AS $$
    DECLARE
        res RESULTSET;
    BEGIN
        res := (SHOW ENDPOINTS IN SERVICE services.workbench);
        RETURN TABLE(res);
    END;
  $$;

GRANT USAGE ON PROCEDURE utils.start_app(varchar, varchar) TO APPLICATION ROLE nae_app_role;
GRANT USAGE ON PROCEDURE utils.get_endpoint() TO APPLICATION ROLE nae_app_role; 