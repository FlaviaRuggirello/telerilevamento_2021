# R_code_no2.r

library(raster)
library(RStoolbox) # here used for raster based multivariate analysis


# 1. Set the working directory EN
setwd("C:/lab/EN")


# 2. Import the first image (single band) importiamo i dati
EN_1<-raster("EN_0001.png")


# 3. Plot the first importaed imaage with your preferred Color Ramp Palette

plot(EN_1)

cls<-colorRampPalette(c("red","pink","orange","yellow"))(200)
plot(EN_1, col=cls)


# 4. Import the last image (13th) and plot it with the previous Color Ramp Palette

EN_13<-raster("EN_0013.png")
plot(EN_13)

cls<-colorRampPalette(c("red","pink","orange","yellow"))(200)
plot(EN_13, col=cls)

# abbiamo così l'immagine dell'NO2 di fine Marzo.


# 5. Make the difference between the two images and plot it

ENdif <- EN_13 - EN_1
plot (ENdif, col=cls)


# 6. plot everything, altogether 

par(mfrow=c(3,1))
plot(EN_1, col=cls, main="NO2 in January")
plot(EN_13, col=cls, main="NO2 in March")
plot(ENdif, col=cls, main="Difference (January - March)")


# 7. Import the whole set

# list of files:
rlist <- list.files(pattern="EN") # facciamo una lista dei files png
rlist

import <- lapply(rlist, raster) #applichiamo la funzione raster tramite la funzione lapply a tutta la lista di files e gli importiamo dandogli il nome "import"
import

EN <- stack(import) # compattiamo i files con la funzione stack e otteniamo i 13 files tutti insieme
plot(EN, col=cls) # applichiamo la Color Ramp Palette precedente


# 8. Replicate the plot of images 1 and 13 using the stack

par(mfrow=c(2,1))
plot(EN$EN_0001, col=cls) #lego il dataset con le singole bande
plot(EN$EN_0013, col=cls)


# 9. Compute a PCA over the 13 images
# facciamo un'analisi multivariata dei nostri dati, diminuiamo il set di 13 bande con una PCA


EN_pca <-rasterPCA(EN)
summary(EN_pca$model)
EN_pca 

dev.off()
plotRGB(EN_pca$map, r=1, g=2, b=3, stretch="lin") # gran parte dell'informazione è nella componente red. si possono vedere i vari componenti e i valori della varianza 


# 10. Compute the local variability (local standard deviation) of the first PCA
# faccio un calcolo della standard deviation sulla prima componente

PC1sd <- focal(EN_pca$map$PC1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(PC1sd, col=cls)
