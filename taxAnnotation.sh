#!/usr/bin/env bash

### ============================================================================
###
### taxAnnotation: a bash script to taxonomically annotate rDNA sequences
### created by Jose G. Macia-Vicente 
###
### ============================================================================ 


### parameters
# input sequences
INPUT_SEQ="example_ITS.fasta"

# check for positional arguments
if [[ $@ ]]
then
  INPUT_SEQ=$1
fi

# NBC parameters
NBC_SEQ="$HOME/db/UNITE/UNITEv8_sh_dynamic.fasta" # ref sequences
NBC_TAX="$HOME/db/UNITE/UNITEv8_sh_dynamic.tax" # ref taxonomy
NBC_CUTOFF=60 # cutoff bootstrap retaining taxa

# BLAST parameters
#BLAST_DB="ftp://ftp.ncbi.nlm.nih.gov/blast/db/ITS_eukaryote_sequences.tar.gz"
BLAST_DB="ITS_eukaryote_sequences" # BLAST database
PERC_ID=90 # minimum % identity
MIN_COVER=80 # minimum % coverage
MAX_TARGET=20 # maximum number of results


### configure
# fetch BLAST databases, if necessary
if [[ $BLAST_DB == "ftp://ftp.ncbi.nlm.nih.gov/blast/db/"* ]]
then
  echo "Fetching BLAST database..."
  wget $BLAST_DB
  wget ftp://ftp.ncbi.nlm.nih.gov/blast/db/taxdb.tar.gz
  ls *.gz | xargs -n1 tar -xzvf
  rm *.gz
  echo "Done!"
fi

# create output folder
mkdir -p output


### run NBC in mothur
# run classifier
if command -v mothur >/dev/null 2>&1
then
  mothur "#classify.seqs(fasta=$INPUT_SEQ, reference=$NBC_SEQ,
    taxonomy=$NBC_TAX, cutoff=$NBC_CUTOFF, probs=T)"
  mv mothur.* ./output/
  cp *.taxonomy ./output/taxonomy_boot.csv
  mv *.taxonomy ./output/
  mv *.summary ./output/
else
  echo "Please, install mothur"
fi

# format output files
sed -i 's/\t/;/g' ./output/taxonomy_boot.csv
sed -i 's/[a-z]__//g' ./output/taxonomy_boot.csv
sed -i "1s/^/seq;kingdom;phylum;class;order;family;genus;species\n/" \
  ./output/taxonomy_boot.csv
sed 's/([^()]*)//g' ./output/taxonomy_boot.csv > ./output/taxonomy.csv


### run local BLAST
# run BLAST
if command -v blastn >/dev/null 2>&1
then
  echo "Running BLAST..."
  blastn -query $INPUT_SEQ -db $BLAST_DB -out ./output/blast_result.csv \
    -outfmt "6 qseqid qlen sseqid sacc stitle staxids sscinames slen evalue \
    length pident qcovs nident mismatch" -perc_identity $PERC_ID \
    -qcov_hsp_perc $MIN_COVER -max_target_seqs $MAX_TARGET
else
  echo "Please, install ncbi-blast+"
fi

# format output file
sed -i 's/\t/;/g' ./output/blast_result.csv
sed -i "1s/^/qseqid;qlen;sseqid;sacc;stitle;staxids;sscinames;slen;evalue;\
  length;pident;qcovs;nident;mismatch\n/" ./output/blast_result.csv
echo "Done!"


### results
echo ""
echo "--- Results ---"
echo "Input file:	"$INPUT_SEQ
echo "NBC results:	./output/taxonomy.csv & ./output/taxonomy_boot.csv"
echo "BLAST results:	./output/blast_result.csv"


### end
