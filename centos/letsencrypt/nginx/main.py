import os
import sys
import fileinput
from dotenv import dotenv_values
import shutil

config = dotenv_values(".env")

textToSearch = "$DOMAIN"
textToReplace = config['DOMAIN']
fileToSearch = "nginx.conf"

tempFile = open( fileToSearch, 'r+' )

for line in fileinput.input( fileToSearch ):
    tempFile.write( line.replace( textToSearch, textToReplace ) )
tempFile.close()

nginxFile = '/etc/nginx/sites-available/default'
# nginxFile = 'other/default'

shutil.copy(fileToSearch, nginxFile)
