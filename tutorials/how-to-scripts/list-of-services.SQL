# block storage
CREATE SERVICE block
  IN COMPUTE POOL tutorial_compute_pool
  FROM @specs
  SPECIFICATION_FILE='block.yaml'
  MIN_INSTANCES=1
  MAX_INSTANCES=1;