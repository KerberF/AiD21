###aktuell keine Verwendung

###Klassifizierung der Partikelgröße 


#Partikelklassen
Grenze.1 <- 0
Grenze.2 <- 1
Grenze.3 <- 3
Grenze.4 <- 5
Grenze.5 <- 10
Grenze.6 <- 20
Grenze.7 <- 30
Grenze.8 <- 50
Grenze.9 <- 80
Grenze.10 <- 130
Grenze.11 <- 200



#Für alle Partikel gemeinsam durchführen? (TRUE= für alle Partikel, FALSE= für ausgewählte Klassen)
alle.Partikel <- FALSE

#Partikelgrößenbestimmung nach Klassen getrennt durchführen? (TRUE= ja, "alle.Partikel" wird automatisch auf "FALSE" gestellt)
nach.Klassen <- TRUE


#Zusätzliche Speicherung nach Klassen? (TURE= SPeicherung nach Klassen, FALSE = Speicherung nach Proben)
Speicherung.Klassen <- TRUE


source(paste("05 - Scripts/",Programm.Version,"/Partikelgrößenbestimmung/Partikelgrößenbestimmung_ausführen.R",sep=""))


