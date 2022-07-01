


#Partikelklassierung
#triggert by button 'Partikelklassierung starten', checks if everything needed is available, asks user for confirmation 
observeEvent(input$Partikelklassierung,{
  if(isTRUE(grepl(".csv",Datapath.location.Datentitel()))){if(isTRUE(grepl(".csv",Datapath.location.Rulefile()))){if(iv_Partikelklassierung$is_valid()){
    confirmSweetAlert(session, inputId = "Run.Partikelklassierung", title = "Partikelklassierung starten?", type = "question", btn_labels = c("Nein","Ja"))
  }else{sendSweetAlert(session, title = "Bitte korrekte Eingabe vornehmen.", type = "error")} }else{sendSweetAlert(session, title = "Keine Rulefile-Datei ausgewählt.", type = "warning")}
  }else{sendSweetAlert(session, title = "Keine Datentitel-Datei ausgewählt.", type = "warning")}
  
  
  
})



####Wenn Automatische PGV aktiviert wird automatisch auf Tab PGV, vermutlich nicht so optimal, deshalb deaktiviert, stattdessen Sweetalert hinzufügen 
observeEvent(input$PGVimAnschluss, 
             {
               if(isTRUE(input$PGVimAnschluss))
               {
                   if(input$Total.Samples!=1){
                       sendSweetAlert(session, title = "Automatische Partikelgrößenbestimmung aktiviert. Gebenenfalls Einstellungen im Abschnitt 'Partikelgrößenbestimmung' vornehmen.", type = "warning")
                 }
               }                 
               #updateTabsetPanel(session, inputId =  "Funktionen", selected = "Partikelgrößenbestimmung")
             })
##Setzt Schutzvariable auf 0 sobald die Funktion einmal deaktiviert wurde. Beim nächsten Mal aktivieren kommt die Nachricht wieder
observeEvent(input$PGVimAnschluss,{
  
  if(input$PGVimAnschluss==FALSE)
  {
    updateNumericInput(session, inputId = "Total.Samples", value= 0)
  }
  
})
#run particle classification if confirmed and automactic particle size distribution is inactive 
observeEvent(input$Run.Partikelklassierung, {if(isTRUE(input$Run.Partikelklassierung)){
  #Progressbar 
  if(isTRUE(input$PGVimAnschluss))
  {
    confirmSweetAlert(session, inputId = "Settings.PGV", title = "Einstellung für Partikelgrößenbestimmung vorgenommen?", type = "question", btn_labels = c("Nein","Ja"))
  }else{
    progressSweetAlert(session, id= "Progress.Partikelklassierung", title = "Partikelklassierung läuft.", display_pct = TRUE, value = 0)
    #Start Partikelklassierung
    #Allgemeine Informationen           
    Projekt <- input$Projekt
    Charge <- input$Charge
    #Total.Samples <- input$Total.Samples  
    Referenzfläche <- input$Referenzfläche
    Version <- input$Version 
    Dateiformat.Messwerte <- input$Dateiformat.Messwerte
    Trennzeichen <- input$Trennzeichen
    Dezimalzeichen <- input$Dezimalzeichen 
    
    #Einstellungenen Partikelklassierung  
    Abstandsüberprüfung <- input$Abstandsüberprüfung
    min.Abstand <- input$min.Abstand 
    Ausfuehrlicher.Abstandspruefer <- input$Ausfuehrlicher.Abstandspruefer
    mdv_only_mainClass <- input$mdv_only_mainClass
    Position.Normierung <- input$Position.Normierung
    Normierung.vorher <- input$Normierungvorher
    PCA <- input$PCA
    PCAcenter <- input$PCAcenter
    PCAscale <- input$PCAscale
    
    
    Elements <- input$Elements 
    Elements.0 <- input$Elements0
    Vorklassierung <- input$Vorklassierung 
    Berechnung.Flächenanteile <- input$Berechnung.Flächenanteile 
    Clusterprüfung <- input$Clusterprüfung 
    Anzahl.Spalten <- input$Anzahl.Spalten
    Quadrate <- input$Quadrate 
    Anzahl.Reihen <- input$Anzahl.Reihen 
    Darstellungen.Clusterprüfung <- input$Darstellungen.Clusterprüfung
    file.Datentitel <- Datapath.location.Datentitel()
    file.Rulefile <- Datapath.location.Rulefile()
    Name.Rulefile <- Datapath.location.Rulefile()
    Ierror <- 0
    source("05 - Scripts/Run/Run_Partikelklassierung.R", local = TRUE)
    updateProgressBar(session, id="Progress.Partikelklassierung", title = "Partikelklassierung läuft: Speichern", value = 100)
    Sys.sleep(1)
    if(Ierror==0)
    {
      closeSweetAlert(session)
      sendSweetAlert(session, title="Partikelklassierung abgeschlossen", type="success")
    }
    if(Ierror==0)
    {
      if(isTRUE(input$PGVimAnschluss))
      {
        Sys.sleep(1)
        closeSweetAlert(session)
        progressSweetAlert(session, id= "Progress.Partikelgrößenbestimmung", title = "Partikelgrößenbestimmung läuft.", display_pct = TRUE, value = 0)
        
        source("05 - Scripts/Serverfunction/determine_particle_distribution.R", local = TRUE)
        
        
        
        
      }
      
      
      
    }
  }
}
  
})


