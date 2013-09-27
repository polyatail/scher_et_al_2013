import sys
from collections import defaultdict

# Adds up Prevotella/Bacteroides abundances in 16S table
# and outputs a single table with a line for each with
# samples sorted by decreasing Prevotella abundance and
# increasing Bacteroides abundance

try:
    sys.argv[1]
except IndexError:
    print "usage %s 16s_otu_table.tab" % sys.argv[0]
    sys.exit(1)

sample_data = defaultdict(lambda: defaultdict(float))

# analyze 16S
for line_num, line in enumerate(open(sys.argv[1], "r")):
    line_split = line.strip().split("\t")

    if line_num == 0:
        samples = line_split[1:]
    elif line_num == 1:
        conditions = line_split[1:]

        for sample, condition in zip(samples, conditions):
            sample_data[sample]["condition"] = condition
            sample_data[sample]["sid"] = sample
    else:
        taxon = line_split[0]

        for sample, abundance in zip(samples, line_split[1:]):
            if "Prevotella" in taxon:
                sample_data[sample]["prevotella"] += float(abundance)

            if "Bacteroides" in taxon:
                sample_data[sample]["bacteroides"] += float(abundance)

condition_order = ["NORA", "HLT", "RA", "PsA"]

def sample_sorter(sample1, sample2):
    x = sample1.copy()
    y = sample2.copy()

    if x["prevotella"] < 5:
        x["prevotella"] = 0
    
    if y["prevotella"] < 5:
        y["prevotella"] = 0

    if condition_order.index(x["condition"]) < \
       condition_order.index(y["condition"]):
        return -1
    elif condition_order.index(x["condition"]) == \
       condition_order.index(y["condition"]):
        if x["prevotella"] < y["prevotella"]:
            return 1
        elif x["prevotella"] == y["prevotella"]:
            if x["bacteroides"] < y["bacteroides"]:
                return -1
            elif x["bacteroides"] == y["bacteroides"]:
                return 0
            elif x["bacteroides"] > y["bacteroides"]:
                return 1
        elif x["prevotella"] > y["prevotella"]:
            return -1
    elif condition_order.index(x["condition"]) > \
       condition_order.index(y["condition"]):
        return 1 

sorted_samples = sorted(sample_data.values(), cmp=sample_sorter)

samples = [x["sid"] for x in sorted_samples]

sys.stdout.write("\t".join(["sid"] + samples) + "\n")
sys.stdout.write("\t".join(["group"] + [sample_data[x]["condition"] for x in samples]) + "\n")
sys.stdout.write("\t".join(["Prevotella"] + [str(sample_data[x]["prevotella"]) for x in samples]) + "\n")
sys.stdout.write("\t".join(["Bacteroides"] + [str(sample_data[x]["bacteroides"]) for x in samples]) + "\n")
