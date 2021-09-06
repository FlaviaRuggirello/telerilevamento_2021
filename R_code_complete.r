#PROGETTO ESAME ANALISI MULTITEMPORALE 2021

install.packages("ncdf4")

#Installo pacchetto «ncdf4» ci serve per vedere i file .nc scaricati da Copernicus

install.packages("raster")

#installo pacchetto «raster» entrambi i pacchetti mi servono per caricare le immagini nel software

 library(ncdf4)
 library(raster)

#con library richiamo i pacchetti scaricati precedentemente per poterli usare 
#nel pacchetto raster è compreso il pacchetto sp , dati di tipo vettoriale usa le classi definite nel pacchetto sp
#Impostiamo la cartella di destinazione dove sono presenti I dati di interesse precedentemente scaricati

setwd("~/Desktop/esameTelerilevamento/immaginiCopernicus") 

#dico a R dove recuperare I file 

heet2018<- raster("c_gls_LST_201801180100_GLOBE_GEO_V1.2.1.nc")
heet2019<- raster("c_gls_LST_201901180100_GLOBE_GEO_V1.2.1.nc")
heet2020<- raster("c_gls_LST_202001180200_GLOBE_GEO_V1.2.1.nc")
heet2021<- raster("c_gls_LST_202101180100_GLOBE_GEO_V1.2.1.nc")


#importo le immagini che visualizzo grazie al pacchetto raster e alle quali do ciascuna un nome per facilitare anche il 
#richiamo e il plottaggio
#visualizzo le immagini e i dettagli
#Si potrebbero caricare tutte le immagini di tipo .nc in blocco  
#list.file(pattern=«.nc») spiega al software tramite nome o tipologia 
#successivamente funzione lapply che  serve per associare la lista di immagini che abbiamo creato a un altro oggetto
#funzione stack -> blocco di file tutti assieme, è usata per trasformare dati disponibili come colonne separate in unico dataframe

heet2018 
heet2019
heet2020
heet2021 

#richiamo le immagini scaricate e osservo le informazioni

#creiamo una  palette di colori per osservare meglio la variazione di temperatura 

clA<- colorRampPalette(c("light blue","pink","purple"))(100)

#creo un grafico per visualizzare il tutto
#PAR ci fa disporre le immagini come vogliamo noi 
#plot funzione ci fa il plottaggio delle immagini

par(mfrow=c(2,2))
plot(heet2018,col=clA, main = "Anno 2018")
plot(heet2019,col=clA, main = "Anno 2019")
plot(heet2020,col=clA, main = "Anno 2020")
plot(heet2021,col=clA, main = "Anno 2021")

#al valore 1 viene assegnato il valore minimo mentre al valore 4 viene assegnato il valore massimo 

#iniziamo classificando le immagini per poi confrontarle successivamente 
#per farlo abbiamo bisogno di una nuova libreria RStoolbox
#installo la libreria 

install.packages(«RStoolbox») 

#serve per il calcolo di indici di vegetazione 
#creiamo una nuova Palette di colori
#iniziamo classificando le nostre immagini, per farlo necessitiamo della libreria Rstoolbox
#quindi richiamo la libreria 

library(RStoolbox)

#creiamo una nuova palette di colori 

clB <- colorRampPalette(c(«pink»,»red»))(100)

#classifichiamo le immagini del 2018 e del 2021 per poi metterle a confronto successivamente
#Il numero di classi che useremo saranno 2, una per il freddo ed una per il caldo


h2018 <- unsuperClass(heet2018 , nClasses =2)

plot(h2018$map,col=clB, main = "Anno 2018")

h2021 <- unsuperClass(heet2021 , nClasses =2)

plot(h2021$map,col=clB, main = "Anno 2021")                        

par(mfrow=c(1,2))

#unsuperClass classificazione non supervisionata , non definiamo a monte le classi lasciamo fare al software dando due classi

#$ questo simbolo serve per unire - attaccare

#frequenza delle 2 mappe per calcolare la percentuale delle zone fredde e delle zone calde

freq(h2018$map)
value    count
[1,]     1  2034436 Freddo
[2,]     2   613943   Caldo
[3,]    NA 26252997 

Totale2018 <- (613943+2034436)

freq((h2021$map))
 value    count
[1,]     1  2024248
[2,]     2   590022
[3,]    NA 26287106

Totate2021<- (2024248+590022)

