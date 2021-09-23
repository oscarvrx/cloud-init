
echo "[DEBUG] Create workdir" >> /var/log/config-yachay.log

mkdir cpanel-files

cd cpanel-files

echo "[DEBUG] Start download config files" >> /var/log/config-yachay.log

wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos7/cpanel-files/csf.allow

wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos7/cpanel-files/csf.conf

wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos7/cpanel-files/csf.ignore

wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos7/cpanel-files/exim.conf.local

echo "[DEBUG] Finish download config files" >> /var/log/config-yachay.log

cp csf.* /etc/csf/

csf -r

cp exim.conf.local /etc/

/scripts/buildeximconf

/scripts/restartsrv_exim