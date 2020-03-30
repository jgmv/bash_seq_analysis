#!/usr/bin/env bash

# annotate taxonomy file with FUNGuild
annotateFUNGuild () {
  # download FUNGuild
  if test -f scripts/FUNGuild/Guilds_v1.0.py
  then
    echo "FUNGuild found"
  else
    git clone https://github.com/UMNFuN/FUNGuild.git scripts/FUNGuild
  fi

  # prepare taxonomy data in FUNGuild format
  cp $1 taxonomy_temp.csv 
  sed -i s/"group;kingdom;phylum;class;order;family;genus;species"/"OTU ID\tTaxonomy"/g taxonomy_temp.csv 
  sed -i 's/;/\t/' taxonomy_temp.csv
  #sed -i 's/;/|/g' taxonomy_temp.csv

  # run FUNGuild
  python scripts/FUNGuild/Guilds_v1.0.py -otu taxonomy_temp.csv

  # modify output file
  rm taxonomy_temp.csv
  mv taxonomy_temp.guilds.txt taxonomy_guilds.csv 
  sed -i s/"OTU ID\tTaxonomy"/"group\tkingdom\tphylum\tclass\torder\tfamily\tgenus\tspecies"/g taxonomy_guilds.csv
  for i in {1..6}
    do 
      sed -i s/";"/"\t"/ taxonomy_guilds.csv 
   done
  sed -i '1 s/./\L&/g' taxonomy_guilds.csv
  sed -i '1 s/ /_/g' taxonomy_guilds.csv
}
