#!/bin/tcsh
#SBATCH --job-name=get_embl_partial
#SBATCH --ntasks 1 --cpus-per-task 4
#SBATCH --mem=4gb
#SBATCH --time 5-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=weissjy@bc.edu

module load dacosta/1.2.13obitools
cd /scratch/weissjy/eDNA
mkdir -p embl_data_partial
cd embl_data_partial

ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_ENV_1.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_ENV_10.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_ENV_2.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_ENV_3.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_ENV_4.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_ENV_5.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_ENV_6.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_ENV_7.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_ENV_8.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_ENV_9.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_INV_1.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_INV_10.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_INV_11.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_INV_12.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_INV_13.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_INV_2.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_INV_3.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_INV_4.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_INV_5.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_INV_6.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_INV_7.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_INV_8.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_INV_9.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_VRT_1.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_VRT_2.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_VRT_3.dat.gz .
ascp -QT -l 300m -P 33001 --overwrite=diff -i /data/weissjy/.aspera/connect/etc/asperaweb_id_dsa.openssh fasp-ebi@fasp.ebi.ac.uk:databases/ena/sequence/snapshot_20220310/std/STD_VRT_4.dat.gz .

