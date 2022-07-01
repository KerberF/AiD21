###Vorschau für Darstellungen erzeugen 



#Wird nicht mehr gebraucht
#Deaktiviert Vorschau, sobald sich an Location Datentitel oder Location Rulefile etwas ändert. 
#observeEvent(Datapath.location.Datentitel(), {
#  updateCheckboxInput(session, inputId = "PlotVorschau", value = FALSE)}
#)
#observeEvent(Datapath.location.Rulefile(), {
#  updateCheckboxInput(session, inputId = "PlotVorschau", value = FALSE)}
#)

observeEvent(input$Plot.preview,{
  
  req(iv_Darstellungen$is_valid()) 
  
  if(isTRUE(grepl(".csv",Datapath.location.Datentitel()))){if(isTRUE(grepl(".csv",Datapath.location.Rulefile())))
  {
    
    plot.x <- input$xplot
    plot.y <- input$yplot
    plot.z <- input$zplot
    Skalierung.x <- input$Skalierung.x
    Skalierung.y <- input$Skalierung.y
    Skalierung.z <- input$Skalierung.z
    fontsize.legend <- input$fontsize.legend
    fontsize.legendpt <- input$fontsize.legendpt
    fontsize.main <- input$fontsize.main 
    gradient <- input$gradient
    fontsize.lab <- input$fontsize.lab
    fontsize.axis <- input$fontsize.axis 
    size.symbols <- input$size.symbols
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
    Darstellungen.Klassen.Anzahl <- input$Darstellungen.Klassen.Anzahl 
    language <- input$language
    Klassen <- paste("Klasse.",1:Darstellungen.Klassen.Anzahl,sep="")
    
    for(i in 1:Darstellungen.Klassen.Anzahl)
    {
      Klasse <- Klassen[i]
      value <- input[[Klassen[i]]]
      assign(Klasse, value)
    }
    
    Klassennamen.in.Datei <- FALSE
    Farbig <- input$Farbig
    Symbole.Füllung <- input$Symbole.Füllung
    
    Projekt <- input$Projekt
    Charge <- input$Charge
    Referenzfläche <- input$Referenzfläche
    Version <- input$Version 
    Dateiformat.Messwerte <- input$Dateiformat.Messwerte
    Trennzeichen <- input$Trennzeichen
    Dezimalzeichen <- input$Dezimalzeichen
    file.Datentitel <- Datapath.location.Datentitel()
    file.Rulefile <- Datapath.location.Rulefile()
    Name.Rulefile <- Datapath.location.Rulefile()
    Vorklassierung <- input$Vorklassierung
    #source("05 - Scripts/Variablen/Variablenbildung.R",local = TRUE)
    source("05 - Scripts/Samples/Dateneinleser_Vorschau.R",local = TRUE)
    if(Ierror==0)
    {
      source("05 - Scripts/Rulefiles/Einlesen_Rulefile.R", local = TRUE)
      
      source("05 - Scripts/Variablen/Variablenfuellung.R",local = TRUE)
      
      output$Vorschau <- renderPlot(
        {
          if(Darstellung.Klassen==TRUE)
          {
            source("05 - Scripts/Darstellungen/Necessary/Necessary_Darstellungen_color_vorschau_update.R", local = TRUE)
          }
          
          if(Darstellung.gesamt==TRUE)
          {
            source("05 - Scripts/Darstellungen/Darstellungen_Vorschau.R",local = TRUE)  
          }  })
    }
    
  }else{sendSweetAlert(session, title = "Keine Rulefile-Datei ausgewählt.", type = "warning")
    updateCheckboxInput(session, inputId = "PlotVorschau", value = FALSE)}
  }else{sendSweetAlert(session, title = "Keine Datentitel-Datei ausgewählt.", type = "warning")
    updateCheckboxInput(session, inputId = "PlotVorschau", value = FALSE)}
  
  
})
#, height =841.68/3, width=595.44/2, res=72


