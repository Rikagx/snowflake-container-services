-- execute service
EXECUTE SERVICE
  IN COMPUTE POOL tutorial_compute_pool
  FROM @tutorial_stage
  SPEC='service_to_service_spec.yaml';

  SET job_id = last_query_id();
  CALL SYSTEM$GET_JOB_STATUS('<job_id returned by EXECUTE SERVICE>');
  CALL SYSTEM$GET_JOB_STATUS($job_id);
  CALL SYSTEM$GET_JOB_LOGS($job_id, 'main');