#!/bin/tcsh
#SBATCH --job-name=assign_taxa
#SBATCH --ntasks 1 --cpus-per-task 4
#SBATCH --mem=32gb
#SBATCH --time 1-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=weissjy@bc.edu

module load dacosta/1.2.13obitools

cd /scratch/weissjy/eDNA/vernal-eDNA
mkdir -p ./5_out
mkdir -p ./5_reports

python3 5_assign_taxa.py 2> ./5_reports/step5.log

