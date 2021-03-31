# My code in R for remote sensing -> "#" serve per scrivere i commenti 

# Chiamare la cartella "lab" in R - R lavora per funzioni quindi ci serve una funzione che dica al sistema che lavoriamo sempre con quella cartella 

# install.packages("raster")

# primo passaggio il settaggio della Working directory 
#setwd("-/lab/")

setwd("~/Desktop/lab") #io ho Mac 


# inseriamo ora i dati , prendiamo da R attraverso un altro comando i dati nella cartella 
# funzione "brick" importa in blocco le immagini per farne una unica satellitare 

# associare brick a un nome 
# "nome oggetto" <- brick ... ( controllare prima se sono funzioni interne o esterne a R - brick sta in rasterpackage )

# richiamare prima il pacchetto 
library("raster")

brick("p224r63_2011_masked.grd")

# assegnare un nome 

p224r63_2011 <- brick("p224r63_2011_masked.grd")

# per vedere il file scrivo il nome e premo invio : rasterbrick , una serie di bnde in formato raster 
# impacchettamento - poi troviamo le dimensioni ( piccole ) - n° righe - n° colonne - calcolo pixel : righe per colonne 
# milioni di pixel per ogni banda - risoluzione 30mt - estensione , ci sono le coordinate - SI 
# sorgente , da dove lo ho preso - banda SRE (1) ecc ... fino alla (7) 
# riflettanze 

# visualizzare bande : funzione plot 

plot(p224r63_2011) #senza virgolette perchè è già in R e visualizzo le immagini 

# dev.off() se esce -> Error in plot.new() : figure margins too large poi di nuovo plotecc


###DAY 2 lez. 17.03.2021

# plottaggio singole bande 
#colori plot 
#B1 : BLUE
#B2 : GREEN
#B3 : RED 
#B4 : NIR 
#B5 
#B6

# colorRampePalette () possiamo cambiare e definire i colori del plot - R relaziona colore con etichetta "label" imp le virgolette 

colorRampePalette(c("black","grey","light grey")) (100) #livelli scala di colori 

#c () in R indica una serie di elementi -> vettore = array 

cl <- colorRampePalette(c("black","grey","light grey")) (100) #livelli scala di colori  , cl nome 

#ora plot con nuovi volori - richiamiamo plot 

plot(p224r63_2011, col=cl) 

#esercizio cambiare colore 

cl1 <- colorRampePalette (c("blue","yellow","grey")) (100)
plot(p224r63_2011, col=cl) #immagine p..r immagine landsat - modis : mod... - file estensione nc derivano da un progrmma "Copernicus "



#### DAY 3 24.03.2021

#SELEZIONARE LA CARTELLA DI RIFERIMENTO 

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

#simbolo per legare banda X a immagine satellitare "$" dollaro.
#plottiamo B1

plot(p224r63_2011$B1_sre)

#plottare banda 1 con scala colori che vogliamo noi

cls2 <- colorRampPalette(c("pink","green","brown","purple")) (200)
plot(p224r63_2011, col=cls2)

plot(p224r63_2011$B1_sre, col=cls2)
dev.off()

#funzione PAR - è una funzione generica - serve per fare un settaggio dei parametri grafici , di un graf che vigliamo creare 
#possiamo plottare accanto l'immagine del B1 (banda blue ) e B2 (banda verde) - staimo facendo multiframe 
# MultiFrame MF. 
#Faremo poi sistema con una riga e due colonne , quindi MF = c( 1,2 ) , "c" è vettore
# quindi grafici con una disposizione che useremo sempre 

plot(p224r63_2011$B1_sre) #plotbandablu
plot(p224r63_2011$B2_sre) #plotbanda verde 
 #dobbiamo metterle una affianco all'altra in R , non una alla volta 

#PAR ci fa mettere le imagini come vogliamo noi in pratica 


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

#26.03.2021

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
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") #immagine a colori naturali - "stretch=Lin " serve per gestire tutte le fasi dei colori 
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
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist") #stretch più pro , al centro della foresta vediamo
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

#31.03.2021 - nuova lezione MULTITEMPORAL SET 

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


