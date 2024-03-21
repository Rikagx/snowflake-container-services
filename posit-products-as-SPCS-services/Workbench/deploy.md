## Pre-req
Create objects from "how-to-scripts/create_objects.SQL"
pull/build, tag, and push image to repository from "how-to-scripts/build_tag_registry.sh"

## stage your spec file
```sql
PUT file://pro-product-deployment/Workbench/spec.yaml @tutorial_stage
  AUTO_COMPRESS=FALSE
  OVERWRITE=TRUE;
  ```

## create a service
```sql
CREATE SERVICE wb
  IN COMPUTE POOL tutorial_compute_pool3
  FROM @tutorial_stage
  SPECIFICATION_FILE='spec.yaml'
  MIN_INSTANCES=1
  MAX_INSTANCES=1;
```

## check and get endpoint
```sql
SHOW SERVICES;
SELECT SYSTEM$GET_SERVICE_STATUS('r_ide');
CALL SYSTEM$GET_SERVICE_LOGS('TUTORIAL_DB.data_schema.r_ide', '0', 'rstudio', 1000);
```

