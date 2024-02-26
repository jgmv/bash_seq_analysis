# bash_seq_analysis
Miscellaneous bash scripts for analysis of sequence data.

### annotateFUNGuild.sh
annotates taxonomy file using FUNGuild [(Nguyen et al. 2016)](https://doi.org/10.1016/j.funeco.2015.06.006). Input file must include the following semicolon-separated columns: `group`, `kingdom`, `phylum`, `class`, `order`, `family`, `genus`, `species`.

### annotateRepSeqs.sh
annotates representative OTU sequences with OTU names.

### cd-hit_clustering.sh
clusters sequences into OTUs using CD-HIT [(Fu et al. 2012)](https://doi.org/10.1093/bioinformatics/bts565) and formats the output files.

### classifyITSseqs.sh
classifies fungal ITS sequences against records in the [UNITE](https://unite.ut.ee/) database of reference ITS sequences [(Kõljalg et al. 2005)](https://doi.org/10.1111/j.1469-8137.2005.01376.x) using the Naïve Bayesian Classifier tool [(Wang et al. 2007)](https://doi.org/10.1128/AEM.00062-07) implemented in mothur [(Schloss et al. 2009)](https://doi.org/10.1128/AEM.01541-09). Requires system-wide access to mothur. 

### getRepSeqs.sh
extracts OTU representative sequences from OTU list and fasta sequences file.

### otuList.sh
generates a list of OTUs from BlastClust output.

### otuList2mothur.sh
transforms OTU list to mothur format for running command `classify.otu` in mothur.

### removeTaxonTag.sh
removes taxon tags from UNITE taxonomy files and modifies the output.

### taxAnnotation.sh
taxonomically annotates rDNA sequences using a [Naive Bayesian Classifier (NBC)](https://doi.org/10.1128/AEM.00062-07) as implemented in [Mothur](https://mothur.org/) and a local BLAST against user-specified databases.
Requires a system-wide installation of [Mothur](https://mothur.org/) (e.g. via `sudo apt install mothur`) and of [`ncbi-blast+`](https://blast.ncbi.nlm.nih.gov/doc/blast-help/downloadblastdata.html) (`sudo apt install ncbi-blast+`).

Specify the reference databases to use in the `### parameters` section of the script, including sequence + taxonomy files for the NBC (e.g. available to download for [bacteria](https://mothur.org/wiki/silva_reference_files/)), [fungi](https://unite.ut.ee/repository.php) and [arbuscular mycorrhizal fungi](https://maarjam.ut.ee/?action=bDownload)) and a BLAST database for BLAST (available through [NCBI](https://ftp.ncbi.nlm.nih.gov/blast/db/)).
In the latter case, it is possible to directly specify a FTP address to a database, and the script will auomatically download it. If providing a folder (e.g. `$HOME/db/BLAST`), ensure there is system wide access (add line `BLASTDB="$HOME/db/BLAST"` to your `~/.profile` or `~/.bashrc` files) and that it also contains the [`taxdb`](https://ftp.ncbi.nlm.nih.gov/blast/db/taxdb.tar.gz) database.

The script can run by providing a fasta file as the `INPUT_SEQ` variable within the file, or using a positional argument. See examples with input file `example_ITS.fasta`:

```bash
# run with input file as parameter (modify 'INPUT_SEQ="example_ITS.fasta"' within file)
bash taxAnnotation.sh

# using positional argument
bash taxAnnotation.sh example_ITS.fasta

# specifying FTP address ('BLAST_DB="ftp://ftp.ncbi.nlm.nih.gov/blast/db/ITS_eukaryote_sequences.tar.gz"' within file)
bash taxAnnotation.sh example_ITS.fasta
```

### taxonomyToTree.sh
generates a tree from a taxonomy file using the script provided by [Tedersoo et al. (2018)](https://doi.org/10.1007/s13225-018-0401-0). The input file must be separated by tabs.
