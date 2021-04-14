#R_code_copernicus 
#visualizzazione dati copernicus 
#ci servono la libreria raster - netCDF4 ( per leggere formato dati scaricati)

library(raster) 

#install.packages("ncdf4") 

install.packages("ncdf4")
library(ncdf4) 

setwd("~/Desktop/lab")

#dobbiamo dare un nome al dataset " ALBEDO " , caricihiamo un singolo strato al momento funzione raster 

albedo <- raster("

#rasterlayer pixel al minimo - risoluzione in coord geo no in metri ma in gradi - sistema di riferimento wgs84
#elissoide. tutte le info 

#scegliamo ColorRampePalette 

cl <- colorRampPalette(c('light blue','green','red','yellow'))(100) 

cl <- colorRampPalette(c('light blue','green','red','yellow'))(100) 

plot(albed, col=cl)

#possiamo diminuire la risoluzione

