


for(i in 1:Total.Samples)
{
  SampleNr <- Samples[i]
  Datensatz <- read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[i]),"_all_Particles_",Version,".csv",sep=""), header=TRUE, dec=",", sep=";")
  assign(SampleNr, Datensatz) # Schreiben von Datensatz in eine Variable mit dem Namen von dem in "SampleNr" gespeicherten String 
}


for(j in 1:Total.Samples)
{
  
  Sample.norm<- get(Samples[j]) 
  for(i in 1:length(Sample.norm$PART))
  {
    
    Sample.norm$Mn[i] <- Sample.norm$Mn[i]-(Sample.norm$Fe[i]*0.0922)
    Sample.norm$Cr[i] <- Sample.norm$Cr[i]-(Sample.norm$Fe[i]*0.2427)
    Sample.norm$Si[i] <- Sample.norm$Si[i]-(Sample.norm$Fe[i]*0.0043)
    if(Sample.norm$Mn[i]<0)
    {
      Sample.norm$Mn[i] <- 0
    }
    if(Sample.norm$Si[i]<0)
    {
      Sample.norm$Si[i] <- 0
    }
    if(Sample.norm$Cr[i]<0)
    {
      Sample.norm$Cr[i] <- 0
    }
  }
  
  
  for(i in 1:length(Sample.norm$PART))
  {
    Particle.totalcontent <- 0
    for(e in Elements) #Aufsummieren aller Gehalte mit Ausnahme von Fe und O, falls sich diese Ausnahmen ändern muss der Vektor Elements angepasst werden und die 0-Setzung die weiter unten erfolgt
    {
      Particle.totalcontent <- Particle.totalcontent+Sample.norm[i,e]
    }
    
    if(Particle.totalcontent>0)
    {
      for(e in Elements) #Normierung der Gehalte auf 100% 
      {
        Sample.norm[i,e] <- Sample.norm[i,e]/Particle.totalcontent*100
      }
    }
    for(l in Elements.0)
    {
      Sample.norm[i,l] <- 0 #Setzen des Wertes von Fe auf 0
    }
    #Sample.norm[i,"Cr"] <- 0 #Setzen des Wertes von O auf 0 
    #Sample.norm[i,"C"] <- 0 #Setzen des Wertes von C auf 0 
  }
  name <- Samples.norm[j]
  assign(name, Sample.norm)
  
  write.csv2(Sample.norm, file =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[j]),"_all_Particles_",Version,"_normiert",".csv",sep=""))
  
  
}
