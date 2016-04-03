#!/bin/bash


listTodos=`ls todos/*`

for file in ~/scripts/conky/todos/*
do
  fileName=`basename "$file"`
	fileName="${fileName:1}"
	echo "$fileName : "
	cat "$file"
	echo ""
done
