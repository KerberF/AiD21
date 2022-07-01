
#requires Variablenbildung, Projekt, Charge, Version
#Projekt <- "Refratechnik" 
#Charge  <- "Doppeltauch"
#Version <- "v1.0"
##Verktor für die Bezeichnung der PGV-Tabelle, requires: Total.Größenklassen, Klassen.Grenzen
Partikelklassen <- 0 #Erzeugung Vektor
if(Merkmal.Größenklassierung=="AREA")
{
  for(i in 1:(Total.Größenklassen-1)) #Erstellt Vektor mit Namen aller eingesetzten Größenkleen 
  {
    j <- (i+1)
    Partikelklassen[i] <- paste("(",get(Klassen.Grenzen[i]),"-",get(Klassen.Grenzen[j]),"] µm²",sep="")
  }
  Partikelklassen[Total.Größenklassen] <- paste(">",get(Klassen.Grenzen[Total.Größenklassen])," µm²",sep="")
}

if(Merkmal.Größenklassierung!="AREA")
{
  for(i in 1:(Total.Größenklassen-1)) #Erstellt Vektor mit Namen aller eingesetzten Größenkleen 
  {
    j <- (i+1)
    Partikelklassen[i] <- paste("(",get(Klassen.Grenzen[i]),"-",get(Klassen.Grenzen[j]),"] µm",sep="")
  }
  Partikelklassen[Total.Größenklassen] <- paste(">",get(Klassen.Grenzen[Total.Größenklassen])," µm",sep="")
}

#Partikelklassen <- c(1,2,3,4,5,6,7,8,10,11,12)
Spaltennamen <- c("Partikelanzahl",Partikelklassen)


#########################Speicherung nach Proben 

TablePartikelanzahl <- read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/Partikelanzahl_flächennormiert_",Charge,"_",Version,".csv", sep=""), header=TRUE, dec=",", sep=";", fileEncoding = "ISO-8859-1")
ISamples <-  length(TablePartikelanzahl$Versuchsbezeichnung)
Probennamen <- NULL
Probennamen <- as.character(TablePartikelanzahl$Versuchsbezeichnung)



for(i in 1:ISamples)
{
  Name <- Probennamen[i]
  TablePGV <-  read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Partikelgröße/nach Proben/",Name,"_",Charge,"_Partikelgrößen_flächennormiert_",Version,".csv", sep=""), header=TRUE, dec=",", sep=";",fileEncoding = "ISO-8859-1")
  Klassennamen <- as.character(TablePGV$X)
  TablePGV <- TablePGV[,-1]
  InumberKlassen <- length(Klassennamen)
  collectPartikelanzahl <- NULL
  for(j in 1:InumberKlassen)
  {
    collectPartikelanzahl[j] <- TablePartikelanzahl[i,j+2]
  }
  TableResults <- data.frame(collectPartikelanzahl,TablePGV) 
  dimTable <- dim(TableResults)
  
  for(k in 1:dimTable[2])
  {
    Sum  <- 0
    for(l in 1:dimTable[1])
    {
      Sum <- Sum+ as.numeric(TableResults[l,k])
    }
    TableResults[(dimTable[1]+1),k] <- Sum
  }
  
  rownames(TableResults) <- c(Klassennamen,"Gesamtanzahl")
  colnames(TableResults) <- Spaltennamen
  safewrite.csv(TableResults,filename = paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Zusammenfassung/nach Proben/",Name,"_Zusammenfassung_flächennormiert_",Version,".csv",sep=""))
}



########Speicherung nach Klassen 

for(i in 1:InumberKlassen)
{
  TableResultsClasses <- TableResults[1,] 
  currentClass <- Klassennamen[i]
  for(j in 1:ISamples)
  {
    Name <- Probennamen[j]
    TablecurrentSample <- read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Zusammenfassung/nach Proben/",Name,"_Zusammenfassung_flächennormiert_",Version,".csv",sep=""), header=TRUE, dec=",", sep=";", fileEncoding = "ISO-8859-1")
    TablecurrentSample <- TablecurrentSample[,-1]
    TableResultsClasses[j,] <- TablecurrentSample[i,]
    
  }
  
  rownames(TableResultsClasses) <- Probennamen
  safewrite.csv(TableResultsClasses,filename = paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Zusammenfassung/nach Klassen/",currentClass,"_Zusammenfassung_flächennormiert_",Version,".csv",sep=""))
}



