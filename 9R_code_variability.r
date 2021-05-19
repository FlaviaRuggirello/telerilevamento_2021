# R_code_variability.r

#scegliamo le librerie che ci servono - viridis per gestione dei colori - le altre le conosco

library(raster)
library(RStoolbox)

setwd("/lab/")

brick("sentinel.png") #prendo l'immagine da fuori R e gli do un nome 

sent <- brick("sentinel.png")

plotRGB(sent)

#NIR 1, RED 2, GREEN 3

# r=1, g=2, b=3

plotRGB(sent,r=1, g=2, b=3, stretch= "lin")

nir <- sent$sentinel.1
red <- sent$sentinel.2
 
ndvi <- (nir-red) / (nir+red)
plot(ndvi)

cl <- colorRampPalette(c('black','white','red','magenta','green'))(100) # 
plot(ndvi,col=cl)

ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(ndvisd3)

clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #
plot(ndvisd3, col=clsd)

# mean ndvi with focal
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvimean3, col=clsd)

ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd5, col=clsd)

sentpca <- rasterPCA(sent)

plot(sentpca$map)

summary(sentpca$model)

