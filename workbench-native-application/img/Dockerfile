FROM rocker/verse:4.3.2

ADD odbc.ini /etc/odbc.ini
ADD odbcinst.ini /etc/odbcinst.ini
RUN apt update
RUN apt install -y unixodbc odbcinst1debian2
RUN wget https://sfc-repo.snowflakecomputing.com/odbc/linux/3.1.4/snowflake-odbc-3.1.4.x86_64.deb
RUN dpkg -i snowflake-odbc-3.1.4.x86_64.deb
RUN R -e "install.packages(c('DBI','odbc'), repos = 'https://cran.rstudio.com/')"