#percentuali

percent2018 <- freq(h2018$map)*100/Totale2018

percent2018
value     count
[1,] 3.775895e-05  23.18184
[2,] 7.551789e-05  76.81816
[3,]           NA 991.28550

percent2021 <- freq(h2021$map)*100/Totale2021

percent2021
            value      count
[1,] 3.825160e-05   22.56928
[2,] 7.650319e-05   77.43072
[3,]           NA 1005.52376

#creiamo una nuova tabella con i valori del 2018 e del 2021

cover <- c("cold","heet")
before <- c(2034436,613943)
after <-   c(2024248,590022)
output <- data.frame(cover,before,after)
View(output)

#per ottenere un grafico più dettagliato usiamo la libreria ggplot2

library(ggplot2)

Grafic1 <- ggplot(output, aes(x=cover,y=before, color=cover))+geom_bar(stat = "identity",fill="white")

plot(Grafic1)

Grafic2 <- ggplot(output, aes(x=cover,y=after,color=cover))+geom_bar(stat = "identity",fill="white")

plot(Grafic2)

#la libreria grid extra invece ci andrà a mettere i 2 grafici ottenuti nella stessa immagine
#grid.arrange compone come più ci piace il multiframe 

library(gridExtra)

grid.arrange(Grafic1,Grafic2, nrow=1) 
        
#nrow= riga

#setto nuovamente la working directory 

setwd("~/Desktop/esameTelerilevamento/immaginiCopernicus/heet")

#carico i miei file tutti assieme , sempre le immagini inciaziali di Copernicus «.nc»

rlist<-list.files(pattern = ".nc")
 
listafinale<-lapply(rlist, raster)

#precedentemente ho aggiunto le immagini in una nuova cartella definita «heet»

heet<-stack(listafinale)

#pacchetto che fa parte di sp – raster

install.packages("rgdal")

#richiamo la libreria 

library(rgdal)

#plotto le immagini con la palette di colori iniziale 

plot(heet, col= clA)
 
#osservo le immagini

heet

#scelgo le coordinate che rappresentano la zona italiana

ext<- c(6,20,30,50)

#applichiamo uno zoom dell’area per ogni immagine
 
zoom(heet&LST.Error.Bar.1,ext)
zoom(heet&LST.Error.Bar.2,ext)
zoom(heet&LST.Error.Bar.3,ext)
zoom(heet&LST.Error.Bar.4,ext)

#successivamente andiamo a tagliare la zona interessata creando una nuova immagine , funzione crop


ITA18<- crop(heet$LST.Error.Bar.1,ext)
ITA19<- crop(heet$LST.Error.Bar.2,ext)
ITA20<- crop(heet$LST.Error.Bar.3,ext)
ITA21<- crop(heet$LST.Error.Bar.4,ext)

#visualizziamo le immagini tutte insieme

par(mfrow=c(2,2))

plot(ITA18,col=clA, main="2018")
plot(ITA19,col=clA, main="2019")
plot(ITA20,col=clA, main="2020")
plot(ITA21,col=clA, main="2021")

#creo una nuova palette per rappresentare lo zoom e il confronto sull’italia 

clC<- colorRampPalette(c("orange","red"))(100)

#plotto e metto sulla stessa linea 

par(mfrow=c(1,2))

plot(ITA18M$map,col=clC, main="01-01-2018")
plot(ITA21M$map,col=clC, main="01-01-2021")

#ricalcolo le frequenze come ho fatto precedentemente 


freq(ITA18M$map)
     value count
[1,]     1 25440
[2,]     2 26178
[3,]    NA 88606


freq(ITA21M$map)
     value count
[1,]     1 29684
[2,]     2 16951
[3,]    NA 93589

totITA18M<- 25440+26178
totITA21M<- 29684+16951

percent2018 <- freq(ITA18M$map)*100/totITA18M


percent2018
           value     count
[1,] 0.001937309  49.28513
[2,] 0.003874617  50.71487
[3,]          NA 171.65717

percent2021 <- freq(ITA21M$map)*100/totITA21M

percent2021
value     count
[1,] 0.002144312  63.65176
[2,] 0.004288624  36.34824
[3,]          NA 200.68404

cover <- c("cold","heet")
before <- c(25440,26178)
after <-   c(29684,16951)
output <- data.frame(cover,before,after)
View(output)


#sempre un analisi dei dati graficamente 

