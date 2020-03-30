# bash_seq_analysis
Miscellaneous bash scripts for analysis of sequence data.

### annotateFUNGuild.sh
annotates taxonomy file using FUNGuild. Input file must include the following semicolon-separated columns: `group`, `kingdom`, `phylum`, `class`, `order`, `family`, `genus`, `species`.

### annotateRepSeqs.sh
annotates representative OTU sequences with OTU names.

### classifyITSseqs.sh
classifies fungal ITS sequences against against records in the [UNITE](https://unite.ut.ee/) database of reference ITS sequences [(Kõljalg et al. 2005)](https://doi.org/10.1111/j.1469-8137.2005.01376.x) using the Naïve Bayesian Classifier tool [(Wang et al. 2007)](https://doi.org/10.1128/AEM.00062-07) implemented in mothur [(Schloss et al. 2009)](https://doi.org/10.1128/AEM.01541-09). Requires system-wide access to mothur. 


### getRepSeqs.sh
extracts OTU representative sequences from OTU list and fasta sequences file.

### otuList.sh
generates a list of OTUs from BlastClust output.

### otuList2mothur.sh
transforms OTU list to mothur format for running command `classify.otu`

### removeTaxonTag.sh
removes taxon tags from UNITE taxonomy files and modifies the output.
