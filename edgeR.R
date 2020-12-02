### HAN (c) Todt
library(limma)
library(edgeR)

###############################################################
### read counts
###############################################################

fDir <-  "/home/ivar/Desktop/Han/Jaar2/Blok 2/project/"
fName <- "WCFS1_cnts.txt"

cnts <- read.delim(paste0(fDir,fName), comment.char="#")

### used for topTags identification
row.names(cnts) <- cnts[,"ID"]

###############################################################
### Create DGEList
###############################################################

exp <- c("WCFS1.glc","WCFS1.glc","WCFS1.rib","WCFS1.rib")

group <- factor(exp)
y <- DGEList(counts=cnts[,2:5],group=group)

###############################################################
### Normalise counts
### Trimmed mean of M values : remove lowest and highest values
### (percentile) and calculate mean
### 
###############################################################

y <- calcNormFactors(y, method="TMM" )

###############################################################
### Remove low reads by using FilterbyExpr
###############################################################

keep <- filterByExpr(y, design)
y <- y[keep,]

###############################################################
###
### Cluster genes using Hierarchal clustering
### 
###############################################################

x <- t(y$counts)
x <- dist(x, method = "euclidean")
x <- hclust(x, method = "average")
plot(x)

###############################################################
### Check statistics
###############################################################

print("Count statistics")
print(summary(y$counts))
print(y$samples)

###############################################################
### Create design matrix
###############################################################

design <- model.matrix(~0+group, data=y$samples)
colnames(design) <- levels(y$samples$group)
print(design)

###############################################################
### Estimate Dispersion
###############################################################

#y <- estimateDisp(y, design)


###############################################################
### Plot results
###############################################################

pdf(paste0(fDir,"LP_edgeR.pdf"))
plotMDS(y)
plotBCV(y)
dev.off()

###############################################################
### Fit data
###############################################################

fit <- glmFit(y,design)

###############################################################
### Determine fold changes
###############################################################

mc <- makeContrasts(exp.r=WCFS1.glc-WCFS1.rib, levels=design)

fit <- glmLRT(fit, contrast=mc)

###############################################################
### Print top tags
###############################################################

res<-topTags(fit)
print(res)


###############
### t() = Transpose draaid de rij en colom om
### kmeans(data) = clusteren van data
### normalizeren
### lage eruit filteren
### p-value etc berekenen
###############