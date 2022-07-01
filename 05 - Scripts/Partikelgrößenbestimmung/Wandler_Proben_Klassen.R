#Umwandlung der Partikeldatei nach Proben in Klassen 
#Hier müssen noch die richtigen Pfade eingetragen werden, dann sollte es auch gehen 
#Einlesen der Daten 
for(i in 1:Total.Samples)
{
  SampleNr <- Samples.Partikelgr[i]
  Datensatz <- read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Partikelgröße/nach Proben/",get(Title.Sample.all[i]),"_",Charge,"_Partikelgrößen_",Version,".csv",sep=""), header=TRUE, dec=",", sep=";", fileEncoding = "ISO-8859-1")
  row.names(Datensatz) <- Datensatz[,1]
  Datensatz <- Datensatz[,-1]
  colnames(Datensatz) <- Partikelklassen
  assign(SampleNr, Datensatz)
}

for(i in 1:Total.Classes)
{
  aktuelle.Klasse <- get(Classes[i])
  for(j in 1:Total.Samples)
  {
    Sample <- get(Samples.Partikelgr[j])
    Summary.Partikelgröße.nach.Klassen.norm[j,] <- data.frame(Sample[i,])
  }
  
  row.names(Summary.Partikelgröße.nach.Klassen.norm) <- used.Samples
  
  Ierror <- safewrite.csv(Summary.Partikelgröße.nach.Klassen.norm, filename =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Partikelgröße/nach Klassen/",aktuelle.Klasse,"_",Charge,"_Partikelgrößen_",Version,".csv",sep="")) 
  
  
}    

if(Ierror==0)
{
  for(i in 1:Total.Samples)
  {
    SampleNr <- Samples.Partikelgr[i]
    Datensatz <- read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Partikelgröße/nach Proben/",get(Title.Sample.all[i]),"_",Charge,"_Partikelgrößen_flächennormiert_",Version,".csv",sep=""), header=TRUE, dec=",", sep=";", fileEncoding = "ISO-8859-1")
    row.names(Datensatz) <- Datensatz[,1]
    Datensatz <- Datensatz[,-1]
    colnames(Datensatz) <- Partikelklassen
    assign(SampleNr, Datensatz)
  }
  
  for(i in 1:Total.Classes)
  {
    if(Ierror==0)
    {
      aktuelle.Klasse <- get(Classes[i])
      for(j in 1:Total.Samples)
      {
        Sample <- get(Samples.Partikelgr[j])
        Summary.Partikelgröße.nach.Klassen.norm[j,] <- data.frame(Sample[i,])
      }
      
      row.names(Summary.Partikelgröße.nach.Klassen.norm) <- used.Samples
      
      Ierror <- safewrite.csv(Summary.Partikelgröße.nach.Klassen.norm, filename =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Partikelgröße/nach Klassen/",aktuelle.Klasse,"_",Charge,"_Partikelgrößen_flächennormiert_",Version,".csv",sep="")) 
      if(Ierror==0)
      {
        if(Kenngrößen==TRUE)
        {
          source("05 - Scripts/Partikelgrößenbestimmung/Kenngrößen.R", local = TRUE)
        }
      }
    } 
  }    
  
}






