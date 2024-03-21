def get_login_token():
  with open('/snowflake/session/token', 'r') as f:
    return f.read()

conn = snowflake.connector.connect(
  host = os.getenv('SNOWFLAKE_HOST'),
  account = os.getenv('SNOWFLAKE_ACCOUNT'),
  token = get_login_token(),
  authenticator = 'oauth'
)


database=workbench_backend_db
schema=metadata


