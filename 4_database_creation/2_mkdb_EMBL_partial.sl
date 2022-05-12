#!/bin/tcsh
#SBATCH --job-name=mkdb_EMBL_partial
#SBATCH --ntasks 1 --cpus-per-task 4
#SBATCH --mem=8gb
#SBATCH --time 5-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=weissjy@bc.edu

module load dacosta/1.2.13obitools
cd /scratch/weissjy/eDNA/

obiconvert --embl -t ./TAXO/ --ecopcrdb-output=embl_db_partial ./embl_data_partial/*.dat.gz --skip-on-error

