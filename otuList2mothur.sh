#!/usr/bin/env bash

# transform OTU list to mothur format for running 'classify.otu'
otuList2mothur () {
  > $2
  for i in $( cut -f1 $1 | sort | uniq )
  do
    otu=$( grep $i $1 | cut -f2 )
    echo $otu >> $2
  done
  sed -i 's/ /,/g' $2
  sed -i '$!{:a;N;s/\n/\t/;ta}' $2
  sed -i "1s/^/0.03\t$(cut -f1 $1 | sort | uniq | wc -l)\n/" $2
}
