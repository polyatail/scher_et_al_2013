import sys
from Bio import SeqIO

if len(sys.argv) < 3:
    print "usage: %s contigs.fa label" % sys.argv[0]
    sys.exit(1)

contig_to_length = {}

for x in SeqIO.parse(sys.argv[1], "fasta"):
    contig_to_length[x.id] = len(str(x.seq))

#contig_to_length = dict(sorted(contig_to_length.items(), key=lambda x: x[1]))

print " ".join(map(str, ["chr", "-", sys.argv[2], sys.argv[2], 0,
                         sum(contig_to_length.values()), sys.argv[2]]))

running_total = 0

for contig, length in contig_to_length.items():
    print " ".join(map(str, ["band", sys.argv[2], contig, contig, 
                             running_total, running_total + length, sys.argv[2]]))

    running_total += length
