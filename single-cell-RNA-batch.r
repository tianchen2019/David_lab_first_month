*Script : "single-cell-RNA-batch.r*

`library(Seurat)
pancreas.data <- readRDS(file = "../data/pancreas_expression_matrix.rds")
metadata <- readRDS(file = "../data/pancreas_metadata.rds")

pancreas <- CreateSeuratObject(pancreas.data, meta.data = metadata)
pancreas.list <- SplitObject(pancreas, split.by = "tech")
for (i in 1:length(pancreas.list)) {
    pancreas.list[[i]] <- NormalizeData(pancreas.list[[i]], verbose = FALSE)
    pancreas.list[[i]] <- FindVariableFeatures(pancreas.list[[i]], selection.method = "vst", 
        nfeatures = 2000, verbose = FALSE)
}
reference.list <- pancreas.list[c("celseq", "celseq2", "smartseq2")]
pancreas.anchors <- FindIntegrationAnchors(object.list = reference.list, dims = 1:30)
pancreas.integrated <- IntegrateData(anchorset = pancreas.anchors, dims = 1:30)
library(ggplot2)
library(cowplot)
#switch to integrated assay. The variable features of this assay are automatically# set during IntegrateData
DefaultAssay(pancreas.integrated) <- "integrated"
#Run the standard workflow for visualization and clustering
pancreas.integrated <- ScaleData(pancreas.integrated, verbose = FALSE)
pancreas.integrated <- RunPCA(pancreas.integrated, npcs = 30, verbose = FALSE)
pancreas.integrated <- RunUMAP(pancreas.integrated, reduction = "pca", dims = 1:30)
p1 <- DimPlot(pancreas.integrated, reduction = "umap", group.by = "tech")
p2 <- DimPlot(pancreas.integrated, reduction = "umap", group.by = "celltype", label = TRUE, repel = TRUE) + NoLegend()
plot_grid(p1, p2)`

# debug: no UMAP
https://github.com/satijalab/seurat/issues/1760

