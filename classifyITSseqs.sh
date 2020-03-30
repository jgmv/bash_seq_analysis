#!/usr/bin/env bash

# classify fungal ITS sequences against the UNITE database
classifyITSseqs () {
  cp $1 temp_seqs.fasta

  UNITE_DB="https://files.plutof.ut.ee/public/orig/56/25/5625BDC830DC246F5B8C7004220089E032CC33EEF515C76CD0D92F25BDFA9F78.zip" # link to last release of UNITE db

  # download last version of UNITE ITS reference dataset, mothur release
  # check https://unite.ut.ee/repository.php
  if test -f ./unite_db/UNITE_sh_dynamic.tax
  then
    echo "UNITE database found"
  else
    mkdir -p unite_db
    wget -P unite_db $UNITE_DB
    unzip -o unite_db/*.zip
    rm unite_db/*.zip
    mv data/UNITE*_sh_dynamic.fasta unite_db/UNITE_sh_dynamic.fasta
    mv data/UNITE*_sh_dynamic.tax unite_db/UNITE_sh_dynamic.tax
    rm -rf data
  fi

  # identify ITS sequences using mothur's NBC
  mothur "#classify.seqs(fasta=temp_seqs.fasta,\
    template=unite_db/UNITE_sh_dynamic.fasta,\
    taxonomy=unite_db/UNITE_sh_dynamic.tax, cutoff=60, probs=T)" 
  removeTaxonTag temp_seqs.UNITE_sh_dynamic.wang.taxonomy taxonomy_boot.csv

  # create a copy of the taxonomy file without bootstrap values
  cp taxonomy_boot.csv taxonomy.csv
  sed -i 's/([^()]*)//g' taxonomy.csv
}
