SHOW SERVICES;

USE ROLE TEST_ROLE;

SELECT SYSTEM$GET_SERVICE_STATUS('service-name');

ALTER SERVICE service-name SUSPEND;

ALTER SERVICE  service-name  RESUME;

drop SERVICE service-name;

USE ROLE ACCOUNTADMIN;

show compute pools;

ALTER compute pool tutorial_compute_pool SUSPEND;

ALTER compute pool tutorial_compute_pool RESUME;

drop compute pool tutorial_compute_pool;



