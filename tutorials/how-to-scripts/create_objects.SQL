CREATE ROLE test_role;
GRANT ROLE test_role TO USER <username>;

ALTER USER <username> SET DEFAULT_ROLE = test_role;

CREATE COMPUTE POOL tutorial_compute_pool
  MIN_NODES = 1
  MAX_NODES = 1
  INSTANCE_FAMILY = standard_1;

GRANT USAGE ON COMPUTE POOL tutorial_compute_pool TO ROLE test_role;
GRANT MONITOR ON COMPUTE POOL tutorial_compute_pool TO ROLE test_role;

CREATE OR REPLACE WAREHOUSE tutorial_warehouse WITH
  WAREHOUSE_SIZE='X-SMALL'
  AUTO_SUSPEND = 180
  AUTO_RESUME = true
  INITIALLY_SUSPENDED=false;

GRANT ALL ON WAREHOUSE tutorial_warehouse TO ROLE test_role;

CREATE DATABASE tutorial_db;

GRANT OWNERSHIP ON DATABASE tutorial_db TO ROLE test_role;




USE ROLE test_role;
USE DATABASE tutorial_db;
USE WAREHOUSE tutorial_warehouse;

CREATE SCHEMA data_schema;

CREATE OR REPLACE IMAGE REPOSITORY tutorial_repository;

CREATE STAGE tutorial_stage DIRECTORY = ( ENABLE = true ); 

SHOW COMPUTE POOLS; --or DESCRIBE COMPUTE POOL tutorial_compute_pool;
SHOW WAREHOUSES;
SHOW IMAGE REPOSITORIES;
SHOW STAGES;