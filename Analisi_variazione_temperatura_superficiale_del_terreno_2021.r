# Analisi temperatura superficiale 

#caricamento dei dati

#Necessitiamo di 2 librerie per inserire le immagini all'interno del software:

Iibrary(ncdf4)
library(raster)

#Impostiamo la cartella di destinazione dove sono presenti I dati di interesse precedentemente scaricati

setwd("~/Desktop/esametelerilevamento")

heet2021 <- raster("")
heet2020 <- raster("")
heet2019 <- raster("")
heet2018 <- raster("")

#visualizzazione delle immagini

#visualizziamo I dettagli di ogni immagine: 
heet2021
heet2020
heet2019
heet2018

#creiamo una palette di colori per far capire la variazione di temperatura; 

cl1 <- colorRampPalette(c("blue","white","red"))(100)

#creiamo un grafico con più immagini usando il comando par

par(mfrow=c(2,2))
plot(heet2018,col=cl1,main = "Anno 2018")
plot(heet2019,col=cl1,main = "Anno 2019")
plot(heet2020,col=cl1,main = "Anno 2020")
plot(heet2021,col=cl1,main = "Anno 2021")

#al valore 0 viene assegnato il valore minimo mentre al valore 1 viene assegnato il valore massimo 
La variazione di temperatura varia dai -1000°C a 100°C

#Analisi multitemporale 

#iniziamo classificando le nostre immagini, per farlo necessitiamo della libreria Rstoolbox

library(RStoolbox)

#creiamo una nuova palette di colori 
cl2 <- colorRampPalette(c("pink","red"))(100)

#classifichiamo le immagini del 2018 e del 2021 per poi metterle a confronto successivamente
Il numero di classi che useremo saranno 2, una per il freddo ed una per il caldo.

h2018 <- unsuperClass(heet2018,nClasses = 2)
plot(h2018$map,col=cl2,main = "Anno 2018")
h2021 <- unsuperClass(heet2020,nClasses = 2)
plot(h2021$map,col=cl2,main = "Anno 2021")

#frequenza delle 2 mappe per calcolare la percentuale delle zone fredde e delle zone calde

freq(h2018$map)
#value      count
      1         2746192  Freddo
      2        1935455.  Caldo
tot2018 <- 2746192+1935455

freq((h2021$map))
#value  count
      1       2234580
      2       2386297
tot2021 <- 2386297+2234580

#percentuali

percent2018 <- freq(h2018$map)*100/tot2018
#freddo <- 58.6
#caldo <- 41.3
percent2021 <- freq(h2021$map)*100/tot2021
#freddo <- 51.6
#caldo <- 48.35

#creiamo una nuova tabella con i valori del 2018 e del 2021


cover <- c("cold","heet")
before <- c(2746192,1935455)
after <- c(2386297,2234580)
output <- data.frame(cover,before,after)
View(output)

#analisi dei dati

#per ottenere un grafico più dettagliato usiamo la libreria ggplot2

library(ggplot2)
p1 <- ggplot(output, aes(x=cover,y=before,color=cover))+geom_bar(stat = "identity",fill="white")
plot(p1)
p2 <- ggplot(output, aes(x=cover,y=after,color=cover))+geom_bar(stat = "identity",fill="white")
plot(p2)

#la libreria grid extra invece ci andrà a mettere i 2 grafici ottenuti nella stessa immagine
library(gridExtra)

grid.arrange(p1,p2,nrow=1)

#conclusioni 

#Il TCI caratterizza indirettamente la disponibilità di umidità attraverso la radiazione vicino alla superficie e le condizioni aerodinamiche.
#Come tale, è utile per la caratterizzazione dello stato di salute della vegetazione e per le applicazioni agro-meteorologiche.

#Nel 2018 notiamo a livello mondiale il valore delle zone fredde (2746192) nettamente superiore a quello delle zone calde (1935455), denotando un migliore stato di salute della vegetazione.
#Nel 2021 notiamo invece un aumento delle zone calde (2234580) a discapito delle zone fredde (2386297) denotando così una condizione peggiore delle condizioni di salute della vegetazione 

#COSA ACCADE IN ITALIA NELLO STESSO ARCO TEMPORALE 

#creiamo una nuova cartella e inseriamo i dati di interesse, una volta fatto andiamo ad impostare una nuova WD

setwd("~/Desktop/esameduccio/heet")

#carichiamo i file di tipo .nc  in blocco

rlist <- list.files(pattern = ".nc")

#con la funzione lapply
listafinale <- lapply(rlist, raster)

heet <- stack(listafinale)

#visualizziamo le immagini 

plot(heet, col=cl1)
heet

#tramite ext andremo a selezionare una zona della nostra immagine di interesse

ext <- c(6,20,30,50)

#applichiamo uno zoom dell’area per ogni immagine 
zoom(heet$)
zoom(heet$)
zoom(heet$)
zoom(heet$)

#successivamente andiamo a tagliare la zona interessata creando una nuova immagine
heet18it<- crop(heet$)
heet19it <- crop(heet$)
heet20it <- crop(heet$)
heet21it <- crop(heet$)

#visualizziamo le immagini tutte insieme
par(mfrow=c(2,2))
plot(heet18it,col=cl1,main = "2018")
plot(heet19it,col=cl1,main = "2019")
plot(heet20it,col=cl1,main = "2020")
plot(heet21it,col=cl1,main = "2021")


#analisi multitemprale in italia 

#andiamo ad effettuare gli stessi passaggi eseguiti in precedenza per l’analisi mondiale ma in Italia:

h2018itm <- unsuperClass(heet18it,nClasses = 2)
h2021itm <- unsuperClass(heet21it,nClasses = 2)

colit <- colorRampPalette(c("orange","red"))(100)

par(mfrow=c(1,2))
plot(h2018itm$map,col=colit,main = "")
plot(h2021itm$map,col=colit,main = "")

#frequenza delle 2 mappe 
freq(h2018itm$map)
#value  count
      1      33005
      2      45725
tot2018itm <- 33005+45725

freq((h2021itm$map))
#value  count
      1      56744
      2      20626
tot2021itm <- 56744+20626

#percentuali

percent2018itm <- freq(h2018itm$map)*100/tot2018itm
#freddo <- 58.0
#caldo <- 41.9

percent2021itm <- freq(h2021itm$map)*100/tot2021itm
#freddo <- 40.1
#caldo <- 59.8


cover <- c("cold","heet")
before <- c(45725,33005)
after <- c(56744,20626)
outputit <- data.frame(cover,before,after)
View(outputit)

#ANALISI DEI DATI

library(ggplot2)
p1 <- ggplot(outputitm,aes(x= cover, y=before, color=cover)) + geom_bar(stat="identity",fill="white")
plot(p1)
p2 <- ggplot(outputitm,aes(x0cover, y=after, color=cover)) + geom_bar(stat="identity", fill="white")
plot(p2)

library(gridExtra)

grid.arrange(p1,p2,nrow=1)

#fine 
