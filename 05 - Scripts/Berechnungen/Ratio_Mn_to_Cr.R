
for(i in 1:Total.Samples)
{
  SampleNr <- Samples[i]
  #Datensatz <- read.table(paste(Speicherort,"/Klassierung/",Charge,"/",Version,"/Zusammensetzung/all/",get(Title.Sample.all[i]),"_all_Particles_",Version,".csv",sep=""), header=TRUE, dec=",", sep=";")
  Datensatz <- read.table(paste(Speicherort,"/01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[i]),"_all_Particles_",Version,"_normiert.csv",sep=""), header=TRUE, dec=",", sep=";")
  assign(SampleNr, Datensatz) # Schreiben von Datensatz in eine Variable mit dem Namen von dem in "SampleNr" gespeicherten String 
}


for(j in 1:Total.Samples)
{
  
  Sample<- get(Samples[j]) 
  
  dim <- data.frame(dim(Sample))
  Mn.Cr.Ratio <-rep(0, times=dim[1,1]) #Erzeugung eines Vektors mit Anzahl an Elementen=Anzahl Zeilen in Data
  Sample <- data.frame(Sample, Mn.Cr.Ratio) #Hinzufügen der neuen Spalte
  Title.Sample <- get(Title.Sample.all[j])
  for(i in 1:length(Sample$PART))
  {
    ratio <- Sample$Mn[i]/Sample$Cr[i]
    Sample$Mn.Cr.Ratio[i] <- ratio
  }
  #write.csv2(Sample, file =paste(Speicherort,"/Klassierung/",Charge,"/",Version,"/Zusammensetzung/","all","/",Title.Sample,"_all_Particles_Ratio",Version,".csv",sep=""))
  write.csv2(Sample, file =paste(Speicherort,"/01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/","all","/",Title.Sample,"_all_Particles_Ratio_normiert_",Version,".csv",sep=""))
  
}


