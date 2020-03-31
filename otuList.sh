#!/usr/bin/env bash

# generate list of OTUs from BlastClust output
otuList() {
 cp $1 .temp
  sed -i 's/^ *//;s/ *$//;s/  */ /;' .temp # remove trailing spaces
  sed -i 's/^/ /' .temp # add extra blank space in each line
  >$2
  NCLUST=$( wc -l .temp | cut -d' ' -f1 )
  for i in $( seq 1 $NCLUST )
  do
    if [ $i -lt 10 ]
     then sed -e $i'!d' -e "s/ / OTU0000$i\t/g" .temp >>$2
    elif [ $i -lt 100 ]
     then sed -e $i'!d' -e "s/ / OTU000$i\t/g" .temp >>$2
    elif [ $i -lt 1000 ]
     then sed -e $i'!d' -e "s/ / OTU00$i\t/g" .temp >>$2
    elif [ $i -lt 10000 ]
     then sed -e $i'!d' -e "s/ / OTU0$i\t/g" .temp >>$2
    else sed -e $i'!d' -e "s/ / OTU$i\t/g" .temp >>$2
    fi
  done
  sed -i 's/^ //' $2 # remove first blank space frome each line
  sed -i ':a;N;$!ba;s/ /\n/g' $2 # replace every blank space by a new line
  
  # remove extra zeros from OTU names
  if [ $NCLUST -lt 10 ]
    then sed -i 's/^OTU0000/OTU/g' $2
  elif [ $NCLUST -lt 100 ]
    then sed -i 's/^OTU000/OTU/g' $2
  elif [ $NCLUST -lt 1000 ]
    then sed -i 's/^OTU00/OTU/g' $2
  elif [ $NCLUST -lt 10000 ]
    then  sed -i 's/^OTU0/OTU/g' $2
  fi

  # remove temporary file
  rm .temp
}
