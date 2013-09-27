## Panel A

ratios <- c(2.02213e-7, 0.06098268)
ratios_sd <- c(3.47576e-7, 0.01748356)

barx <- barplot(ratios, log="y", ylim=c(1e-7, 0.1), names.arg=c("Media", "P. copri"), ylab="Ratio P. copri / Universal 16S QPCR", col=c("black", "#ef8a62"), yaxt="no", cex.names=0.8)
axis(2, labels=c(parse(text="10^-7"), parse(text="10^-6"), parse(text="10^-5"), parse(text="10^-4"), parse(text="10^-3"), parse(text="10^-2"), parse(text="10^-1")), at=c(1e-7, 1e-6, 1e-5, 1e-4, 1e-3, 1e-2, 1e-1), las=1)
arrows(barx, ratios + ratios_sd, barx, ratios, angle=90, code=1, length=0.1)

