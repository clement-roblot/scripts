#!/bin/bash

# Ensure an empty temporary subdirectory
ScriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

file="ENSSAT_EII3_SISEA.ics"

bevents=($(grep -n BEGIN:VEVENT $file | cut -d: -f1))
eevents=($(grep -n END:VEVENT $file | cut -d: -f1))

ehead=${bevents[0]}
let "ehead -= 1"

bfoot=$(wc -l < $file)
bfoot=$bfoot+1
let "bfoot -= ${eevents[-1]}"

for (( i=0; i < ${#bevents[@]}; i++))
do
	head -n $ehead $file > $file-$i.ics
	sed -n ${bevents[$i]},${eevents[$i]}p $file >> $file-$i.ics
	tail -n $bfoot $file >> $file-$i.ics
done

rm -r $file

cadaver https://www.martobre.fr/owncloud/remote.php/caldav/calendars/karlito/sisea << EOC
  delete *
  mput *.ics
  exit
EOC

rm -r ENSSAT_EII3_SISEA.ics*.ics
