#!/usr/bin/env bash

# annotate representative OTU sequences with OTU names
annotateRepSeqs () {
  cp $2 $3
  while read line
  do
    name=$( echo $line | cut -d' ' -f2 )
    otu=$( echo $line | cut -d' ' -f1 )
    sed -i "s/\<$name\>/$otu|$name/g" $3
  done < $1
}
