# R_code_variability.r
# Analizziamo pattern spaziali tramite l’uso di indici del paesaggio nell’area del ghiacciao del Similaun

library(raster)
library(RStoolbox)
library(ggplot2) # per ploottare ggplot
library(gridExtra) # per plottare insieme ggplot
#install.packages("viridis")
library(viridis) # serve per colorare i plot automaticamente

setwd("/lab/")

sent <- brick("sentinel.png") # portiamo dentro R l'immagine che abbiamo scaricato del ghiacciao del Similaun

plotRGB(sent, stretch="lin") # non dobbiamo specificare in che colore mettere le bande perchè sono già r=1, g=2, b=3 dove NIR 1, RED 2, GREEN 3

plotRGB(sent, r=2, g=1, b=3, stretch="lin") # viene mostrata la componente rocciosa in viola, la vegetazione in verde e acqua in nero perchè assorbe il NIR

# calcoliamo l'indice NDVI e calcoliamo la varibilità dell'immagine
sent # per vedere come si chiamano le bande
# rinominiamo e leghiamo le bande all'immagine
nir <- sent$sentinel.1
red <- sent$sentinel.2

ndvi <- (nir-red)/ (nir+red)
plot(ndvi) # dove è presente il bianco non c'è vegetazione, marroncino rappresenta la roccia, giallo e verde chiaro è la vegetazione 

cl<- clorRampPalette(c('black', 'white', 'red', 'magenta', 'green'))(100)
plot(ndvi, col=cl)

# calcoliamo la deviazione standard di questa immagine
ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd) # w= window. prendiamo una finestra di 3x3 pixel
plot(ndvisd3)

clsd <- colorRampPalette(c('blue', 'green', 'pink', 'magenta', 'orange', 'brown', 'red', 'yellow'))(100)
plot(ndvisd3, col=clsd) # la deviazione standard del NDVI è più bassa dove è presente la roccia nuda ed aumenta in corrispondenza del passaggio alla vegetazione per poi diminuire di nuovo nelle parti vegetate

# calcoliamo la media del ndvi con focal
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)

clsd <- colorRampPalette(c('blue', 'green', 'pink', 'magenta', 'orange', 'brown', 'red', 'yellow'))(100)
plot(ndvimean3, col=clsd) # media per 3 pixel. si ottengono valori molti alti nelle praterie di alta quota e per la parte seminaturale. valori più bassi per la roccia nuda

# cambiamo la finestra: 11x11 pixel
ndvisd11 <- focal(ndvi, w=matrix(1/121, nrow=11, ncol=11), fun=sd) 
clsd <- colorRampPalette(c('blue', 'green', 'pink', 'magenta', 'orange', 'brown', 'red', 'yellow'))(100)
plot(ndvisd11, col=clsd) # se ho un immagine con dettagli molto alti è meglio usare una finestra più piccola. finestre troppo grandi rischiano di omogenizzare il risultato.

# cambiamo la finestra: 5x5 pixel
ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd) # situazione ideale per identicare le variazioni della deviazione standard
clsd <- colorRampPalette(c('blue', 'green', 'pink', 'magenta', 'orange', 'brown', 'red', 'yellow'))(100)
plot(ndvisd5, col=clsd)         

# PCA: analisi multivariata su tutto il dataset e poi prendiamo la PC1 (unico strato) per fare una finestra e calcolare una mappa di deviazione standard
sentpca <- rasterPCA(sent) # fa l'analisi dei componenit principali per il raster
plot(sentpca$map) # la prima componente mantiene il range di iniformazione più alto. passando alle PC successive l'informazione si perde

sentpca # $call= funzione che abbiamo usato. $model= princomp(cor = spca, comvmat = covMat[[1]]). cor= correlazione, covmat= matrice di covarianza. $map : RasterBrick 

summary(sentpca$model) # per vedere quanta variabilità iniziale spiegano le singole componenti
# la prima PC spiega il 0.6736804 dell'informazione originale.

pc1 <- sentpca$map$PC1
pc1_5 <- focal(pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue', 'green', 'pink', 'magenta', 'orange', 'brown', 'red', 'yellow'))(100)
plot(pc1_5, col=clsd) # molto ben visibile la variabilità del paesaggio


#con la funzione source si possono caricare codici presi da fuori
source("source_test_lezione.r.txt") # abbiamo preso un pezzo di codice scaricandolo come documento di testo e lo abbiamo aperto direttamente con R
# pc1 <- sentpca$map$PC1
# pc1sd7 <- focal(pc1, w=matrix(1/49, nrow=7, ncol=7), fun=sd)
# plot(pc1sd7)
source("source_ggplot.r.txt")

# facciamo un plottaggio con ggplot, metodo migliore per individuare discontinuità a livello geografico, a livello geologico serve per individuare variabilità geomorfologica e a livello ecologico serve a individuare variabilità ecologica (ecotoni)
p1 <- ggplot() +
geom_raster(pc1_5, mapping = aes(x=x, y=y, fill=layer)) +
scale_fill_viridis() + # non specifichiamo il tipo di legenda viridis
ggtitle("Standard deviation of PC1 by viridis colour scale")

# cambiamo il tipo di legenda per i colori
p2 <- ggplot() +
geom_raster(pc1_5, mapping = aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="magma") + 
ggtitle("Standard deviation of PC1 by magma colour scale")

p3 <- ggplot() +
geom_raster(pc1_5, mapping = aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="turbo") + 
ggtitle("Standard deviation of PC1 by turbo colour scale")

# per ottenere i 3 plot con le legende e posso confrontare le diverse legende dei colori
grid.arrange(p1, p2, p3, nrow=1)