library(ggplot2)

Grafic3 <- ggplot(output, aes(x=cover,y=before, color=cover))+geom_bar(stat = "identity",fill="white")

plot(Grafic3)

Grafic4 <- ggplot(output, aes(x=cover,y=after,color=cover))+geom_bar(stat = "identity",fill="white")

plot(Grafic4)

library(gridExtra)

grid.arrange(Grafic3,Grafic4, nrow=1)

#///////////////////////////////////////////////////////////////////////////////// PROVA DIFFERENTE MA STESSO FINE //////////////

#carico tutte le immagini in un unica soluzione 


listafinale<-lapply(rlist, raster)


heet<-stack(listafinale) #nuova cartella dove ho messo le immagini 

#rgdal pacchetto più richiamo la libreria 

install.packages("rgdal")


library(rgdal)


Italia<- readOGR(dsn= "Italy_squared.shp") #OPPURE FUNZIONE SHAPEFILE()

#shapefile italia creato con QGIS immagine scaricata dal geoportale nazionale avrei potuto utilizzare le funzioni

#ext – zoom – crop appartenenti al pacchetto R


PLOT1<- mask(crop(heet2018, Italia), Italia)  #POTEVO UTILIZZARE ANCHE CROP SENZA MASK 

POLT2<- mask(crop(heet2019, Italia)), Italia)

PLOT3<- mask(crop(heet2020, Italia), Italia)

PLOT4<- mask(crop(heet2021, Italia), Italia)


cl1<- colorRampPalette(c("pink","red","purple"))(100)


plot(PLOT1, col=cl1, main="2018")

plot(POLT2, col=cl1, main="2019")

plot(PLOT3, col=cl1, main="2020")

plot(PLOT4, col=cl1, main="2021")

#VOLEVO PROVARE ALTERNATIVA - SPIEGARE AL PROF 


#FINE PROGETTO 




#PRIMO CODICE

# My code in R for remote sensing -> "#" serve per scrivere i commenti 

# Creare e Chiamare la cartella "lab" sul desktop per R - R lavora per funzioni quindi ci serve una funzione che dica al sistema che lavoriamo sempre con quella cartella 

# install.packages("raster")
#richiamo la librearia raster library(raster) senza virgolette perchè è dentro R

# primo passaggio il settaggio della Working directory 
#setwd("-/lab/")

setwd("~/Desktop/lab") #io ho Mac - speghiamo a R dove andare a prendere oggetti


# inseriamo ora i dati , prendiamo da R attraverso un altro comando i dati nella cartella 
# funzione "brick" importa in blocco le immagini per farne una unica satellitare 

# associare brick a un nome 
# "nome oggetto" <- brick ... ( controllare prima se sono funzioni interne o esterne a R - brick sta in rasterpackage )

# richiamare prima il pacchetto 
library(raster)

#brick è la funzione per creare un raster multistrato
brick("p224r63_2011_masked.grd")


# assegnare un nome 

p224r63_2011 <- brick("p224r63_2011_masked.grd")

# per vedere il file scrivo il nome e premo invio : rasterbrick , una serie di bande in formato raster 
# impacchettamento - poi troviamo le dimensioni ( piccole ) - n° righe - n° colonne - calcolo pixel : righe per colonne 
# milioni di pixel per ogni banda - risoluzione 30mt - estensione , ci sono le coordinate - SI 
# sorgente , da dove lo ho preso - banda SRE (1) ecc ... fino alla (7) 
# riflettanze 

# visualizzare bande per visualizzare valori di riflettanza : funzione plot 

plot(p224r63_2011) #senza virgolette perchè è già in R e visualizzo le immagini 

# dev.off() se esce -> Error in plot.new() : figure margins too large poi di nuovo plotecc


###DAY 2 lez. 17.03.2021

# plottaggio singole bande (LANDSAT)
#colori plot 
#B1 : BLUE
#B2 : GREEN
#B3 : RED 
#B4 : NIR (INFRAROSSO VICINO)
#B5 : INFRAROSSO TERMICO 
#B6 : INFRAROSSO MEDIO , UN ALTRO

# colorRampePalette () possiamo cambiare e definire i colori del plot - R relaziona colore con etichetta "label" imp le virgolette 

colorRampePalette(c("black","grey","light grey")) (100) #livelli scala di colori 

#c () in R indica una serie di elementi -> vettore = array - argomento

