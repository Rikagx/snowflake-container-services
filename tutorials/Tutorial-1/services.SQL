-- create service (make sure to stage file first)

CREATE SERVICE echo_service
  IN COMPUTE POOL tutorial_compute_pool
  FROM @tutorial_stage
  SPECIFICATION_FILE='echo_spec.yaml'
  MIN_INSTANCES=1
  MAX_INSTANCES=1;

SHOW SERVICES;
SELECT SYSTEM$GET_SERVICE_STATUS('echo_service');
DESCRIBE SERVICE echo_service;

-- create a UDF to communicate with service
CREATE FUNCTION my_echo_udf (text varchar)
  RETURNS varchar
  SERVICE=echo_service
  ENDPOINT=echoendpoint
  AS '/echo';

/* 
The SERVICE property associates the UDF with the echo_service service.
The ENDPOINT property associates the UDF with the echoendpoint endpoint within service.
AS ‘/echo’ specifies the HTTP path to the Echo server. You can find this path in the service code (echo_service.py).

*/