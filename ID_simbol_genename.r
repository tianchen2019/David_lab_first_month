*Script : ID_simbol_genename.r*
also can see in the network: https://www.jianshu.com/p/33e22a558457     ； https://www.jianshu.com/p/f7d1f0ffb27e
library(biomaRt)
human = useMart("ensembl", dataset = "hsapiens_gene_ensembl")
mouse = useMart("ensembl", dataset = "mmusculus_gene_ensembl")

gene_up_id = getLDS(attributes = c("ensembl_gene_id"), filters = "ensembl_gene_id", 
                    values = gene_kras_up_filter$ensembl_gene_id , mart = mouse, attributesL = c("ensembl_gene_id", "hgnc_symbol", "entrezgene_id"), 
                    martL = human, uniqueRows=T)
`https://www.jianshu.com/p/33e22a558457`
### uniqueRows记住变成F，按照原始顺序排的
# listAttributes(mouse) 查看所有的可以用的symbol，看库中的基因symbol有多少
# attributes是你要转的symbol,mart是你要转的是什么物种的，martL是你转成什么物种的。
# 常用的symbol列出：
# ensembl_gene_id,entrezgene_id(gene_id),hgnc_symbol(人的gene symbol),mgi_symbol(老鼠的基因)
(
