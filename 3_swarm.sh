#!/bin/bash

## Adapted from:
## https://github.com/frederic-mahe/swarm/wiki/Fred's-metabarcoding-pipeline

## 4. Global replication, clustering, chimera detection
mkdir -p ./3_out
mkdir -p ./3_reports

LOG=3_reports/step3.log
exec 3>&1 1>>${LOG} 2>&1

VSEARCH=$(which vsearch)
SWARM=$(which swarm)
TMP_FASTA=$(mktemp --tmpdir=".")
FINAL_FASTA="3_out/pooled_final.fasta"

# Pool sequences
cat 2_out/*_derep.fasta > "${TMP_FASTA}"

# Dereplicate (vsearch)
"${VSEARCH}" --derep_fulllength "${TMP_FASTA}" \
             --sizein \
             --sizeout \
             --fasta_width 0 \
             --output "${FINAL_FASTA}" > /dev/null

rm -f "${TMP_FASTA}"
echo "Done with global dereplication" 1>&3

# Clustering
THREADS=4
TMP_REPRESENTATIVES=$(mktemp --tmpdir=".")
"${SWARM}" \
    -d 1 -f -t ${THREADS} -z \
    -i ${FINAL_FASTA/.fasta/_1f.struct} \
    -s ${FINAL_FASTA/.fasta/_1f.stats} \
    -w ${TMP_REPRESENTATIVES} \
    -o ${FINAL_FASTA/.fasta/_1f.swarms} < ${FINAL_FASTA}
echo "Done with clustering" 1>&3

# Sort representatives by size
"${VSEARCH}" --fasta_width 0 \
             --sortbysize ${TMP_REPRESENTATIVES} \
             --output ${FINAL_FASTA/.fasta/_1f_representatives.fasta}
rm ${TMP_REPRESENTATIVES}
echo "Done with sorting" 1>&3

# Chimera checking
REPRESENTATIVES=${FINAL_FASTA/.fasta/_1f_representatives.fasta}
UCHIME=${REPRESENTATIVES/.fasta/.uchime}
"${VSEARCH}" --uchime_denovo "${REPRESENTATIVES}" \
             --uchimeout "${UCHIME}"
echo "Done with chimera detection" 1>&3

