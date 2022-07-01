#run_all: Ausführen aller notwendigen Skritps für eine vollständige Partikelklassierung mit Partikelgrößenbestimmungsource("Scripts/Variablenbildung.R")
Durchgeführt <- "Partikelklassierung+Partikelgrößenbestimmung"

if(Einstellungen =="")
{
  Einstellungen <- "Einstellungen"
}
source(paste("03 - Einstellungen/",Einstellungen,".R",sep=""))

source(paste("05 - Scripts/",Programm.Version,"/Variablen/Variablenbildung.R",sep=""))

source(paste("05 - Scripts/",Programm.Version,"/Samples/Dateneinleser.R",sep=""))
source(paste("05 - Scripts/",Programm.Version,"/Rulefiles/Einlesen_Rulefile.R",sep=""))
source(paste("05 - Scripts/",Programm.Version,"/Variablen/Variablenfuellung.R",sep="")) #muss ausgeführt werden, um alle nötigen Vektoren zu erzeugensource
source(paste("05 - Scripts/",Programm.Version,"/Variablen/Ordnerstruktur.R",sep=""))

source(paste("05 - Scripts/",Programm.Version,"/Partikelklassierung/Partikelklassierung.R",sep=""))

source(paste("05 - Scripts/",Programm.Version,"/Partikelgrößenbestimmung/Partikelgrößenbestimmung_ausführen.R",sep=""))
source(paste("05 - Scripts/",Programm.Version,"/Dokumentation/Dok_Partikelklassierung+Partikelgrößenbestimmung.R",sep=""))

print(paste("Partikelklassierung und Partikelgrößenbestimmung für die Charge '",Charge,"' Version ",Version," erfolgreich durchgeführt.",sep="" ))
