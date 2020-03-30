#!/usr/bin/env bash

# generates tree from taxonomy using the script provided by Tedersoo et al. 2018
taxonomyToTree () {
  # download FUNGuild
  if test -f scripts/my_bioinfPerls/taxonomy_to_tree.pl
  then
    echo "taxonomy_to_tree.pl found"
  else
    git clone https://github.com/mr-y/my_bioinfPerls.git scripts/my_bioinfPerls
  fi

  perl scripts/my_bioinfPerls/taxonomy_to_tree.pl $1 > $2
}
