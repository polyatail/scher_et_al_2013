#!/bin/bash

for i in ../nucmer_out/*.coords; do
    python ../src/nucmer2links.py `echo $i | cut -d '/' -f 3 | cut -d '.' -f 1 | cut -d '_' -f 1` \
      `echo $i | cut -d '/' -f 3 | cut -d '.' -f 1 | cut -d '_' -f 2` < $i > \
      `basename $i | sed 's/.coords/.links/'`
done
