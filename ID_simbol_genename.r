*Script : ID_simbol_genename.r*
also can see in the network: https://www.jianshu.com/p/33e22a558457     ； https://www.jianshu.com/p/f7d1f0ffb27e
library(biomaRt)
library(clusterProfiler)
library(org.Hs.eg.db)
human = useMart("ensembl", dataset = "hsapiens_gene_ensembl")
mouse = useMart("ensembl", dataset = "mmusculus_gene_ensembl")

gene_up_id = getLDS(attributes = c("ensembl_gene_id"), filters = "ensembl_gene_id", 
                    values = gene_kras_up_filter$ensembl_gene_id , mart = mouse, attributesL = c("ensembl_gene_id", "hgnc_symbol", "entrezgene_id"), 
                    martL = human, uniqueRows=T)
`https://www.jianshu.com/p/33e22a558457`
