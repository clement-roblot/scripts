#!/bin/bash

SORTIE=~/listes_disque_films

rm $SORTIE

echo "kikooo on va liste ce qu'il y a dans le disque externe.\n\n\n" >> $SORTIE

echo "Les films : \n" >> $SORTIE

ls /media/films/film/ >> $SORTIE

echo "\n\n\nLes jeux : \n" >> $SORTIE

ls /media/films/jeux/ >> $SORTIE

echo "\n\n\nLes logiciels : \n" >> $SORTIE

ls /media/films/logiciels/ >> $SORTIE

echo "\n\n\nLes series : \n" >> $SORTIE

ls /media/films/series/ >> $SORTIE

