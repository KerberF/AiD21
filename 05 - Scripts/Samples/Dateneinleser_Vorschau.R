##Einlesen der Daten

##Quelle für Datensatztitel auswählen 
source("05 - Scripts/Samples/Titel_aus_Datei_Vorschau.R", local = TRUE) 
if(Ierror==0)
{
  for(i in 1:Total.Samples)
  {
    if(Ierror==0)
    {
      SampleNr <- Samples[i]
      
      ##mit Variablen Projekt und Charge versuchen; mit Versuchbezeichnung (Dateinamen) versuchen
      Ierror <- tryCatch(
        {
          Datensatz <- read.csv(paste("01 - Projekte/",Projekt,"/",Charge,"/Messwerte/",get(Title.Sample.all[i]),".csv",sep=""), header=TRUE, dec=",", sep=";")
          dim <- dim(Datensatz)
          if(dim[2]<2)
          {
            Datensatz <- read.csv(paste("01 - Projekte/",Projekt,"/",Charge,"/Messwerte/",get(Title.Sample.all[i]),".csv",sep=""), header=TRUE, dec=".", sep=",")
          }
          Ierror <- 0
        },
        error=function(cond)
        {return(1) },
        warning=function(cond)
        {return(1) }
        
      )
      ##mit Variablen Projekt und Charge versuchen; mit anzuzeigendem Titel versuchen 
      if(Ierror==1)
      {
        Ierror <- tryCatch(
          {
            Datensatz <- read.csv(paste("01 - Projekte/",Projekt,"/",Charge,"/Messwerte/",get(displayed.Title.Sample.all[i]),".csv",sep=""), header=TRUE, dec=",", sep=";")
            dim <- dim(Datensatz)
            if(dim[2]<2)
            {
              Datensatz <- read.csv(paste("01 - Projekte/",Projekt,"/",Charge,"/Messwerte/",get(displayed.Title.Sample.all[i]),".csv",sep=""), header=TRUE, dec=".", sep=",")
            }
            Ierror <- 0
          },
          error=function(cond)
          {return(1) },
          warning=function(cond)
          {return(1) }
          
        )
      }
      
      #mit Pfaden versuchen: 
      if(Ierror==1)
      {
        Ierror <- tryCatch(
          {
            Datensatz <- read.csv(get(Pfad.Samples[i]), header=TRUE, dec=",", sep=";")
            dim <- dim(Datensatz)
            if(dim[2]<2)
            {
              Datensatz <- read.csv(get(Pfad.Samples[i]), header=TRUE, dec=".", sep=",")
            }
            Ierror <- 0
          },
          error=function(cond)
          {
            closeSweetAlert(session)
            if(isTRUE(grepl("No such file or directory",cond)))
            {
              sendSweetAlert(session, title=paste("Datei ", get(Title.Sample.all[i]),".csv weder im Ordner 'Messwerte' noch unter hinterlgetem Pfad gefunden. Bitte Dateipfad und Dateiname überprüfen.",sep=""), type="error",width=1000)
            }else{
              if(isTRUE(grepl("more columns than column names",cond)))
              {
                sendSweetAlert(session, title=paste("Fehler in Datei ",get(Title.Sample.all[i]),".csv. Bitte Tabellenkopf überprüfen.",sep=""), type="error",width=1000)
              }else{
                sendSweetAlert(session, title=paste("Fehler in Datei ",get(Title.Sample.all[i]),".csv. Bitte Datei überprüfen.",sep=""), type="error",width=1000)
              }}
            return(1)
          },
          warning=function(cond)
          {
            closeSweetAlert(session)
            if(isTRUE(grepl("No such file or directory",cond)))
            {
              sendSweetAlert(session, title=paste("Datei ",get(Title.Sample.all[i]),".csv weder im Ordner 'Messwerte' noch unter hinterlegtem Pfad gefunden. Bitte Dateipfad und Dateiname überprüfen.",sep=""), type="error",width=1000)
            }else{
              if(isTRUE(grepl("more columns than column names",cond)))
              {
                sendSweetAlert(session, title=paste("Fehler in Datei ",get(Title.Sample.all[i]),".csv. Tabellenkopf überprüfen.",sep=""), type="error",width=1000)
              }else{
                sendSweetAlert(session, title=paste("Fehler in Datei ",get(Title.Sample.all[i]),".csv. Bitte Datei überprüfen.",sep=""), type="error",width=1000)
              }}
            return(1)
          }
          
        )
        
        
        
      }
      
      
      
      
      
      
      
      if(Ierror==0)
      {
        
        col.names <- colnames(Datensatz)
        for(i in 1:length(col.names))
        {
          if(col.names[i]=="PART.")
          {
            col.names[i] <- "PART"
          }
          if(col.names[i]=="FIELD.")
          {
            col.names[i] <- "FIELD"
          }
          if(col.names[i]=="MAGIELD.")
          {
            col.names[i] <- "MAGFIELD"
          }
          if(col.names[i]=="TYPE.4ET..")
          {
            col.names[i] <- "TYPE4ET"
          }
          
        }
        
        colnames(Datensatz)<- col.names
        
        assign(SampleNr, Datensatz)
      }
    }   
  }
  
  
  
  
}