#run particle classification if confirmed and automactic particle size distribution is active 
observeEvent(input$Settings.PGV, {if(isTRUE(input$Settings.PGV))
{
  progressSweetAlert(session, id= "Progress.Partikelklassierung", title = "Partikelklassierung läuft.", display_pct = TRUE, value = 0)
  #Start Partikelklassierung
  #Allgemeine Informationen           
  Projekt <- input$Projekt
  Charge <- input$Charge
  #Total.Samples <- input$Total.Samples  
  Referenzfläche <- input$Referenzfläche
  Version <- input$Version 
  Dateiformat.Messwerte <- input$Dateiformat.Messwerte
  Trennzeichen <- input$Trennzeichen
  Dezimalzeichen <- input$Dezimalzeichen 
  
  #Einstellungenen Partikelklassierung  
  Abstandsüberprüfung <- input$Abstandsüberprüfung
  min.Abstand <- input$min.Abstand 
  Ausfuehrlicher.Abstandspruefer <- input$Ausfuehrlicher.Abstandspruefer
  mdv_only_mainClass <- input$mdv_only_mainClass
  Position.Normierung <- input$Position.Normierung
  Normierung.vorher <- input$Normierungvorher
  PCA <- input$PCA
  PCAcenter <- input$PCAcenter
  PCAscale <- input$PCAscale
  
  
  Elements <- input$Elements 
  Elements.0 <- input$Elements0
  Vorklassierung <- input$Vorklassierung 
  Berechnung.Flächenanteile <- input$Berechnung.Flächenanteile 
  Clusterprüfung <- input$Clusterprüfung 
  Anzahl.Spalten <- input$Anzahl.Spalten
  Quadrate <- input$Quadrate 
  Anzahl.Reihen <- input$Anzahl.Reihen 
  Darstellungen.Clusterprüfung <- input$Darstellungen.Clusterprüfung
  file.Datentitel <- Datapath.location.Datentitel()
  file.Rulefile <- Datapath.location.Rulefile()
  Name.Rulefile <- Datapath.location.Rulefile()
  Ierror <- 0
  source("05 - Scripts/Run/Run_Partikelklassierung.R", local = TRUE)
  if(Ierror==0)
  {
    updateProgressBar(session, id="Progress.Partikelklassierung", title = "Partikelklassierung läuft: Speichern", value = 100)
  }
  Sys.sleep(1)
  if(Ierror==0)
  {
    closeSweetAlert(session)
    sendSweetAlert(session, title="Partikelklassierung abgeschlossen", type="success")
  }
  if(Ierror==0)
  {
    if(isTRUE(input$PGVimAnschluss))
    {
      Sys.sleep(1)
      closeSweetAlert(session)
      progressSweetAlert(session, id= "Progress.Partikelgrößenbestimmung", title = "Partikelgrößenbestimmung läuft.", display_pct = TRUE, value = 0)
      source("05 - Scripts/Serverfunction/determine_particle_distribution.R", local = TRUE)
      
      
      
      
    }
    
    
    
  }
}
})
