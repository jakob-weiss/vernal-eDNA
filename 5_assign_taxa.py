## Adapted from:
## https://github.com/MelissaIngala/BelizeBatDiets/blob/master/OBITools%20analysis.txt

from glob import glob
from subprocess import call

# working with step 2 output (dereplicated at sample-level);
# could also work with step 3 output (globally dereplicated)
for f in glob('2_out/*derep*fasta'):
    prefix = '5_out/'+f.split('/')[-1].split('.')[0]
    tagged = prefix+'_tagged.fasta'
    done = prefix+'_tagged_done.fasta'
    tab = prefix+'_tagged_done_tab.txt'
    
    # assign taxonomy
    if '12S' in f:
        call('ecotag -d /scratch/weissjy/eDNA/TAXO -m 0.90 -R /scratch/weissjy/eDNA/ref_dbs/12S_ref_db_final.fasta {} > {}'.format(f, tagged),\
                shell=True)
    else:
        call('ecotag -d /scratch/weissjy/eDNA/TAXO -m 0.90 -R /scratch/weissjy/eDNA/ref_dbs/16S_ref_db_final.fasta {} > {}'.format(f, tagged),\
                shell=True)

    # get rid of unwanted information
    call('obiannotate  --delete-tag=scientific_name_by_db --delete-tag=obiclean_samplecount --delete-tag=obiclean_count --delete-tag=obiclean_singletoncount --delete-tag=obiclean_cluster --delete-tag=obiclean_internalcount --delete-tag=obiclean_head --delete-tag=taxid_by_db --delete-tag=obiclean_headcount  --delete-tag=id_status --delete-tag=rank_by_db {} > {}'.format(tagged, done), shell=True)
    
    # make fasta into tabulated format
    call('obitab -o {} > {}'.format(done, tab), shell=True)

for f in glob('5_out/*derep_tagged_done.fasta'):
    prefix = f.split('.')[0]
    matched = prefix+'_matched.fasta'
    tab = prefix+'_matched_tab.txt'
    
    # keep only reads for which at least one match has been found
    # if more than one match found, keep only the best match(es)
    # output in fasta and tabulated formats
    call('obigrep -A best_match {} > {}'.format(f, matched), shell=True)
    call('obitab -o {} > {}'.format(matched, tab), shell=True)
    