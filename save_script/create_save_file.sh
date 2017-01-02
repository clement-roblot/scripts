#!/bin/bash

timestamp=`date +"%Y%m%d%H%M"`

cd ~
find . -not -path './\.*' -not -path '*\.git*' -not -path './Music*' -not -path './Pictures*' -not -path './Downloads*' -type f -size -1000k > ~/Downloads/[$timestamp]listOfFiles
tar -cvf ~/Downloads/[$timestamp]archive.tar.gz --files-from ~/Downloads/[$timestamp]listOfFiles
openssl enc -aes-256-cbc -e -in ~/Downloads/[$timestamp]archive.tar.gz > ~/Downloads/[$timestamp]archive.tar.gz.enc
rm ~/Downloads/[$timestamp]listOfFiles
rm ~/Downloads/[$timestamp]archive.tar.gz

mkdir -p ~/Downloads/[$timestamp]
cd ~/Downloads/[$timestamp]
split -b 20m ~/Downloads/[$timestamp]archive.tar.gz.enc [$timestamp]
rm ~/Downloads/[$timestamp]archive.tar.gz.enc


cat <<EOT >> rebuild.sh
#!/bin/bash

timestamp=`find . -name "\[*\]*" | head -1 | sed "s/.*\[\([0-9]*\)\].*/\1/"`

cat \[*\]* > \[$timestamp\]archive.tar.gz.enc

openssl aes-256-cbc -d -in \[$timestamp\]archive.tar.gz.enc > \[$timestamp\]archive.tar.gz
EOT

chmod +x rebuild.sh



#to recompose the file
#cat \[201609231802\]* > \[201609231802\]archive.tar.gz.enc

#to decrypt the file
#openssl aes-256-cbc -d -in archive.tar.gz.enc > archive.tar.gz



