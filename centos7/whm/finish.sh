#!/bin/sh

{
  echo "[DEBUG] Start Quotas eanbled" >> /var/log/cpanel.process.log

  /scripts/fixquotas

  repquota -a
  echo "[DEBUG] Finished Quotas eanbled" >> /var/log/cpanel.process.log

} 2>&1 | tee -a /var/log/cpanel.process.log