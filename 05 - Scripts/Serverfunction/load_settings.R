##Load and save settings in the programm

#creating variable 
Datapath.location.settings <- reactiveVal("Keine Datei gewählt.")


#updateting textbox after browsing a file 
observeEvent(input$location.settings,{ 
  #updateTextInput(session, "Datapath.location.settings", value = paste(choose.files(caption = "Parameterset auswählen", default =paste0(getwd(), "/03 - Einstellungen/*.csv"), filters = c("CSV Files (*.csv)","*.csv"),index = 1, multi = FALSE)))
  Datapath.location.settings(choose.files(caption = "Parameterset auswählen", default =paste0(getwd(), "/03 - Einstellungen/*.csv"), filters = c("CSV Files (*.csv)","*.csv"),index = 1, multi = FALSE))
  if(length(Datapath.location.settings())==0)
  {
    output$outDatapath <- renderText(paste("Keine Datei gewählt."))
  }else{
    output$outDatapath <- renderText(Datapath.location.settings())
  }
  updateNumericInput(session, inputId = "Total.Samples", value = 1) #willkürlich gewählter Wert um Nachricht bei Automatischer PGV nicht zu triggern. Total.Samples nur gewählt, weil diese Variable noch von früheren Versionen vorhanden war und nicht mehr genutzt wurde
  updateNumericInput(session, inputId = "collect.SettingsA", value = 1)
  updateTabItems(session, inputId = "Funktionen", selected = "Partikelgrößenbestimmung")
  
})

#standard output at program start 
output$outDatapath <- renderText(paste("Keine Datei gewählt."))

###new File choose
#test <- dlg_open(title = "Select one R file", filters = dlg_filters[c("R", "All"), ])$res
#test2 <- read.csv(test, header = TRUE, sep=";")

#Confirm Laden
#vorher alle Tabs öffnen

#collect all settings --> it is necessary to open all tabs since some variables are only genereated if the tab was opened at least once
#after collecting the user is asked if current settings should be overwritten by loaded settings 
observeEvent(input$collect.SettingsA, {if(input$collect.SettingsA>0){
  
  
  updateTabItems(session, inputId = "Funktionen", selected = "Darstellungen")
  updateNumericInput(session, inputId = "collect.SettingsB", value = 1)
}
})
observeEvent(input$collect.SettingsB, {if(input$collect.SettingsB>0){
  updateTabItems(session, inputId = "Funktionen", selected = "AllgemeineEinstellungen")
  updateNumericInput(session, inputId = "collect.SettingsB", value = 0)
  updateNumericInput(session, inputId = "collect.SettingsA", value = 0) 
  if(isTRUE(grepl(".csv",Datapath.location.settings()))){ 
    Einstellungen.Name <- unlist(strsplit(Datapath.location.settings(), split = "\\\\"))
    last <- length(Einstellungen.Name)
    #,gsub(".csv","",Einstellungen.Name[last]), Kann in title= paste() unterhalb dieser Zeile eingefügt werden, um Name der Einstellugnsdatei anzuzeigen. Aber ist größer als das Fenster. 
    confirmSweetAlert(session, inputId = "Confirm.load.settings", title = paste("Aktuelle Einstellungen werden überschrieben. Einstellungen laden?",sep=""), type = "question", btn_labels = c("Nein","Ja"))}
  else{sendSweetAlert(session, title="Bitte eine Datei auswählen", type="warning")}
}
})

#Setzt die Schutzvariable zurück auf 0 für Nachricht bei Automatische PGV
observeEvent(input$Confirm.load.settings, {
  if(input$Confirm.load.settings==FALSE)
  {
    updateNumericInput(session, inputId = "Total.Samples", value = 0)
  }
})