cl <- colorRampePalette(c("black","grey","light grey")) (100) #livelli scala di colori  , cl nome 

#ora plot con nuovi volori - richiamiamo plot 

plot(p224r63_2011, col=cl) 

#esercizio cambiare colore 

cl1 <- colorRampePalette (c("blue","yellow","grey")) (100)
plot(p224r63_2011, col=cl) #immagine p..r immagine landsat - modis : mod... - file estensione nc derivano da un programma "Copernicus "

#abbiamo visto esempi con colori doversi , belli !

#### DAY 3 24.03.2021

#SELEZIONARE LA CARTELLA DI RIFERIMENTO - prima andrebbero richiamate le librerie 

setwd("~/Desktop/lab")

#richiamare pacchetto "raster" e pacchetto sp , quest'ultimo fa la gestione dei dati all'interno del software
#dati raster - matruce di numeri disposti in quadratini

library(raster)
library(sp)

# con brick assegnamo un nome - visto lezioni precedenti - virgolette perchè prendiamo cose esterne a R 
p224r63_2011 <- brick("p224r63_2011_masked.grd")

#facciamo plot con ColorRampPalette 

cls <- colorRampPalette(c("red","pink","orange","purple")) (200)
plot(p224r63_2011, col=cls)

#bassa riflettanza rosso - alta riflettanza viola 

p224r63_2011

#Bande di Landsat
#B1 : blue
#B2 : green 
#B3 : red 
#B4 : near infrared NIR 
#B5 : middle infrared 
#B6 : infrared ( termico - lontano) 
#B7 : middle infrared 

#plottiamo una sola banda 

#Prima però ripulire la finestra grafica dev.off() 
dev.off() 

#simbolo per legare banda X a immagine satellitare "$" dollaro - scelgo livello del multistrato che ci interessa 
#plottiamo B1

plot(p224r63_2011$B1_sre)

#plottare banda 1 con scala colori che vogliamo noi

cls2 <- colorRampPalette(c("pink","green","brown","purple")) (200)
plot(p224r63_2011, col=cls2)

plot(p224r63_2011$B1_sre, col=cls2)
dev.off()

#funzione PAR - è una funzione generica - serve per fare un settaggio dei parametri grafici (di un grafico che vogliamo creare)
#possiamo plottare accanto l'immagine del B1 (banda blue ) e B2 (banda verde) - stiamo facendo multiframe 
# MultiFrame MF. 
#Faremo poi sistema con una riga e due colonne , quindi MF = c( 1,2 ) , "c" è vettore
# quindi grafici con una disposizione che useremo sempre 

plot(p224r63_2011$B1_sre) #plotbandablu
plot(p224r63_2011$B2_sre) #plotbanda verde 
 #dobbiamo metterle una affianco all'altra in R , non una alla volta 

#PAR ci fa mettere le imagini come vogliamo noi in pratica 

#esempio
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#ovviamente si puà fare anche una colonna e duerighe ecce quindi si usa par(mfcol=c(1,2))

# plot the first four bands of Landsat , plot delle prime quattro bande 
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#esercizio 2,2 colonna a riga -> quadrato 

par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#altro esercizio come prima ma una color rampe palette per ogni banda 

par(mfrow=c(2,2))
 
clb <- colorRampPalette(c("dark blue","blue","light blue")) (100)
plot(p224r63_2011$B1_sre, col=clb)

clg <- colorRampPalette(c("dark green","green","light green")) (100)
plot(p224r63_2011$B2_sre, col=clg)

clr <- colorRampPalette(c("dark red","red","pink")) (100)
plot(p224r63_2011$B3_sre, col=clr)

clnir <- colorRampPalette(c("red","orange","yellow")) (100)
plot(p224r63_2011$B4_sre, col=clnir)

#oggi quindi abbiamo imparato come predisporre in maniera riassuntiva le immagini , come plottarle
#con che colori ecc

# DAY 4 - 26.03.2021

#Visualizzazione dati by RGB

#richiamiamo lbreria raster 
#setworkingdirectory --> mac 

library(raster)
setwd("~/Desktop/lab")

#funzione per importare dati dall'esterno "brick" con virgolette perchè fuori R , brick la associamo a un nome 

# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio
#oggi queste importanti per il lavoro

