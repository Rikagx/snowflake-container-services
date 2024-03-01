CREATE SCHEMA if not exists core;
CREATE APPLICATION ROLE if not exists app_user;

CREATE SCHEMA if not exists app_public;
GRANT USAGE ON SCHEMA app_public TO APPLICATION ROLE app_user;
CREATE OR REPLACE PROCEDURE app_public.start_app (pool_name varchar)
   RETURNS string
   LANGUAGE sql
   as $$
BEGIN
CREATE SERVICE core.wb
  IN COMPUTE POOL identifier(:pool_name)
  spec=spec.yaml;

/*CREATE OR REPLACE FUNCTION app_public.endpoint_url (TEXT VARCHAR)
    RETURNS varchar
    AS 'show endpoints in service core.wb' */

RETURN 'Service successfully created';
END;
$$;

GRANT USAGE ON PROCEDURE app_public.start_app(varchar) TO APPLICATION ROLE app_user;
/*GRANT USAGE ON PROCEDURE app_public.endpoint_url TO APPLICATION ROLE app_user; */