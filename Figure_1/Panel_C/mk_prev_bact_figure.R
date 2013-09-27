library(Cairo)

a <- read.table("20121022_prev_bact_abund.tab")

b <- a[3:4,]
rownames(b) <- b$V1
b <- b[,-1]
colnames(b) <- array(t(a[1,-1]))

names(b) <- NULL

space_vector <- c(rep(0.25, length(which(a[2,] == "NORA"))), 2.0,
                  rep(0.25, length(which(a[2,] == "HLT"))-1), 2.0,
                  rep(0.25, length(which(a[2,] == "RA"))-1), 2.0,
                  rep(0.25, length(which(a[2,] == "PsA"))-1))

#png(filename="20130327_prev_bact_abund.png", height=500, width=2190, res=200)

par(mar=c(2,5,1,0))

barplot(as.matrix(b), border=NA,
        col=c(rgb(239,138,98, maxColorValue=255), rgb(103,169,207, maxColorValue=255)),
        ylim=c(0,100), las=2, xlab="", ylab="% of Total Reads", space=space_vector, width=rep(1, ncol(b)))

mtext(side=1, text="Subject", line=0.5)

#dev.off()
