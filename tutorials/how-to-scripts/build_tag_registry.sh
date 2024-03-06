

docker build --rm --platform linux/amd64 -t my_image:tutorial
docker tag my_image:tutorial <repository_url>/<image_name>
-- Build an image for the linux/amd64 platform that Snowpark Container Services supports
-- upload the image to the image repository in your account
-- to upload an image on your behalf to your repository, you need to first authenticate with Docker

docker login login <registry_hostname> -u <username>
-- For the <repository_url>, use the SHOW IMAGE REPOSITORIES SQL command to get the repository URL.
-- For the <registry_hostname>, use the SHOW IMAGE REPOSITORIES SQL command to get the repository URL. 
-- The hostname in the URL is the registry hostname, for example, myorg-myacct.registry.snowflakecomputing.com.
-- <username> is your Snowflake username. Docker will prompt you for your password.

-- If you are using SnowCLI instead of Docker, run the following:
snow registry token --format JSON | docker login <registry-hostname> -u 0sessiontoken --password-stdin

docker push <repository_url>/<image_name>
