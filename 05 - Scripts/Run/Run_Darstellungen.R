#run_all: Ausführen aller notwendigen Skritps für eine vollständige Partikelklassierung mit Partikelgrößenbestimmungsource("Scripts/Variablenbildung.R")
Durchgeführt <- "Darstellung"

Ierror <- 0

#source("05 - Scripts/Variablen/Variablenbildung.R",local = TRUE)
updateProgressBar(session, id="progress.Darstellungen", title = "Darstellungen erzeugen...", value = 10)

source("05 - Scripts/Samples/Dateneinleser.R",local = TRUE)
if(Ierror==0)
{
  source("05 - Scripts/Rulefiles/Einlesen_Rulefile.R", local = TRUE)
  if(Ierror==0)
  {
    source("05 - Scripts/Variablen/Ordnerstruktur.R", local = TRUE)
    source("05 - Scripts/Variablen/Variablenfuellung.R",local = TRUE) #muss ausgeführt werden, um alle nötigen Vektoren zu erzeugen 
    
    if(Darstellung.Klassen==TRUE)
    {
      source("05 - Scripts/Darstellungen/Necessary/Necessary_Darstellungen_color.R", local = TRUE)
    }
    
    if(Darstellung.gesamt==TRUE)
    {
      source("05 - Scripts/Darstellungen/Darstellungen.R",local = TRUE)  
    }  
    
    #source("05 - Scripts/Dokumentation/Dok_Darstellung.R",local = TRUE)
    
    
  }}
