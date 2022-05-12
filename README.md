# vernal-eDNA
Bioinformatics pipeline to process 12S + 16S metabarcoded eDNA samples

This repository represents a (mostly) reproducible example of my work with Prof. DaCosta in the Spring 2022 semester.

I only worked with the R1 reads because of apparent issues with R2 read quality across all samples. Extension of the pipeline to handling paired-end reads would require R1 and R2 files to be merged before step 1, e.g., with vsearch, as described [here](https://github.com/frederic-mahe/swarm/wiki/Fred's-metabarcoding-pipeline).

## Setup
Clone the repository: `git clone https://github.com/weissjy/vernal-eDNA.git`

Then, `cd vernal-eDNA/` and place the raw data (gzipped fastq files) into a new folder within `vernal-eDNA` called `raw_data`.

## Step 1: processing raw reads
This step clips sequencing primers, then the 12S and 16S adapters, using cutadapt. The output files are trimmed, gzipped fastq files separated by matched marker. The output files are located in `1_out/`. Reads without a match against either the 12S or 16S adapter sequences are discarded.

To run:
`module load dacosta/3.7cutadapt`, then `python3 1_process_reads.py`

This step takes ≤ 1 minute on a single interactive node for the 8 files we are working with.

## Step 2: sample-level dereplication
This step dereplicates reads at the sample level using vsearch. The output files are dereplicated fasta files, located in `2_out/`. 

To run:
`module load dacosta/1.0`, then `python3 2_vsearch.py`

This step also takes ≤ 1 minute on a single interactive node.

## Step 3: global dereplication, clustering, chimera detection
Adapted from the pipeline outlined in the [swarm documentation](https://github.com/frederic-mahe/swarm/wiki/Fred's-metabarcoding-pipeline). This step uses vsearch and swarm.

The output files are located in `3_out/`.

To run:
`module load dacosta/1.0` (if not done already), then `bash 3_swarm.sh`.

This step also takes ≤ 1 minute on a single interactive node.

## Step 4: database creation
Since there exists no curated database for our taxa of interest, we proceeded by making a custom reference database using in silico PCR on the set of EMBL reference sequences. This is by far the most time-consuming step. The database was created using the protocol outlined by Ingala et al. [here](https://github.com/MelissaIngala/BelizeBatDiets/blob/master/OBITools%20analysis.txt). In the directory `4_create_database/` are the Slurm files I used to build the database as follows:

1. Download set of reference sequences (subset of STD files) from EMBL
2. Make an ecoPCR database using obitools
3. Run in silico PCR against the ecoPCR database using obitools, then clean up the results to create a fasta file containing the reference sequences for each marker.

These steps took about 5 days in total, so if at all possible, I recommend using the files already set up in my folder. The ecoPCR database is in `/scratch/weissjy/eDNA/embl_db_partial`, and the fasta files for the 12S and 16S databases created using in silico PCR are in `/scratch/weissjy/eDNA/ref_dbs`.

## Step 5: taxonomic assignments
This step uses the database created in step 4 to obtain taxonomic assignments for the sample sequences. This step is still in-progress. I have been working with the sample-level dereplicated sequences (step 2 output) in this step, but one could also work with the globally dereplicated sequences (step 3 output). The Slurm file `5_assign_taxa.sl` and the auxiliary Python file `5_assign_taxa.py` should place taxonomic assignment results in `5_out/`.

This step took approximately 9 hours for our data with the resources requested in the Slurm file. In order to re-run this step, some directory references may need to be changed in order for obitools to be able to work with the reference databases and NCBI taxonomy dump located in the directory `/scratch/weissjy/eDNA/`.

## Issues, questions, or comments?
Please feel free to contact me: jakobweiss99 at gmail dot com.
