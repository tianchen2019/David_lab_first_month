**Work record in David lab(2019.7.30-2019.8.25)**
#### Ⅰ. Single-cell RNA-seq analysis       
##### Day2 single-cell RNA-seq analysis: Seurat package
###### 1. batch effect assessment
*Script : "single-cell-RNA-batch.r*
###### 2. Clustering
*Scripts : single_cell_cluster.r*
#### Ⅱ. Heatmap of differential expression genes in important pathways
###### 1. search differential expression genes in some pathways
###### (1) Using R package to get pathways' genes.
Geting pathway's KO number: https://www.genome.jp/kegg/pathway.html
*Script : ko_pathway_genes.r*
###### (2) Search genes in KEGG enrichment analysis's results
###### (3) Switch "gene ID" to "gene name"
*Script : ID_simbol_genename.r*
###### (4) CPM count matrix
*pathway_gene.xlsx*
###### (5) Fig. Heatmap
*heatmap.r*
#### Ⅲ. Heatmap of migrasome associated genes

##### Yu Li Lab migrasome associated gene list's heatmap
###### (1) *Script : migrasome_heatmap.r*
###### (2) analysis : *email*
#### Ⅳ. paper's profile (Fig.5)
###### (1) klf5/Foxa2 dependent and repress's ChIP-seq/ATAC-seq data's heatmap
*Script : ChIp_heatmap.sh*
###### (2)  klf5/Foxa2 dependent and repress's ATAC-seq profile
*Script : profile.r*
#### Ⅴ. profile of GAIN region in our ATAC-seq/Kras ChIP data
###### (1) Switch mm9 to mm10
a. Using UCSC tools
b. Using CrossMap software
###### (2) overlap ragion's computeMatrix 
*Script : computeMatrix.sh*
###### (3) profile
*Script : the same as profile.r*
#### Ⅵ. TF overlap Venn Fig
###### (1) cat all factors together
*Script : extract_peaks.sh*
###### (2) Venn Fig
*Script : venn.r*
#### Ⅶ. upload bigwig file to UCSC browser
###### (1) load bigwig data to a network to get a URL link
the network is : https://de.cyverse.org/de/
###### (1) load data to UCSC gene browser
*Annotation file  : uscs.txt*
