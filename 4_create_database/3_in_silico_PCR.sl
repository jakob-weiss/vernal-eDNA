#!/bin/tcsh
#SBATCH --job-name=in_silico_PCR
#SBATCH --ntasks 1 --cpus-per-task 4
#SBATCH --mem=48gb
#SBATCH --time 5-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=weissjy@bc.edu

module load dacosta/1.2.13obitools
cd /scratch/weissjy/eDNA
mkdir -p ref_dbs

/mmfs1/data/weissjy/ecopcr/src/ecoPCR -d embl_db_partial/embl_141_partial -e 5 -l 30 -L 800 -c RGACGAGAAGACCCTATARA ACGCTGTTATCCCTAARGTA > ref_dbs/16S.seqs
/mmfs1/data/weissjy/ecopcr/src/ecoPCR -d embl_db_partial/embl_141_partial -e 5 -l 30 -L 800 -c ACACCGCCCGTCACCCT GTAYACTTACCATGTTACGACTT > ref_dbs/12S.seqs

cd ref_dbs

obiconvert --ecopcr --fasta-output 16S.seqs > 16S_ref_db.fasta
obiconvert --ecopcr --fasta-output 12S.seqs > 12S_ref_db.fasta

obigrep -d ../embl_db_partial/embl_141_partial --require-rank=family --fasta 12S_ref_db.fasta > 12S_ref_db_family.fasta
obiuniq -d ../embl_db_partial/embl_141_partial --fasta 12S_ref_db_family.fasta > 12S_ref_db_family_uniq.fasta
obigrep -d ../embl_db_partial/embl_141_partial --require-rank=family —fasta 12S_ref_db_family_uniq.fasta > 12S_ref_db_family_taxid.fasta
obiannotate --uniq-id --fasta 12S_ref_db_family_taxid.fasta > 12S_ref_db_final.fasta

obigrep -d ../embl_db_partial/embl_141_partial --require-rank=family --fasta 16S_ref_db.fasta > 16S_ref_db_family.fasta
obiuniq -d ../embl_db_partial/embl_141_partial --fasta 16S_ref_db_family.fasta > 16S_ref_db_family_uniq.fasta
obigrep -d ../embl_db_partial/embl_141_partial --require-rank=family —fasta 16S_ref_db_family_uniq.fasta > 16S_ref_db_family_taxid.fasta
obiannotate --uniq-id --fasta 16S_ref_db_family_taxid.fasta > 16S_ref_db_final.fasta

