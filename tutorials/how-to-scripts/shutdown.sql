SHOW SERVICES;

USE ROLE TEST_ROLE;

SELECT SYSTEM$GET_SERVICE_STATUS('r_ide');
SELECT SYSTEM$GET_SERVICE_STATUS('rsconnect');
SELECT SYSTEM$GET_SERVICE_STATUS('rspm');


ALTER SERVICE r_ide SUSPEND;
ALTER SERVICE rsconnect SUSPEND;
ALTER SERVICE rspm SUSPEND;


ALTER SERVICE  r_ide  RESUME;
ALTER SERVICE  rsconnect  RESUME;
ALTER SERVICE rspm  RESUME;

drop SERVICE r_ide;
drop SERVICE rsconnect;
drop SERVICE rspm;

USE ROLE ACCOUNTADMIN;

show compute pools;

ALTER compute pool tutorial_compute_pool SUSPEND;
ALTER compute pool compute_pool_connect SUSPEND;
ALTER compute pool compute_pool_pm SUSPEND;

ALTER compute pool tutorial_compute_pool RESUME;
ALTER compute pool compute_pool_connect RESUME;
ALTER compute pool compute_pool_pm RESUME;

drop compute pool tutorial_compute_pool;
drop compute pool compute_pool_pm;
drop compute pool compute_pool_pm;


