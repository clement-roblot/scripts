#!/bin/bash


sudo rsync -avu --delete-during /home/karlito/ /media/truecrypt1

# -a : recursive and with symbolic links
# -v : verbose
# -u : skip unchanged files
# --delete-during : delete files that are not in the source folder as soon as they are found


sync

