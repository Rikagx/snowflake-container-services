## Configure Pre-requisites

-   **A Snowflake account:** Note that trial accounts are not supported.
-   **SnowSQL:** the command-line client for executing SQL commands. You can use any Snowflake client that supports executing SQL commands and uploading files to a Snowflake stage. The tutorials are tested using the SnowSQL and the Snowsight web interface. For instructions to install this command-line client, see [Installing SnowSQL](https://docs.snowflake.com/en/user-guide/snowsql-install-config).
-   [**Docker Desktop**](https://docs.docker.com/get-docker/): Note that you can use any OCI-compliant clients to create images, such as Docker, Podman, or Nerdctl.
-   **Snowflake extension for VSCode (Optional):** enables you to connect to Snowflake, write and execute SQL queries, and view results without leaving VS Code.

## Terminology

**Snowpark Container Services (SPCS)** - is a fully managed container offering designed to facilitate the deployment, management, and scaling of containerized applications within the Snowflake ecosystem. This service enables users to run containerized workloads directly within Snowflake, ensuring that data doesn’t need to be moved out of the Snowflake environment for processing. Unlike traditional container orchestration platforms like Docker or Kubernetes, Snowpark Container Services offers an OCI runtime execution environment specifically optimized for Snowflake. (e.g. not K8s API but similar)

**SPCS Service** - A service is long-running and, like a web service, does not end automatically. After you create a service, Snowflake manages the running service.

**SPCS Job** - A job has a finite lifespan, similar to a stored procedure. When all of the job’s application containers exit, the job is considered complete.

**Native Application** - The Snowflake Native App Framework allows you to create data applications that leverage core Snowflake functionality such as SPCS, Snowpark, etc. After developing and testing an application package, a provider can share an application with consumers by publishing a listing containing the application package as the data product of a listing. The listing can be a Snowflake Marketplace listing or a private listing.

**Snowpark** - set of libraries and runtimes in Snowflake that securely deploy and process non-SQL code, including Python, Java, and Scala. On the client side, Snowpark consists of libraries, including the DataFrame API and native Snowpark machine learning (ML) APIs for model development and deployment. On the server side, runtimes include Python, Java, and Scala in the warehouse model or Snowpark Container Services . In the warehouse model, developers can leverage user-defined functions (UDFs) and stored procedures (sprocs) to bring in and run custom logic.

## Project Overview

## Helpful Links

-   [SPCS overview](https://docs.snowflake.com/en/LIMITEDACCESS/snowpark-containers/overview)

-   [SPCS tutorials](https://docs.snowflake.com/developer-guide/snowpark-container-services/tutorials/common-setup)

-   [Native App overview](https://docs.snowflake.com/en/developer-guide/native-apps/native-apps-about)

-   [Example of setting up workbench in SPCS](https://medium.com/snowflake/unlocking-machine-learning-potential-running-r-inside-snowpark-container-services-3ccdb2cac896)