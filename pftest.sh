#!/usr/local/bin/bash

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit 1
fi

red='\033[0;31m'
green='\033[0;32m'
reset='\033[0m' # No Color

tables=`pfctl -vvsTables | grep "-" | awk '{print $2}' | grep -v "ALTQ"`

while read -r fname; do
    echo "----------------------"
    printf "Table: $fname: "
    result=`pfctl -t $fname  -T test $1 2>&1`

#    echo "result: $result"
    if [[ $result == *1/1* ]]; then
     printf "${red}$1 found in ${fname}!${reset}\n"
    else
     printf "${green}$1 not found in table${reset}\n"
    fi
done <<< "$tables"
