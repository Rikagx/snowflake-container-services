PUT file://manifest.yml @tutorial_database.tutorial_schema.tutorial_stage overwrite=true auto_compress=false;
PUT file://scripts/setup.sql @tutorial_database.tutorial_schema.tutorial_stage overwrite=true auto_compress=false;
PUT file://spec.yaml @tutorial_database.tutorial_schema.tutorial_stage overwrite=true auto_compress=false;

--DROP APPLICATION PACKAGE tutorial_package;

CREATE APPLICATION PACKAGE tutorial_package;
ALTER APPLICATION PACKAGE tutorial_package
  ADD VERSION "V1"
  USING @tutorial_database.tutorial_schema.tutorial_stage;

--ALTER APPLICATION PACKAGE tutorial_package DROP VERSION "V1";

--DROP APPLICATION IF EXISTS tutorial_app;
CREATE APPLICATION tutorial_app
  FROM APPLICATION PACKAGE tutorial_package
  USING VERSION "V1";

USE ROLE ACCOUNTADMIN;
GRANT BIND SERVICE ENDPOINT ON ACCOUNT TO APPLICATION tutorial_app;

GRANT USAGE ON COMPUTE POOL tutorial_compute_pool
  TO APPLICATION tutorial_app;

use role TUTORIAL_ROLE;
CALL tutorial_app.app_public.start_app('tutorial_compute_pool');
CALL tutorial_app.app_public.get_endpoint();

SELECT SYSTEM$GET_SERVICE_STATUS('core.wb');