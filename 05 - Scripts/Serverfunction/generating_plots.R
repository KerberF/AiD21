
observeEvent(input$Darstellungen.erzeugen,{
  if(isTRUE(grepl(".csv",Datapath.location.Datentitel()))){if(isTRUE(grepl(".csv",Datapath.location.Rulefile()))){if(iv_Darstellungen$is_valid()){
    confirmSweetAlert(session, inputId = "Run.Darstellungen", title = "Darstellungen erzeugen?", type = "question", btn_labels = c("Nein","Ja"))
  }else{sendSweetAlert(session, title = "Bitte korrekte Eingabe vornehmen.", type = "error")} }else{sendSweetAlert(session, title = "Keine Rulefile-Datei ausgewählt.", type = "warning")}
  }else{sendSweetAlert(session, title = "Keine Datentitel-Datei ausgewählt.", type = "warning")}
  
  
  
})


observeEvent(input$Run.Darstellungen, { if(isTRUE(input$Run.Darstellungen)){
  progressSweetAlert(session, id= "progress.Darstellungen", title = "Darstellungen erzeugen...", display_pct = TRUE, value = 0)
  plot.x <- input$xplot
  plot.y <- input$yplot
  plot.z <- input$zplot
  fontsize.legend <- input$fontsize.legend
  fontsize.legendpt <- input$fontsize.legendpt
  fontsize.main <- input$fontsize.main 
  gradient <- input$gradient
  fontsize.lab <- input$fontsize.lab
  fontsize.axis <- input$fontsize.axis 
  size.symbols <- input$size.symbols
  Skalierung.x <- input$Skalierung.x
  Skalierung.y <- input$Skalierung.y
  Skalierung.z <- input$Skalierung.z
  #Minimum <- Skalierung.z[1]
  Maximum <- Skalierung.z
  Position.Legende.x <- input$Position.Legendex 
  Position.Legende.y <- input$Position.Legendey
  figure.rows <- input$figure.rows
  figure.col <- input$figure.col 
  Darstellung.gesamt <- if(input$Darstellungen_gesamt_Klassen=="Rohdaten"|| input$Darstellungen_gesamt_Klassen=="Hauptklassen normiert"|| input$Darstellungen_gesamt_Klassen=="Hauptklassen unnormiert"){TRUE}else{FALSE} 
  Daten.Normiert <- if(input$Darstellungen_gesamt_Klassen=="Hauptklassen normiert"){TRUE}else{FALSE} 
  Darstellungen.Rohdaten <- if(input$Darstellungen_gesamt_Klassen=="Rohdaten"){TRUE}else{FALSE} 
  Darstellung.Klassen <- if(input$Darstellungen_gesamt_Klassen=="ausgewählte Hauptklassen"){TRUE}else{FALSE} 
  Darstellungsvariante <- input$Darstellungen_gesamt_Klassen
  
  Darstellungen.Klassen.Anzahl <- input$Darstellungen.Klassen.Anzahl 
  language <- input$language
  Normierung.vorher <- input$Normierungvorher
  Klassen <- paste("Klasse.",1:Darstellungen.Klassen.Anzahl,sep="")
  
  for(i in 1:Darstellungen.Klassen.Anzahl)
  {
    Klasse <- Klassen[i]
    value <- input[[Klassen[i]]]
    assign(Klasse, value)
  }
  
  Klassennamen.in.Datei <- input$Klassennamen.in.Datei
  Farbig <- input$Farbig
  Symbole.Füllung <- input$Symbole.Füllung
  
  Projekt <- input$Projekt
  Charge <- input$Charge
  #Total.Samples <- input$Total.Samples  
  Referenzfläche <- input$Referenzfläche
  Version <- input$Version 
  Dateiformat.Messwerte <- input$Dateiformat.Messwerte
  Trennzeichen <- input$Trennzeichen
  Dezimalzeichen <- input$Dezimalzeichen
  file.Datentitel <- Datapath.location.Datentitel()
  file.Rulefile <- Datapath.location.Rulefile()
  Name.Rulefile <- Datapath.location.Rulefile()
  Vorklassierung <- input$Vorklassierung 
  
  
  source("05 - Scripts/Run/Run_Darstellungen.R", local = TRUE)
  Sys.sleep(1)
  if(Ierror==0)
  {
    closeSweetAlert(session)
    sendSweetAlert(session, title="Darstellungen erfolgreich erzeugt.", type="success")
  }
  
}
  
  
  
})