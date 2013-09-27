#!/bin/bash

for i in *.fa; do
    SUBJ_1=`echo $i | cut -d '_' -f 2`

    for j in *.fa; do
        SUBJ_2=`echo $j | cut -d '_' -f 2`

        nucmer $i $j -p ${SUBJ_1}_${SUBJ_2}
    done
done
