#!/bin/sh

{

yum install http://repo.jetlicense.com/centOS/jetapps-repo-latest.rpm -y

yum clean all --enablerepo=jetapps*

yum install jetapps-cpanel --disablerepo=* --enablerepo=jetapps -y

jetapps --install jetbackup stable

} 2>&1 | tee -a /var/log/cpanel.jetbackup.log