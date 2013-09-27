png(filename="fourpanel_figure.png", width=1600, height=1400, res=200)

par(mfrow=c(2, 2),
    mar=c(4.1, 4.1, 1.1, 1.1))

# panel A

table <- read.table("20130327_all_hits_id_cov.tab")

plot(table$V2, table$V3,
     xlab="Identity",
     ylab="Coverage",
     xlim=c(0.9, 1),
     col=rgb(0, 0, 0, 0.01),
     cex=0.1, pch=20)

abline(v=0.97, col="red", lty=3)
abline(h=0.95, col="red", lty=3)

# panel B

table <- read.table("20130208_derep_id_counts.tab", header=T)

plot(table$id, table$orfs,
     type="l",
     xlab="Identity",
     ylab="Dereplicated ORFs")

abline(v=0.97, col="red", lty=3)

# panel C

table <- read.table("20130327_pres_orfs_vs_read_count.tab", header=T)

plot(((table$percent_pcopri / 100) * table$read_count) / 1e6,
     table$orfs_present,
     xlab="Expected P. copri Reads (millions)",
     ylab="P. copri ORFs Present",
     cex=0.5, pch=20)

abline(v=7, col="red", lty=3)
abline(h=3000, col="red", lty=3)

# panel D

table <- read.table("all_hits_id_length.tab", header=T)

plot(table$id / 100, table$length,
     ylim=c(0, 2000),
     xlab="Identity",
     ylab="Length",
     col=rgb(0, 0, 0, 0.1),
     cex=0.1, pch=20)

abline(v=0.97, col="red", lty=3)
abline(h=300, col="red", lty=3)

dev.off()
