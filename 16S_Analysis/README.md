16S_Analysis
================

* **20120919_OTU_seeds.fa** FASTA file containing the seed sequences from each
  OTU called in the analysis. Headers are formatted as such:

  ```
  printf(">%s %d|%d", read_name, otu_number, reads_mapping_to_otu);
  ```

* **20120919_otu_table.counts.tab** OTU table with read counts rather than
  relative abundances.

* **20120927_otu_table_hierarchical.tab** OTU table with relative abundances
