#!/bin/sh

{
  if [ -f .env ]; then
      # Load Environment Variables
      export $(cat .env | grep -v '#' | awk '/=/ {print $1}')
  fi

  yum install wget -y

  echo "[DEBUG] Start download installer cloudlinux" >> /var/log/cloudlinux.log

  wget https://repo.cloudlinux.com/cloudlinux/sources/cln/cldeploy

  echo "[DEBUG] Installer download completed" >> /var/log/cloudlinux.log

  echo "[DEBUG] Starts running the installer" >> /var/log/cloudlinux.log

  sh cldeploy -k $LICENCE_CLOUDLINUX

  echo "[DEBUG] Cloudlinux successfully installed" >> /var/log/cloudlinux.log

  reboot

} 2>&1 | tee -a /var/log/cloudlinux.process.log
