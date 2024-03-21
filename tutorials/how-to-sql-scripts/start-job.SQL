-- to start a job

EXECUTE SERVICE
  IN COMPUTE POOL tutorial_compute_pool
  FROM @tutorial_stage
  SPEC='my_job_spec.yaml';

  -- get id of query
  SET jobid = LAST_QUERY_ID();

  -- run the job
  SELECT * FROM results;

  SELECT SYSTEM$GET_JOB_STATUS($jobid);
  SELECT SYSTEM$GET_JOB_LOGS($jobid, 'main')
