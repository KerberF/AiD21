
Ierror <- tryCatch(
  {
    Rulefile <- read.table(file=file.Rulefile, header=TRUE, dec=",", sep=";",fileEncoding = "ISO-8859-1") 
    #Rulefile <- read.table(file = "rule.csv", header=TRUE, dec=",", sep=";",fileEncoding = "ISO-8859-1")
    Ierror <- 0
  },
  error=function(cond)
  {
    closeSweetAlert(session)
    if(isTRUE(grepl("nicht öffnen",cond)))
    {
      sendSweetAlert(session, title=paste("Rulefile ", file.Rulefile," nicht gefunden. Bitte Dateipfad und Dateiname überprüfen.",sep=""), type="error", width= 1000)
    }else{
      sendSweetAlert(session, title=paste("Fehler in Rulefile-Datei ", file.Rulefile,". Bitte Datei überprüfen.",sep=""), type="error", width= 1000)
    }
    return(1)
  },
  warning=function(cond)
  {
    closeSweetAlert(session)
    if(isTRUE(grepl("nicht öffnen",cond)))
    {
      sendSweetAlert(session, title=paste("Rulefile ", file.Rulefile," nicht gefunden. Bitte Dateipfad und Dateiname überprüfen.",sep=""), type="error", width= 1000)
    }else{
      sendSweetAlert(session, title=paste("Fehler in Rulefile-Datei ", file.Rulefile,". Bitte Datei überprüfen.",sep=""), type="error", width= 1000)
    }
    return(1)
  }
  
)



if(Ierror==0)
{
  
  length_file <- length(Rulefile$Klassenname)
  if(Vorklassierung==TRUE)
  {
  PreRulefile <- data.frame(Rulefile$PreKlassennamen,Rulefile$PreKlassenbedingungen)
  Total.PreClasses <- 0
  for(i in 1:length_file) #Bestimmt die Anzahl an PreKlassen
  {
    if(paste(PreRulefile[i,1])!="NA"& paste(PreRulefile[i,1])!="")
    {
      Total.PreClasses <- Total.PreClasses+1
    }
  }
  }
  Rulefile <- data.frame(Rulefile$Klassenname,Rulefile$Klassenbedingung)
  
  Total.Classes <- 0
  for(i in 1:length_file) #Bestimmt die Anzahl an PreKlassen
  {
    if(paste(Rulefile[i,1])!="NA"& paste(Rulefile[i,1])!="")
    {
      Total.Classes <- Total.Classes+1
    }
  }
  
  ##Erzeugung vonNamen zur Abrufung von Klassennamen und Klassenbedingungen
  
  Condition.Classes <- paste("Condition.Class",1:Total.Classes,sep="") #Erstellt Namen zur Abrufung der Klassenconditions
  
  if(Vorklassierung==TRUE)
  {
    Condition.PreClasses <- paste("Condition.PreClass",1:Total.PreClasses,sep="") #Erstellt Namen zur Abrufung der Klassenconditions
  }
  
  Classes <- paste("Class",1:Total.Classes,sep="")
  if(Vorklassierung==TRUE)
  {
    PreClasses <- paste("PreClass",1:Total.PreClasses,sep="")
  }
  
  
  #Einlesen
  for(i in 1:Total.Classes)
  {
    ClassNr <-   Classes[i]
    Classname <- paste(Rulefile[i,1])
    assign(ClassNr, Classname)
    ClassConNr <- Condition.Classes[i]
    Cond <- parse(text=paste(Rulefile[i,2]))
    assign(ClassConNr, Cond)
  }
  
  
  if(Vorklassierung==TRUE)
  {
    if(Total.PreClasses>0)
    {
      for(i in 1:Total.PreClasses)
      {
        PreClassNr <-   PreClasses[i]
        PreClassname <- paste(PreRulefile[i,1])
        assign(PreClassNr, PreClassname)
        PreClassConNr <- Condition.PreClasses[i]
        Cond <- parse(text=paste(PreRulefile[i,2]))
        assign(PreClassConNr, Cond)
      }
    }  
  }
}