## based on the workflow given at:
## https://github.com/frederic-mahe/swarm/wiki/Fred's-metabarcoding-pipeline

from subprocess import call
from glob import glob
import os

## Set up directories if not present
if not os.path.exists('2_out'):
	os.makedirs('2_out')
if not os.path.exists('2_reports'):
	os.makedirs('2_reports')

## 2. File-level dereplication
R1_files = sorted(glob('1_out/*_SP_1*S_trimmed.fastq.gz'))

for i in range(len(R1_files)):
	prefix = R1_files[i].split('_trimmed')[0]
	justfile = prefix.split('/')[1]

	# relabel reads to give each a unique ID, discard reads with Ns,
	# annotate with expected error rates
	call('vsearch --fastq_filter {} --fastq_maxns 0 --relabel_sha1 --eeout --fastqout 2_out/tmp.fastq 2> 2_reports/step2.log'.format(R1_files[i]), shell=True)

        # convert fastq to fasta
	call('vsearch --fastq_filter {} --fastq_maxns 0 --fastaout 2_out/tmp.fasta 2>> 2_reports/step2.log'.format(R1_files[i]), shell=True)

        # dereplicate reads within the file
	call('vsearch --derep_fulllength 2_out/tmp.fasta --sizeout --fasta_width 0 --relabel_sha1 --output {} 2>> 2_reports/step2.log'.format('2_out/'+justfile+'_derep.fasta'), shell=True)

        # reformat the output to add error rates and read lengths
	call('bash 2_sed.sh', shell=True)
	print('done with ' + R1_files[i])

# clean up temporary files
call('rm 2_out/tmp.fasta 2_out/tmp.fastq', shell=True)
