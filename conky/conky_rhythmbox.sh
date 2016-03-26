#!/bin/bash
#~/scripts/song.sh

song=$(rhythmbox-client --print-playing --no-start)

if [ $song = `` ]
then
echo -e "Rhythmbox n'est pas lance"
else
echo $song
fi
exit
