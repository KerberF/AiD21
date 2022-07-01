#run_all: Ausführen aller notwendigen Skritps für eine vollständige Partikelklassierung mit Partikelgrößenbestimmungsource("Scripts/Variablenbildung.R")
Durchgeführt <- "Partikelgrößenbestimmung"
Ierror <- 0
updateProgressBar(session, id="Progress.Partikelgrößenbestimmung", title = "Partikelgrößenbestimmung läuft: Messwerte verarbeiten", value = 10)

#source("05 - Scripts/Variablen/Variablenbildung.R", local = TRUE)

source("05 - Scripts/Samples/Dateneinleser.R", local = TRUE)
if(Ierror==0)
{
  source("05 - Scripts/Rulefiles/Einlesen_Rulefile.R", local = TRUE)
  if(Ierror==0)
  {
    source("05 - Scripts/Variablen/Variablenfuellung.R",local = TRUE) #muss ausgeführt werden, um alle nötigen Vektoren zu erzeugen
    
    source("05 - Scripts/Variablen/Ordnerstruktur.R",local = TRUE)
    
    
    source("05 - Scripts/Partikelgrößenbestimmung/Partikelgrößenbestimmung_ausführen.R",local = TRUE)
    
    source("05 - Scripts/Dokumentation/Dok_Partikelgrößenbestimmung.R", local = TRUE)
    
    #print(paste("Partikelgrößenbestimmung für die Charge '",Charge,"' Version ",Version," erfolgreich durchgeführt.",sep="" ))
  }}