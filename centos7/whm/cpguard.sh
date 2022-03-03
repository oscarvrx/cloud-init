#!/bin/sh

{

whmapi1 set_tweaksetting key=phploader value=ioncube

curl -o cpguard.sh -L https://downloads.opsshield.com/cpguard/cpguard.sh

bash cpguard.sh install

} 2>&1 | tee -a /var/log/cpanel.cpguard.log
