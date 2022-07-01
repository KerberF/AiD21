###Partikelgrößen Variablenerzeugung und -füllung
if(alle.Partikel==FALSE)
{
  if(nach.Klassen==FALSE)
  {
    print("Die Klassierung kann sowohl für alle Partikel gemeinsam als auch nach Klassen getrennt durchgeführt werden. Bitte wählen sie mindestens einer dieser beiden Optionen aus.")
  }
  
}



Partikelklassen <- 0 #Erzeugung Vektor
if(Merkmal.Größenklassierung=="AREA")
{
  for(i in 1:(Total.Größenklassen-1)) #Erstellt Vektor mit Namen aller eingesetzten Größenkleen 
  {
    j <- (i+1)
    Partikelklassen[i] <- paste("(",get(Klassen.Grenzen[i]),"-",get(Klassen.Grenzen[j]),"] µm²",sep="")
  }
  Partikelklassen[Total.Größenklassen] <- paste(">",get(Klassen.Grenzen[Total.Größenklassen])," µm²",sep="")
}

if(Merkmal.Größenklassierung!="AREA")
{
  for(i in 1:(Total.Größenklassen-1)) #Erstellt Vektor mit Namen aller eingesetzten Größenkleen 
  {
    j <- (i+1)
    Partikelklassen[i] <- paste("(",get(Klassen.Grenzen[i]),"-",get(Klassen.Grenzen[j]),"] µm",sep="")
  }
  Partikelklassen[Total.Größenklassen] <- paste(">",get(Klassen.Grenzen[Total.Größenklassen])," µm",sep="")
}



used.Größenklassen <- 0   #wird vermutlich nicht verwendet 
for(i in 1:Total.Größenklassen) #wird vermutlich nicht verwendet
{used.Größenklassen[i] <- Partikelklassen[i]} #wird vermutlich nicht verwendet


Sample.Gr.all <- paste("Sample.Gr",1:Total.Größenklassen, sep="")

dum2 <- data.frame(row.names = c("Anzahl gesamt",paste("Anzahl normiert auf",Referenzfläche,"mm²")),matrix(1:(Total.Größenklassen*2),nrow=2,ncol=Total.Größenklassen))
colnames(dum2) <- Partikelklassen
dum2b <- data.frame(row.names = paste("Anzahl normiert auf",Referenzfläche,"mm²"),matrix(1:(Total.Größenklassen),nrow=1,ncol=Total.Größenklassen))
colnames(dum2b) <- Partikelklassen
Summary.Partikelgröße <- dum2
Summary.Partikelgröße.all <- dum2b
Summary.Partikelgröße.all.norm <- dum2b
Summary.Partikelgröße.Klassen <- dum2b
Summary.Partikelgröße.Klassen.norm <- dum2b
Summary.Partikelgröße.nach.Klassen <- dum2b
Summary.Partikelgröße.nach.Klassen.norm <- dum2b




if(Ermittlung.Dequi==TRUE)
{
  updateProgressBar(session, id="Progress.Partikelgrößenbestimmung", title = "Partikelgrößenbestimmung läuft: Berechung der Äuqivalenzdurchmesser", value = 20)
  source("05 - Scripts/Partikelgrößenbestimmung/Ermittlung_Dequi.R", local = TRUE)
}



if(alle.Partikel==TRUE)
{
  if(Merkmal.Größenklassierung=="Dequi")
  {
    for(i in 1:Total.Samples)
    {
      SampleNr <- Samples[i]
      Datensatz <- read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[i]),"_all_Particles_with_Dequi_",Version,".csv",sep=""), header=TRUE, dec=",", sep=";", fileEncoding = "ISO-8859-1")
      assign(SampleNr, Datensatz) # Schreiben von Datensatz in eine Variable mit dem Namen von dem in "SampleNr" gespeicherten String 
    }
  }
  if(Merkmal.Größenklassierung!="Dequi")
  {
    for(i in 1:Total.Samples)
    {
      SampleNr <- Samples[i]
      Datensatz <- read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[i]),"_all_Particles_",Version,".csv",sep=""), header=TRUE, dec=",", sep=";",fileEncoding = "ISO-8859-1")
      assign(SampleNr, Datensatz) # Schreiben von Datensatz in eine Variable mit dem Namen von dem in "SampleNr" gespeicherten String 
    }
  }
}


