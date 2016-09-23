#!/bin/bash

ssh -l root martobre.fr 'bash -s' < backupPayload.sh

scp root@martobre.fr:/home/admin/*dokuwiki.tar.gz ./saves/

ssh -l root martobre.fr 'rm /home/admin/*dokuwiki.tar.gz'
