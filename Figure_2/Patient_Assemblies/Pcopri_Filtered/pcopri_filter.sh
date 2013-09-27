#!/bin/bash

# BLAST metagenomes against P. copri reference
for i in `ls ../Unfiltered/*.fa`; do
    blastn -subject $i -query wustl_ref_assembly.fa -evalue 1e-5 -outfmt 6 > `basename $i | sed 's/.fa/.b6/'`
done

# Figure out which contigs hit with at least 97% identity
# over 300 nt or more, we'll keep these
for i in *.b6; do
    awk '{if ($3 >= 97 && $4 >= 300) { printf $2"\n"}}' $i | sort -u > `echo $i | sed 's/.b6/.kept/'`
done

# Extract kept contigs into a new, P. copri filtered fasta
for i in *.kept; do
    env PYTHONPATH=~/pyfasta-0.4.5 pyfasta extract --header --space --fasta=../Unfiltered/`echo $i | sed 's/.kept/.fa/'` --file $i > `echo $i | sed 's/.kept/.filtered.fa/'`
done
