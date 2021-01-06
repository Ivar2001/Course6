#Load packages
library(pathview)
library(edgeR)
library(xlsx)

# Set the correct working dir
currWD <- getwd()
neededWD <- paste(currWD, "/Kegg mapper", sep = "")
setwd(neededWD)

#Define pathway to be used (found on KEGG db)
glycolysispathway <- "lpl00010"
pentosephyosphatepathway <- "lpl00030"

#Load selected genes
WCFS1genes <- read.xlsx("Merged_Genes.xlsx", 1)
NC8genes <- read.xlsx("Merged_Genes.xlsx", 2)

#Seperate logFC of selected genes
WCFS1logFC <- WCFS1genes$logFC
NC8logFC <- NC8genes$logFC

#Set names of the data
names(WCFS1logFC) <- WCFS1genes$NA.
names(NC8logFC) <- NC8genes$NA.

#Generate pathviews
WCFS1.out <- pathview(gene.data = WCFS1logFC, species = "lpl", pathway = glycolysispathway, gene.idtype = "KEGG")
file.copy("lpl00010.pathview.png", "WCFS1.lpl00010.pathview.png")
NC8.out <- pathview(gene.data = NC8logFC, species = "lpl", pathway = glycolysispathway, gene.idtype = "KEGG")
file.copy("lpl00010.pathview.png", "NC8.lpl00010.pathview.png")

WCFS1.out <- pathview(gene.data = WCFS1logFC, species = "lpl", pathway = pentosephyosphatepathway, gene.idtype = "KEGG")
file.copy("lpl00030.pathview.png", "WCFS1.lpl00030.pathview.png")
NC8.out <- pathview(gene.data = NC8logFC, species = "lpl", pathway = pentosephyosphatepathway, gene.idtype = "KEGG")
file.copy("lpl00030.pathview.png", "NC8.lpl00030.pathview.png")