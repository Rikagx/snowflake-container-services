## Overall
will add license files as secrets
can we add config section in the spec file
no network ingress for jobs - maybe just use for the background jobs
can you connect cluster to external storage
how to join the container to your auth domain e.g. AD - or is this all through Snowflake Oauth - 
products need to installed with root

can you connect cluster to external postgresql db  (egress)

can you run an startup scripts when starting service?

need to convert values.yaml to spec.yaml 
https://github.com/rstudio/helm/tree/main/charts/rstudio-workbench#configuration-files

will these volume types work for us - https://docs.snowflake.com/en/LIMITEDACCESS/snowpark-containers/specification-reference#spec-volumes-field-optional


## Workbench
To run in a container it is required to run the base wb image as well as a session component (uses the launcher). Launcher integrates with Kubernetes so that any kind of session or job can be started in that external cluster. Does this happen in the compute pool?
Usually the session image is set in the /etc/rstudio/launcher.kubernetes.profiles.conf config file to use the K8s Job Launcher plugin
- 	Requires root in container, but container can be unprivileged
https://docs.posit.co/ide/server-pro/job_launcher/job_launcher.html


need to create a Kubernetes Persistent Volume Claim in order to specify mount points as appropriate to mount the users’ home drives and any other desired paths. In order for sessions to run properly within containers, it is required to mount the home directories into the containers, as well as any directories containing per-user state (e.g., a customized XDG_DATA_HOME). The home mount path within the container must be the same as the user’s home path as seen by the Posit Workbench instance itself (generally, /home/{USER}).

need to configure shared storage for loadbalanced sessions

worker nodes in compute pool need to be able to pull images

can you add any lightweight startup service - for example to provision users via sssd that runs once at startup and then sleeps forever

can you add pam?

```
/etc/rstudio/rserver.conf
launcher-address=localhost
launcher-port=5559
launcher-sessions-enabled=1
launcher-default-cluster=Kubernetes

# the callback address that launcher sessions will reconnect to rserver on
# since our Kubernetes jobs run on a different network segment, this needs
# to be the routable IP address of the web server servicing RStudio traffic
# (routable from the point of view of any Kubernetes nodes)
launcher-sessions-callback-address=http://10.15.44.30:8787

launcher-use-ssl=1
launcher-sessions-container-image=rstudio:R-4.2
launcher-sessions-container-run-as-root=0
launcher-sessions-create-container-user=1


-----
# /etc/rstudio/launcher.kubernetes.profiles.conf

[*]
default-cpus=1
default-mem-mb=512
max-cpus=2
max-mem-mb=1024
container-images=rstudio/r-session-complete:centos7-2023.09.1
default-container-image=rstudio/r-session-complete:centos7-2023.09.1
allow-unknown-images=0
```

## Connect
https://docs.snowflake.com/en/LIMITEDACCESS/snowpark-containers/additional-considerations-services-jobs#guidelines-and-limitations
https://support.posit.co/hc/en-us/articles/1500005369282-Posit-Professional-Product-Root-Privileged-Requirements

As of July 2022, only the RStudio Connect container uses the --privileged flag for user and code isolation and security and all other images can be run unprivileged.
service and job containers are not privileged - however, running privileged containers is required with Docker but not in K8s launcher

Requires K8s PVC to create data directory - if you can't then need to mount with a regular volume

## Package Manager

Requires K8s PVC to create data directory - if you can't then need to mount with a regular volume


when stopping and resuming services get a weird error - 000005 (XX000): Failed to get logs for container: rstudio. Error message: UNKNOWN, Container Status: UNKNOWN, Container Image: duloftf-posit-software-pbc.registry.snowflakecomputing.com/tutorial_db/data_schema/tutorial_repository/rstudio/rstudio-workbench:deploy - 
- this is because compute pool was still resuming - would be good to get a more helpful message

 ('nonce-...') is required to enable inline execution. Note that hashes do not apply to event handlers, style attributes and javascript: navigations unless the 'unsafe-hashes' keyword is present. Note also that 'style-src' was not explicitly set, so 'default-src' is used as a fallback. - causing the icons not to show up

 ran shiny app - only shows up in browser - launcher does not work, geyser plot doesnt show up
 content security policy of your site blocks resources

 can run scripts but always get an error that says status code 504 when executing dependencies - when downloading packages to open shiny app or markdown script

markdown doesnt show up in launcher window - but does show up when click open in browser - plots do not show up


publishing markdown -super slow - installing, curling, caching, using - takes about 20 minutes but does eventually publish

but may be due to size of instance which was default for testing - eventhough using cached binaries

starting up multiple sessions works well


when loading package caret - 

System has not been booted with systemd as init system (PID 1). Can't operate.
Failed to connect to bus: Host is down
Warning message:
In system("timedatectl", intern = TRUE) :
  running command 'timedatectl' had status 1

downloads are fast

can connect to snowflake database and write and read data!

can clone repos from git in terminal and in the UI

error when navigating across folders - screenshot


vscode - python not installed in correct path - 
bash: python: command not found

PATH=/usr/lib/rstudio-server/bin/code-server/lib/vscode/bin/remote-cli:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/bin


in jupyter notebook
$ python3 -m venv .venv
The virtual environment was not created successfully because ensurepip is not
available.  On Debian/Ubuntu systems, you need to install the python3-venv
package using the following command.

    apt install python3.10-venv



Connection to the server failed. Ensure that you have a working internet connection, you've configured any required proxies, and your system's root CA certificate store is up to date