#schema RGB :Red Green Blue - 3 colori fondamentali per comporre gli altri .
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") #immagine a colori naturali - "stretch=Lin " serve per gestire/visualizzare tutte le fasi dei colori 
#quini R vedrà tutti i colori che vanno dal dark blue al light blue per esempio

#utilizziamo altri colori

plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") #banda rossa
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") #branda verde 

#montaggio di bande - escono pattern ecologici  ombre fiumi ecc - violA SUOLo nudo - componente agricola

plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin") #tutto altro schema rispetto a prima 

#ora facciamo PAR - esercizio multiframe 2x2 con queste bande 

par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") 
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

#funzione pdf 
pdf("firstPDF")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") 
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

dev.off()

#primo pdf in cartella lab 

#prendiamo un immagine , verde fluo, i colori stavolta sono i reali non scelti 
#stretchhistogram 

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") #stretch lineare 
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist") #stretch più pro , al centro della foresta vediamo - chiamata anche funzione logistica aumenta lo stretch e la possibilità di ciò che vediamo
#un vero e proprio polmone - aree umide - zone più vegetative ecce

#quindi abbiamo fatto diversi plot strecciati e ovviamente anche i PAR - così mettiamo ciò che abbiamo ottenito 
#visualizzato bene 

# par natural colours, flase colours, and false colours with histogram stretching
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist") #COSì VEDIAMO LE COMPONENETI DIFFERENTI DELLA FORESTA 
#stretch ancora più ampio - tutto più PRO SERVE A STITRARE I VALORI 
#NON SERVE LEGENDA perchè escono colori effettivi che ha deciso l'immagine - tanti strati? no legenda 

#prossima volta PCA 

#pacchetto RStoolbox 
#installare pacchetto per prossima volta 

install.packages("RStoolbox")

#DAY 5- 31.03.2021 - nuova lezione MULTITEMPORAL SET 

library(raster)
setwd("~/Desktop/lab")

p224r63_2011 <- brick("p224r63_2011_masked.grd")

#ho fatto quello che abbiamo sempre fatto nelle volte scorse
#Ora carichiamo il 1988 dalla stessa cartella - nome uguale basta cambiare la data 

#raster brick blocco di diversi raster tutti assieme che importiamo 

p224r63_1988 <- brick("p224r63_1988_masked.grd")
#stesse info periodo diverso

#ora plottiamo 1988 , prima intera immagine 

plot(p224r63_1988) -> #plottiamo singole bande - b1,b2,b3 ecc colori scritti sopra 

#Ora plot in RGB 

plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")



#creare un multiframe con par e poi inserire le due immagini 1988 e 2011

par(mfrow=c(2,1))

plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="hist")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

#creiamo pdf

 pdf("multitemp.pdf")
> par(mfrow=c(2,2))
> plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
> plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
> plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="hist")
> plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")
> dev.off

#preso dal mio R 

#DVI del 1988 e del 2011
dvi1988<-p224r63_1988$B4_sre - p224r63_1988$B3_sre  

#Il DVI  si calcola con NIR-RED quindi utilizzeremo la banda del NIR e quella del RED
dvi2011<-p224r63_2011$B4_sre - p224r63_2011$B3_sre

par(mfrow=c(2,1))         
plot(dvi1988) 
plot(dvi2011)

cldvi<-colorRampPalette(c('red', 'orange', 'yellow')) (100)   

#Definiamo dei colori con colorRampPalette
par(mfrow=c(2,1))                                             
plot(dvi1988, col=cldvi)
plot(dvi2011, col=cldvi)

#Differenza nel tempo quindi 2011-1988

difdvi<-dvi2011- dvi1988
cldif<-colorRampPalette(c('blue', 'white', 'red'))(100)
plot(difdvi, col=cldif)

--------------------------------------------------------------------------------------

#SECONDO CODICE

#Time series analysis
#Greenland increase of temperature
#Data and code from Emanuela Cosma 

setwd("~/Desktop/lab/greenland")

#che pacchetti utilizzeremo???

# install.packages("raster") vanno sempre messi prima della setwd
library(raster)

#oggi utilizzaremo dati sulla tempertura e dati sullo strato della groenlandia 

#Primo carichiamo pacchetto raster 
#choose Directory

#STACK -> la funzione stack è usata per trasformare dati disponibili come colonne separate in un data frame o lista avente una singola colonna 
#che può essere utilizzato nello studio dei modelli di varianza o altri modelli lineari

