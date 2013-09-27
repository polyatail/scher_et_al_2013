par(xpd=NA)

a <- read.table("20120918_patient_data.tab", header=T, row.names=1, sep="\t")
a <- a[order(rownames(a)),]

c <- read.table("20120927_otu_table_hierarchical.tab")

d <- matrix(0, ncol=4, nrow=114)
row.names(d) <- array(t(c[1,]))[-1]
d[,1] <- as.numeric(array(t(c[6,])))[-1]
d[,2] <- as.numeric(array(t(c[12,])))[-1]
d[,3] <- as.numeric(array(t(c[934,])))[-1]
d[,4] <- d[,1] + d[,2] + d[,3]
d <- as.matrix(d[order(rownames(d)),])
colnames(d) <- c("OTU4", "OTU12", "OTU934", "Pcopri")

a$Pcopri <- d[,1]

a$SE_status <- 0
a$SE_status[which(a$SE > 0)] <- 1
a$SE_status <- factor(a$SE_status, c(1, 0))

a$Disease = factor(a$Disease, c("NORA", "CRA", "HLT"))

a <- a[which(!is.na(a$SE)),]

boxplot(a$Pcopri ~ a$SE_status + a$Disease, ylim=c(0, 100), ylab="Prevotella copri Relative Abundance (%)", outline=F, xaxt="no")
stripchart(a$Pcopri ~ a$SE_status + a$Disease, add=T, vertical=T, method="jitter", jitter=0.35, pch=c(-0x2605L, -0x2606L, 15, 0, 19, 1), cex=1, col=c("#ef8a62", "#ef8a62", "black", "black", "#67a9cf", "#67a9cf"), lwd=2)

axis(1, at=1:6, labels=c("NORA +SE", "NORA -SE", "CRA +SE", "CRA -SE", "HLT +SE", "HLT -SE"), cex.axis=0.8)

segments(1, 80, 2, 80)
segments(3, 60, 4, 60)
segments(5, 60, 6, 60)

nora_nose <- a[which(a$SE_status == 0 & a$Disease == "NORA"),]$Pcopri
nora_se <- a[which(a$SE_status == 1 & a$Disease == "NORA"),]$Pcopri
nora_ttest <- t.test(nora_nose, nora_se)

if (nora_ttest$p.value < 0.001) {
    text(1.5, 85, "p<0.001")
} else {
    text(1.5, 85, paste("p=", round(nora_ttest$p.value, 3), sep=""))
}

cra_nose <- a[which(a$SE_status == 0 & a$Disease == "CRA"),]$Pcopri
cra_se <- a[which(a$SE_status == 1 & a$Disease == "CRA"),]$Pcopri
cra_ttest <- t.test(cra_nose, cra_se)
text(3.5, 65, paste("p=", round(cra_ttest$p.value, 3), sep=""))

hlt_nose <- a[which(a$SE_status == 0 & a$Disease == "HLT"),]$Pcopri
hlt_se <- a[which(a$SE_status == 1 & a$Disease == "HLT"),]$Pcopri
hlt_ttest <- t.test(hlt_nose, hlt_se)
text(5.5, 65, paste("p=", round(hlt_ttest$p.value, 3), sep=""))

text(1:6, -17, c(paste("(n=", length(nora_se), ")", sep=""),
                 paste("(n=", length(nora_nose), ")", sep=""),
                 paste("(n=", length(cra_se), ")", sep=""),
                 paste("(n=", length(cra_nose), ")", sep=""),
                 paste("(n=", length(hlt_se), ")", sep=""),
                 paste("(n=", length(hlt_nose), ")", sep="")), cex=0.8)
