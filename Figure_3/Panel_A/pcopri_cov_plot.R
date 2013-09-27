a <- read.table("20130319_pcopri_cov_fpkm.tab", header=T)

rownames(a) <- a$marker
a <- a[,-1]
b <- log10(a + 1)
c <- boxplot(b, plot=F)

meds <- sapply(b, median)

healthy_b <- rbind(b["019",], b["093",], b[grep("^SRS", row.names(b)),])
nora_b <- b[grep("^SRS", row.names(b), invert=T),]
nora_b <- nora_b[grep("(019B|093B)", row.names(nora_b), invert=T),]

healthy_means <- sapply(healthy_b, mean)
nora_means <- sapply(nora_b, mean)

bound <- read.table("20130318_pcopri_contig_bounds.tab")[,1] / 1000
m <- read.table("20130325_pcopri_markers.var.b6")
m$V9 <- m$V9 / 1000
m$V10 <- m$V10 / 1000

par(xpd=NA)

plot(meds, pch=20, cex=0.2, col="gray", bty="n", ylab="log10(FPKM)", xlab="", xaxt="n", cex.lab=0.9, cex.axis=0.9)
axis(side=3, cex.axis=0.9, cex.lab=0.9)
text(3700, 2.54, "kb", cex=0.9)
axis(side=3, at=bound, col=rgb(0,0,0,0.3), labels=F)
for(x in 1:length(b)) { segments(x, c$stats[2,x], x, c$stats[4,x], col=rgb(204, 204, 204, 128, maxColorValue=255)) }
lines(lowess(nora_means, f=0.01), col="#ee8961", lwd=2)
lines(lowess(healthy_means, f=0.01), col="#66a8ce", lwd=2)

for (i in 1:62) {
  rect(xleft=m[i,9], xright=m[i,10], ybottom=-0.2, ytop=-0.1, border=rgb(5, 113, 176, maxColorValue=255))
}