#importiamo immagini funzione per singoli dati , no pacchetto : raster 
#all'interno di pacchetto raster esiste funzione "raster" per creare un'oggetto raster layer
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

#lapply , è una funzione che applico ad  un'altra  certa funzione (raster)a una lista di file , tutti assieme .

#funzione list.files crea la lista di file a cui R poi applicherà Lapply 

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

#creiao un file composto dalle T nei vari anni su un unica immagine

plotRGB(TGr, 1, 2, 3, stretch="Lin")


plotRGB(TGr, 1, 2, 3, stretch="Lin")

#coloristRpackage -> ne parlerà

#VENERDI' 9 

library(rasterVis) #Methods for enhanced aumentare la visualizzaione e interazione con i dati raster
library(raster)

levelplot(TGr) #funzione levelpolt visione diversi livelli plot *****

levelplot(TGr$list_2000) #il grafico , mostra l'andatura media per colonna e lo stesso a dx per riga 
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100) #immagine singole e non un immagine satellitare su vari livelli RGB

levelplot(TGr, col.regions=cl)

levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

levelplot(TGr,col.regions=cl, main="LST variation in time",names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

# Melt nome lista oggetti

setwd("~/Desktop/lab")

meltlist <- list.files(pattern="melt") 

melt_import <- lapply(meltlist,raster)

melt <- stack(melt_import)

melt

levelplot(melt) #grafico scioglimento ghiacciai 1979- 2007

#analisi multitemporale 

melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt #sottrazione dati per vedere differenza 

clb <- colorRampPalette(c("blue","white","red"))(100)
plot(melt_amount, col=clb)

levelplot(melt_amount, col.regions=clb)

#14 aprile 2021

#installo pacchetto "knitr"

install.packages("knitr") 

#ha spiegato Copernicus 
#scaricare dati da copernicus

----------------------------------------------------------------------------------------------------------

#TERZO CODICE

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
-------------------------------------------------------------------------------------------------------------------------

#QUARTO CODICE

# R_code_knitr.r


setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac 

#ovviamente io ho mac , uso :

setwd("~/Desktop/lab")

library(knitr)

#usiamo un gestore di testo dove copieremo tutto il codice che vogliamo importare
#mettiamo all'interno della nostra cartella tutto il necessario (sia i file come immagini che il codice)

setwd("c:/lab/greenland1") 

#questo nel nostro caso ma bisogna selezionare la cartella corrispondente
getwd() #per controllare la cartella di lavoro

#cosa stiamo facendo in questa maniera? stiamo importando dalla cartella selezionata il file contenente il codice per creare un pdf unico
#questo pdf avrà al suo interno tutto quello su cui abbiamo lavorato

#Per fare questo utilizziamo la funzione stitch dove per prima cosa metteremo il nome del file di testo che abbiamo creato
stitch("greenland.r", template = system.file("misc", "knitr-template.Rnw", package="knitr"))

#overleaf per creare PDF

---------------------------------------------------------------------------------------------------------------------------------------------

#QUINTO CODICE

#R_code_classification.r

#processo che accorpa pixel con valori simili e rappresenta una classe 

library(raster)
library(RStoolbox)

setwd("~/Desktop/lab") 
#settiamo la working directory 

#scarichiamo i dati - virtuale - immagine in lab - rappresenta livelli energetici diversi del sole 
#carichiamo l'immagine 

#brick , funzione per prendere dall'esterno un oggetto come le immagini - immagine rgb su 3 livelli 
#Rasterbrick prende una serie di dati 

#mettiamo i pacchetti che di solito van prima di tutto - aggiungo in alto

#una volta aggiunta la library  posso usare brick

so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

#per visualizzare i livelli rgb uso "plotRGB"

plotRGB()

#per vedere i livelli metto solo "so" e invio 

so
#valori da 0 a 255 - immagini in bit 
#quindi plottiamo 

plotRGB(so, 1, 2, 3, stretch="lin") livelli e strecciamo per far vedere tutti i valori

#ovviamente potrebbero esserci più livelli noi ne usiamo solo 3 

#classifichiamo l'immagini per vedere le classi . come ?

#installiamo il pacchetto
#iniziamo la classificazione 

#classificazione non supervisionata - non definiamo a monte le classi - lasciamo al software 

#UNSUPERVISED CLASSIFICATION 

#unsuperClass 

unsuperClass(so, nClasses=3)

soc <- unsuperClass(so, nClasses=3) #crea in uscita il modelloe la mappa e le uniamo "$"

plot(soc$map) #plottiamo

#3 classi vediamo che le label hanno colori associati a caso 

#per fare si che la classificazione sia sempre la stessa usiamo la funzione "set.seed" - (42) significato della vita prof

#Unsupervised Classification with 20 classes - dare un nome diverso sennò sovrascrive quello precedente 

unsuperClass(so, nClasses=20)

soc2 <- unsuperClass(so, nClasses=20)

plot(soc2$map)

#set.seed per vedere la differenziazione 

# scaricato immagine da :https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
#brick e importo l'immagine 

brick("sun.png") 

#do il nome 

sun <- brick("sun.png")

# classifichiamo l'immagine con tre classi

#riprendo classificazione di prima 

sunc <- unsuperClass( sun, nClasses=3)

plot(sunc$map)

#noize - rumore immagine 

#mask serve per nascondere "le nuvole" 

plot(soc20$map,col=cl)

cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(soc20$map,col=cl)
# Download Solar Orbiter data and proceed further!
# Grand Canyon
# https://landsat.visibleearth.nasa.gov/view.php?id=80948
# When John Wesley Powell led an expedition down the Colorado River and through the Grand Canyon in 1869, he was confronted with a daunting landscape.
 #At its highest point, the serpentine gorge plunged 1,829 meters (6,000 feet) from rim to river bottom, making it one of the deepest canyons in the United States. 
#In just 6 million years, water had carved through rock layers that collectively represented more than 2 billion years of geological history, nearly half of the time Earth has existed.
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
plotRGB(gc, r=1, g=2, b=3, stretch="lin")
plotRGB(gc, r=1, g=2, b=3, stretch="hist")
gcc2 <- unsuperClass(gc, nClasses=2)
gcc2
plot(gcc2$map)
gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)

