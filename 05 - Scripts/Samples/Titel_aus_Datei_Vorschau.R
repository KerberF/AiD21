#Einlesen der Datensatztitel aus einer Datei: 

#file.Datentitel <- "01 - Projekte/Testlauf/Lauf_1/Messwerte/Titel_MAC-AMC.csv"

Ierror <- tryCatch(
  {
    Daten.Titel <- read.table(file=file.Datentitel, header=TRUE, dec=",", sep=";",fileEncoding = "ISO-8859-1") 
    Ierror <- 0
  },
  error=function(cond)
  {
    closeSweetAlert(session)
    if(isTRUE(grepl("nicht öffnen",cond)))
    {
      sendSweetAlert(session, title=paste("Datentitel ", file.Datentitel," nicht gefunden. Bitte Dateipfad und Dateiname überprüfen.",sep=""), type="error", width= 1000)
    }else{
      sendSweetAlert(session, title=paste("Fehler in Datentitel-Datei ", file.Datentitel,". Bitte Datei überprüfen.",sep=""), type="error", width= 1000)
    }
    return(1)
  },
  warning=function(cond)
  {
    closeSweetAlert(session)
    closeSweetAlert(session)
    if(isTRUE(grepl("nicht öffnen",cond)))
    {
      sendSweetAlert(session, title=paste("Datentitel ", file.Datentitel," nicht gefunden. Bitte Dateipfad und Dateiname überprüfen.",sep=""), type="error", width= 1000)
    }else{
      sendSweetAlert(session, title=paste("Fehler in Datentitel-Datei ", file.Datentitel,". Bitte Datei überprüfen.",sep=""), type="error", width= 1000)
    }
    return(1)
  }
  
)




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
  
  Total.Samples <- (figure.col*figure.rows)
  if(Total.Samples>=length(Daten.Titel$Titel))
  {
    Total.Samples <- length(Daten.Titel$Titel)
  }
  if(Total.Samples>0)
  {
    
    source("05 - Scripts/Variablen/Variablenbildung.R", local = TRUE)
    
    
    
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
      assign(MessflächeNr, Fläche)
      
    }
  }else{sendSweetAlert(session, title=paste("Fehler in Datentitel-Datei ", file.Datentitel,". Bitte Datei überprüfen.",sep=""), type="error", width= 1000)
    Ierror <- 1}
  
}
