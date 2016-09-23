#!/bin/bash

IFS='
'

for arg in $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS
do
	fullFileName=$(basename "$arg")
	fileName="${fullFileName%.*}"
	
	nouveau_path=$(dirname "$arg")/$fileName.jpg

  touch $nouveau_path

done