#rifatto stesso procedimento di prima

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#SESTO CODICE 

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
-----------------------------------------------------------------------------------------------------------------------------------------------------

#SETTIMO CODICE

# R_code_vegetation_indices.r

library(raster) # require(raster)
library(RStoolbox) # per il calcolo degli indici di vegetazione

# install.packages("rasterdiv")

# per l'indice NDVI del pianeta
library(rasterVis)

setwd("~/Desktop/lab")

defor1<-brick("defor1.jpg")
defor2<-brick("defor2.jpg")

# b1= NIR, b2= red, b3= green

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin") # vediamo le due immagine sulla stessa colonna, si nota la grande diminuzione di vegetazione della foresta amazzonica

# calcoliamo il primo indice di vegetazione

defor1 # andiamo a vedere il nome delle bande aprendo tutte le informazioni del file e vediamo che il NIR si chiama defor1.1 e il RED defor1.2

dvi1 <- defoder1$defor1.1-defor1$defor1.2 # per ogni pixel prendiamo il valore nel NIR e sottraiamo il valore nel RED, si crea una mappa composta dalla differenza dei pixel = DVI

plotdvi1
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifichiamo lo schema dei colori in modo che si veda bene la vegetazione in rosso

plot(dvi1, col=cl, main="DVI at time 1") # in questo modo visualizziamo il DVI che abbiamo appena calcolato

# calcoliamo l'indice di vegetazione per la seconda immagine
dvi2 <- defor2$defor2.1-defor2$defor2.2

plotdvi2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)

plot(dvi2, col=cl, main="DVI at time 2") # è ben visibile in giallo la parte in cui non è più presente vegetazione

# mettiamo le due immagini a confronto
par (mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

# Qual'è la differenza nella stessa zona tra questi due tempi? facciamo la differenza tra i DVI delle due situazioni
difdvi <- dvi1 - dvi2 #facciamo la differenza per ogni pixel, anche se hanno estensione diversa viene calcolata la differenza dove è presente l'intersezione.

plot(difdvi)

cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld)

# ndvi: facciamo la standardizzazione sulla somma dell'indice di vegetazione
# NDVI= (NIR-RED) / (NIR+RED)

ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
# si potrebbe anche fare ndvi1 <- dvi1 / (defor1$defor1.1 + defor1$defor1.2)


plot(ndvi1)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)

plot(ndvi1, col=cl)

ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
plot(ndvi2, col=cl)

