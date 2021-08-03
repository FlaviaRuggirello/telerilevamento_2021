> install.packages("ncdf4")
--- Please select a CRAN mirror for use in this session ---
provo con l'URL 'https://cran.stat.unipd.it/bin/macosx/contrib/4.0/ncdf4_1.17.tgz'
Content type 'application/octet-stream' length 2284788 bytes (2.2 MB)
==================================================
downloaded 2.2 MB


The downloaded binary packages are in
	/var/folders/xl/xdt1txg96_12j93nc3sypl600000gn/T//RtmpEvxhlI/downloaded_packages
> install.packages("raster")
provo con l'URL 'https://cran.stat.unipd.it/bin/macosx/contrib/4.0/raster_3.4-13.tgz'
Content type 'application/octet-stream' length 4241838 bytes (4.0 MB)
==================================================
downloaded 4.0 MB


The downloaded binary packages are in
	/var/folders/xl/xdt1txg96_12j93nc3sypl600000gn/T//RtmpEvxhlI/downloaded_packages
> library(ncdf4)
> library(raster)
Carico il pacchetto richiesto: sp
> setwd("~/Desktop/esameTelerilevamento") 
> heet2018<- raster("c_gls_LST_201801180100_GLOBE_GEO_V1.2.1.nc")
Error in charToDate(x) : 
  character string is not in a standard unambiguous format
Inoltre: Warning message:
In .varName(nc, varname, warn = warn) : varname used is: ERRORBAR_LST
If that is not correct, you can set it to one of: ERRORBAR_LST, LST, PERCENT_PROC_PIXELS, Q_FLAGS, TIME_DELTA
> heet2019<- raster("c_gls_LST_201901180100_GLOBE_GEO_V1.2.1.nc")
Error in charToDate(x) : 
  character string is not in a standard unambiguous format
Inoltre: Warning message:
In .varName(nc, varname, warn = warn) : varname used is: ERRORBAR_LST
If that is not correct, you can set it to one of: ERRORBAR_LST, LST, PERCENT_PROC_PIXELS, Q_FLAGS, TIME_DELTA
> heet2020<- raster("c_gls_LST_202001180200_GLOBE_GEO_V1.2.1.nc")
Warning message:
In .varName(nc, varname, warn = warn) : varname used is: ERRORBAR_LST
If that is not correct, you can set it to one of: ERRORBAR_LST, LST, PERCENT_PROC_PIXELS, Q_FLAGS, TIME_DELTA
> heet2021<- raster("c_gls_LST_202101180100_GLOBE_GEO_V1.2.1.nc")
Warning message:
In .varName(nc, varname, warn = warn) : varname used is: ERRORBAR_LST
If that is not correct, you can set it to one of: ERRORBAR_LST, LST, PERCENT_PROC_PIXELS, Q_FLAGS, TIME_DELTA
> heet2018
class      : RasterLayer 
dimensions : 3584, 8064, 28901376  (nrow, ncol, ncell)
resolution : 0.04464286, 0.04464286  (x, y)
extent     : -180.0223, 179.9777, -79.97768, 80.02232  (xmin, xmax, ymin, ymax)
crs        : +proj=longlat +pm=0 +a=6378137 +rf=298.257232666016 
source     : c_gls_LST_201801180100_GLOBE_GEO_V1.2.1.nc 
names      : LST.Error.Bar 
z-value    : 0 
zvar       : ERRORBAR_LST 

> heet2019
class      : RasterLayer 
dimensions : 3584, 8064, 28901376  (nrow, ncol, ncell)
resolution : 0.04464286, 0.04464286  (x, y)
extent     : -180.0223, 179.9777, -79.97768, 80.02232  (xmin, xmax, ymin, ymax)
crs        : +proj=longlat +pm=0 +a=6378137 +rf=298.257232666016 
source     : c_gls_LST_201901180100_GLOBE_GEO_V1.2.1.nc 
names      : LST.Error.Bar 
z-value    : 0 
zvar       : ERRORBAR_LST 

> heet2020
class      : RasterLayer 
dimensions : 3584, 8064, 28901376  (nrow, ncol, ncell)
resolution : 0.04464286, 0.04464286  (x, y)
extent     : -180.0223, 179.9777, -79.97768, 80.02232  (xmin, xmax, ymin, ymax)
crs        : +proj=longlat +pm=0 +a=6378137 +rf=298.257232666016 
source     : c_gls_LST_202001180200_GLOBE_GEO_V1.2.1.nc 
names      : LST.Error.Bar 
z-value    : 2020-01-18 
zvar       : ERRORBAR_LST 

> heet2021
class      : RasterLayer 
dimensions : 3584, 8064, 28901376  (nrow, ncol, ncell)
resolution : 0.04464286, 0.04464286  (x, y)
extent     : -180.0223, 179.9777, -79.97768, 80.02232  (xmin, xmax, ymin, ymax)
crs        : +proj=longlat +pm=0 +a=6378137 +rf=298.257232666016 
source     : c_gls_LST_202101180100_GLOBE_GEO_V1.2.1.nc 
names      : LST.Error.Bar 
z-value    : 2021-01-18 
zvar       : ERRORBAR_LST 

> clA<- colorRampPalette(c("light blue","pink","purple"))(100)
> 
> par(mfrow=c(2,2))
>  plot(heet2018,col=clA, main = "Anno 2018")
>  plot(heet2019,col=clA, main = "Anno 2019")
>  plot(heet2020,col=clA, main = "Anno 2020")
>  plot(heet2021,col=clA, main = "Anno 2021")
> 
> 
