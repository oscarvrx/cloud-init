#!/bin/sh

{
  yum install yum-utils epel-release http://rpms.remirepo.net/enterprise/remi-release-7.rpm httpd unzip wget curl htop -y

  hostnamectl set-hostname $SUBDOMAIN

  echo "[DEBUG] Hostname $(hostname)" >> /var/log/cpanel.process.log

  hostname

  systemctl stop NetworkManager

  systemctl disable NetworkManager

  yum install perl -y
} 2>&1 | tee -a /var/log/cpanel.process.log