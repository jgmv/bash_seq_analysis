#!/usr/bin/env bash

# cluster sequences with cd-hit, and formats output
cd_hit_clustering () {
  if [ -x "$(command -v cdhit)" ]
  then
    printf "cdhit found\\n"
  else
    printf "cdhit not found. Please install.\\n"
    return   
  fi
  
  # run cd-hit
  cdhit -i $2 -o .temp -c $1 -g 1

  # representative sequences
  mv .temp $3.fasta

  # generate clusters file
  sed -i 's/.*>//' .temp.clstr
  sed -i 's/[...].*//' .temp.clstr
  sed -i 's/Cluster [0-9]*//' .temp.clstr
  sed -i ':a;N;$!ba;s/\n\n/;/g' .temp.clstr
  sed -i ':a;N;$!ba;s/\n/ /g' .temp.clstr
  sed -i ':a;N;$!ba;s/;/\n/g' .temp.clstr
  sed -i 's/;/\n/g' .temp.clstr
  sed -i 's/^ *//;s/ *$//;s/  */ /;' .temp.clstr

  # generate clusters tab
  otuList .temp.clstr $3.csv

  # delete temporaty file
  rm .temp.clstr
}
