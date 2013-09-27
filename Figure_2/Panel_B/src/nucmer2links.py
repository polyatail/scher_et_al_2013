import sys
from Bio import SeqIO

if len(sys.argv) < 3:
    print "usage: %s ref_label target_label < nucmer.coords" % sys.argv[0]
    sys.exit(1)

parse = False
link_count = 1

for line in sys.stdin:
    if parse == False:
        if line.startswith("="):
            parse = True

        continue

    line_split = line.rstrip("\n").split()

    # skip synteny < 300bp
    if abs(int(line_split[1]) - int(line_split[0])) < 300:
        continue

    print " ".join(map(str, ["link%d" % link_count, sys.argv[1],
                             line_split[0], line_split[1]]))

    print " ".join(map(str, ["link%d" % link_count, sys.argv[2],
                             line_split[3], line_split[4]]))

    link_count += 1
