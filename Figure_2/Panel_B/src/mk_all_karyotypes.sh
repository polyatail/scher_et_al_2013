#!/bin/bash

for i in ../assemblies/*.fa; do python ../src/contig_to_circos.py $i `basename $i | cut -d '_' -f 2` > `basename $i | cut -d '_' -f 2`.karyotype; done
