#!/bin/bash

timestamp=`date +"%Y%m%d%H%M"`

tar -cvf /home/admin/[$timestamp]dokuwiki.tar.gz /var/www/dokuwiki/data

