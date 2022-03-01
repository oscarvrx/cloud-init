#!/bin/sh

INSTALL_APP_INSTALLATRON=false
INSTALL_APP_ACRONIS=false
INSTALL_APP_CLOUDLINUX=false
INSTALL_APP_CAGEFS=false
INSTALL_APP_CSF=false
SUBDOMAIN="cpanel.elastika.pe"
LICENCE_CLOUDLINUX=""
CONFIGURE_YACHAY_SCRIPT=false

reg_subdomain="^[[:alnum:]](([[:alnum:]]|-){0,61}[[:alnum:]])?$"

# SUBDOMINIO APP

printf "Enter domain or subdomain [cpanel.elastika.pe]: "

read -r SUBDOMAIN_IN

if [[ ! $SUBDOMAIN_IN =~ $reg_subdomain ]]; then
    SUBDOMAIN=$SUBDOMAIN_IN
fi

# CSF APP

printf "Install CSF [y/N]: "

read -r HAS_INSTALL_CSF

if [ "$HAS_INSTALL_CSF" = "y" ] || [ "$HAS_INSTALL_CSF" = "Y" ] ; then
    INSTALL_APP_CSF=true
fi

# ACRONIS APP

printf "Install ACRONIS [y/N]: "

read -r HAS_INSTALL_ACRONIS

if [ "$HAS_INSTALL_ACRONIS" = "y" ] || [ "$HAS_INSTALL_ACRONIS" = "Y" ] ; then
    INSTALL_APP_ACRONIS=true
fi


# INSTALLATRON APP

printf "Install INSTALLATRON [y/N]: "

read -r HAS_INSTALL_INSTALLATRON

if [ "$HAS_INSTALL_INSTALLATRON" = "y" ] || [ "$HAS_INSTALL_INSTALLATRON" = "Y" ] ; then
    INSTALL_APP_INSTALLATRON=true
fi

# CLOUDLINUX APP

printf "Install CLOUDLINUX [y/N]: "

read -r HAS_INSTALL_CLOUDLINUX

if [ "$HAS_INSTALL_CLOUDLINUX" = "y" ] || [ "$HAS_INSTALL_CLOUDLINUX" = "Y" ] ; then
    ## LICENCIA DE CLOUDLINUX

    printf "Enter your CLOUDLINUX license [xxxxx...]: "

    read -r LICENCE_CLOUDLINUX_IN

    if [ "$LICENCE_CLOUDLINUX_IN" ]; then
        LICENCE_CLOUDLINUX=$LICENCE_CLOUDLINUX_IN
    fi

    ## CAGEFS APP

    printf "Install CAGEFS [y/N]: "

    read -r HAS_INSTALL_CAGEFS

    if [ "$HAS_INSTALL_CAGEFS" = "y" ] || [ "$HAS_INSTALL_CAGEFS" = "Y" ] ; then
        INSTALL_APP_CAGEFS=true
    fi

    INSTALL_APP_CLOUDLINUX=true
fi


echo $SUBDOMAIN
echo $INSTALL_APP_CSF
echo $INSTALL_APP_INSTALLATRON
echo $INSTALL_APP_ACRONIS
echo $INSTALL_APP_CLOUDLINUX
echo $LICENCE_CLOUDLINUX
echo $INSTALL_APP_CAGEFS

echo "SUBDOMAIN=$SUBDOMAIN" >> .env
echo "LICENCE_CLOUDLINUX=$LICENCE_CLOUDLINUX" >> .env

# 1. run tools
wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos7/whm/tools.sh

chmod +x tools.sh

./tools.sh

# 2. run whm
wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos7/whm/whm.sh

chmod +x whm.sh

./whm.sh

# 3. run csf
if [ "$INSTALL_APP_CSF" = true ] ; then
    wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos7/whm/csf.sh

    chmod +x csf.sh

    ./csf.sh
fi

# 4. run acronis
if [ "$INSTALL_APP_ACRONIS" = true ] ; then
    wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos7/whm/acronis.sh

    chmod +x acronis.sh

    ./acronis.sh
fi

# 5. run csfconfig
if [ "$INSTALL_APP_CSF" = true ] ; then
    wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos7/whm/csf.sh

    chmod +x csf.sh

    ./csf.sh
fi

# 6. run installatron
if [ "$INSTALL_APP_INSTALLATRON" = true ] ; then
    wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos7/whm/installatron.sh

    chmod +x installatron.sh

    ./installatron.sh
fi

# 7. run finish cpanel
wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos7/whm/finish.sh

chmod +x finish.sh

./finish.sh

# 8. run cloudlinux
if [ "$INSTALL_APP_CLOUDLINUX" = true ] ; then
    wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos7/whm/cloudlinux.sh

    chmod +x cloudlinux.sh

    ./cloudlinux.sh
fi

# 9. run cageFs
if [ "$INSTALL_APP_CAGEFS" = true ] ; then
    wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos7/whm/cagefs.sh

    chmod +x cagefs.sh

    ./cagefs.sh
fi

# 10. configure yachay script
wget https://raw.githubusercontent.com/oscarvrx/cloud-init/master/centos7/whm/config-yachay.sh

chmod +x config-yachay.sh

./config-yachay.sh
