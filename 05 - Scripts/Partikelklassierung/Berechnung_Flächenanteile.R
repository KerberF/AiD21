#Berechnung der Flächenanteile
#muss noch für die Pres gemacht werden 


for(i in 1:Total.Samples)
{
  SampleNr <- Samples[i]
  Datensatz <- read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[i]),"_all_Particles_",Version,".csv",sep=""), header=TRUE, dec=",", sep=";", fileEncoding = "ISO-8859-1")
  assign(SampleNr, Datensatz) # Schreiben von Datensatz in eine Variable mit dem Namen von dem in "SampleNr" gespeicherten String 
}#close Loop i 

for(j in 1:Total.Samples)
{
  Sample<- get(Samples[j]) 
  Messfläche <- get(Messfläche.all[j])
  Title.Sample <- get(Title.Sample.all[j]); 
  dim <- data.frame(dim(Sample))
  
  for(k in 1:Total.Classes)
  {
    name <-get(Classes[k])
    area <- 0 
    if(dim[1,1]>=1)
    {
      for(z in 1:dim[1,1])
      {
        if(Sample$Class[z]==name)
        {
          area <- area+ Sample$AREA[z]
        }
        
        
      }#Close Loop z
    }
    Summary.AREA[j,k] <- area
    Summary.AREA.norm[j,k] <- round((area/Messfläche/10000),6) #Umrechnung von mm² in um² /10^6 und Umrechnung in Prozent *100
    
  }#Close Loop k
  
}#close Loop j 

Vektor.Classes.Pr <- 0   #Erzeugung Vektor
for(i in 1:Total.Classes) #Füllen des Vektors mit allen in der Analyse verwendeten Samples
{Vektor.Classes.Pr[i] <- (paste(get(Classes[i])," in %", sep=""))} #Erstellt Vektor mit Namen aller eingesetzten Klassen 

Vektor.Classes.Area <- 0   #Erzeugung Vektor
for(i in 1:Total.Classes) #Füllen des Vektors mit allen in der Analyse verwendeten Samples
{Vektor.Classes.Area[i] <- (paste(get(Classes[i])," in µm²", sep=""))} #Erstellt Vektor mit Namen aller eingesetzten Klassen 



colnames(Summary.AREA) <- Vektor.Classes.Area
colnames(Summary.AREA.norm) <- Vektor.Classes.Pr

row.names(Summary.AREA) <- used.Samples
row.names(Summary.AREA.norm) <- used.Samples

Ierror <- safewrite.csv(Summary.AREA, filename =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/Gesamtfläche_der_Klassen_",Charge,"_",Version,".csv",sep=""))
if(Ierror==0)
{
  Ierror <-  safewrite.csv(Summary.AREA.norm, filename =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/Flächenanteile_der_Klassen_",Charge,"_",Version,".csv",sep=""))
}

if(Ierror==0)
{
  if(Vorklassierung==TRUE)
  {
    
    for(i in 1:Total.Samples)
    {
      SampleNr <- Samples[i]
      Datensatz <- read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[i]),"_all_Particles_pre_",Version,".csv",sep=""), header=TRUE, dec=",", sep=";", fileEncoding = "ISO-8859-1")
      assign(SampleNr, Datensatz) # Schreiben von Datensatz in eine Variable mit dem Namen von dem in "SampleNr" gespeicherten String 
    }#close Loop i 
    
    for(j in 1:Total.Samples)
    {
      Sample<- get(Samples[j]) 
      Messfläche <- get(Messfläche.all[j])
      Title.Sample <- get(Title.Sample.all[j]); 
      dim <- data.frame(dim(Sample))
      
      
      for(k in 1:Total.PreClasses)
      {
        name <-get(PreClasses[k])
        area <- 0 
        if(dim[1,1]>=1)
        {
          for(z in 1:dim[1,1])
          {
            if(Sample$Class[z]==name)
            {
              area <- area+ Sample$AREA[z]
            }
            
            
          }#Close Loop z
        }
        Summary.AREA.pre[j,k] <- area
        Summary.AREA.norm.pre[j,k] <- round((area/Messfläche/10000),6) #Umrechnung von mm² in um² /10^6 und Umrechnung in Prozent *100
        
      }#Close Loop k
      
      
      
      
      
    }#close Loop j 
    
    
    
    
    
    
    Vektor.Classes.Pr.pre <- 0   #Erzeugung Vektor
    for(i in 1:Total.PreClasses) #Füllen des Vektors mit allen in der Analyse verwendeten Samples
    {Vektor.Classes.Pr.pre[i] <- (paste(get(PreClasses[i])," in %", sep=""))} #Erstellt Vektor mit Namen aller eingesetzten Klassen 
    
    Vektor.Classes.Area.pre <- 0   #Erzeugung Vektor
    for(i in 1:Total.PreClasses) #Füllen des Vektors mit allen in der Analyse verwendeten Samples
    {Vektor.Classes.Area.pre[i] <- (paste(get(PreClasses[i])," in µm²", sep=""))} #Erstellt Vektor mit Namen aller eingesetzten Klassen 
    
    
    
    colnames(Summary.AREA.pre) <- Vektor.Classes.Area.pre
    colnames(Summary.AREA.norm.pre) <- Vektor.Classes.Pr.pre
    
    
    
    row.names(Summary.AREA.pre) <- used.Samples
    row.names(Summary.AREA.norm.pre) <- used.Samples
    
    Ierror <-  safewrite.csv(Summary.AREA.pre, filename =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/Gesamtfläche_der_Klassen_pre_",Charge,"_",Version,".csv",sep=""))
    
    if(Ierror==0)
    {
      Ierror <-   safewrite.csv(Summary.AREA.norm.pre, filename =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/Flächenanteile_der_Klassen_pre_",Charge,"_",Version,".csv",sep=""))
      
      
    }
    
    
  }
}
