#!/bin/sh 
set -x
echo "iniciando script"
ls
echo "$1"
echo "$2"
echo "$3"

exec "$1, $2, $3"