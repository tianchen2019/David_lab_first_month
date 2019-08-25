*heatmap.r*
###heatmap
rm(list=ls())
setwd("F:/R_wenjian/new")
data<- read_excel("count_new.xlsx",col_names = T)

matrix=as.matrix(data[,4:51])
m1<-as.matrix(data[,1])
#matrix_jia<-cbind(m1,matrix)
rownames(matrix)=data$gene
#rownames(matrix2)=c(1:235)
c<-unique(data$gene)
matrix2<-matrix[c,]
#mtc<-matrix2[,2:49]

write.table(annotation_row,file = "qu_chong_gene_path.tsv",row.names = F, sep="\t", quote=F)

###fen_pathway
matrix_jia<-cbind(m1,matrix)
matrix_jia<-matrix_jia[c,]
mtc<-matrix_jia[,2:49]


pathway<-unique(annotation_row_zong$pathway)
pathway
write.table(pathway,file="pathway.txt",row.names = F,sep="\t")
#heatmap:
library(pheatmap)
factors1=c(rep("D0_WT",times=6),rep("D2_WT",times=9),rep("D7_WT",times=9),rep("D0_Kras",times=6),rep("D2_Kras",times=9),rep("D7_Kras",times=9))
annotation_col= data.frame(type = factor(factors1))
rownames(annotation_col)= colnames(matrix2)

annotation_row=data.frame(pathway=factor(matrix_jia[,1]))
rownames(annotation_row) = rownames(matrix_jia) 

pdf("new3.pdf")
bk = unique(c(seq(-2.5,2.5, length=15)))
annotation_color <- list(Condition =c(D0_WT="#0079bf", D2_WT="#70b500", D7_WT="#ff9f1a",
                                      D0_Kras="#eb5a46", D2_Kras="#f2d600", D7_Kras="#c377e0"))

pheatmap(log2(matrix2+1),gaps_col=c(6,15,24,30,39,48),
         gaps_row = c(41,56,66,93,136,150,165,186,189,198,206,222,235,240,244),
         breaks = bk,cluster_rows=F,cluster_cols=F,
         border_color="grey46",scale = 'row',
         color = colorRampPalette(c("blue", "white","red"))(15),
         show_rownames = T,show_colnames =F,annotation_col = annotation_col,
         annotation_row = annotation_row,
         annotation_colors=annotation_color,
         fontsize=4,fontsize_row = 2)
dev.off()

###cili_GO
cili_data<-read_excel("cili_path.xlsx",col_names = T)
cili<-as.matrix(cili_data[,4:51])
rownames(cili)<-cili_data$gene
cili<-cili[unique(cili_data$gene),]
dim(cili)
cili_jia<-as.matrix(cili_data[,1:2])
rownames(cili_jia)<-cili_data$gene
cili_jia<-cili_jia[unique(cili_data$gene),]
matrix_zong<-rbind(matrix2,cili)
annotation_row2=data.frame(pathway=factor(cili_jia[,1]))
rownames(annotation_row2) = rownames(cili_jia)
annotation_row_zong<-rbind(annotation_row,annotation_row2)
pdf("zong3.pdf")
pheatmap(log2(matrix_zong+1),#gaps_col=c(6,15,24,30,39,48),
         #gaps_row = c(41,56,66,93,136,150,165,186,189,198,206,222,235,240,244),
         breaks = bk,cluster_rows=F,cluster_cols=F,
         border_color="grey46",scale = 'row',
         color = colorRampPalette(c("blue", "white","red"))(15),
         show_rownames = T,show_colnames =F,annotation_col = annotation_col,
         annotation_row = annotation_row_zong,
         annotation_colors=annotation_color,
         fontsize=4,fontsize_row = 1)
dev.off()
