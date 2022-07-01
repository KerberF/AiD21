##Berechnung des Äquivalentdurchemessers

#erstmal nur für klassierte Daten durchführbar 
#Einlesen der klassierten Daten 

if(Vorklassierung==TRUE)
{
  for(i in 1:Total.Samples)
  {
    SampleNr <- Samples[i]
    Datensatz <- read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[i]),"_all_Particles_pre_",Version,".csv",sep=""), header=TRUE, dec=",", sep=";",fileEncoding = "ISO-8859-1")
    assign(SampleNr, Datensatz) # Schreiben von Datensatz in eine Variable mit dem Namen von dem in "SampleNr" gespeicherten String 
  }
  
  
  for(j in 1:Total.Samples)
  {
    
    
    Sample<- get(Samples[j]) 
    Messfläche <- get(Messfläche.all[j])
    Title.Sample <- get(Title.Sample.all[j]); 
    
    dim <- data.frame(dim(Sample))
    Dequi <-rep(0, times=dim[1,1]) #Erzeugung eines Vektors mit Anzahl an Elementen=Anzahl Zeilen in Sample
    Sample <- data.frame(Sample, Dequi) #Hinzufügen der neuen Spalte
    for(z in 1:dim[1,1])
    {
      Sample$Dequi[z] <- sqrt(4*Sample$AREA[z]/pi)
    }
    SampleNr <- Samples[j]
    assign(SampleNr, Sample)
    Ierror <- safewrite.csv(Sample, filename =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/","all","/",Title.Sample,"_all_Particles_pre_with_Dequi_",Version,".csv",sep=""))
    
  }
  
  
  
  
}


if(Ierror==0)
{
  
  
  
  
  for(i in 1:Total.Samples)
  {
    SampleNr <- Samples[i]
    Datensatz <- read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[i]),"_all_Particles_",Version,".csv",sep=""), header=TRUE, dec=",", sep=";",fileEncoding = "ISO-8859-1")
    assign(SampleNr, Datensatz) # Schreiben von Datensatz in eine Variable mit dem Namen von dem in "SampleNr" gespeicherten String 
  }
  
  
  for(j in 1:Total.Samples)
  {
    
    
    Sample<- get(Samples[j]) 
    Messfläche <- get(Messfläche.all[j])
    Title.Sample <- get(Title.Sample.all[j]); 
    
    dim <- data.frame(dim(Sample))
    Dequi <-rep(0, times=dim[1,1]) #Erzeugung eines Vektors mit Anzahl an Elementen=Anzahl Zeilen in Sample
    Sample <- data.frame(Sample, Dequi) #Hinzufügen der neuen Spalte
    for(z in 1:dim[1,1])
    {
      Sample$Dequi[z] <- sqrt(4*Sample$AREA[z]/pi)
    }
    SampleNr <- Samples[j]
    assign(SampleNr, Sample)
    Ierror <- safewrite.csv(Sample, filename =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/","all","/",Title.Sample,"_all_Particles_with_Dequi_",Version,".csv",sep=""))
    
  }
}
