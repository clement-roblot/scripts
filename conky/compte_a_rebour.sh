#!/bin/bash
#Script de compte à rebours pour mon Conky

#25 juin 2012 08:00:00 (GMT+2)
upd=$(echo 1392894000)
act=$(date +%s)
diff=$(( ($act-$upd)*-1 ))
jours=$(( $diff/3600/24 ))
heures=$((($diff/3600)-($jours*24)))
minutes=$(( $diff/60 - ($jours*24*60) - ($heures*60) ))
secondes=$(($diff%60))

if [[ $heures -lt 10 ]] ; then
  if [[ $minutes -lt 10 ]] ; then
    if [[ $secondes -lt 10 ]] ; then
      echo  $jours' Jours', 0$heures':0'$minutes':0'$secondes
    else
      echo  $jours' Jours', 0$heures':0'$minutes':'$secondes
    fi
  else
    if [[ $secondes -lt 10 ]] ; then
      echo  $jours' Jours', 0$heures':'$minutes':0'$secondes
    else
      echo  $jours' Jours', 0$heures':'$minutes':'$secondes
    fi
  fi
else
  if [[ $minutes -lt 10 ]] ; then
    if [[ $secondes -lt 10 ]] ; then
      echo  $jours' Jours', $heures':0'$minutes':0'$secondes
    else
      echo  $jours' Jours', $heures':0'$minutes':'$secondes
    fi
  else
    if [[ $secondes -lt 10 ]] ; then
      echo  $jours' Jours', $heures':'$minutes':0'$secondes
    else
      echo  $jours' Jours', $heures':'$minutes':'$secondes
    fi
  fi
fi
exit 0
