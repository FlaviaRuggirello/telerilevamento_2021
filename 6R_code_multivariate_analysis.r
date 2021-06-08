# R_code_multivariate_analysis.r

library(raster)
library(RStoolbox)

setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac 


p224r63_2011 <- brick("p224r63_2011_masked.grd")

plot(p224r63_2011)

p224r63_2011

plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)
plot(p224r63_2011$B2_sre, p224r63_2011$B1_sre, col="red", pch=19, cex=2)

pairs(p224r63_2011)

#PCA ANALISI IMPATTANTE 
#QUINDI SI potreebbe ricreare un dato più leggero 

#aggregate cells : resampling (ricampionamento) - aggreghiamo i pixel - quante volte voglia aumentare i pixel - risoluzione 

#fun=mean -> media dei valori 


#aggreghiamo linearmente di 10 i nostri pixel 

p224r63_2011res <- aggregate(p224r63_2011, fact=10) #aumentare grandezza del pixel significa diminuire la risoluzione e significa alleggerire l'immagine 

par(mfrow= c(2,1)) 

plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")

p224r63_2011res_pca <- rasterPCA(p224r63_2011res)


summary(p224r63_2011res_pca$model)

p224r63_2011res_pca

dev.off()
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")

