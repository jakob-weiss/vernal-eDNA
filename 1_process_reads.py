from subprocess import call
from glob import glob
import os

###
# Step 1: Trimming sequencing primer, then 12S and 16S adapters
###

### Primer sequences
# sequencing primer
SP_all = 'AGATCGGAAGAGCACACGTCTGAACTCCAGTCACNNNNNNNNATCTCGTATGCCGTCTTCTGCTTG'

# 12S forward adapter
a12S_R1 = 'AAGTCGTAACATGGTAAGTRTAC'

# 16S forward adapter
a16S_R1 = 'TACYTTAGGGATAACAGCGT'
###

## Set up directories if not present
if not os.path.exists('1_out'):
    os.makedirs('1_out')
if not os.path.exists('1_reports'):
    os.makedirs('1_reports')


## 1a. Trimming sequencing primer
R1_files = sorted(glob('raw_data/*_R1.fastq.gz'))

for i in range(len(R1_files)):
    prefix = R1_files[i].split('_R1.fastq')[0]
    justfile = prefix.split('/')[1]

        # -m: minimum read length
        # -O: minimum overlap with primer
    call('cutadapt -m 20 --discard-untrimmed -O 5 --cores=0 -b {} -o {} {} > {}'.format(
        SP_all, '1_out/'+justfile+'_R1_SP_trimmed.fastq.gz',
        R1_files[i], '1_reports/'+justfile+'_R1_SP.report'), shell=True)

    print('done with ' + R1_files[i])

## 1b. Trimming 12S and 16S adapters and separating reads by marker
R1_files = sorted(glob('1_out/*.fastq.gz'))

for i in range(len(R1_files)):
    prefix = R1_files[i].split('_trimmed')[0]
    justfile = prefix.split('/')[1]

        # -u: trim the Ns at the beginning of each read
        # -m: minimum read length
        # -O: minimum overlap with adapter
    call('cutadapt -u 6 -m 40 --discard-untrimmed -O 5 --cores=0 -a {} -b {} -o {} {} > {}'.format(
        a12S_R1, a12S_R1, '1_out/'+justfile+'_12S_trimmed.fastq.gz',
        R1_files[i], '1_reports/'+justfile+'_12S_trimmed.report'), shell=True)
    call('cutadapt -u 7 -m 40 --discard-untrimmed -O 5 --cores=0 -a {} -b {} -o {} {} > {}'.format(
        a16S_R1, a16S_R1, '1_out/'+justfile+'_16S_trimmed.fastq.gz',
        R1_files[i], '1_reports/'+justfile+'_16S_trimmed.report'), shell=True)
        
    print('done with ' + R1_files[i])

