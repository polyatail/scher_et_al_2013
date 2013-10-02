library(vegan)

colors <- c("#D9D9D9", "#FFFFB3", "#BEBADA", "#B3DE69", "#67A9CF", "#EF8A62", "#FDB462")

a <- read.table("20120927_otu_table_hierarchical.tab")

taxa <- a$V1[-(1:2)]
sids <- array(t(a[1,]))[-1]
groups <- array(t(a[2,]))[-1]

groups <- sub("^ERA$", "NORA", groups)
groups <- sub("^RA$", "CRA", groups)

groups <- factor(groups, levels=c("NORA", "HLT", "CRA", "PsA"))

a <- read.table("20120927_otu_table_hierarchical.tab", skip=2)

a <- a[,-1]

indiv_data <- matrix(0, ncol=ncol(a), nrow=12)

colnames(indiv_data) <- sids
rownames(indiv_data) <- c("invsimpson", "shannon",
                          "Firmicutes", "Bacteroidetes", "p_Other",
                          "Veillonellaceae", "Lachnospiraceae", "Ruminococcaceae",
                          "Porphyromonadaceae", "Bacteroidaceae", "Prevotellaceae", "f_Other")

for (i in 1:ncol(a))
{
    indiv_data["invsimpson", i] <- diversity(a[,i], index="invsimpson")
    indiv_data["shannon", i] <- diversity(a[,i], index="shannon")

    for (j in rownames(indiv_data)[-(1:2)])
    {
        indiv_data[j, i] <- sum(a[,i][grep(j, taxa)])
    }

    indiv_data["p_Other", i] <- 100 - sum(indiv_data[, i][3:4])
    indiv_data["f_Other", i] <- 100 - sum(indiv_data[, i][6:11])
}

# find mean abundances in groups
group_data <- matrix(0, ncol=4, nrow=10)

colnames(group_data) <- c("NORA", "HLT", "CRA", "PsA")
rownames(group_data) <- c("Firmicutes", "Bacteroidetes", "p_Other",
                          "Veillonellaceae", "Lachnospiraceae", "Ruminococcaceae",
                          "Porphyromonadaceae", "Bacteroidaceae", "Prevotellaceae",
                          "f_Other")

for (i in 1:ncol(group_data))
{
    for (j in rownames(group_data))
    {
        group_data[j, i] <- mean(indiv_data[j,][grep(colnames(group_data)[i], groups)])
    }
}

par(mfrow=c(2,2),
    mar=c(3.1, 4.1, 3.1, 2.1),
    oma=c(9, 0, 0, 0),
    xpd=NA)

boxplot(indiv_data["shannon",] ~ groups, ylab="Shannon Entropy", outline=F, ylim=c(1, 4.5))
stripchart(indiv_data["shannon",] ~ groups, vertical = T, add = T, method="jitter", jitter=0.35, pch=20)

boxplot(indiv_data["invsimpson",] ~ groups, ylab="Simpson Inverse", outline=F, ylim=c(0, 35))
stripchart(indiv_data["invsimpson",] ~ groups, vertical = T, add = T, method="jitter", jitter=0.35, pch=20)

barplot(group_data[1:3,], ylim=c(0, 100), ylab="% of Total Reads (mean)", col=c("#FCCDE5", "#8DD3C7", "#FDB462"))
barplot(group_data[-(1:3),], ylim=c(0, 100), ylab="% of Total Reads (mean)", col=colors)

legend(-5, -30, sub("p_", "", rownames(group_data[1:3,])), fill=c("#FCCDE5", "#8DD3C7", "#FDB462"))
legend(0.8, -24, sub("f_", "", rownames(group_data[-(1:3),])), fill=colors)
