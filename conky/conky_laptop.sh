#!/bin/bash
killall conky
killall conky
sleep 60
xset m 4 1
#feh --bg-scale `dcop kdesktop KBackgroundIface currentWallpaper 1`
conky -c /home/karlito/scripts/conky/conkyrc_laptop &
conky -c /home/karlito/scripts/conky/conkyrc2 &
xbindkeys
exit
