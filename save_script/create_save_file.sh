#!/bin/bash

timestamp=`date +"%Y%m%d%H%M"`

cd ~
find . -not -path './\.*' -not -path '*\.git*' -not -path './Music*' -not -path './Pictures*' -not -path './Downloads*' -type f -size -1000k > ~/Downloads/[$timestamp]listOfFiles
tar -cvf ~/Downloads/[$timestamp]archive.tar.gz --files-from ~/Downloads/[$timestamp]listOfFiles
openssl enc -aes-256-cbc -e -in ~/Downloads/[$timestamp]archive.tar.gz > ~/Downloads/[$timestamp]archive.tar.gz.enc
rm ~/Downloads/[$timestamp]listOfFiles
rm ~/Downloads/[$timestamp]archive.tar.gz

#to decrypt the file
#openssl aes-256-cbc -d -in archive.tar.gz.enc > archive.tar.gz
