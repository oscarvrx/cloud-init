#!/bin/sh

{

  if [ -f .env ]; then
    # Carga las variable del .env
    export $(cat .env | grep -v '#' | awk '/=/ {print $1}')
  fi

  curl -o latest -L https://securedownloads.cpanel.net/latest && sh latest

} 2>&1 | tee -a /var/log/cpanel.process.log
