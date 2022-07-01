#findet aktuell keine Verwendung, wurde erweitert zu Clusterprüfung
#resetten bzw. Formatieren der Speichermatrizen
Summary.Partikel.pro.Field <-data.frame(dum4)
dum5 <- data.frame(row.names = c(1),matrix(1:(Total.Classes),nrow=1,ncol=Total.Classes))
colnames(dum5) <- used.Classes
Ergebnis <- data.frame(dum5)


#Einlesen der Daten 
for(i in 1:Total.Samples)
{
  for(j in 1:Total.Classes)
  {
    Datensatz <- read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/nach Klassen/",get(Classes[j]),"_",get(Title.Sample.all[i]),"_",Version,".csv",sep=""), header=TRUE, dec=",", sep=";")
    Field.Nr <- 1 
    Anzahl.pro.Field <- 0
    if(length(Datensatz$PART)==0)
    { 
      Ergebnis[Field.Nr,j] <- 0
    } else{
      for(k in 1:length(Datensatz$PART))
      {
        if(Datensatz$FIELD[k]==Field.Nr)
        {
          Anzahl.pro.Field = Anzahl.pro.Field+1
        } else {
          Ergebnis[Field.Nr,j] <- Anzahl.pro.Field
          Field.Nr = Field.Nr + 1
          Anzahl.pro.Field <- 0
        }
        
        
        
      } 
      
      
      length(Ergebnis[,1]) 
      length(Ergebnis[1,]) 
      
    }}
  
  #Entfernen aller NAs 
  for(l in 1:length(Ergebnis[,1])) 
  {
    for(m in 1:length(Ergebnis[1,]))
    {
      if(is.na(Ergebnis[l,m]))
      {
        Ergebnis[l,m] <- 0
      }
    }
  }#Ende Entfernen NAs 
  
  #Mittelwertbildung 
  for(l in 1:length(Ergebnis[1,])) 
  {
    avg <- mean(Ergebnis[,l])  
    standard <- sd(Ergebnis[,l])  
    median  <-  median(Ergebnis[,l]) 
    min  <-  min(Ergebnis[,l]) 
    max  <-  max(Ergebnis[,l]) 
    
    
    Partikel.pro.Field[1,l] <-avg 
    Partikel.pro.Field[2,l] <-standard 
    if(avg>0)
    {
      Partikel.pro.Field[3,l] <-standard/avg 
    } else {Partikel.pro.Field[3,l] <- 0}
    Partikel.pro.Field[4,l] <-median 
    Partikel.pro.Field[5,l] <-min 
    Partikel.pro.Field[6,l] <-max 
  }#Ende Mittelwert
  
  Summary.Partikel.pro.Field[i,] <- data.frame(Partikel.pro.Field[1,]) 
  Summary.Partikel.pro.Field[i+Total.Samples,] <- data.frame(Partikel.pro.Field[2,])   
  Summary.Partikel.pro.Field[i+2*Total.Samples,] <- data.frame(Partikel.pro.Field[3,])   
  Summary.Partikel.pro.Field[i+3*Total.Samples,] <- data.frame(Partikel.pro.Field[4,])   
  Summary.Partikel.pro.Field[i+4*Total.Samples,] <- data.frame(Partikel.pro.Field[5,])
  Summary.Partikel.pro.Field[i+5*Total.Samples,] <- data.frame(Partikel.pro.Field[6,])
}
#Reihennamen
Mittelwert.used.Samples <- 0
for(i in 1:Total.Samples) #Füllen des Vektors mit allen in der Analyse verwendeten Samples
{Mittelwert.used.Samples[i] <- (paste("Mittelwert_",get(Title.Sample.all[i]),sep=""))} #Erstellt Vektor mit Namen aller eingesetzten Klassen 

Standardabweichung.used.Samples <- 0
for(i in 1:Total.Samples) #Füllen des Vektors mit allen in der Analyse verwendeten Samples
{Standardabweichung.used.Samples[i] <- (paste("Standardabweichung_",get(Title.Sample.all[i]),sep=""))} #Erstellt Vektor mit Namen aller eingesetzten Klassen 

rel.Standardabweichung.used.Samples <- 0
for(i in 1:Total.Samples) #Füllen des Vektors mit allen in der Analyse verwendeten Samples
{rel.Standardabweichung.used.Samples[i] <- (paste("rel. Standardabweichung_",get(Title.Sample.all[i]),sep=""))} #Erstellt Vektor mit Namen aller eingesetzten Klassen 

Median.used.Samples <- 0
for(i in 1:Total.Samples) #Füllen des Vektors mit allen in der Analyse verwendeten Samples
{Median.used.Samples[i] <- (paste("Median_",get(Title.Sample.all[i]),sep=""))} #Erstellt Vektor mit Namen aller eingesetzten Klassen 

Minimum.used.Samples <- 0
for(i in 1:Total.Samples) #Füllen des Vektors mit allen in der Analyse verwendeten Samples
{Minimum.used.Samples[i] <- (paste("Minimum_",get(Title.Sample.all[i]),sep=""))} #Erstellt Vektor mit Namen aller eingesetzten Klassen 

Maximum.used.Samples <- 0
for(i in 1:Total.Samples) #Füllen des Vektors mit allen in der Analyse verwendeten Samples
{Maximum.used.Samples[i] <- (paste("Maximum_",get(Title.Sample.all[i]),sep=""))} #Erstellt Vektor mit Namen aller eingesetzten Klassen 



row.names(Summary.Partikel.pro.Field) <- c(Mittelwert.used.Samples,Standardabweichung.used.Samples,rel.Standardabweichung.used.Samples,Median.used.Samples,Minimum.used.Samples,Maximum.used.Samples)



Ierror <- safewrite.csv(Summary.Partikel.pro.Field, filename =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/Partikelanzahl_pro_Field_",Charge,"_",Version,".csv",sep=""))


