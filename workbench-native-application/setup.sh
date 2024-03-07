# ---- Add Docker image to Snowflake

# Build/pull and tag an image for the linux/amd64 platform
# Upload the image to the Snowflake image repository that is created in producer.sql
# For the <repository_url>, use the SHOW IMAGE REPOSITORIES SQL command to get the repository URL.

-- docker build ./images --platform linux/amd64 -t workbench:latest
-- docker pull rstudio/rstudio-workbench
-- SHOW IMAGE REPOSITORIES;
### example url: duloftf-posit-software-pbc.registry.snowflakecomputing.com/pro/app/img
docker tag workbench:latest duloftf-posit-software-pbc.registry.snowflakecomputing.com/pro/app/img/workbench:latest
-- select SYSTEM$REGISTRY_LIST_IMAGES( '/PRO/APP/IMG');

# to upload an image on your behalf to your repository, you need to first authenticate with Docker
# For the <registry_hostname>, use the SHOW IMAGE REPOSITORIES SQL command above to get the repository URL. 
# The hostname in the URL is the registry hostname, for example, duloftf-posit-software-pbc.registry.snowflakecomputing.com
# <username> is your Snowflake username. Docker will prompt you for your password.
docker login <registry_hostname> -u <username>

# If you are using SnowCLI instead of Docker, run the following:
snow registry token --format JSON | docker login <registry-hostname> -u 0sessiontoken --password-stdin

docker push <repository_url>/workbench:latest
