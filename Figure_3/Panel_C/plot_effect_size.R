a <- read.table("pres_abs.filtered.fdr_0.25.display.tab", header=T)
b <- a[order(a$effect_size),]

stripped_IDs <- sub("gene_id_", "", b$ID)

png(filename="20130327_effect_size.png", width=800, height=600, res=175)
bp <- barplot(b$effect_size, ylab="Effect Size", horiz=F, col=c(rep("#ee8961", length(which(b$effect_size < 0))), rep("#66a8ce", length(which(b$effect_size > 0)))))#, cex.lab=0.9, cex.axis=0.9)
text(bp[which(b$effect_size > 0)], 0.05, stripped_IDs[which(b$effect_size > 0)], adj=c(0,0.5), srt=90)#, cex=0.5)
text(bp[which(b$effect_size < 0)], -0.05, stripped_IDs[which(b$effect_size < 0)], adj=c(1,0.5), srt=90)#, cex=0.5)
dev.off()