# Rstoolbox: spectralIndices
# si può usare la funzione spectralIndices che calcola diversi indici multrispettrali
vi1 <- spectralIndices(defor1, green = 3, red = 2, nir = 1)
plot (vi1, col=cl)

vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
plot (vi2, col=cl)

difndvi <- ndvi1 - ndvi2 # vediamo la differenza tra gli indici di vegetazione delle due immagini normalizzati
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld)

# worldwilde NDVI
plot(copNDVI)

copNDVI <- reclassify(copNDVI, cbind(253:255, NA)) # per oscurare i valori dell'acqua che non ci interessano
plot(copNDVI)

# è necessario richiamare il pacchetto rasterVis
levelplot(copNDVI) # immagine che mostra i valori di biomassa della Terra

----------------------------------------------------------------------------------------------------------------------------

#OTTAVO CODICE

# R_code_land_cover.r

library(raster)
library(RStoolbox) # per la classificazione
# install.packages("ggplot2")
library(ggplot2)
# install.packages("gridExtra")
library(gridExtra)

setwd("~/Desktop/lab")

defor1<-brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch= "lin") # plottiamo l'immagine in RGB

# necessari i pacchetti "RStoolbox" e "ggplot"
ggRGB(defor1, r=1, g=2, b=3, stretch= "lin") # creiamo un immagine singola delle 3 bande

defor2<-brick("defor2.jpg")
ggRGB(defor2, r=1, g=2, b=3, stretch= "lin") # facciamo lo stesso procedimento con la seconda immagine

# mettiamo a confronto le due immagini
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

# per fare un multiframe delle due immagini con ggplot2 bisogna utilizzare la funzione "grid.arrange"
# necessario installare "gridExtra"

# diamo un nome a ciascuno plot e poi li mettiamo insieme
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch= "lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch= "lin")

grid.arrange(p1,p2, nrow=2)

# classificazione non supervisionata, garantisce di non agire in modo soggettivo
d1c <- unsuperClass(defor1, nClasses=2)

d1c
plot(d1c$map) 
# classe 1 agricola
# classe 2 foresta
# set.seed() per permetterti di ottenere gi stessi risultati

d2c <- unsuperClass(defor2, nClasses=2)

d2c
plot(d2c$map) 
# classe 1 agricola
# classe 2 foresta

d2c3 <- unsuperClass(defor2, nClasses=3)
plot(d2c3$map) 
# classe 3 foresta
# classe 1 e 2 due tipi diversi di coltivazione

# frequenze
freq(d1c$map) # calcola l afrequenza di delle due classi nella mappa che abbiamo generato
# value  count
# [1,]     1  33575
# [2,]     2 307717

s1 <- 33575 + 307717

prop1 <- freq(d1c$map) / s1 # calcoliamo la proporzione delle frequenze
# prop coltivazioni agricole: 0.09837617
# prop foresta: 0.90162383

s2 <- 342726
prop2 <- freq(d2c$map) / s2
# prop coltivazioni agricole: 0.4769174
# prop foresta: 0.5230826

# si possono anche calcolare le percentuali moltiplicando per cento

# build a dataframe
# facciamo una tabella che contenga questi risultati
cover <- c("Forest", "Agriculture") # prima colonna. Siccome è un vettore di due diversi blocchi devo mettere "c"
percent_1992 <- c(90.16, 9.84)
percent_2006 <- c(52.31, 47.69)

percentages <- data.frame (cover, percent_1992, percent_2006)
#    cover percent_1992 percent_2006
# 1      Forest        90.16        52.31
# 2 Agriculture         9.84        47.69

# plottiamo con la funzione ggplot le percentuali di cover di foresta e coltivazioni
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="light blue")

ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="light blue")

# creiamo un unico grafico
p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="light blue")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="light blue")

grid.arrange(p1, p2, nrow=1)
---------------------------------------------------------------------------------------------------------------------------------------------

#NONO CODICE

# R_code_variability.r
# Analizziamo pattern spaziali tramite l’uso di indici del paesaggio nell’area del ghiacciao del Similaun

library(raster)
library(RStoolbox)
library(ggplot2) # per ploottare ggplot
library(gridExtra) # per plottare insieme ggplot
#install.packages("viridis")
library(viridis) # serve per colorare i plot automaticamente

setwd("~/Desktop/lab")

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
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#DECIMO CODICE

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
------------------------------------------------------------------------------------------------------------------------------------------------------


#FINE

