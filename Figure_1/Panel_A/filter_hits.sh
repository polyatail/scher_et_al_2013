#!/bin/bash

grep NORA 20121023_lefse_a0.001_lda2.0.tab | sort -k4,4nr | awk '{printf $1"\t"$2"\t"$3"\t-"$4"\t"$5"\n"}' > filtered.tab
grep HLT 20121023_lefse_a0.001_lda2.0.tab | sort -k4,4n >> filtered.tab
