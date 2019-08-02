#!/usr/bin/env bash

# extract OTU representative sequences from OTU list and fasta sequences file
getRepSeqs () {
  > $3
  cp $2 .temp
  echo ">" >> .temp
  for i in $( cat $1 )
  do
    seq=$( grep -w $i .temp )
    sed -n -e "/$seq/,/>/ p" .temp | sed -e '$d' >> $3
  done
  rm .temp
}
