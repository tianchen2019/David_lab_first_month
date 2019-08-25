*Script : ko_pathway_genes.r*
the network: https://cloud.tencent.com/developer/news/392677
`if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("KEGGREST")
library(KEGGREST)
listdataBases()
listDatabases()
org<-keggList('organism')
head(org)
for (i in c(1:13)){
  gs[i]<-keggGet(a$KEGG[i])
  org<-keggList('organism')
  #head(org)
  gs[[1]][["GENE"]]
}

gs1<-keggGet("mmu00250")
gs1[[1]][["GENE"]]
#genes<-unlist(lapply(gs[[1]]$GENE,function(x) strsplit(x,';')))
a<-as.data.frame(gs1[[1]][["GENE"]])
gs2<-keggGet("mmu00030")
a2<-as.data.frame(gs2[[1]][["GENE"]])
gs3<-keggGet("mmu03010")
a3<-as.data.frame(gs3[[1]][["GENE"]])
gs4<-keggGet("mmu04144")
a4<-as.data.frame(gs4[[1]][["GENE"]])
write.table(a,file = "a1.tsv",row.names = F, sep="\t", quote=F)
write.table(a2,file = "a2.tsv",row.names = F, sep="\t", quote=F)
write.table(a3,file = "a3.tsv",row.names = F, sep="\t", quote=F)
write.table(a4,file = "a4.tsv",row.names = F, sep="\t", quote=F)`
