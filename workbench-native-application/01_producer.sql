USE ROLE SECURITYADMIN;
CREATE ROLE NAE_PRODUCER_ROLE;
GRANT ROLE NAE_PRODUCER_ROLE TO ROLE SYSADMIN;

USE ROLE SYSADMIN;
CREATE DATABASE PRO;
CREATE WAREHOUSE PRO_WH
    WAREHOUSE_SIZE=XSMALL
    INITIALLY_SUSPENDED=TRUE;

USE ROLE SECURITYADMIN;
GRANT ALL PRIVILEGES ON DATABASE PRO TO ROLE NAE_PRODUCER_ROLE;
GRANT ALL PRIVILEGES ON WAREHOUSE PRO_WH TO ROLE NAE_PRODUCER_ROLE;

USE ROLE ACCOUNTADMIN;
GRANT CREATE APPLICATION PACKAGE ON ACCOUNT TO ROLE NAE_PRODUCER_ROLE;

USE ROLE NAE_PRODUCER_ROLE;
CREATE SCHEMA PRO.APP;
CREATE STAGE PRO.APP.PKG ENCRYPTION = (TYPE='SNOWFLAKE_SSE');
CREATE IMAGE REPOSITORY PRO.APP.IMG;

-- Go push your image to the PRO.APP.IMG repository
-- use setup.sh file

PUT file://pkg/manifest.yml @pro.app.pkg overwrite=true auto_compress=false;
PUT file://pkg/setup.sql @pro.app.pkg overwrite=true auto_compress=false;
PUT file://pkg/spec.yaml @pro.app.pkg overwrite=true auto_compress=false;

USE ROLE NAE_PRODUCER_ROLE;
CREATE APPLICATION PACKAGE NAE_APP_PKG;

USE ROLE NAE_PRODUCER_ROLE;
-- for recreating the application use the following commands to drop previous versions
--ALTER APPLICATION PACKAGE NAE_APP_PKG DROP VERSION "V0";
ALTER APPLICATION PACKAGE NAE_APP_PKG
  ADD VERSION "V0"
  USING @pro.app.pkg;

ALTER APPLICATION PACKAGE NAE_APP_PKG
  ADD VERSION "V1"
  USING @pro.app.pkg;

  ALTER APPLICATION PACKAGE NAE_APP_PKG
  ADD VERSION "V2"
  USING @pro.app.pkg;


