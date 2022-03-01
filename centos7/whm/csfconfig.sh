#!/bin/sh

{
  if [ -f .env ]; then
    # Carga las variable del .env
    export $(cat .env | grep -v '#' | awk '/=/ {print $1}')
  fi

  echo "[DEBUG] Configuring CSF" >> /var/log/cpanel.process.log
  rm /etc/csf/csf.allow

  wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos/csf.allow

  cp csf.allow /etc/csf/csf.allow

  csf –r

  service csf start

  echo "[DEBUG] Finished configuring CSF" >> /var/log/cpanel.process.log
} 2>&1 | tee -a /var/log/cpanel.process.log