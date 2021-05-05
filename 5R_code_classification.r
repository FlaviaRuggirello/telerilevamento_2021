#R_code_classification.r

library(raster)
library(RStoolbox)

setwd("~/Desktop/lab") #settiamo la working directory 

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

soc <- unsuperClass(so, nClasses=3)

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

#noize - cerca in internet 

#mask serve per nascondere "le nuvole" 

plot(soc20$map,col=cl)

cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(soc20$map,col=cl)
# Download Solar Orbiter data and proceed further!
# Grand Canyon
# https://landsat.visibleearth.nasa.gov/view.php?id=80948
# When John Wesley Powell led an expedition down the Colorado River and through the Grand Canyon in 1869, he was confronted with a daunting landscape. At its highest point, the serpentine gorge plunged 1,829 meters (6,000 feet) from rim to river bottom, making it one of the deepest canyons in the United States. In just 6 million years, water had carved through rock layers that collectively represented more than 2 billion years of geological history, nearly half of the time Earth has existed.
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
plotRGB(gc, r=1, g=2, b=3, stretch="lin")
plotRGB(gc, r=1, g=2, b=3, stretch="hist")
gcc2 <- unsuperClass(gc, nClasses=2)
gcc2
plot(gcc2$map)
gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)
