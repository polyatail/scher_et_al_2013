## Panel D

boxplot(data ~ groups, outline=F, ylim=c(0, 15), border="white", ylab="Endoscopy Score")
segments(2.25, 8, 1.75, 8, lwd=2)
segments(0.75, 3.8, 1.25, 3.8, lwd=2)
stripchart(data ~ groups, vertical=T, method="stack", offset=1, pch=c(19, 15), ylim=c(0, 15), col=c("black", "#EF8A62"), add=T, cex=1.2)
segments(1, 12, 2, 12)
text(1.5, 14, "p<0.01")
