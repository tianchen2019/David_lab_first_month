migrasome_heatmap.r
migara<-read_excel("./tsapn_family.xlsx",col_names = T)
count_zong<- read_excel("./new/counts_norm.xlsx",col_names = T)
library(biomaRt)
library(clusterProfiler)
library(org.Hs.eg.db)
human = useMart("ensembl", dataset = "hsapiens_gene_ensembl")
mouse = useMart("ensembl", dataset = "mmusculus_gene_ensembl")

###gene_id_to_gene_name
genes=getBM(attributes = c('ensembl_gene_id','mgi_symbol'),filters='ensembl_gene_id',
      values = count_zong$id,mart = mouse)
rownames(count_zong)=count_zong$id
#É¾³ıNAĞĞ£ºgenes2<-genes[complete.cases(genes),] 
select=(genes$mgi_symbol !="")
id<-genes$ensembl_gene_id[select]
gene_name<-genes$mgi_symbol[select]
count_zong2<-count_zong[id,]
rownames(count_zong2)<- count_zong2$id
#rm(count_zong2)

count_zong2<-as.matrix(count_zong2)
rownames(count_zong2)<-gene_name
count_zong2<-count_zong2[,2:49]

mig_gene<-c(migara$gene)
a<-intersect(mig_gene,rownames(count_zong2))
count3<-count_zong2[a,]
count4<-matrix(as.numeric(count3),nrow=nrow(count3))
rownames(count4)<-rownames(count3)
colnames(count4)<-colnames(count3)
#heatmap
factors1=c(rep("D0_WT",times=6),rep("D2_WT",times=9),rep("D7_WT",times=9),rep("D0_Kras",times=6),rep("D2_Kras",times=9),rep("D7_Kras",times=9))
annotation_col= data.frame(type = factor(factors1))
rownames(annotation_col)= colnames(count_zong2)
bk = unique(c(seq(-2,2, length=15)))
annotation_color <- list(Condition =c(D0_WT="#0079bf", D2_WT="#70b500", D7_WT="#ff9f1a",
                                      D0_Kras="#eb5a46", D2_Kras="#f2d600", D7_Kras="#c377e0"))
pdf("magra_new1.pdf")
pheatmap(log2(count4+1),gaps_col=c(6,15,24,30,39,48),
         #gaps_row = c(41,56,66,93,136,150,165,186,189,198,206,222,235,240,244),
         breaks = bk,cluster_rows=T,cluster_cols=F,
         border_color="grey60",scale = 'row',
         color = colorRampPalette(c("blue", "white","red"))(15),
         show_rownames = T,show_colnames =F,annotation_col = annotation_col,
         #annotation_row = annotation_row_zong,
         annotation_colors=annotation_color,
         fontsize=4,fontsize_row = 7,cellwidth = 7,cellheight =7)
dev.off()

###different_gene_overlap
up_data<-read_excel("./new/gene_list_ k-lockedUP.xlsx",col_names = T)
down_data<- read_excel("./new/gene_list_k-lockedDOWN.xlsx",col_names = T)
chayi_gene<-c(up_data$mgi_symbol,down_data$mgi_symbol)
b<-intersect(chayi_gene,mig_gene)
chayi_count<-count_zong2[b,]
chayi_count2<- matrix(as.numeric(chayi_count),nrow=nrow(chayi_count))
rownames(chayi_count2)<-rownames(chayi_count)
colnames(chayi_count2)<-colnames(chayi_count)
pdf("magra_diff4.pdf")
pheatmap(log2(chayi_count2+1),gaps_col=c(6,15,24,30,39,48),
         #gaps_row = c(41,56,66,93,136,150,165,186,189,198,206,222,235,240,244),
         breaks = bk,cluster_rows=T,cluster_cols=F,
         border_color="grey60",scale = 'row',
         color = colorRampPalette(c("blue", "white","red"))(15),
         show_rownames = T,show_colnames =F,annotation_col = annotation_col,
         #annotation_row = annotation_row_zong,
         annotation_colors=annotation_color,
         fontsize=4,fontsize_row = 7,cellwidth = 7,cellheight = 7)
dev.off()
