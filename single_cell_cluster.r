*Scripts : single_cell_cluster.r*
`rm(list = ls())
setwd("F:/R_wenjian")
library(Seurat)
library(data.table)
library(stringr)
library(dplyr)
library(rtracklayer)
library(ggplot2)
counts_d2 <- as.data.frame(fread("hebing_count.txt"))
gtf <- import("gencode.vM21.chr_patch_hapl_scaff.annotation.gtf.gz")
protein <- unique(gtf$gene_name[gtf$transcript_type %in% "protein_coding"])
mito <- unique(gtf$gene_name[as.character(seqnames(gtf)) %in% "chrM"])
genes_name <- unique(c(protein, mito))
  
rownames(counts_d2) <- counts_d2$Geneid
counts_d2 <- counts_d2[, c(7:93)]
#colnames(counts_d2) <- str_split_fixed(colnames(counts_d2), "/", 2)[, 1]
colnames(counts_d2)<- rownames(metadata2)
counts_d2<- counts_d2[genes_name, ]

klf5_d2 <- CreateSeuratObject(counts = counts_d2, project = "klf5_day2", min.cells = 3, min.features = 200)
klf5_d2[["percent.mt"]] <- PercentageFeatureSet(klf5_d2, pattern = "^mt-")
VlnPlot(klf5_d2, features = c("nFeature_RNA", "nCount_RNA", "percent.mt"), ncol = 3)
klf5_d2 <- subset(klf5_d2, subset = nFeature_RNA > 1000  & nCount_RNA >200 & percent.mt < 10)
klf5_d2 <- NormalizeData(klf5_d2, normalization.method = "LogNormalize", scale.factor = 10000)
klf5_d2 <- FindVariableFeatures(klf5_d2, selection.method = "vst", nfeatures = 3000)
#top15 <- head(VariableFeatures(klf5_d2), 15)
#plot1 <- VariableFeaturePlot(klf5_d2)
#LabelPoints(plot = plot1, points = top15, repel = TRUE)
all.genes <- rownames(klf5_d2)
klf5_d2 <- ScaleData(klf5_d2, features = all.genes)
klf5_d2 <- RunPCA(klf5_d2, features = VariableFeatures(object = klf5_d2))

klf5_d2 <- JackStraw(klf5_d2, num.replicate = 100)
klf5_d2 <- ScoreJackStraw(klf5_d2, dims = 1:20)

klf5_d2 <- FindNeighbors(klf5_d2, dims = 1:10)
klf5_d2 <- FindClusters(klf5_d2, resolution = 1)

klf5_d2 <- RunTSNE(klf5_d2, dims.use = 1:10, perplexity = 5)

TSNEPlot(object = klf5_d2,pt.size = 2)
#cluster1.markers <- FindMarkers(object = klf5_d2, ident.1 = 3, min.pct = 0.25)
#VlnPlot(object = klf5_d2, features = c("Sox9", "Krt19"))
klf5_d2.markers <- FindAllMarkers(klf5_d2, only.pos = TRUE, min.pct = 0.25, logfc.threshold = 0.25)

write.table(klf5_d2.markers,file = "fenqun_marker3.tsv",row.names = F, sep="\t", quote=F)


###picture
klf5_d2.markers %>% group_by(cluster) %>% top_n(n = 3, wt = avg_logFC)

VlnPlot(object = klf5_d2, features = c("Ttn", "D10Wsu102e","Sfrp5",
                                       "Cldn2", "Dmbt1", "Ly6d",
                                       "Lurap1l", "Apoe", "Anxa5",
                                       "Vcam1", "Slc34a2", "Hba-a1"), ncol = 3)
FeaturePlot(object = klf5_d2, features = c("Ttn", "D10Wsu102e","Sfrp5",
                                       "Cldn2", "Dmbt1", "Ly6d",
                                       "Lurap1l", "Apoe", "Anxa5",
                                       "Vcam1", "Slc34a2", "Hba-a1"), ncol = 3)

top50 <- klf5_d2.markers %>% group_by(cluster) %>% top_n(n = 50, wt = avg_logFC)
DoHeatmap(klf5_d2, features = top50$gene, size = 2)`
