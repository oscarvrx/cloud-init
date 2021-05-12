#!/bin/sh

yum install yum-utils epel-release http://rpms.remirepo.net/enterprise/remi-release-7.rpm httpd unzip wget curl htop -y

hostname cp-testing-elastika.yachay.pe

systemctl stop NetworkManager

systemctl disable NetworkManager

yum install perl -y

curl -o latest -L https://securedownloads.cpanel.net/latest && sh latest

wget https://download.configserver.com/csf.tgz

tar -xzf csf.tgz

cd csf

sh install.cpanel.sh

rm /etc/csf/csf.conf

wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos/csf.conf

cp csf.conf /etc/csf/csf.conf

csf –r && service lfd restart

wget http://repo.cloudlinux.com/cloudlinux/sources/cln/cldeploy

sh cldeploy

rpm -qa | grep -i acronis


REPO_BASE="https://download.acronis.com/ci/cpanel/stable/acronis-cpanel-stable"

usage()
{
    echo "Usage: $0 [OPTIONS]" >&2
    echo "  -h                   Display this help message" >&2
    echo "  -r PATH              Override base repository path" >&2
}

parse_options()
{
    while getopts ':h:r:' opt; do
        case "$opt" in
            h)
                usage
                exit 0
                ;;
            r)
                REPO_BASE=$OPTARG
                ;;
            :)
                echo "Option -$OPTARG requires an argument" >&2
                usage
                exit 3
                ;;
        esac
    done
}

parse_options "$@"

cat > /etc/yum.repos.d/acronis-cpanel-stable.repo <<EOF
[acronis-cpanel-stable]
name=Acronis Repository for cPanel plugin
baseurl=$REPO_BASE
enabled=1
gpgcheck=0
EOF

yum install -y acronis-backup-cpanel


rm /etc/csf/csf.allow

wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos/csf.allow

cp csf.allow /etc/csf/csf.allow

csf –r

service csf start

## TODO: INSTALLATRON
rpm -Uvh https://data.installatron.com/installatron-plugin-cpanel-latest.noarch.rpm


## TODO: LITESPEED
# This script looks at the user's environment, then fetches the appropriate installer for Litespeed.

# Error handling, make sure we exit cleanly if something goes wrong instead of breaking the user's system.
setup(){
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
}

