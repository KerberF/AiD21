x<-0        #Reset der Aussortierten Partikel
Sample.cut <- Sample #Erzeugung einer Variable Sample.cut

for(k in 1:Total.PreClasses)
{
  if(Ierror==0)
  {
  name <-Sample.PreClasses[k] #Erzeugung Variable zur Speicherung der Partikel dieser Klasse
  Data  <-subset(Sample.cut, eval(get(Condition.PreClasses[k]))) #Zeilen von Sample 1, die folgende Bedingungen erfüllen, werden behalten
  x <- c(x,Data$PART) #Speicherung der Partikelnummer für die ausgewählten Partikel 
  if(length(x)>1)
  {
    Sample.cut <- Sample[-x,] #Entfernung der ausgewählten Partikel aus dem gesamten Datensatz
  }
  dim <- data.frame(dim(Data))
  Class.name <- used.PreClasses[k]    ##Abfragen des Klassennamens
  Class <-rep(Class.name, times=dim[1,1]) #Erzeugung eines Vektors mit Anzahl an Elementen=Anzahl Zeilen in Data
  Data <- data.frame(Data, Class) #Hinzufügen der neuen Spalte
  Test.Abstand <- Data       #Variable zur Abstandsüberprüfung
  if(mdv_only_mainClass==FALSE)
  {
  if(Ausfuehrlicher.Abstandspruefer==TRUE)
  {
    source("05 - Scripts/Partikelklassierung/mdv.R",local = TRUE) #Abstandsüberprüfer
  }
  if(Ausfuehrlicher.Abstandspruefer==FALSE)
  {
    source("05 - Scripts/Partikelklassierung/Abstandsüberprüfer.R",local = TRUE) #Abstandsüberprüfer
  }
  }
  assign(name, Test.Abstand) # Schreiben von Test.Abstand in eine Variable mit dem Namen von dem in "name" gespeicherten String 
  
  Ierror <- safewrite.csv(get(Sample.PreClasses[k]), filename =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/nach Klassen/",Class.name,"_",Title.Sample,"_",Version,".csv",sep=""))
  
  if(Ierror==0)
  {
    
    Ierror <- safewrite.csv(get(Sample.PreClasses[k]), filename =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/nach Proben/",Title.Sample,"_",Class.name,"_",Version,".csv",sep=""))
  } 
  }
  
  
}
if(Ierror==0)
{
  all.Particles <- data.frame(t(names(Sample1)),Class=1)    #Reset des Dataframes all.Particles
  colnames(all.Particles) <- c(names(Sample1),"Class")    #Spaltennamne
  all.Particles[1:length(Sample1)] <- t(1:length(Sample1)) #Füllen der ersten Zeile
  all.Particles <- all.Particles[-1,] #Entfernen der vorher geschriebenen ersten Zeile
  
  
  for(z in 1:Total.PreClasses) #Schreiben der Summarys
  {
    Summary.PreClasses[1:2,z] <- (dim(get(Sample.PreClasses[z])));
    Summary.PreClasses[2,z] <- round((Summary.PreClasses[1,z]*Referenzfläche/Messfläche),0);
    if(length(get(Sample.PreClasses[z])$PART)>0) #All Particles nur addieren, wenn überhaupt welche vorhanden, sonst tritt Fehler auf 
    {
      all.Particles <- rbind(all.Particles, get(Sample.PreClasses[z]))
    }
  }
  all.Particles <- subset(all.Particles, is.na(all.Particles$PART)==FALSE ) #Entferenen aller NAs
  
  Ierror <- safewrite.csv(all.Particles, filename =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",Title.Sample,"_all_Particles_pre_",Version,".csv",sep=""))
  
  
  
  
  #write.csv2(Summary.PreClasses, file =paste("Ergebnisse/",Charge,"/","Summary","/",Title.Sample,"_Summary_PreClasses.csv",sep=""))
}
