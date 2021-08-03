install.packages("ncdf4")
install.packages("raster")

library(ncdf4)
library(raster)

setwd("~/Desktop/esameTelerilevamento") 

heet2018<- raster("c_gls_LST_201801180100_GLOBE_GEO_V1.2.1.nc")
heet2019<- raster("c_gls_LST_201901180100_GLOBE_GEO_V1.2.1.nc")
heet2020<- raster("c_gls_LST_202001180200_GLOBE_GEO_V1.2.1.nc")
heet2021<- raster("c_gls_LST_202101180100_GLOBE_GEO_V1.2.1.nc")


clA<- colorRampPalette(c("light blue","pink","purple"))(100)
 
 par(mfrow=c(2,2))
  plot(heet2018,col=clA, main = "Anno 2018")
  plot(heet2019,col=clA, main = "Anno 2019")
  plot(heet2020,col=clA, main = "Anno 2020")
  plot(heet2021,col=clA, main = "Anno 2021")
 
 
