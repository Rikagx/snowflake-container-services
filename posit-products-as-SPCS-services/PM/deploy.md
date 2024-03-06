## Pre-req
Create objects from "how-to-scripts/create_objects.SQL"
pull/build, tag, and push image to repository from "how-to-scripts/build_tag_registry.sh"

## stage your spec file
```sql
PUT file://pro-product-deployment/PM/spec_pm.yaml @tutorial_stage
  AUTO_COMPRESS=FALSE
  OVERWRITE=TRUE;
  ```

## create a service
```sql
CREATE SERVICE rspm
  IN COMPUTE POOL compute_pool_pm
  FROM @tutorial_stage
  SPECIFICATION_FILE='spec_pm.yaml'
  MIN_INSTANCES=1
  MAX_INSTANCES=1;
```

## check and get endpoint
```sql
SHOW SERVICES;
SELECT SYSTEM$GET_SERVICE_STATUS('rspm');
DESCRIBE SERVICE rspm;
CALL SYSTEM$GET_SERVICE_LOGS('TUTORIAL_DB.data_schema.rspm', '0', 'pm', 1000);
```

asks me to signin to snowflake when going to endpoint
Sign in to Snowflake to continue to SNOWSERVICES_INGRESS_OAUTH (SnowServices Ingress)
status":"PENDING","message":"Unschedulable due to insufficient memory resources