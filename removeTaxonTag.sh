#!/usr/bin/env bash

# remove taxon tags from UNITE taxonomy files and modify output
removeTaxonTag () {
  cp $1 $2
  sed -i 's/k__//g' $2
  sed -i 's/p__//g' $2
  sed -i 's/c__//g' $2
  sed -i 's/o__//g' $2
  sed -i 's/f__//g' $2
  sed -i 's/g__//g' $2
  sed -i 's/s__//g' $2
  sed -i 's/\t/;/g' $2
  sed -i 's/;$//' $2
  sed -i "1s/^/group;kingdom;phylum;class;order;family;genus;species\n/" $2
  sed -i 's/Otu/OTU/g' $2
  sed -i '/OTU;Size;Taxonomy/d' $2
}
