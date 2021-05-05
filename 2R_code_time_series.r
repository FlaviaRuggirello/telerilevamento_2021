#Time series analysis
#Greenland increase temperature
#Data anc code from Emanuela 

setwd("~/Desktop/lab/greenland")

#che pacchetti utilizzeremo???

# install.packages("raster")
library(raster)

#oggi utilizzaremo dati sulla tempertura e dati sullo strato della groenlandia 

#Primo carichiamo pacchetto raster 
#choose Directory

#STACK -> importante cerca 

#importiamo immagini funzione per singoli dati , no pacchetto : raster 
#all'interno di pacchetto raster esisre funzione "raster" 
#ciclo movimento iterativo di funzioni -> in informatica 

lst_2000 <- raster("lst_2000.tif")

plot(lst_2000) #plottiamo semplicemente l'immagine importata 

lst_2005 <- raster("lst_2005.tif")

plot(lst_2005)

#utilizziamo per ridurre il peso delle immagini , valori interi e non digitali DN digital number 
#per la temperatura "bit" 


lst_2010 <- raster("lst_2010.tif")

lst_2015 <- raster("lst_2015.tif")

par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#lapply , è una funzione cge applico ad  un'altra  certa funzione (raster)a una lista di file , tutti assieme .

#funzione list.files crea la lista di file a cui R poi applicherà Rapply 

#LIST OF FILE 
#pattern spiega al software - cerca i file tramite nome 

list.file

rlist <- list.files(pattern="lst")
rlist
[1] "lst_2000.tif" "lst_2005.tif" "lst_2010.tif"
[4] "lst_2015.tif"

lapply(rlist,raster) #applichiamo la funzione alla lista scelta e utilizzando la funzione raster 

import <- lapply(rlist,raster) #file uniti tutti assieme con un unico nome - attenzione maiuscole 

#stack blocco di file tutti assieme  - fa un unico file grande e univoco 
#mi servirà per fare plot 

TGr <- stack(import)
plot(TGr)

#potrei usare lapply, invece di usare raster metto plot 



plotRGB(TGr, 1, 2, 3, stretch="Lin")


plotRGB(TGr, 1, 2, 3, stretch="Lin")

#coloristRpackage -> ne parlerà

#VENERDI' 9 SALTATO LEZIONE - MANCANO MIEI COMMENTI !!!!

levelplot(TGr)
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(TGr, col.regions=cl)

levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

levelplot(TGr,col.regions=cl, main="LST variation in time",
          names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

# Melt
meltlist <- list.files(pattern="melt")
melt_import <- lapply(meltlist,raster)
melt <- stack(melt_import)
melt

levelplot(melt)

melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt

clb <- colorRampPalette(c("blue","white","red"))(100)
plot(melt_amount, col=clb)

levelplot(melt_amount, col.regions=clb)

#14 aprile 2021

#installo pacchetto "knitr"

install.packages("knitr") 

#ha spiegato Copernicus 
#scaricare dati da copernicus
