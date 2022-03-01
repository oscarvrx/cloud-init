#!/bin/sh

echo "[DEBUG] Create workdir" >> /var/log/config-yachay.log

mkdir cpanel-files

cd cpanel-files

echo "[DEBUG] Start download config files" >> /var/log/config-yachay.log

wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos7/cpanel-files/csf.allow

wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos7/cpanel-files/csf.conf

wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos7/cpanel-files/csf.ignore

wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos7/cpanel-files/exim.conf.local

echo "[DEBUG] Finish download config files" >> /var/log/config-yachay.log

echo "[DEBUG] Start file relocation" >> /var/log/config-yachay.log

mv /etc/csf/csf.allow /etc/csf/csf.allow.bak

mv /etc/csf/csf.conf /etc/csf/csf.conf.bak

mv /etc/csf/csf.ignore /etc/csf/csf.ignore.bak

cp csf.* /etc/csf/

csf -r >> /var/log/csf-yachay.log

CSF_YACHAY=$(cat /var/log/csf-yachay.log | grep "Error")

if [ "$CSF_YACHAY" ]
then
    echo "[ERROR] Se ha producido un error en la reubicación del archivo CSF, compruebe el archivo /var/log/csf-yachay.log."
else
    echo "[SUCCESS] The CSF files were successfully relocated."
fi

mv /etc/exim.conf.local /etc/exim.conf.local.bak

cp exim.conf.local /etc/

/scripts/buildeximconf >> /var/log/exim-build-yachay.log

/scripts/restartsrv_exim >> /var/log/exim-restart-yachay.log

BUILD_EXIM_YACHAY=$(cat /var/log/exim-build-yachay.log | grep "Error")

if [ "$BUILD_EXIM_YACHAY" ]
then
    echo "[ERROR] There was an error relocating the EXIM file, check the /var/log/exim-build-yachay.log file."
else
    echo "[SUCCESS] EXIM files were successfully relocated."
fi

RESTART_EXIM_YACHAY=$(cat /var/log/exim-restart-yachay.log | grep "Error")

if [ "$RESTART_EXIM_YACHAY" ]
then
    echo "[ERROR] An error occurred while restarting the EXIM service, check the /var/log/exim-restart-yachay.log file."
else
    echo "[SUCCESS] EXIM service restarted successfully"
fi

echo "[DEBUG] File relocation is completed" >> /var/log/config-yachay.log