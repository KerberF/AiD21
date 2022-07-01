##############################Allgemeine Einstellungen##############################

Projekt <- "Testlauf"
Charge <- "Lauf_1"
Total.Samples <-  4   #Anzahl an Proben, die miteinander verglichen werden sollen 
Referenzfläche <- 100   #Fläche, auf die die Partikelanzahl aller Proben bezogen wird
Version <- "Test"

######################################Samplemanager#################################

#vorliegendes Dateiformat der Messwerte(Auswahl: ".csv" oder ".txt")
Messwerte <- "" #Wenn kein Eintrag vorhanden, dann wird standardmäßig der Name der Charge übernommen 
Dateiformat.Messwerte <- ".csv"
Trennzeichen <- ";"
Dezimalzeichen <- ","

#Datentitel aus Datei
Name.Datei <- "Titel_MAC-AMC" #Dateiendung nicht mit notieren, wird mit nächster Variable erfasst; Wenn kein Eintrag vorhanden, dann wird standardmäßig der Name der Charge übernommen 
Dateiformat.Titel <- ".csv" #vorliegendes Dateiformat der Titel(Auswahl: ".csv" oder ".txt")


#################################Partikelklassierung################################

#Rulefile-Einstellungen
Name.Rulefile <- "Rulefile_16Cr7Mn6Ni_sintered_v2.6"
Dateiformat.Rulefile <- ".csv"

#Abstandsüberprüfung durchführen?  (TRUE = Ja)
Abstandsüberprüfung <- TRUE

#Minimaler Abstand in mm zwischen den Partikeln, dass sie als separate Partikle gezählt werden
min.Abstand <- 0.001   

#Soll der minimale Abstand zwischen einem Partikel und den nächsten 10 Partikeln getestet werden? (TRUE=Ja, FALSE=es wird nur der Abstand zum nächsten Partikel getestet)
Ausfuehrlicher.Abstandspruefer <- TRUE

##Positionsnormierung? #Normierung der Positionen auf den Ursprung (0;0))
Position.Normierung <- TRUE 

#Sollen die einzelnen Gehalte vor der Klassierung normiert werden und die normierten Daten für die Klassierung verwendet werden?  (TRUE=Ja)
Normierung.vorher <- FALSE

#Welche Elemente sollchen dafür berücksichtigt werden?
Elements <- c("N","Na","Mg","Al","Si","S","K","Ca","Ti","Mn","O","Cr") 

#Welche Elemente sollen auf 0 gesetzt werden? 
Elements.0 <- c("Fe","C")

#Sollen ausgewählte Partikel vor der Zusammensetzungsnormierung Vorklassiert werden? Beispiel: Kratzer, FeO oder Schmutz können nach der Normierung nur noch schwer detketiert werden
Vorklassierung <- FALSE

#Sollen die Flächenanteile der einzelnen Partikelklassen bestimmt werden? 
Berechnung.Flächenanteile <- FALSE 

#Sollen die mittlere Anzahl der Partikel pro gemessenem Field ermittlet werden? 
Clusterprüfung <- TRUE 

#Unterteilung der Messfläche in eine Matrix (Anzahl.Spalten x Anzahl.Reihen)
Anzahl.Spalten <-4 #definiert die Anzahl der Felder innerhalb einer Reihe, d.h. Anzahl der Spalten im Messfeld

Quadrate <- TRUE #wenn TRUE, dann wird Anzahl Reihen so ermittelt, dass Felder mit möglichst quadratischer Geometrie entstehen, exakte Quadrate nicht immer möglich, da Anzahl eine ganze Zahlen sein müssen 

Anzahl.Reihen <- 4 #definiert die Anzahl der Felder innerhalb einer Spalte, d.h. Anzahl der Reihen im Messfeld; wenn Quadrate <- TRUE, dann wird die benötigte Anzahl an Reihen automatisch ermittelt unabhängig davon, was in dieser Variabel definiert ist

#Sollen für die Clusterprüfung Balkendiagramme dargestellt werden?  
Darstellungen.Clusterprüfung <- TRUE


##############################Partikelgrößenbestimmung##############################

#Nach welchem Merkmal sollen die Partikel hinsichtlich ihrer Größe klassiert werden? 
Merkmal.Größenklassierung <- "AREA"

