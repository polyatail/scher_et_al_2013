import sys
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio import SeqIO

pseudochrom = []

for x in SeqIO.parse(sys.stdin, "fasta"):
    pseudochrom.append(str(x.seq))

SeqIO.write(SeqRecord(Seq("".join(pseudochrom)), id=sys.argv[1], description=""), sys.stdout, "fasta")