# Checks for reasons running this script could be unsafe, then abort 
check_environment(){

# Not Linux
operating_system=$(uname -s)
if [ ! "${operating_system}" == "Linux" ]; then
  echo "Fatal error: your operating system is not supported."
  exit 1
fi

# Not root
if ! [ "$(id -u)" = 0 ]; then
  echo "Please run this script as root, or with sudo."
  exit 1
fi

# No serial no
if [ $# -eq 0 ]; then
  echo "Please include your serial no when running this script, i.e. bash install.sh 123456789. To request a trial key, use bash install.sh TRIAL"
  exit 1
fi

# LS already installed
if [ -f /usr/local/lsws/bin/lswsctrl ]; then
  echo "Fatal error: found Litespeed is already installed. Refusing to install a second time."
  exit 1
fi
}

Base_DownloadTrialKey()
{
    curl -s -S -o trial.key "${1}"
}

Base_GetTrialKey()
{
    local LICENSE_SITE="https://license.litespeedtech.com/reseller/trial.key"
    local LICENSE_SITE_2="https://license2.litespeedtech.com/reseller/trial.key"

    if ! Base_DownloadTrialKey $LICENSE_SITE;
    then
        Base_DownloadTrialKey $LICENSE_SITE_2
    fi
}

run_installers(){

# This applies to all control panels
admin_pass=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 16 ; echo '')

if [ -d "/etc/httpd/conf/plesk.conf.d/" ] || [ -d "/etc/apache2/plesk.conf.d/" ]; then
  is_plesk=1
else
  is_plesk=0
fi

# cPanel is installed
if [ -d "/usr/local/cpanel" ] && [ -f "./lsws.options" ]; then
  . ./lsws.options
  curl -s -S -o "lsws_whm_autoinstaller.sh" https://cpanel.litespeed.sh
  chmod a+x lsws_whm_autoinstaller.sh
  ./lsws_whm_autoinstaller.sh "$1" "${php_suexec}" "${port_offset}" "${admin_user}" "${admin_pass}" "${admin_email}" "${easyapache_integration}" "${auto_switch_to_lsws}" "${deploy_lscwp}"
  echo "Install finished! Your randomly generated admin password for the LiteSpeed WebAdmin interface on port 7080 is ${admin_pass}"
  echo "Please make sure to save this password."

elif [ -d "/usr/local/cpanel" ] && [ ! -f "./lsws.options" ]; then
  # echo "Could not find an lsws.options file. We will ask you for your preferred settings instead, but for automated bulk provisioning, you may want to exit and create an lsws.options file."
  # read -p "Continue installer? (y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
  # $confirm == y
  confirm="y"
  # read -p "Enable PHP_SUEXEC. Run PHP processes as the account owner. Available values: 0 (off), 1 (on), and 2 (user home directory only). Default value is 2: " php_suexec
  # php_suexec="${php_suexec:=2}"
  php_suexec="1"
  # read -p "Apache port offset. Run LiteSpeed in parallel with Apache. For example, if set to 1000, Apache will listen on port 80, and LiteSpeed on 1080. If set to 0, Apache and LiteSpeed will use the same port, and LiteSpeed will not automatically start after installation. Default value is 1000: " port_offset
  # port_offset="${port_offset:=1000}"
  port_offset="1000"
  # read -p "Admin username. For accessing LiteSpeed WebAdmin console. Default value is admin: " admin_user
  # admin_user="${admin_user:=admin}"
  admin_user="root"
  # read -p "Admin email address. Receive important server notices, such as license expiration and server core dumps. Default value is root@localhost: " admin_email
  # admin_email="${admin_email:=root@localhost}"
  admin_email="root@localhost"
  # read -p "EasyApache integration. Automatically rebuild matching PHP for LiteSpeed under EasyApache 3. Does nothing under EasyApache 4. Available values are 1 (enable) and 0 (disable). Default value is 1: " easyapache_integration
  # easyapache_integration="${easyapache_integration:=1}"
  easyapache_integration="1"
  # read -p "Switch to LiteSpeed Web Server. Automatically switches at the end of the installation if the port offset is set to 0. Available values are 1 (enable) and 0 (disable). Default value is 0: " auto_switch_to_lsws
  # auto_switch_to_lsws="${auto_switch_to_lsws:=0}"
  auto_switch_to_lsws="0"
  # read -p "Deploy LSCWP Automatically. Scans for Wordpress Websites on server and installs LSCache Plugin on them, Automatically sets up Cache Root. Available values are 1 (enable) and 0 (disable). Default value is 0: " deploy_lscwp
  # deploy_lscwp="${deploy_lscwp:=0}"
  deploy_lscwp="0"
  curl -s -S -o "lsws_whm_autoinstaller.sh" https://cpanel.litespeed.sh
  chmod a+x lsws_whm_autoinstaller.sh
  ./lsws_whm_autoinstaller.sh "$1" "${php_suexec}" "${port_offset}" "${admin_user}" "${admin_pass}" "${admin_email}" "${easyapache_integration}" "${auto_switch_to_lsws}" "${deploy_lscwp}"
  echo "Install finished! Your randomly generated admin password for the LiteSpeed WebAdmin interface on port 7080 is ${admin_pass}"
  echo "Please make sure to save this password."

# Customization is more bare-bones in the absense of an autoinstaller like cPanel has.
elif [ -d "/usr/local/directadmin" ] && [ -f "./lsws.options" ]; then
  . ./lsws.options
  cd /usr/local/directadmin/custombuild
  ./build update
  ./build set webserver litespeed
  ./build set mod_ruid2 no

  if [[ $1 == "TRIAL" ]] || [[ $1 == "trial" ]] ; then
    ./build set litespeed_serialno trial
  else
    ./build set litespeed_serialno $1
  fi

  ./build set php1_mode lsphp
  ./build set php1_release ${php_version_default}
  ./build set php2_mode lsphp
  ./build set php2_release ${php_version_second}
  ./build set php3_mode lsphp
  ./build set php3_release ${php_version_third}
  ./build set php4_mode lsphp
  ./build set php4_release ${php_version_fourth}
  ./build litespeed
  ./build php n
  echo "Install finished! Your randomly generated admin password for the LiteSpeed WebAdmin interface on port 7080 is `grep -m1 '^litespeedadmin=' | cut -d= -f2`"
  echo "Please make sure to save this password."

# No control panel
else 
  latest_version=$(curl -s -S http://update.litespeedtech.com/ws/latest.php | head -n 1 | sed -nre 's/^[^0-9]*(([0-9]+\.)*[0-9]+).*/\1/p') # 5.3.1, 6.0.1, etc
  major_version=$(echo "${latest_version}" | cut -c 1)  # 5, 6, etc
  bitness=$(uname -m)
  if [ "${bitness}" == "i686" ]; then
    bitness="i386"
  fi

  rm -f lsws-latest.tar.gz # Clean up in case of old installs
  rm -rf "lsws-${latest_version}" # Clean up in case of old installs
  curl -s -S -o "lsws-latest.tar.gz" https://www.litespeedtech.com/packages/"${major_version}".0/lsws-"${latest_version}"-ent-"${bitness}"-linux.tar.gz 
  tar -xzf "lsws-latest.tar.gz"
  cd "lsws-${latest_version}"

  if [[ "${1}" == "TRIAL" ]] || [[ "${1}" == "trial" ]] ; then
    Base_GetTrialKey
  else
    echo "${1}" > serial.no
  fi

  bash "./install.sh"
fi
}


main(){
setup
check_environment "$@"
run_installers "$@"
exit 0
}
  
main "$@"

reboot