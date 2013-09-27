import sys

"""
Renames PhyloPhlAn's obfuscated leaf names in newick-formatted
to their actual phylogenetic names and outputs the result
"""

if len(sys.argv) < 2:
    print "usage: %s tcodes2tax.txt < tree.nwk" % sys.argv[0]
    sys.exit(1)

tcode2tax = {}

for line in open(sys.argv[1]):
    line_split = line.strip().split()

    tax2group = {}

    for x in line_split[1].split("."):
        tax2group[x[:3]] = x[3:]

    if tax2group["s__"].endswith("_"):
        tax2group["s__"] = tax2group["s__"] + tax2group["t__"]
    else:
        tax2group["s__"] = tax2group["s__"] + "_" + tax2group["t__"]

    tcode2tax[line_split[0]] = tax2group["g__"] + "_" + tax2group["s__"]

for line in sys.stdin:
    for tcode, tax in tcode2tax.items():
        line = line.replace(tcode, tax)

    print line    
