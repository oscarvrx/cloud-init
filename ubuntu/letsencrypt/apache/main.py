import os
import sys
import fileinput
from dotenv import dotenv_values
import shutil

config = dotenv_values(".env")

textToSearch = "$DOMAIN"
textToReplace = config['DOMAIN']
fileToSearch = "apache.conf"

tempFile = open( fileToSearch, 'r+' )

for line in fileinput.input( fileToSearch ):
    tempFile.write( line.replace( textToSearch, textToReplace ) )
tempFile.close()

nginxFile = '/etc/apache2/sites-available/' + config['DOMAIN']
# nginxFile = 'other/default'

shutil.copy(fileToSearch, nginxFile)

cronFile = '/var/spool/cron/crontabs/root'
# cronFile = 'other/root'

with open(cronFile, 'a') as f:
    f.write('\n0 12 * * * /usr/bin/certbot renew --quiet')