# R_code_multivariate_analysis.r

library(raster)
library(RStoolbox)

setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac 

setwd("~/Desktop/lab") #mio pc

p224r63_2011 <- brick("p224r63_2011_masked.grd") #prendo l'immagine da fuori R

plot(p224r63_2011) #plottiamo 

p224r63_2011 #visualizziamo il file 

#Confrontiamo la banda 1 con la banda 2
#pch è il la forma dei punti che andremo a vedere nel nostro grafico, possiamo decidere noi la forma
#cex indica invece la grandezza di questi punti

plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)
plot(p224r63_2011$B2_sre, p224r63_2011$B1_sre, col="red", pch=19, cex=2)

#Se volessimo vedere invece un confronto tra tutte le bande? Utilizzeremo la funzione Pairs
#La funzione Pair mette in correlazione a due a due tutte le variabili di un certo Dataset(nel nostro caso sono le bande)

pairs(p224r63_2011)

#PCA ANALISI IMPATTANTE 
#QUINDI SI potreebbe ricreare un dato più leggero 

#aggregate cells : resampling (ricampionamento) - aggreghiamo i pixel - quante volte voglia aumentare i pixel - risoluzione 

#fun=mean -> media dei valori 


#aggreghiamo linearmente di 10 i nostri pixel 

p224r63_2011res <- aggregate(p224r63_2011, fact=10) #aumentare grandezza del pixel significa diminuire la risoluzione e significa alleggerire l'immagine 

par(mfrow= c(2,1)) 

#facciamo paragone


plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")

#cos'è  PCA?
#principal componing analysis
#prendiamo un asse nella variabilità maggiore e una in quella minore 

p224r63_2011res_pca <- rasterPCA(p224r63_2011res)


summary(p224r63_2011res_pca$model)

p224r63_2011res_pca #vedo il file 

str(p224r63_2011res_pca) #serve per avere more info del file 

dev.off() #dev.off serve per uscire 

plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")


