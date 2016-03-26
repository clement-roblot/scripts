#!/bin/bash

EN_TETE='[Install dokuwiki]'

echo "$EN_TETE On va télécharger le fichier."
wget http://www.splitbrain.org/_media/projects/dokuwiki/dokuwiki-2012-01-25a.tgz
echo "$EN_TETE On a télécharger le fichier. Maintenant on va l'extraire."
tar -xvf dokuwiki-2012-01-25a.tgz
echo "$EN_TETE On a extrait le fichier, maintenant supprime l'archive."
rm dokuwiki-2012-01-25a.tgz
echo "$EN_TETE On a supprimé l'archivemaintenant on déplace les fichiers."
mv dokuwiki-2012-01-25a/* .
echo "$en_TETE On supprime le dossier vide."
rm -r dokuwiki-2012-01-25a/