if(nach.Klassen==TRUE)
{
  #alle.Partikel <- FALSE
  if(Merkmal.Größenklassierung!="Dequi")
  {
    for(i in 1:Total.Samples)
    {
      SampleNr <- Samples[i]
      Datensatz <- read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[i]),"_all_Particles_",Version,".csv",sep=""), header=TRUE, dec=",", sep=";",fileEncoding = "ISO-8859-1")
      assign(SampleNr, Datensatz) # Schreiben von Datensatz in eine Variable mit dem Namen von dem in "SampleNr" gespeicherten String 
    }
  }
  if(Merkmal.Größenklassierung=="Dequi")
  {
    for(i in 1:Total.Samples)
    {
      SampleNr <- Samples[i]
      Datensatz <- read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[i]),"_all_Particles_with_Dequi_",Version,".csv",sep=""), header=TRUE, dec=",", sep=";",fileEncoding = "ISO-8859-1")
      assign(SampleNr, Datensatz) # Schreiben von Datensatz in eine Variable mit dem Namen von dem in "SampleNr" gespeicherten String 
    }
  }
}
Schrittweite <- (70/Total.Samples)
for(j in 1:Total.Samples)
{
  updateProgressBar(session, id="Progress.Partikelgrößenbestimmung", title = "Partikelgrößenbestimmung läuft: Größenklassierung", value = (20+j*Schrittweite))  
  Sample<- get(Samples[j]) 
  Messfläche <- get(Messfläche.all[j])
  Title.Sample <- get(Title.Sample.all[j]); 
  source("05 - Scripts/Partikelgrößenbestimmung/Größenklassierung.R", local = TRUE);
  #Summary.Partikelgröße.all[j,] <- data.frame(Summary.Partikelgröße[1,]) ; #Speicherung der Partikelgesamtanzahl
  #Summary.Partikelgröße.all.norm[j,] <- data.frame(Summary.Partikelgröße[2,]) #Speicherung der normierten Partikelanzahl 
  
}

if(Ierror==0)
{
  if(alle.Partikel==TRUE)
  {
    ##Speicherung der Zusammenfassung
    row.names(Summary.Partikelgröße.all) <- used.Samples
    row.names(Summary.Partikelgröße.all.norm) <- used.Samples
    Ierror <- safewrite.csv(Summary.Partikelgröße.all, filename =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Partikelgröße/Partikelgröße_alle_Partikel_",Charge,"_",Version,".csv",sep=""))
    
    if(Ierror==0)
    {
      Ierror <- safewrite.csv(Summary.Partikelgröße.all.norm, filename =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Partikelgröße/Partikelgröße_alle_ Partikel_flächennnormiert_",Charge,"_",Version,".csv",sep=""))
      if(Ierror==0)
      {
        if(Kenngrößen==TRUE)
        {
          source("05 - Scripts/Partikelgrößenbestimmung/Kenngrößen_alle.R", local = TRUE)
        }
      }
      
    }}
  if(Ierror==0)
  {
    updateProgressBar(session, id="Progress.Partikelgrößenbestimmung", title = "Partikelgrößenbestimmung läuft: Speichern", value = 100)
    
    if(nach.Klassen==FALSE) #Schutz, falls vergessen wurde, die Speicherung nach Klassen auszuschalten, geht nur bei der Partikelgrößenbestimmung nach Klassen getrennt 
    {
      Speicherung.Klassen <- FALSE
    }
    
    
    if(Speicherung.Klassen==TRUE)
    {
      source("05 - Scripts/Partikelgrößenbestimmung/Wandler_Proben_Klassen.R", local = TRUE)
    }
  }}
