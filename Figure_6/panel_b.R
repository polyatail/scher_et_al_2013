## Panel B

par(xpd=NA)
par(oma=c(9,0,0,0))

colors <- c("#fdb462", "#67a9cf", "#ef8a62", "#fffdb3")
mouse_data <- read.table("stripped_otu_table.tab", header=T, row.names=1, sep="\t")
mouse_data <- mouse_data * 100
barplot(as.matrix(mouse_data), col=colors, ylab="% of Total Reads", names.arg=c("#1", "#2", "#1", "#2"))

segments(2.6, 105, 4.8, 105, lwd=2)
segments(0.2, 105, 2.4, 105, lwd=2)
text(1.3, 112, "Media")
text(3.7, 112, "P. copri")

legend(0, -42, row.names(mouse_data), fill=colors)
par(oma=c(0,0,0,0))
