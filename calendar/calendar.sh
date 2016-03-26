#TODO
# - mettre une variable nom du fichier
# - mettre une variable ligne de commande (appele du script perl)


#!/bin/bash

cd $(dirname $(readlink -f $0));

perl calendar.pl

touch ENSSAT_EII3_SISEA.ics
size_calendar=$(du ENSSAT_EII3_SISEA.ics | cut -f1)


if [ "$size_calendar" -eq "0" ]
then
	while [ "$size_calendar" -eq "0" ]
	do
		echo "J'ai eu un probleme pour recuperer l'agenda, je retenterais dans une heure. ;)" | mail -s "Erreur récupération calendrier" karlito@martobre.fr
		sleep 3600
		perl calendar.pl
		size_calendar=$(du ENSSAT_EII3_SISEA.ics | cut -f1)
	done

        echo "Le probleme est resolu, j'ai recupere un calendrier potable." | mail -s "Fin d'alèrte récupération de calendrier" karlito@martobre.fr
fi

./upload2.sh
./upload3.sh


