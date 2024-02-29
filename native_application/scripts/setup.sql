-- Setup script for the workbench application.
CREATE APPLICATION ROLE app_public;
CREATE SCHEMA IF NOT EXISTS core;
GRANT USAGE ON SCHEMA core TO APPLICATION ROLE app_public;

CREATE OR REPLACE WAREHOUSE tutorial_warehouse WITH
  WAREHOUSE_SIZE='X-SMALL'
  AUTO_SUSPEND = 180
  AUTO_RESUME = true
  INITIALLY_SUSPENDED=false;

CREATE COMPUTE POOL tutorial_compute_pool
  MIN_NODES = 1
  MAX_NODES = 1
  INSTANCE_FAMILY = standard_1;

CREATE DATABASE tutorial_db;

CREATE SECURITY INTEGRATION snowservices_ingress_oauth
  TYPE=oauth
  OAUTH_CLIENT=snowservices_ingress
  ENABLED=true;

CREATE OR REPLACE NETWORK RULE ALLOW_ALL_RULE
  TYPE = 'HOST_PORT'
  MODE = 'EGRESS'
  VALUES_LIST= ('0.0.0.0:443', '0.0.0.0:80');
CREATE EXTERNAL ACCESS INTEGRATION ALLOW_ALL_EAI
  ALLOWED_NETWORK_RULES = (ALLOW_ALL_RULE)
  ENABLED = true;
GRANT USAGE ON INTEGRATION ALLOW_ALL_EAI TO ROLE CONTAINER_USER_ROLE;

CREATE IMAGE REPOSITORY CONTAINER_HOL_DB.PUBLIC.IMAGE_REPO;

CREATE SERVICE wb
   IN COMPUTE POOL tutorial_compute_pool
   FROM SPECIFICATION $$
spec:
  container:
  - name: rstudio
    image: duloftf-posit-software-pbc.registry.snowflakecomputing.com/tutorial_db/data_schema/tutorial_repository/rstudio/rstudio-workbench:deploy
    env:
      RSW_LICENSE: ""
    resources:
      limits:
        memory: 16Gi
      requests:
        memory: 4Gi
  endpoint:
  - name: e1
    port: 8787
    public: true
  networkPolicyConfig:
    allowInternetEgress: true
   $$;

GRANT USAGE ON SERVICE wb TO APPLICATION ROLE app_public;
GRANT USAGE ON COMPUTE POOL tutorial_compute_pool TO APPLICATION ROLE app_public;
GRANT MONITOR ON COMPUTE POOL tutorial_compute_pool TO APPLICATION ROLE app_public;
GRANT ALL ON WAREHOUSE tutorial_warehouse TO ROLE test_role;
GRANT OWNERSHIP ON DATABASE tutorial_db TO ROLE test_role;

