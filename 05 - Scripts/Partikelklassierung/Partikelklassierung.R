##Ausführung der Partikelklassierung

if(Position.Normierung==TRUE)
{
  updateProgressBar(session, id="Progress.Partikelklassierung", title = "Partikelklassierung läuft: Positionsnormierung", value = 20)
  source("05 - Scripts/Normierung/Positionsnormierer.R",local = TRUE)
}
updateProgressBar(session, id="Progress.Partikelklassierung", title = "Partikelklassierung läuft: Vorklassierung", value = 30)
Schrittweite <- (20/Total.Samples)
if(Vorklassierung==TRUE)
{
  
  #kopieren der originalen Partikelnummern
  #Vorklassierung
  for(j in 1:Total.Samples)
  {
    if(Ierror==0)
    {
    updateProgressBar(session, id="Progress.Partikelklassierung", title = "Partikelklassierung läuft: Vorklassierung", value = (30+j*Schrittweite))
    Sample<- get(Samples[j]) 
    Messfläche <- get(Messfläche.all[j])
    Title.Sample <- get(Title.Sample.all[j]); 
    source("05 - Scripts/Partikelklassierung/Vorklassierer.R", local = TRUE);
    SampleNr <- Samples[j]
    if(length(Sample.cut$PART>0))
    {
      Sample.cut$PART <- 1:length(Sample.cut$PART)
    }
    assign(SampleNr, Sample.cut)
    Summary.allPre[j,] <- data.frame(Summary.PreClasses[1,]) ; #Speicherung der Partikelgesamtanzahl
    Summary.all.normPre[j,] <- data.frame(Summary.PreClasses[2,]) #Speicherung der normierten Partikelanzahl 
    }
  }

  #used.Samples
  #Summary.allPre
  ##Speicherung der Zusammenfassung
  #row.names(Summary.allPre) <- used.Samples
  #row.names(Summary.all.normPre) <- used.Samples
  Versuchsbezeichnung <- used.Samples
  Titel <- used.Samples.displayed.Title
  
  Summary.allPre <- data.frame(Versuchsbezeichnung, Titel, Summary.allPre) 
  Summary.all.normPre <- data.frame(Versuchsbezeichnung, Titel, Summary.all.normPre) 
  if(Ierror==0)
  {
  Ierror <-  safewrite.csv(Summary.allPre, filename =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/Partikelanzahl_pre_",Charge,"_",Version,".csv",sep=""),rownames= FALSE)
  if(Ierror==0)
  {
    Ierror <-  safewrite.csv(Summary.all.normPre, filename =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/Partikelanzahl_pre_flächennormiert_",Charge,"_",Version,".csv",sep=""),rownames=FALSE)
    
  }
  }
}

updateProgressBar(session, id="Progress.Partikelklassierung", title = "Partikelklassierung läuft: Zusammensetzungsnormierung", value = 50)  
if(Ierror==0)
{
  
  if(Normierung.vorher==TRUE)  
  {
    source("05 - Scripts/Normierung/Zusammensetzungsnormierer.R",local = TRUE)
    for(i in 1:Total.Samples)
    {
      SampleNr <- Samples[i]
      Datensatz <- read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Messwerte normiert/",get(Title.Sample.all[i]),"_",Version,"_normiert.csv",sep=""), header=TRUE, dec=",", sep=";")
      Datensatz <- Datensatz[,-1]
      assign(SampleNr, Datensatz)
    }
  }
  updateProgressBar(session, id="Progress.Partikelklassierung", title = "Partikelklassierung läuft: Hauptklassierung", value = 70)
  for(j in 1:Total.Samples)
  {
    if(Ierror==0)
    {
      updateProgressBar(session, id="Progress.Partikelklassierung", title = "Partikelklassierung läuft: Hauptklassierung", value = (70+j*Schrittweite))
      Sample<- get(Samples[j]) 
      Messfläche <- get(Messfläche.all[j])
      Title.Sample <- get(Title.Sample.all[j]); 
      source("05 - Scripts/Partikelklassierung/Klassierer_auto.R",local = TRUE);
      Summary.all[j,] <- data.frame(Summary.Classes[1,]) ; #Speicherung der Partikelgesamtanzahl
      Summary.all.norm[j,] <- data.frame(Summary.Classes[2,]) #Speicherung der normierten Partikelanzahl 
    }
  }
  #Summary.all.norm
  ##Speicherung der Zusammenfassung
  #row.names(Summary.all) <- used.Samples
  #row.names(Summary.all.norm) <- used.Samples
  if(Ierror==0)
  {
    Summary.all <- data.frame(Versuchsbezeichnung, Titel, Summary.all) 
    Summary.all.norm <- data.frame(Versuchsbezeichnung, Titel, Summary.all.norm) 
    
    
    Ierror  <- safewrite.csv(Summary.all, filename =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/Partikelanzahl_",Charge,"_",Version,".csv",sep=""),rownames=FALSE)
    if(Ierror==0)
    {
      Ierror  <- safewrite.csv(Summary.all.norm, filename =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/Partikelanzahl_flächennormiert_",Charge,"_",Version,".csv",sep=""),rownames=FALSE)
    }
    
    if(Ierror==0)
    {
      if(Vorklassierung == TRUE)
      {
        for(i in 1:Total.Samples)
        {
          if(Ierror==0)
          {
            Datensatz <- read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[i]),"_all_Particles_",Version,".csv",sep=""), header=TRUE, dec=",", sep=";")
            Datensatz.all <- read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[i]),"_all_Particles_pre_",Version,".csv",sep=""), header=TRUE, dec=",", sep=";")
            Datensatz <- rbind(Datensatz, Datensatz.all)
            Ierror <-   safewrite.csv(Datensatz, filename = paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[i]),"_all_Particles_combined_",Version,".csv",sep=""))
          }
        }
      }
      
      if(Ierror==0)
      {
        if(PCA==TRUE)
        {
          updateProgressBar(session, id="Progress.Partikelklassierung", title = "Partikelklassierung läuft: PCA", value = 91)
          source("05 - Scripts/Berechnungen/PCA.R",local = TRUE)
        }
        
      }
      
      if(Ierror==0)
      {
        #nur für 16Cr7Mn6Ni-Auswertung
        #source("05 - Scripts/Normierung/Zusammensetzungsnormierer_speziell.R",local = TRUE)
        if(Berechnung.Flächenanteile==TRUE)
        {
          updateProgressBar(session, id="Progress.Partikelklassierung", title = "Partikelklassierung läuft: Berechnung der Flächenanteile", value = 93)
          source("05 - Scripts/Partikelklassierung/Berechnung_Flächenanteile.R",local = TRUE)
        }
        
        if(Clusterprüfung==TRUE)
        {
          updateProgressBar(session, id="Progress.Partikelklassierung", title = "Partikelklassierung läuft: Clusterprüfung", value = 95)
          source("05 - Scripts/Partikelklassierung/Clusterprüfung.R",local = TRUE)
        }
      }
    }
  }
}