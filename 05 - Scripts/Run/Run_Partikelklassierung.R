#run_all: Ausführen aller notwendigen Skritps für eine vollständige Partikelklassierung mit Partikelgrößenbestimmungsource("Scripts/Variablenbildung.R")
Durchgeführt <- "Partikelklassierung"

updateProgressBar(session, id="Progress.Partikelklassierung", title = "Partikelklassierung läuft: Messwerte verarbeiten", value = 10)



source("05 - Scripts/Samples/Dateneinleser.R", local = TRUE)
if(Ierror==0)
{
  for(j in 1:Total.Samples)
  {
    Sample<- get(Samples[j]) 
    Part_org <- Sample$PART
    Sample <- data.frame(Sample, Part_org)
    SampleNr <- Samples[j]
    assign(SampleNr, Sample)
  }
  
  source("05 - Scripts/Rulefiles/Einlesen_Rulefile.R",local = TRUE)
  if(Ierror==0)
  {
    source("05 - Scripts/Variablen/Ordnerstruktur.R",local = TRUE)
    
    
    
    source("05 - Scripts/Variablen/Variablenfuellung.R",local = TRUE) #muss ausgeführt werden, um alle nötigen Vektoren zu erzeugensource
    
    #Speicherung der originalen Partikelnummern in einer extra Spalte
    
    
    
    source("05 - Scripts/Partikelklassierung/Partikelklassierung.R",local = TRUE)
     source("05 - Scripts/Dokumentation/Dok_Partikelklassierung.R",local = TRUE)
   
    
    #print(paste("Partikelklassierung für die Charge '",Charge,"' Version ",Version," erfolgreich durchgeführt.",sep="" ))
  }
}