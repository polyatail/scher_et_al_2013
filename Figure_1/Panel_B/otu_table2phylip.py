import sys
from collections import defaultdict

"""
Calculates Bray-Curtis distances from OTU table and
outputs the resulting distance matrix in PHYLIP format
"""

try:
    sys.argv[1]
except IndexError:
    print "usage: %s 16s_otu_table.tab" % sys.argv[0]
    sys.exit(1)

def braycurtis(vector1, vector2):
    num = sum([min(x, y) for x, y in zip(vector1, vector2)])
    denom = sum(vector1) + sum(vector2)

    return 1 - ((2 * float(num)) / float(denom))

# load otu table
sample_to_vector = defaultdict(list)

for line in open(sys.argv[1], "r"):
    line_split = line.strip().split()

    if line.startswith("sid"):
        samples = line_split[1:]
        continue
    elif line.startswith("group"):
        continue

    for sample_name, otu_abund in zip(samples, line_split[1:]):
        sample_to_vector[sample_name].append(float(otu_abund))

# calc distances
print "\t%s" % len(samples)

for sample_num1, sample_name1 in enumerate(samples):
    row = [sample_name1]

    for sample_num2, sample_name2 in enumerate(samples[:sample_num1]):
        row.append(braycurtis(sample_to_vector[sample_name1], sample_to_vector[sample_name2]))

    print "\t".join(map(str, row))        
