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

