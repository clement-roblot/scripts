#!/bin/bash

IFS='
'

for arg in $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS
do
	nouveau_nom=$(basename "$arg" | tr A-Z a-z | sed 's/\.\|\ /\_/g')
	nouveau_path=$(dirname "$arg")/$nouveau_nom
	mv $arg $nouveau_path
done
