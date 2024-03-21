## Pre-req
Create objects
pull/build, tag, and push image to repository from "how-to-scripts/build_tag_registry.sh"

## stage your spec file
```sql
PUT file://pro-product-deployment/Workbench/spec.yaml @tutorial_stage
  AUTO_COMPRESS=FALSE
  OVERWRITE=TRUE;
  ```

## create a service
```sql
CREATE SERVICE service-name
  IN COMPUTE POOL tutorial_compute_pool
  FROM @tutorial_stage
  SPECIFICATION_FILE='spec.yaml'
  MIN_INSTANCES=1
  MAX_INSTANCES=1;
```

## check and get endpoint
```sql
SHOW SERVICES;
SELECT SYSTEM$GET_SERVICE_STATUS('service-name');
CALL SYSTEM$GET_SERVICE_LOGS('TUTORIAL_DB.data_schema.r_ide', '0', 'rstudio', 1000);
```

