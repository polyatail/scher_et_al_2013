## Panel C

library(sfsmisc)

par(xpd=NA)

a <- read.table("dss_timecourse.csv", header=T)
errbar(a$Day, a$Prevotella, a$Prevotella + a$Prevotella_SD, a$Prevotella - a$Prevotella_SD, ylim=c(90, 105), type="b", pch=15, lwd=3, xlab="Day", ylab="% of Starting Body Weight", col="#ef8a62")
par(new=T)
errbar(a$Day, a$Media, a$Media + a$Media_SD, a$Media - a$Media_SD, ylim=c(90, 105), type="b", pch=19, axes=F, xlab="", ylab="")

legend(0, 95, c("Media", "P. copri"), col=c("black", "#ef8a62"), pch=c(19, 15))
text(c(4, 6, 7, 8, 9), c(104, 103, 103, 100.5, 98.5), c("*", "*", "**", "*", "*"), cex=1.5)
text(2.25, 99, "* p<0.05\n** p<0.01", adj=c(1,1))

segments(0, 106, 7, 106, lwd=2)
text(3.5, 107, "DSS")