#loading of settings, if confirmed 
observeEvent(input$Confirm.load.settings, {if(isTRUE(input$Confirm.load.settings)){
  
  progressSweetAlert(session, id= "progress.load.settings", title = "Einstellungen laden...", display_pct = TRUE, value = 0)
  for(i in seq_len(50)){
    updateProgressBar(session, id="progress.load.settings", value = i*2)
    Sys.sleep(0.01)
  }
 # settings <- read.csv("test.csv", header=TRUE, sep=";", dec=".", stringsAsFactors = FALSE, fileEncoding = "ISO-8859-1")
  #settings2 <- read.csv("test2.csv", header=TRUE, sep=";", dec=".", stringsAsFactors = FALSE, fileEncoding = "ISO-8859-1")
  
  settings <- read.csv(Datapath.location.settings(), header=TRUE, sep=";", dec=".", stringsAsFactors = FALSE, fileEncoding = "ISO-8859-1")
  #settings <- read.csv("Dateiname2.csv", header=TRUE, sep=";", dec=".", stringsAsFactors = FALSE)
  if(settings$value[length(settings$InputId)]=="v1.2")
  {
    values_Skalierung.x <- NULL
    values_Skalierung.y <- NULL

    for(i in 1:length(settings$InputId))
    {
      if(settings$InputId[i]=="Projekt")
      {
        updateTextInput(session, inputId = "Projekt", value = settings$value[i])
      }else{
        if(settings$InputId[i]=="Charge")
        {
          updateTextInput(session, inputId = "Charge", value = settings$value[i])
        }else{
          if(settings$InputId[i]=="Version")
          {
            updateTextInput(session, inputId = "Version", value = settings$value[i])
          }else{ 
            if(settings$InputId[i]=="Datapath.location.Datentitel")
            {
              Datapath.location.Datentitel(settings$value[i]) 
            }else{ 
              if(settings$InputId[i]=="Datapath.location.Rulefile")
              {
                Datapath.location.Rulefile(settings$value[i])
              }else{ 
                if(settings$InputId[i]=="Klassierungsmerkmal")
                {
                  updateTextInput(session, inputId = "Klassierungsmerkmal", value = settings$value[i])
                }else{
                  if(settings$InputId[i]=="custom.Merkmal")
                  {
                    updateTextInput(session, inputId = "custom.Merkmal", value = settings$value[i])
                  }else{
                    if(settings$InputId[i]=="xplot")
                    {
                      updateTextInput(session, inputId = "xplot", value = settings$value[i])
                    }else{      
                      if(settings$InputId[i]=="yplot")
                      {
                        updateTextInput(session, inputId = "yplot", value = settings$value[i])
                      }else{
                        if(settings$InputId[i]=="zplot")
                        {
                          updateTextInput(session, inputId = "zplot", value = settings$value[i])
                        }else{      
                          if(settings$InputId[i]=="Abstandsüberprüfung")
                          {
                            updateCheckboxInput(session, inputId = "Abstandsüberprüfung", value = (if(settings$value[i]=="TRUE"){TRUE}else{FALSE}))
                          }else{     
                            if(settings$InputId[i]=="Ausfuehrlicher.Abstandspruefer")
                            {
                              updateCheckboxInput(session, inputId = "Ausfuehrlicher.Abstandspruefer", value = (if(settings$value[i]=="TRUE"){TRUE}else{FALSE}))
                            }else{
                              if(settings$InputId[i]=="Position.Normierung")
                              {
                                updateCheckboxInput(session, inputId = "Position.Normierung", value = (if(settings$value[i]=="TRUE"){TRUE}else{FALSE}))
                              }else{   
                                if(settings$InputId[i]=="Normierungvorher")
                                {
                                  updateCheckboxInput(session, inputId = "Normierungvorher", value = (if(settings$value[i]=="TRUE"){TRUE}else{FALSE}))
                                }else{   
                                  if(settings$InputId[i]=="Berechnung.Flächenanteile")
                                  {
                                    updateCheckboxInput(session, inputId = "Berechnung.Flächenanteile", value = (if(settings$value[i]=="TRUE"){TRUE}else{FALSE}))
                                  }else{
                                    if(settings$InputId[i]=="Clusterprüfung")
                                    {
                                      updateCheckboxInput(session, inputId = "Clusterprüfung", value = (if(settings$value[i]=="TRUE"){TRUE}else{FALSE}))
                                    }else{  
                                      if(settings$InputId[i]=="Quadrate")
                                      {
                                        updateCheckboxInput(session, inputId = "Quadrate", value = (if(settings$value[i]=="TRUE"){TRUE}else{FALSE}))
                                      }else{
                                        if(settings$InputId[i]=="Darstellungen.Clusterprüfung")
                                        {
                                          updateCheckboxInput(session, inputId = "Darstellungen.Clusterprüfung", value = (if(settings$value[i]=="TRUE"){TRUE}else{FALSE}))
                                        }else{      
                                          if(settings$InputId[i]=="Ermittlung.Dequi")
                                          {
                                            updateCheckboxInput(session, inputId = "Ermittlung.Dequi", value = (if(settings$value[i]=="TRUE"){TRUE}else{FALSE}))
                                          }else{
                                            if(settings$InputId[i]=="alle.Partikel")
                                            {
                                              updateCheckboxInput(session, inputId = "alle.Partikel", value = (if(settings$value[i]=="TRUE"){TRUE}else{FALSE}))
                                            }else{
                                              if(settings$InputId[i]=="nach.Klassen")
                                              {
                                                updateCheckboxInput(session, inputId = "nach.Klassen", value = (if(settings$value[i]=="TRUE"){TRUE}else{FALSE}))
                                              }else{    
                                                if(settings$InputId[i]=="Speicherung.Klassen")
                                                {
                                                  updateCheckboxInput(session, inputId = "Speicherung.Klassen", value = (if(settings$value[i]=="TRUE"){TRUE}else{FALSE}))
                                                }else{      
                                                  if(settings$InputId[i]=="Klassennamen.in.Datei")
                                                  {
                                                    updateCheckboxInput(session, inputId = "Klassennamen.in.Datei", value = (if(settings$value[i]=="TRUE"){TRUE}else{FALSE}))
                                                  }else{
                                                    if(settings$InputId[i]=="Farbig")
                                                    {
                                                      updateCheckboxInput(session, inputId = "Farbig", value = (if(settings$value[i]=="TRUE"){TRUE}else{FALSE}))
                                                    }else{
                                                      if(settings$InputId[i]=="Symbole.Füllung")
                                                      {
                                                        updateCheckboxInput(session, inputId = "Symbole.Füllung", value = (if(settings$value[i]=="TRUE"){TRUE}else{FALSE}))
                                                      }else{   
                                                        if(settings$InputId[i]=="Referenzfläche")
                                                        {
                                                          updateNumericInput(session, inputId = "Referenzfläche", value = settings$value[i])
                                                        }else{
                                                          if(settings$InputId[i]=="min.Abstand")
                                                          {
                                                            updateNumericInput(session, inputId = "min.Abstand", value = settings$value[i])
                                                          }else{
                                                            if(settings$InputId[i]=="Anzahl.Spalten")
                                                            {
                                                              updateNumericInput(session, inputId = "Anzahl.Spalten", value = settings$value[i])
                                                            }else{
                                                              if(settings$InputId[i]=="Anzahl.Reihen")
                                                              {
                                                                updateNumericInput(session, inputId = "Anzahl.Reihen", value = settings$value[i])
                                                              }else{
                                                                if(settings$InputId[i]=="Total.Größenklassen")
                                                                {
                                                                  number.Größenklassen <- as.numeric(settings$value[i])
                                                                  updateNumericInput(session, inputId = "Total.Größenklassen", value = settings$value[i])
                                                                }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
      #new if-else construction cause maximum was reached          
      
      if(settings$InputId[i]=="letzte")
      {
        updateNumericInput(session, inputId = "letzte", value = settings$value[i])
      }else{
        if(settings$InputId[i]=="Position.Legendex")
        {
          updateNumericInput(session, inputId = "Position.Legendex", value = settings$value[i])
        }else{
          if(settings$InputId[i]=="Position.Legendey")
          {
            updateNumericInput(session, inputId = "Position.Legendey", value = settings$value[i])
          }else{
            if(settings$InputId[i]=="Darstellungen.Klassen.Anzahl")
            {
              number.Klassen <- as.numeric(settings$value[i])
              updateNumericInput(session, inputId = "Darstellungen.Klassen.Anzahl", value = settings$value[i])
            }else{
              if(settings$InputId[i]=="figure.rows")
              {
                updateNumericInput(session, inputId = "figure.rows", value = settings$value[i])
              }else{
                if(settings$InputId[i]=="figure.col")
                {
                  updateNumericInput(session, inputId = "figure.col", value = settings$value[i])
                }else{
                  if(settings$InputId[i]=="figure.col")
                  {
                    updateNumericInput(session, inputId = "figure.col", value = settings$value[i])
                  }else{      
                    if(settings$InputId[i]=="xmin")
                    {
                      values_Skalierung.x[1] <-  settings$value[i]
                    }else{   
                      if(settings$InputId[i]=="xmax")
                      {
                        values_Skalierung.x[2] <-  settings$value[i]
                        updateNumericInput(session, inputId = "Skalierung.x", value = values_Skalierung.x)
                      }else{    
                        if(settings$InputId[i]=="ymin")
                        {
                          values_Skalierung.y[1] <-  settings$value[i]
                        }else{   
                          if(settings$InputId[i]=="ymax")
                          {
                            values_Skalierung.y[2] <-  settings$value[i]
                            updateNumericInput(session, inputId = "Skalierung.y", value = values_Skalierung.y)
                          }else{    
                            if(settings$InputId[i]=="zmax")
                            {
                              updateNumericInput(session, inputId = "Skalierung.z", value = settings$value[i])
                            }else{ 
                              if(settings$InputId[i]=="PGVimAnschluss")
                              {
                                updateCheckboxInput(session, inputId = "PGVimAnschluss", value = (if(settings$value[i]=="TRUE"){TRUE}else{FALSE}))
                              }
                              #else{  
                              #if(settings$InputId[i]=="Grenze1")
                              #{
                              #number.Größenklassen <- number.Größenklassen-3 #weil es beispielsweise bei 11 Klassen nur 10 Grenzen gibt, wovon eine als "letzte" angegeben wird
                              #for(j in i:(i+number.Größenklassen))
                              # {
                              #  updateNumericInput(session,inputId = settings$InputId[j], value = settings$value[j])  
                              #}
                              #}else{
                              #if(settings$InputId[i]=="Klasse.1")
                              #{
                              #number.Klassen <- number.Klassen-1   
                              # for(j in i:(i+number.Klassen))
                              #{
                              #  updateSelectInput(session, inputId = settings$InputId[j], selected = settings$value[j])  
                              #}  
                              #}
                              else{ 
                                if(settings$InputId[i]=="Kenngrößen")
                                {
                                  updateCheckboxInput(session, inputId = "Kenngrößen", value = (if(settings$value[i]=="TRUE"){TRUE}else{FALSE}))
                                }else{ 
                                  if(settings$InputId[i]=="language")
                                  {
                                    updateTextInput(session, inputId = "language", value = settings$value[i])
                                  }else{ 
                                    if(settings$InputId[i]=="fontsize.legend")
                                    {
                                      updateSliderInput(session, inputId = "fontsize.legend", value = settings$value[i])
                                    }
                                    else{ 
                                      if(settings$InputId[i]=="fontsize.legend")
                                      {
                                        updateSliderInput(session, inputId = "fontsize.legend", value = settings$value[i])
                                      }
                                      else{ 
                                        if(settings$InputId[i]=="fontsize.legendpt")
                                        {
                                          updateSliderInput(session, inputId = "fontsize.legendpt", value = settings$value[i])
                                        }
                                        else{ 
                                          if(settings$InputId[i]=="fontsize.main")
                                          {
                                            updateSliderInput(session, inputId = "fontsize.main", value = settings$value[i])
                                          }
                                          else{ 
                                            if(settings$InputId[i]=="fontsize.lab")
                                            {
                                              updateSliderInput(session, inputId = "fontsize.lab", value = settings$value[i])
                                            }else{ 
                                              if(settings$InputId[i]=="fontsize.axis")
                                              {
                                                updateSliderInput(session, inputId = "fontsize.axis", value = settings$value[i])
                                              }else{ 
                                                if(settings$InputId[i]=="size.symbols")
                                                {
                                                  updateSliderInput(session, inputId = "size.symbols", value = settings$value[i])
                                                }else{ 
                                                  if(settings$InputId[i]=="gradient")
                                                  {
                                                    updateCheckboxInput(session, inputId = "gradient", value = (if(settings$value[i]=="TRUE"){TRUE}else{FALSE}))
                                                  }      
                                                  
                                                }}}}}}}}}}}}}}}}}}}}}}
      
      
    } 
    Settings.Elements <- subset(settings, InputId=="sel.Elements")
    Settings.Elements0 <- subset(settings, InputId=="sel.Elements0")
    Settings.Elementsadd <- subset(settings, InputId=="Elementsadd")
    Settings.Elementsadd0 <- subset(settings, InputId=="Elementsadd0")
    #Elements selected 
    numberElements <- length(Settings.Elements$InputId)
    newElements <- NULL
    for(i in 1:numberElements)
    {
      newElements <- c(newElements, as.character(Settings.Elements$value[i]))
    }
    
    #Elements0 selected 
    numberElements0 <- length(Settings.Elements0$InputId)
    newElements0 <- NULL
    for(i in 1:numberElements0)
    {
      newElements0 <- c(newElements0, as.character(Settings.Elements0$value[i]))
    }
    
    #Elements add
    numberElementsadd <- length(Settings.Elementsadd$InputId)
    newElementsadd <- NULL
    for(i in 1:numberElementsadd)
    {
      newElementsadd <- c(newElementsadd, as.character(Settings.Elementsadd$value[i]))
    }
    
    #Elements0 add
    numberElementsadd0 <- length(Settings.Elementsadd0$InputId)
    newElementsadd0 <- NULL
    for(i in 1:numberElementsadd0)
    {
      newElementsadd0 <- c(newElementsadd0, as.character(Settings.Elementsadd0$value[i]))
    }
    
    updateCheckboxGroupInput(session,"Elements", selected = newElements, choices = newElementsadd)
    updateCheckboxGroupInput(session,"Elements0", selected = newElements0, choices = newElementsadd0)
    #Größenklassen 
    
    
    #updateTabItems(session, inputId = "Funktionen", selected = "Darstellungen")
    
    
    Sys.sleep(0.5)
    
    
    
  }
  else{ #old settings loading, is not used anymore 
    for(i in 1:6){
      updateTextInput(session, inputId = settings$InputId[i],value = settings$value[i])
    }
    Datapath.location.Datentitel(settings$value[7])    
    Datapath.location.Rulefile(settings$value[8])    
    for(i in 9:12){
      updateTextInput(session, inputId = settings$InputId[i],value = settings$value[i])
    }
    
    for(i in 14:29){
      #  if(settings$InputId[i] == "projektID" ) {
      #     
      #  } else if {} {
      #   
      # } else {
      #  #falssch
      # }
      
      updateCheckboxInput(session, inputId = settings$InputId[i], 
                          value = (if(settings$value[i]=="TRUE"){TRUE}else{FALSE}))
    }
    for(i in 30:47){
      updateNumericInput(session, inputId = settings$InputId[i], 
                         value = settings$value[i])
    }
    #Anzahl der ausgewählten Elemente
    numberElements <- as.numeric(settings$InputId[48])
    numberElements <- numberElements+47 #Verschiebeung um 22 Zellen, da Start bei 23, und Ende bei numberElemnts+22
    numberElements0 <- as.numeric(settings$InputId[numberElements+1])
    numberElements0 <- numberElements+numberElements0 
    newElements <- NULL
    newElements0 <- NULL
    
    for(i in 23:numberElements)
    {
      newElements <- c(newElements, as.character(settings$value[i]))
    }
    for(i in (numberElements+1):numberElements0)
    {
      newElements0 <- c(newElements0, as.character(settings$value[i]))
    }
    numberElementschoices <- as.numeric(settings$InputId[numberElements0+1])
    numberElementschoices <- numberElementschoices+numberElements0
    
    numberElements0choices <- as.numeric(settings$InputId[numberElementschoices+1])
    numberElements0choices <- numberElements0choices+numberElementschoices
    
    choices <- NULL
    choices0 <- NULL
    
    for(i in (numberElements0+1):numberElementschoices)
    {
      choices <- c(choices, as.character(settings$value[i]))
    }
    for(i in (numberElementschoices+1):numberElements0choices)
    {
      choices0 <- c(choices0, as.character(settings$value[i]))
    }
    updateCheckboxGroupInput(session,"Elements", selected = newElements, choices = choices)
    updateCheckboxGroupInput(session,"Elements0", selected = newElements0, choices = choices0)
    
    number.Größenklassen <- as.numeric(settings$value[35])
    number.Größenklassen <- number.Größenklassen+numberElements0choices-2 #-2, weil es beispielsweise bei 11 Klassen nur 10 Grenzen gibt, wovon eine als "letzte" angegeben wird
    for(i in (numberElements0choices+1):number.Größenklassen)
    {
      updateNumericInput(session,inputId = settings$InputId[i], value = settings$value[i])  
    }
    
    number.Klassen <- as.numeric(settings$value[39])
    number.Klassen <- number.Klassen+number.Größenklassen
    for(i in (number.Größenklassen+1):number.Klassen)
    {
      updateSelectInput(session, inputId = settings$InputId[i], selected = settings$value[i])  
    }
    Sys.sleep(0.5)
    
  }
  
  updateNumericInput(session, inputId = "collect.SettingsE", value = 1) 
  
}

  
})


#triggering some tabs that create variables after opening the tab, otherwise settings can not be written to those variables 
observeEvent(input$collect.SettingsE, {
  if(input$collect.SettingsE>0){
   updateTabItems(session, inputId = "Funktionen", selected = "Partikelgrößenbestimmung")
  updateNumericInput(session, inputId = "collect.SettingsF", value = 1)
}
})

observeEvent(input$collect.SettingsF, {if(input$collect.SettingsF>0){
  updateTabItems(session, inputId = "Funktionen", selected = "Darstellungen")
  updateNumericInput(session, inputId = "collect.SettingsG", value = 1)
}
})



#loading class boundaries again, since varaibales were not avaiable before 
observeEvent(input$collect.SettingsG, {
  if(input$collect.SettingsG>0){
    updateTabItems(session, inputId = "Funktionen", selected = "AllgemeineEinstellungen")
    settings <- read.csv(Datapath.location.settings(), header=TRUE, sep=";", dec=".", stringsAsFactors = FALSE, fileEncoding = "ISO-8859-1")
    for(i in 1:length(settings$InputId))
    {
      if(settings$InputId[i]=="Total.Größenklassen")
      {
        number.Größenklassen <- as.numeric(settings$value[i])
      }else{     
        if(settings$InputId[i]=="Grenze1")
        {
          number.Größenklassen <- number.Größenklassen-3 #weil es beispielsweise bei 11 Klassen nur 10 Grenzen gibt, wovon eine als "letzte" angegeben wird
          for(j in i:(i+number.Größenklassen))
          {
            updateNumericInput(session,inputId = settings$InputId[j], value = settings$value[j])  
          }
        }else{
          if(settings$InputId[i]=="letzte")
          {
            updateNumericInput(session, inputId = "letzte", value = settings$value[i])
          }else{
            if(settings$InputId[i]=="Darstellungen.Klassen.Anzahl")
            {
                   number.Klassen <- as.numeric(settings$value[i])
            }else{
              if(settings$InputId[i]=="Klasse.1")
              {
                number.Klassen <- number.Klassen-1   
                for(j in i:(i+number.Klassen))
                {
                  updateSelectInput(session, inputId = settings$InputId[j], selected = settings$value[j])  
                }  
              }
              
              
              
            }
          }
          
          
          
        }   
        
      }
      
    }
    #resetting the triggering variabales 
    updateNumericInput(session, "collect.SettingsE", value = 0)
    updateNumericInput(session, "collect.SettingsF", value = 0)
    updateNumericInput(session, "collect.SettingsG", value = 0)
    closeSweetAlert(session)
    sendSweetAlert(session, title="Einstellungen geladen", type="success")
  }
  
  
})
