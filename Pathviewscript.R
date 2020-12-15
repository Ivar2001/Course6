#Load packages
library(pathview)
library(edgeR)
library(xlsx)

#Define pathway to be used (found on KEGG db)
mypathway <- "lpl00010"

#Load selected genes
WCFS1genes <- read.xlsx("./Selected genes.xls", 1)
NC8genes <- read.xlsx("./Selected genes.xls", 2)

#Seperate logFC of selected genes
WCFS1logFC <- WCFS1genes$logFC
NC8logFC <- NC8genes$logFC

#Set names of the data
names(WCFS1logFC) <- row.names(WCFSgenes)
names(NC8logFC) <- row.names(NC8genes)

#Generate pathviews
pathview(gene.data = WCFS1logFC, species = "lpl", pathway = mypathway, gene.idtype = "KEGG")
pathview(gene.data = NC8logFC, species = "lpl", pathway = mypathway, gene.idtype = "KEGG")