setwd("F:/R_wenjian/deeptools/profile/")
library(ggplot2)
library(openxlsx)
library(reshape2)
#klf5_repress
rm(list=ls())
data <- t(read.xlsx("klf5_depend.xlsx", rowNames = TRUE, colNames = FALSE))
#rownames(data) <- seq(-3000, 2990, 10)
#wt_tmp <- data[c(201:401), c(5:10)]
#kras_tmp <- data[c(201:401), c(11:16)]
rownames(data) <- seq(-3000, 2990, 10)
wt_tmp <- data[, c(5:10)]
kras_tmp <- data[, c(11:16)]
D0_WT <- rowMeans(wt_tmp[, c(1:2)])
D2_WT <- rowMeans(wt_tmp[, c(3:4)])
D7_WT <- rowMeans(wt_tmp[, c(5:6)])

D0_Kras <- rowMeans(kras_tmp[, c(1:2)])
D2_Kras <- rowMeans(kras_tmp[, c(3:4)])
D7_Kras <- rowMeans(kras_tmp[, c(5:6)])
wt <- data.frame(D0_WT, D2_WT, D7_WT)
#wt <- wt[c(1:600), ]
wt <- apply(wt, 2, function(x) (x-min(x)))
wt <- as.data.frame(wt)
wt$bin <- as.numeric(rownames(wt))
wt_mat <- melt(wt, id = "bin")
names(wt_mat)[2] <- "sample"
pdf("kras_repress_wt.pdf")
ggplot(wt_mat, aes(x = bin, y = value, color = sample)) + geom_line(size = 1) +
  theme_bw() + theme(panel.grid.major=element_blank(),panel.grid.minor=element_blank()) +
  xlab("peaks center") + ylab("ATAC-seq intensity") + scale_x_continuous(breaks=c(-3000, 3000), labels = c("-3kb", "3kb"))
dev.off()
###ks_test
test1<-ks.test(wt[50:150,2],wt[50:150,1])
test2<-ks.test(wt[50:150,3],wt[50:150,2])
test3<-ks.test(wt[50:150,3],wt[50:150,1])
max(wt[50:150,2])/max(wt[50:150,1])
max(wt[50:150,3])/max(wt[50:150,2])
max(wt[50:150,3])/max(wt[50:150,1])



test1<-ks.test(wt[201:401,2],wt[201:401,1])
test2<-ks.test(wt[201:401,3],wt[201:401,2])
test3<-ks.test(wt[201:401,3],wt[201:401,1])
max(wt[201:401,2])/max(wt[201:401,1])
max(wt[201:401,3])/max(wt[201:401,2])
max(wt[201:401,3])/max(wt[201:401,1])
 
###klf5_kras mutation
kras <- data.frame(D0_Kras, D2_Kras, D7_Kras)
#kras <- kras[c(1:600), ]
kras <- apply(kras, 2, function(x) (x-min(x)))
kras <- as.data.frame(kras)
kras$bin <- as.numeric(rownames(kras))
kras_mat <- melt(kras, id = "bin")
names(kras_mat)[2] <- "sample"
pdf("kras_repress_kras_mu.pdf")
ggplot(kras_mat, aes(x = bin, y = value, color = sample)) + geom_line(size = 1) +
  theme_bw() + theme(panel.grid.major=element_blank(),panel.grid.minor=element_blank()) +
  xlab("peaks center") + ylab("ATAC-seq intensity") + scale_x_continuous(breaks=c(-3000, 3000), labels = c("-3.0kb", "3.0kb"))
dev.off()

test1<-ks.test(kras[50:150,2],kras[50:150,1])
test2<-ks.test(kras[50:150,3],kras[50:150,2])
test3<-ks.test(kras[50:150,3],kras[50:150,1])
max(kras[50:150,2])/max(kras[50:150,1])
max(kras[50:150,3])/max(kras[50:150,2])
max(kras[50:150,3])/max(kras[50:150,1])


test1<-ks.test(kras[201:401,2],kras[201:401,1])
test2<-ks.test(kras[201:401,3],kras[201:401,2])
test3<-ks.test(kras[201:401,3],kras[201:401,1])
max(kras[201:401,2])/max(kras[201:401,1])
max(kras[201:401,3])/max(kras[201:401,2])
max(kras[201:401,3])/max(kras[201:401,1])
