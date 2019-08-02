#!/usr/bin/env bash

# generate list of OTUs from BlastClust output
otuList () {
  cp $1 clusters
  sed -i 's/.$//' clusters # remove last blank space from each line
  sed -i 's/^/ /' clusters # add extra blank space in each line
  >$2
  for i in $( seq 1 $( wc -l clusters | cut -d' ' -f1 ) )
  do
    if [ $i -lt 10 ]
    then sed -e $i'!d' -e "s/ / OTU00$i\t/g" clusters >>$2
    elif [ $i -lt 100 ]
    then sed -e $i'!d' -e "s/ / OTU0$i\t/g" clusters >>$2
    else sed -e $i'!d' -e "s/ / OTU$i\t/g" clusters >>$2
    fi
  done
  sed -i 's/^ //' $2 # remove first blank space frome each line
  sed -i ':a;N;$!ba;s/ /\n/g' $2 # replace every blank space by a new line
  rm clusters
}

