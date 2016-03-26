#!/bin/bash

capa_max=$(cat /proc/acpi/battery/BAT0/info | grep "design capacity:" | cut -c26-29)

capa_actuel=$(cat /proc/acpi/battery/BAT0/state | grep "remaining capacity:" | cut -c26-29)

capa_actuel=$(($capa_actuel*100))

pourcent=$(($capa_actuel/$capa_max))

echo $pourcent

exit


