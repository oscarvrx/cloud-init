#!/bin/sh

{
  if [ -f .env ]; then
      # Carga las variable del .env
      export $(cat .env | grep -v '#' | awk '/=/ {print $1}')
  fi

  echo "[DEBUG] Starts running the installer dependiencies" >> /var/log/cloudlinux.log

  yum install wget -y

  echo "[DEBUG] Dependiencies successfully installed" >> /var/log/cloudlinux.log

  echo "[DEBUG] Start download installer cloudlinux" >> /var/log/cloudlinux.log

  wget https://repo.cloudlinux.com/cloudlinux/sources/cln/cldeploy

  echo "[DEBUG] Installer download completed" >> /var/log/cloudlinux.log

  echo "[DEBUG] Starts running the installer" >> /var/log/cloudlinux.log

  sh cloudlinux.sh -k $LICENCE_CLOUDLINUX

  echo "[DEBUG] Cloudlinux successfully installed" >> /var/log/cloudlinux.log

  echo "[DEBUG] Starts running CageFs installer" >> /var/log/cloudlinux.log

  yum install cagefs -y

  echo "[DEBUG] CageFs successfully installed" >> /var/log/cloudlinux.log

  # Necesita de una la cualquier palabra que contenga numero 1 inicialmente
  LIMIT=$(cat /etc/yachay/cloudlinux.cfg)
  SUB="3"

  if [[ "$LIMIT" != *"$SUB"* ]]; then
    NUM=$((${LIMIT: -1} + 1))
    echo "[DEBUG] Attempt number $NUM"
  fi

  echo $LIMIT$NUM > /etc/yachay/cloudlinux.cfg


} 2>&1 | tee -a /var/log/cloudlinux.process.log

# Obtener el log de la ejecucion 2>&1 | tee -a /var/log/cloudlinux.process.log