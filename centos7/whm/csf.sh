#!/bin/sh

{
  if [ -f .env ]; then
    # Carga las variable del .env
    export $(cat .env | grep -v '#' | awk '/=/ {print $1}')
  fi

  wget https://download.configserver.com/csf.tgz

  tar -xzf csf.tgz

  cd csf

  sh install.cpanel.sh

  rm /etc/csf/csf.conf

  wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos/csf.conf

  cp csf.conf /etc/csf/csf.conf

  csf –r && service lfd restart

  rpm -qa | grep -i acronis

} 2>&1 | tee -a /var/log/cpanel.process.log