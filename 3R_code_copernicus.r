#R_code_copernicus 
#visualizzazione dati copernicus 
#ci servono la libreria raster - netCDF4 ( per leggere formato dati scaricati)

library(raster) 

#install.packages("ncdf4") 

install.packages("ncdf4")
library(ncdf4) 

setwd("~/Desktop/lab")

#dobbiamo dare un nome al dataset " ALBEDO " , caricihiamo un singolo strato al momento funzione raster 

albedo <- raster("c_gls_ALBH_202006130000_GLOBE_PROBAV_V1.5.1.nc")

#rasterlayer pixel al minimo - risoluzione in coord geo no in metri ma in gradi - sistema di riferimento wgs84
#elissoide. tutte le info 

#scegliamo ColorRampePalette 

cl <- colorRampPalette(c('light blue','green','red','yellow'))(100) 

cl <- colorRampPalette(c('light blue','green','red','yellow'))(100) 

plot(albed0, col=cl)

#possiamo diminuire la risoluzione

#resampling 

albedores <- aggregate(albedo, fact=100) #cos'è aggregate -> funzione generica per raggruppamento di data frame
#serve per gestirlo meglio - media pixel più piccoli contenuti 
plot(albedores, col=cl)

