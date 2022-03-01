#!/bin/sh

{
  if [ -f .env ]; then
      # Carga las variable del .env
      export $(cat .env | grep -v '#' | awk '/=/ {print $1}')
  fi

  echo "[DEBUG] Start running CageFs installer" >> /var/log/cloudlinux.log

  yum install cagefs -y

  echo "[DEBUG] CageFs successfully installed" >> /var/log/cloudlinux.log
} 2>&1 | tee -a /var/log/cloudlinux.process.log