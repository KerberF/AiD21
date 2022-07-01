#Einlesen der Datensatztitel aus einer Datei: 



if(Ierror==0)
{
  sizeTable <- dim(Daten.Titel)
  if(sizeTable[2]==2)
  {  
    Aktiv <- rep("TRUE",sizeTable[1])
    Pfad <- rep("Kein Pfad vorhanden.", sizeTable[1])
    Dateiname <- NULL 
    for(i in 1:sizeTable[1])
    {
      Dateiname[i] <- Daten.Titel[i]
    }
    Daten.Titel <- data.frame(Daten.Titel, Aktiv, Pfad, Dateiname)
  }
  if(sizeTable[2]==3)
  {  
    Pfad <- rep("Kein Pfad vorhanden.", sizeTable[1])
    Dateiname <- NULL 
    for(i in 1:sizeTable[1])
    {
      Dateiname[i] <- Daten.Titel[i]
    }
    Daten.Titel <- data.frame(Daten.Titel, Pfad, Dateiname)
  }
  if(sizeTable[2]==4)
  {  
    
    Dateiname <- NULL 
    for(i in 1:sizeTable[1])
    {
      Dateiname[i] <- Daten.Titel[i]
    }
    Daten.Titel <- data.frame(Daten.Titel, Dateiname)
  }
  Daten.Titel <- subset(Daten.Titel, Aktiv == "TRUE")
  Total.Samples <- length(Daten.Titel$Titel)
  
  source("05 - Scripts/Variablen/Variablenbildung.R", local = TRUE)
  
  
  if(Total.Samples > 0)
  {
    for(i in 1:Total.Samples)
    {
      TitelNr <-   Title.Sample.all[i]
      Titel <- paste(Daten.Titel$Dateiname[i])
      assign(TitelNr, Titel)
      
      displayedTitleNr <- displayed.Title.Sample.all[i]
      displayedTitle <- paste(Daten.Titel$Titel[i])
      assign(displayedTitleNr,displayedTitle)
      
      PfadNr <- Pfad.Samples[i]
      Pfad <- paste(Daten.Titel$Pfad[i])
      assign(PfadNr, Pfad)
      
      MessflächeNr <- Messfläche.all[i]
      Fläche <- Daten.Titel[i,2]
      if(Fläche==0)
      {
        closeSweetAlert(session)
        sendSweetAlert(session, title=paste("Messfläche der Datei ",Titel," ist 0. Bitte korrekte Messfläche angeben.",sep=""), type="error", width= 1000)
        Ierror <- 1
      }
      assign(MessflächeNr, Fläche)
    }
  }else{sendSweetAlert(session, title=paste("Fehler in Datentitel-Datei ", file.Datentitel,". Bitte Datei überprüfen.",sep=""), type="error", width= 1000)
    Ierror <- 1}
}
#paste(get(Pfad.Samples[3]))
#test <- read.csv(get(Pfad.Samples[3]), header = TRUE, dec = ".", sep = ",")
#Datensatz <- read.csv(paste("01 - Projekte/","Refratechnik","/","Doppeltauch","/Messwerte/",get(Title.Sample.all[3]),".csv",sep=""), header=TRUE, dec=",", sep=";")
