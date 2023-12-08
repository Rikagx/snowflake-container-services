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
