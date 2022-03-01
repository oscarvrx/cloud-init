#!/bin/sh

{

  if [ -f .env ]; then
    # Carga las variable del .env
    export $(cat .env | grep -v '#' | awk '/=/ {print $1}')
  fi

  rpm -Uvh https://data.installatron.com/installatron-plugin-cpanel-latest.noarch.rpm

} 2>&1 | tee -a /var/log/cpanel.process.log