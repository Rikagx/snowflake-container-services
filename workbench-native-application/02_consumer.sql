USE ROLE SECURITYADMIN;
CREATE ROLE NAE_INSTALLER_ROLE;
GRANT ROLE NAE_INSTALLER_ROLE TO ROLE SYSADMIN;
-- WH created elsewhere
GRANT USAGE ON WAREHOUSE TUTORIAL_WAREHOUSE2 TO ROLE NAE_INSTALLER_ROLE;

USE ROLE ACCOUNTADMIN;
GRANT CREATE APPLICATION ON ACCOUNT TO ROLE NAE_INSTALLER_ROLE;
GRANT ALL PRIVILEGES ON APPLICATION PACKAGE NAE_APP_PKG TO ROLE NAE_INSTALLER_ROLE;

USE ROLE SYSADMIN;
CREATE COMPUTE POOL NAE
MIN_NODES=1
MAX_NODES=1
INSTANCE_FAMILY=CPU_X64_S;

USE ROLE SECURITYADMIN;
GRANT USAGE ON COMPUTE POOL NAE TO ROLE NAE_INSTALLER_ROLE;
GRANT MONITOR ON COMPUTE POOL NAE TO ROLE NAE_INSTALLER_ROLE;

USE ROLE NAE_INSTALLER_ROLE;
USE WAREHOUSE TUTORIAL_WAREHOUSE2;
-- drop the application first if you are recreating it or changing any pkg files
-- DROP APPLICATION NAE_APP;
CREATE APPLICATION NAE_APP
  FROM APPLICATION PACKAGE NAE_APP_PKG
  USING VERSION "V0";

USE ROLE SECURITYADMIN;
GRANT USAGE ON COMPUTE POOL NAE TO APPLICATION NAE_APP;

USE ROLE ACCOUNTADMIN;
-- integration has been created elsewhere in external_network.sh - this one is wide-open so only for testing purposes

GRANT USAGE ON INTEGRATION ALLOW_ALL_EAI TO APPLICATION NAE_APP;
GRANT BIND SERVICE ENDPOINT ON ACCOUNT TO APPLICATION NAE_APP;

USE ROLE NAE_INSTALLER_ROLE;
-- DESCRIBE COMPUTE POOL NAE;
CALL NAE_APP.UTILS.START_APP('NAE', 'ALLOW_ALL_EAI');
CALL NAE_APP.UTILS.GET_ENDPOINT();
SELECT SYSTEM$GET_SERVICE_STATUS('services.workbench');