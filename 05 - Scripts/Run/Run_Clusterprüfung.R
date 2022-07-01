#run_all: Ausführen aller notwendigen Skritps für eine vollständige Partikelklassierung mit Partikelgrößenbestimmungsource("Scripts/Variablenbildung.R")
Durchgeführt <- "Clusterprüfung"

if(Einstellungen =="")
{
  Einstellungen <- "Einstellungen"
}
source(paste("03 - Einstellungen/",Einstellungen,".R",sep=""))

source(paste("05 - Scripts/",Programm.Version,"/Variablen/Variablenbildung.R",sep=""))


source(paste("05 - Scripts/",Programm.Version,"/Variablen/Ordnerstruktur.R",sep=""))


source(paste("05 - Scripts/",Programm.Version,"/Variablen/Variablenfuellung.R",sep="")) #muss ausgeführt werden, um alle nötigen Vektoren zu erzeugensource

#Speicherung der originalen Partikelnummern in einer extra Spalte


source(paste("05 - Scripts/",Programm.Version,"/Partikelklassierung/Clusterprüfung.R",sep=""))
source(paste("05 - Scripts/",Programm.Version,"/Dokumentation/Dok_Clusterprüfung.R",sep=""))

print(paste("Clusterprüfung für die Charge '",Charge,"' Version ",Version," erfolgreich durchgeführt.",sep="" ))
