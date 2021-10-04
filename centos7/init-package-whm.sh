#!/bin/bash

echo "Enter domain or subdomain: "

read SUBDOMAIN

# SUM=0

# EXPRESION="^[A-Za-z0-9]+$"

# for i in $(echo $SUBDOMAIN | tr "." "\n")
# do
#   if [[ $i =~ $EXPRESION ]];
#   then
#     SUM=$(expr $SUM + 1)
#   else
#     echo "[ERROR] Invalid domain or subdomain"
#     exit 1
#   fi
# done

# if [ "$SUM" -le 2 ] || [ "$SUM" -ge 4 ];
# then
#     echo "[ERROR] Invalid domain or subdomain"
#     exit 1
# fi

echo "Enter your Cloudlinux license: "

read LICENCE_CLOUDLINUX

# if [[ "$LICENCE_CLOUDLINUX" != CL-* ]]
# then
#   echo "[ERROR] Invalid license"
#   exit 1
# fi

# echo "Enter your LiteSpeed Web Server license (TRIAL/you_key): "

# read LICENCE_LITESPEED

# START SCRIPT INSTALL APPS

mkdir -p /etc/yachay

echo "Linux1" > /etc/yachay/cloudlinux.cfg

CLOUD_INIT=/etc/yachay/cloud-init

mkdir -p $CLOUD_INIT

cd $CLOUD_INIT

echo "SUBDOMAIN=$SUBDOMAIN" >> .env

wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos7/whm.sh

chmod +x whm.sh

# sh whm.sh TRIAL

# echo -e "password1234\npassword1234" | passwd root

echo "LICENCE_CLOUDLINUX=$LICENCE_CLOUDLINUX" >> .env

wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos7/cloudlinux.sh

chmod +x /etc/yachay/cloud-init/cloudlinux.sh

# sh cloudlinux.sh

wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos7/config-yachay.sh

chmod +x /etc/yachay/cloud-init/config-yachay.sh

# sh config-yachay.sh

reboot
