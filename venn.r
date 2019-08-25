library(VennDiagram)
setwd("F:/R_wenjian/deeptools/overlap/new")
a<-read.table(file="Foxa2_dox_peaks.peaks",header = F,sep="\t")
b<-read.table(file="Fra1_peaks.peaks",header = F,sep="\t")
c<-read.table(file="JunB_peaks.peaks",header = F,sep="\t")
d<-read.table(file = "Klf5_dox_peaks.peaks",header = F,sep="\t")
e<-read.table(file="sun.peaks",header = F,sep="\t")


p <- venn.diagram(
  x = list(
    "     a" = a$V4,
    "     b" = b$V4,
    "     c"=c$V4,
    "     d"=d$V4,
    "     e"=e$V4
  ),
  filename = "overlap8.png",
  col = "transparent",
  fill = c("red","blue","green","orange","violet"),
  alpha = 0.5,
  #label.col = c("darkred", "white", "darkblue","darkred","darkred","darkred","darkred"),
  cex = 1,
  
  fontfamily = "serif",
  fontface = "bold",
  cat.default.pos = "text",
  #cat.col = c("darkred", "darkblue","darkred", "white", "darkblue","darkred", "white","darkred", "darkblue","darkred"),
  cat.cex = 0,
  cat.fontfamily = "serif",
  #cat.dist = c(0.06, 0.06),
  cat.pos = c(0,0,250,90,0)
)