#Soll der Äquivalentdurchmesser (Dequi) für die klassierten Partikel berechnet werden? Hinweis: Durch den Abstandsprüfer werden die Partikelfächen aufsummiert, Dequi wird aus dieser neuen Fläche berechnet.
Ermittlung.Dequi <- FALSE


Total.Größenklassen <- 11 #Anzahl der vorhandenen Partikelklassen 

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


#Für alle Partikel gemeinsam durchführen? (TRUE = Ja)
alle.Partikel <- TRUE

#Partikelgrößenbestimmung nach Klassen getrennt durchführen? (TRUE = Ja)
nach.Klassen <- TRUE

#Zusätzliche Speicherung nach Klassen? (TURE= SPeicherung nach Klassen, FALSE = Speicherung nach Proben)
Speicherung.Klassen <- TRUE


####################################Darstellungen###################################

#Was soll dargestellt werden?
plot.x <- "Cr"
plot.y <- "Mn"
plot.z <- "Si"

#Skalierung der x- und y-Achse
Skalierung.x <- c(0,65)
Skalierung.y <- c(0,65)


#Maximalwert für den Farbverlauf
Maximum <- 25
Minimum <- 0 #bei Darstellung nach Klassen automatisch von 0 bis max, bei Darstellung gesamt wählbar. 
#Position der Legende
Position.Legende.x <- 200
Position.Legende.y <- 0

#Ausgabe in PDF 
figure.rows <- 3#Anzahl an Zeilen
figure.col <- 2 ##Anzahl an Spalten

#Ausgabe als mehrseitige PDF? (TRUE= mehrseitige PDF, FALSE = mehrere einzelne PDFs)
Mehrseitige.PDF <- FALSE


#Sollen alle Partikel gemeinsam dargestellt werden? 
Darstellung.gesamt <- TRUE

#Darstellung einer normierten Zusammensetzung? 
Daten.Normiert <- TRUE

#Sollen nur ausgewählte Klassen dargestellt werden? (Wenn TRUE, dann wird Darstellung.gesamt automatisch auf FALSE gestellt.
#Keine Auswahl für normierte oder nicht normierte Daten möglich, es werden automatisch die Daten aus der zugehörigen Partikelklassierung dargestellt.
Darstellung.Klassen <- TRUE 


#Die folgenden Optionen sind nur verfügbar, wenn die Darstellung nach ausgewählten Klassen aktiviert wurde.

#Wieviele Klassen sollen dargestellt werden?  
Darstellungen.Klassen.Anzahl <- 5

#Klassennamen, welche dargestellt werden sollen
#die Klassen werden immer von 1 beginnend dargestellt
#es müssen mindestens so viele Klassennamen eingegeben werden, wie in Darstellung.Klassen.Anzahl angegeben wurde
#weitere Klassennamen stören nicht, werden nicht berücksichtigt
#Klassennamen müssen exakt mit den Namen der Partikelklassierung übereinstimmen 

Klasse.1 <- "Cr-Mn"
Klasse.2 <- "Si-Mn"
Klasse.3 <- "Si-Cr-Mn"
Klasse.4 <- "Mn-Si-lowAl"
Klasse.5 <- "Mischoxide"
Klasse.6 <- "Mischsulfide"
Klasse.7 <- "MnSi-Al2O3-MnS"
Klasse.8 <- "Kratzer"
Klasse.9 <- "Schmutz"
Klasse.10 <- "andere"

#Sollen der PDF-Name die Namen der dargestellten Klassen enthalten? Falls PDF-Name zu lang, können an dieser Stelle Zeichen eingespart werden
Klassennamen.in.Datei <- TRUE

#Darstellung in Farbe oder in Graustufen? TRUE = Farbig, FALSE = Graustufen 
Farbig <- TRUE 

#Symbole mit schwarzem Rand und abweichender Füllung? TRUE = mit Rand; FALSE = kein Rand; geht nur im Farbmodus, andernfalls wird es automatisch auf FALSE gesetzt 
Symbole.Füllung <- TRUE

##############################Programmeinstellungen##############################

Speicherort <- "C:/Users/flori/Homeoffice/ASPEX-Auswertung-Programm" #Speicherort für die Hauptordner; kann auch gleich dem Speicherort des R-Projektes sein 



