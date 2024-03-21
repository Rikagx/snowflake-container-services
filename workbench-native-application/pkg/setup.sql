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
        SPECIFICATION_FILE='stage.yaml'
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


/* Create a Snowflake-based backend for Workbench metadata db
maybe create a second application role for stored procedure to create wb_backend

create db if not exists workbench_backend;
create schema if not exists workbench_backend.metadata; 
create schema if not exists workbench_backend.file_system;

create stage if not exists workbench_backend.file_system.stage_name ENCRYPTION = (TYPE='SNOWFLAKE_SSE');
grant all privileges on db workbench_backend to application role nae_app_role; 
# may need to grant usage on - db workbench_backend potentially squeeze perms over time

grant all privileges on schema workbench_backend.metadata application role nae_app_role; 
grant all privileges on schema workbench_backend.file_system to application role nae_app_role; 
grant all privilieges on stage workbench_backend.file_system.stage_name to application role nae_app_role; 

CREATE WAREHOUSE db
    WAREHOUSE_SIZE=XSMALL
    INITIALLY_SUSPENDED=TRUE;

grant all privileges to warhouse db application role nae_app_role;

# provide guidance for if objects already exist then the 
# when application is deleted, the ownershop of the db goes to the installer
# when application is reinstalled, need to grant all privileges to the application again 
# if these objects exist before app is installed, then all priv on these objects need to be granted on the application

*/