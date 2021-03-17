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


