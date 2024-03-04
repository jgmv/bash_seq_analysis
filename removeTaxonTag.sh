#!/usr/bin/env bash

# remove taxon tags from UNITE taxonomy files and modify output
removeTaxonTag () {
  cp $1 $2
  sed -i 's/[a-z]__//g' $2
  sed -i 's/;$//' $2
  sed -i "1s/^/group;kingdom;phylum;class;order;family;genus;species\n/" $2
  sed -i 's/Otu/OTU/g' $2
  sed -i '/OTU;Size;Taxonomy/d' $2
}
