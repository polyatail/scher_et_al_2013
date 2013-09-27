a <- read.table("20130327_lefse_a0.001_lda2.0.annotated.fixed.tab", sep="\t")

rownames(a) <- a$V1
a <- a[,-1]

colors = rep("gray", length(rownames(a)))
colors[grep("Bacteroid", rownames(a))] = "#67A9CF" # blue
colors[grep("Prevotella", rownames(a))] = "#EF8A62" # red

par(xpd=NA)

bp <- barplot(a$V4, horiz=T, col=colors, xlim=c(-6, 6), xlab="Effect Size")

split_ids <- strsplit(rownames(a), " ")
ids <- vector(length=nrow(a))

for (i in 1:nrow(a))
{
    ids[i] <- parse(text=paste(c("paste(", paste(unlist(split_ids[i]), collapse=", ' ', "), ")"), collapse=""))
}

text(-0.1, bp[which(a$V4 > 0)], ids[which(a$V4 > 0)], adj=c(1,0.5), cex=0.8)
text(0.1, bp[which(a$V4 < 0)], ids[which(a$V4 < 0)], adj=c(0,0.5), cex=0.8)
