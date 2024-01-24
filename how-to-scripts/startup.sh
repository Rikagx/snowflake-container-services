ENV RSW_ROOTUSER admin
ENV RSW_ROOTUSER_PASSWD rstudio
ENV RSW_ROOTUSER_UID 0



# Create one user
if [ $(getent passwd $RSW_TESTUSER_UID) ] ; then
    echo "UID $RSW_TESTUSER_UID already exists, not creating $RSW_TESTUSER test user";
else
    if [ -z "$RSW_TESTUSER" ]; then
        echo "Empty 'RSW_TESTUSER' variables, not creating test user";
    else
        useradd -m -s /bin/bash -N -u $RSW_TESTUSER_UID $RSW_TESTUSER
        echo "$RSW_TESTUSER:$RSW_TESTUSER_PASSWD" | sudo chpasswd
    fi
fi

# Create root user
if [ $(getent passwd $RSW_ROOTUSER_UID) ] ; then
    echo "UID $RSW_ROOTUSER_UID already exists, not creating $RSW_ROOTUSER root user";
else
    if [ -z "$RSW_ROOTUSER" ]; then
        echo "Empty 'RSW_ROOTUSER' variables, not creating root user";
    else
        useradd -m -s /bin/bash -N -ou $RSW_ROOTUSER_UID -g 0 $RSW_ROOTUSER
        echo "$RSW_ROOTUSER:$RSW_ROOTUSER_PASSWD" | sudo chpasswd
    fi
fi


#Create a new root user for the notebook server
RUN useradd -ms /bin/bash -ou 0 -g 0 admin   

#set the user and working directory 
USER jupyter
WORKDIR /home/jupyter 