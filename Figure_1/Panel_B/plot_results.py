import sys
import pkg_resources

pkg_resources.require("matplotlib")

import matplotlib.pyplot as plot
import matplotlib
import numpy
from collections import defaultdict

try:
    sys.argv[2]
except IndexError:
    print "usage: %s 16s_otu_table.tab braycurtis.pcoa.axes" % sys.argv[0]
    sys.exit(1)

# load PCA coordinates
sample_to_coords = {}

for line in open(sys.argv[2], "r"):
    line_split = line.strip().split()

    if line.startswith("group"):
        continue

    sample_to_coords[line_split[0]] = (float(line_split[1]), float(line_split[2]))

# load Prevotella/Bacteroides abundances, and cohort groups
sample_to_bacteroides = defaultdict(float)
sample_to_prevotella = defaultdict(float)

for line in open(sys.argv[1], "r"):
    line_split = line.strip().split()

    if line.startswith("sid"):
        samples = line_split[1:]
        continue
    elif line.startswith("group"):
        group = line_split[1:]
        continue
    elif not line.startswith("Bacteria"):
        continue

    tax_split = line_split[0].split("|")

    for sample_name, tax_value in zip(samples, line_split[1:]):
        if "Bacteroides" in tax_split:
            sample_to_bacteroides[sample_name] += float(tax_value)

        if "Prevotella" in tax_split:
            sample_to_prevotella[sample_name] += float(tax_value)

sample_to_group = dict(zip(samples, group))

# color samples by Bacteroides/Prevotella abundances
cm2 = matplotlib.colors.LinearSegmentedColormap.from_list("blackblue", ["black", "#67A9CF"])

sample_to_color = {}

for sample_name in sample_to_coords.keys():
    sample_to_color[sample_name] = cm2(round(sample_to_bacteroides[sample_name]/float(100), 1))

    if sample_to_prevotella[sample_name] >= 10:
        sample_to_color[sample_name] = matplotlib.colors.colorConverter.to_rgba("#EF8A62")

# begin plot
fig = plot.figure()
ax = fig.add_subplot(111)

ax.set_xlabel("PC1")
ax.set_ylabel("PC2")

# find and plot different groups
def plot_group(group_name, marker_code):
    x = []
    y = []
    c = []
    
    for sample_name, sample_group in sample_to_group.items():
        if sample_group == group_name:
            x.append(sample_to_coords[sample_name][0])
            y.append(sample_to_coords[sample_name][1])
            c.append(sample_to_color[sample_name])

    ax.scatter(numpy.array(x), numpy.array(y), s=100, c=c, marker=marker_code, edgecolors="none")

plot_group("NORA", (5,1))
plot_group("RA", "s")
plot_group("PsA", "^")
plot_group("HLT", "o")

font = {"family": "Arial",
        "weight": "normal",
        "size": 16}

matplotlib.rc("font", **font)

# plot colorbar
bar_fig = plot.figure(figsize=(4,1.5))
ax1 = bar_fig.add_axes([0.05, 0.65, 0.9, 0.15])

norm = matplotlib.colors.Normalize(vmin=0, vmax=100)
cb1 = matplotlib.colorbar.ColorbarBase(ax1, cmap=cm2,
                                   norm=norm,
                                   orientation="horizontal")
cb1.set_label("Percent Bacteroides")

plot.show()
