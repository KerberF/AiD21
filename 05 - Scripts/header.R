#Auswertung von ASPEX-Untersuchungen v1.5

#Einstellungs-Datei; anzugeben ist der Dateiname der zu verwendeten Einstellungsdatei; bei keiner Angabe wird die Datei "Einstellungen.R" genutzt 
Einstellungen <- "Einstellungen_D";  file.edit(paste("03 - Einstellungen/",Einstellungen,".R",sep=""))


#Was soll durchgeführt werden? 


#Erzeugung der Hauptordner + Versionsaktualisierung
source("05 - Scripts/Version.R")

#Erzeugen eines neuen Projekt- oder Chargenordners 
source(paste("05 - Scripts/",Programm.Version,"/Run/Run_Ordner.R",sep=""))

#Partikelklassierung  
source(paste("05 - Scripts/",Programm.Version,"/Run/Run_Partikelklassierung.R",sep=""))

#Clusterprüfung
source(paste("05 - Scripts/",Programm.Version,"/Run/Run_Clusterprüfung.R",sep=""))

#Partikelgrößenbestimmung 
source(paste("05 - Scripts/",Programm.Version,"/Run/Run_Partikelgrößenbestimmung.R",sep=""))

#Darstellung 
source(paste("05 - Scripts/",Programm.Version,"/Run/Run_Darstellungen.R",sep=""))

#Partikelklassierung + Partikelgrößenbestimmung 
source(paste("05 - Scripts/",Programm.Version,"/Run/Run_Partikelklassierung_Partikelgrößenbestimmung.R",sep=""))

#Partikelklassierung + Partikelgrößenbestimmung + Darstellung
source(paste("05 - Scripts/",Programm.Version,"/Run/Run_Partikelklassierung_Partikelgrößenbestimmung_Darstellung.R",sep=""))



