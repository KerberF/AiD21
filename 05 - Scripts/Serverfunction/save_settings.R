
#Speichern der Einstellungen in Datei
options.save <- reactiveVal(0)  


#Confirm Speichern 


observeEvent(input$save.settings, {
  if(length(Datapath.location.settings())!=0 && Datapath.location.settings()!="Keine Datei gewählt.")
  {
    options.save(0) 
    updateNumericInput(session, inputId = "collect.SettingsC", value = 1)
    updateTabItems(session, inputId = "Funktionen", selected = "Partikelgrößenbestimmung")
  }else{sendSweetAlert(session, title = "Keine Datei zum überspreichern gewählt.", type = "warning")}
})

observeEvent(input$save.as.settings, {
  options.save(1)
  inputSweetAlert(inputId = "Dateiname.Settings", title = "Bitte Dateinamen angeben.", type = "info",session, input = "text")
})

observeEvent(input$Dateiname.Settings,{
  if(input$Dateiname.Settings!="")
  {
    updateNumericInput(session, inputId = "collect.SettingsC", value = 1)
    updateTabItems(session, inputId = "Funktionen", selected = "Partikelgrößenbestimmung")
  }
})

observeEvent(input$collect.SettingsC, {if(input$collect.SettingsC>0){
  
  
  updateTabItems(session, inputId = "Funktionen", selected = "Darstellungen")
  updateNumericInput(session, inputId = "collect.SettingsD", value = 1)
  
}
})

observeEvent(input$collect.SettingsD, {if(input$collect.SettingsD>0){
  updateTabItems(session, inputId = "Funktionen", selected = "AllgemeineEinstellungen")
  updateNumericInput(session, inputId = "collect.SettingsD", value = 0)
  updateNumericInput(session, inputId = "collect.SettingsC", value = 0)
  displayed_title <- paste("Einstellungen speichern?",sep="")
  confirmSweetAlert(session, inputId = "Confirm.save.settings", title = displayed_title, type = "question", btn_labels = c("Nein","Ja"),  width = 1200)
}
})

observeEvent(input$Confirm.save.settings, {if(isTRUE(input$Confirm.save.settings)){
  if(options.save()==1)
  {
    
    Ierror <- tryCatch(
      {
        test <- read.csv(paste("03 - Einstellungen/",input$Dateiname.Settings,".csv", sep=""), header = TRUE, dec=",", sep=";")
        Ierror <- 0
      }
      ,
      error=function(cond)
      {
        return(1)
      },
      warning=function(cond)
      {
        return(1)
      })
  }
  if(options.save()==0)
  {
    Ierror <- 1 #for save.settings no query whether to overwrite or not
  }
  if(Ierror==0)
  {
    displayed_title <- paste("Datei bereits vorhanden. Überschreiben?",sep="")
    confirmSweetAlert(session, inputId = "Confirm.overwrite.settings", title = displayed_title, type = "question", btn_labels = c("Nein","Ja"),  width = 1200)
  }else{
    #Define Inputs to safe, erst alle nummerischen, dann alle Text, dann alle Checkboxen etc. 
    inputs_to_save <- c("Projekt","Charge","Version","Klassierungsmerkmal","custom.Merkmal","language",
                        "xplot","yplot","zplot","gradient",
                        "Abstandsüberprüfung","Ausfuehrlicher.Abstandspruefer","Position.Normierung","Normierungvorher","Vorklassierung","Berechnung.Flächenanteile","Clusterprüfung","Quadrate","Darstellungen.Clusterprüfung",
                        "Ermittlung.Dequi","alle.Partikel","nach.Klassen","Speicherung.Klassen","Klassennamen.in.Datei","Farbig","Symbole.Füllung","PGVimAnschluss","Kenngrößen",
                        "Referenzfläche","min.Abstand","Anzahl.Spalten","Anzahl.Reihen","Total.Größenklassen","letzte","Position.Legendex","Position.Legendey","Darstellungen.Klassen.Anzahl","figure.rows","figure.col","fontsize.legend","fontsize.legendpt","fontsize.main","fontsize.lab","fontsize.axis","size.symbols")
    
    #Declare inputs (Variable anlegen)
    
    inputs <- NULL
    #Append all inputs before saving
    for(input.i in inputs_to_save){
      inputs <- append(inputs, input[[input.i]])
    }    #Inputs Data.frame
    inputs_data_frame <- data.frame(InputId = inputs_to_save, value = inputs, stringsAsFactors = FALSE)
    
    #Skalierung von Plots speichern 
    lastrow <-  length(inputs_data_frame$InputId)
    inputs_data_frame[lastrow+1,1] <- "Datapath.location.Datentitel"
    inputs_data_frame[lastrow+2,1] <- "Datapath.location.Rulefile"
    inputs_data_frame[lastrow+1,2] <- paste(Datapath.location.Datentitel())
    inputs_data_frame[lastrow+2,2] <- paste(Datapath.location.Rulefile())
    lastrow <-  length(inputs_data_frame$InputId)
    Skalierung.x <- input$Skalierung.x
    Skalierung.y <- input$Skalierung.y
    Skalierung.z <- input$Skalierung.z
    #x-Achse
    inputs_data_frame[lastrow+1,2] <- Skalierung.x[1]
    inputs_data_frame[lastrow+1,1] <- "xmin"
    inputs_data_frame[lastrow+2,2] <- Skalierung.x[2]
    inputs_data_frame[lastrow+2,1] <- "xmax"
    
    #y-Achse
    inputs_data_frame[lastrow+3,2] <- Skalierung.y[1]
    inputs_data_frame[lastrow+3,1] <- "ymin"
    inputs_data_frame[lastrow+4,2] <- Skalierung.y[2]
    inputs_data_frame[lastrow+4,1] <- "ymax"
    
    #z-Achse
    #inputs_data_frame[lastrow+5,2] <- Skalierung.z[1]
    #inputs_data_frame[lastrow+5,1] <- "zmin"
    inputs_data_frame[lastrow+5,2] <- Skalierung.z
    inputs_data_frame[lastrow+5,1] <- "zmax"
    
    
    #Hinzufügen der Vektoren für Elemente der Normierung
    Elements.selected <- input$Elements
    Elements0.selected <- input$Elements0
    lastrow <-  length(inputs_data_frame$InputId)
    if(length(Elements.selected)>0){
      for(i in 1:length(Elements.selected))
      {inputs_data_frame[lastrow+i,2] <- Elements.selected[i]
      inputs_data_frame[lastrow+i,1] <- "sel.Elements"}
      #inputs_data_frame[lastrow+1,1] <- length(Elements.selected)
    }
    if(length(Elements0.selected)>0){
      lastrow <-  length(inputs_data_frame$InputId)
      for(i in 1:length(Elements0.selected))
      {inputs_data_frame[lastrow+i,2] <- Elements0.selected[i]
      inputs_data_frame[lastrow+i,1] <- "sel.Elements0"}
      #inputs_data_frame[lastrow+1,1] <- length(Elements0.selected)
    }
    #Fals zusätzliche Elemente hinzugefügt wurden, dann werden diese hier mit abgespeichert:
    #für Elements
    newchoices <- NULL
    Anzahl <- input$Elements.to.add
    var <- paste("addelementchoice",1:Anzahl,sep="")
    if(input$weitere==TRUE){for(i in var)
    {
      newchoices <- append(newchoices, input[[i]])
      choices.elements <- c(choices.elements,newchoices)
    }}
    lastrow <-  length(inputs_data_frame$InputId)
    for(i in 1:length(choices.elements))
    {inputs_data_frame[lastrow+i,2] <- choices.elements[i]
    inputs_data_frame[lastrow+i,1] <- "Elementsadd"}
    #inputs_data_frame[lastrow+1,1] <- length(choices.elements)
    
    #für Elements0
    newchoices <- NULL
    Anzahl <- input$Elements.to.add0
    var <- paste("addelement0choice",1:Anzahl,sep="")
    if(input$weitere0==TRUE){
      for(i in var)
      {
        newchoices <- append(newchoices, input[[i]])
        choices.elements0 <- c(choices.elements.default,newchoices)
      }}else{choices.elements0 <- choices.elements.default}
    lastrow <-  length(inputs_data_frame$InputId)
    for(i in 1:length(choices.elements0))
    {inputs_data_frame[lastrow+i,2] <- choices.elements0[i]
    inputs_data_frame[lastrow+i,1] <- "Elementsadd0"}
    #inputs_data_frame[lastrow+1,1] <- length(choices.elements0)
    
    
    #Größenklassen 
    Total.Größenklassen <- input$Total.Größenklassen 
    lastrow <-  length(inputs_data_frame$InputId)
    Klassen.Grenzen <- paste("Grenze",1:Total.Größenklassen,sep="")
    
    for(i in 1:(Total.Größenklassen-2))
    {
      Grenze <- Klassen.Grenzen[i]
      value <- input[[Klassen.Grenzen[i]]]
      inputs_data_frame[lastrow+i,1] <- Grenze
      inputs_data_frame[lastrow+i,2] <- value
    }
    
    Anzahl.Klassen <- input$Darstellungen.Klassen.Anzahl
    lastrow <-  length(inputs_data_frame$InputId)
    Klassen <- paste("Klasse.",1:Anzahl.Klassen,sep="")
    
    for(i in 1:Anzahl.Klassen)
    {
      Klasse <- Klassen[i]
      value <- input[[Klassen[i]]]
      inputs_data_frame[lastrow+i,1] <- Klasse
      inputs_data_frame[lastrow+i,2] <- value
    }
    
    
    lastrow <- length(inputs_data_frame$InputId)
    inputs_data_frame[lastrow+1,1] <- "Version_Settings"
    inputs_data_frame[lastrow+1,2] <- "v1.2"
    #Save inputs 
    
    if(options.save()==0)
    {
      Ierror <-  safewrite.csv(inputs_data_frame, filename = paste(Datapath.location.settings()))
    }
    if(options.save()==1)
    {
      Ierror <-  safewrite.csv(inputs_data_frame, filename = paste("03 - Einstellungen/",input$Dateiname.Settings,".csv", sep = ""))
      if(Ierror==0)
      {
        Datapath.location.settings(paste("03 - Einstellungen/",input$Dateiname.Settings,".csv", sep = ""))
        output$outDatapath <- renderText(Datapath.location.settings())
      }
    }
    if(Ierror==0)
    {
      output$outDatapath <- renderText(Datapath.location.settings())
      sendSweetAlert(session, title = "Einstellungen erfolgreich gespeichert", type = "success")
    }
  }
}
})


observeEvent(input$Confirm.overwrite.settings, {if(isTRUE(input$Confirm.overwrite.settings)){
  #Define Inputs to safe, erst alle nummerischen, dann alle Text, dann alle Checkboxen etc. 
  inputs_to_save <- c("Projekt","Charge","Version","Klassierungsmerkmal","custom.Merkmal","language",
                      "xplot","yplot","zplot","gradient",
                      "Abstandsüberprüfung","Ausfuehrlicher.Abstandspruefer","Position.Normierung","Normierungvorher","Vorklassierung","Berechnung.Flächenanteile","Clusterprüfung","Quadrate","Darstellungen.Clusterprüfung",
                      "Ermittlung.Dequi","alle.Partikel","nach.Klassen","Speicherung.Klassen","Klassennamen.in.Datei","Farbig","Symbole.Füllung","PGVimAnschluss","Kenngrößen",
                      "Referenzfläche","min.Abstand","Anzahl.Spalten","Anzahl.Reihen","Total.Größenklassen","letzte","Position.Legendex","Position.Legendey","Darstellungen.Klassen.Anzahl","figure.rows","figure.col","fontsize.legend","fontsize.legendpt","fontsize.main","fontsize.lab","fontsize.axis","size.symbols")
  
  #Declare inputs (Variable anlegen)
  
  inputs <- NULL
  #Append all inputs before saving
  for(input.i in inputs_to_save){
    inputs <- append(inputs, input[[input.i]])
  }    #Inputs Data.frame
  inputs_data_frame <- data.frame(InputId = inputs_to_save, value = inputs, stringsAsFactors = FALSE)
  
  #Skalierung von Plots speichern 
  lastrow <-  length(inputs_data_frame$InputId)
  inputs_data_frame[lastrow+1,1] <- "Datapath.location.Datentitel"
  inputs_data_frame[lastrow+2,1] <- "Datapath.location.Rulefile"
  inputs_data_frame[lastrow+1,2] <- paste(Datapath.location.Datentitel())
  inputs_data_frame[lastrow+2,2] <- paste(Datapath.location.Rulefile())
  lastrow <-  length(inputs_data_frame$InputId)
  Skalierung.x <- input$Skalierung.x
  Skalierung.y <- input$Skalierung.y
  Skalierung.z <- input$Skalierung.z
  
  #x-Achse
  inputs_data_frame[lastrow+1,2] <- Skalierung.x[1]
  inputs_data_frame[lastrow+1,1] <- "xmin"
  inputs_data_frame[lastrow+2,2] <- Skalierung.x[2]
  inputs_data_frame[lastrow+2,1] <- "xmax"
  
  #y-Achse
  inputs_data_frame[lastrow+3,2] <- Skalierung.y[1]
  inputs_data_frame[lastrow+3,1] <- "ymin"
  inputs_data_frame[lastrow+4,2] <- Skalierung.y[2]
  inputs_data_frame[lastrow+4,1] <- "ymax"
  
  #z-Achse
  #inputs_data_frame[lastrow+5,2] <- Skalierung.z[1]
  #inputs_data_frame[lastrow+5,1] <- "zmin"
  inputs_data_frame[lastrow+5,2] <- Skalierung.z
  inputs_data_frame[lastrow+5,1] <- "zmax"
  
  #Hinzufügen der Vektoren für Elemente der Normierung
  Elements.selected <- input$Elements
  Elements0.selected <- input$Elements0
  lastrow <-  length(inputs_data_frame$InputId)
  if(length(Elements.selected)>0){
    for(i in 1:length(Elements.selected))
    {inputs_data_frame[lastrow+i,2] <- Elements.selected[i]
    inputs_data_frame[lastrow+i,1] <- "sel.Elements"}
    #inputs_data_frame[lastrow+1,1] <- length(Elements.selected)
  }
  if(length(Elements0.selected)>0){
    lastrow <-  length(inputs_data_frame$InputId)
    for(i in 1:length(Elements0.selected))
    {inputs_data_frame[lastrow+i,2] <- Elements0.selected[i]
    inputs_data_frame[lastrow+i,1] <- "sel.Elements0"}
    #inputs_data_frame[lastrow+1,1] <- length(Elements0.selected)
  }
  #Fals zusätzliche Elemente hinzugefügt wurden, dann werden diese hier mit abgespeichert:
  #für Elements
  
  newchoices <- NULL
  Anzahl <- input$Elements.to.add
  var <- paste("addelementchoice",1:Anzahl,sep="")
  if(input$weitere==TRUE){for(i in var)
  {
    newchoices <- append(newchoices, input[[i]])
    choices.elements <- c(choices.elements,newchoices)
  }}
  lastrow <-  length(inputs_data_frame$InputId)
  for(i in 1:length(choices.elements))
  {inputs_data_frame[lastrow+i,2] <- choices.elements[i]
  inputs_data_frame[lastrow+i,1] <- "Elementsadd"}
  #inputs_data_frame[lastrow+1,1] <- length(choices.elements)
  
  #für Elements0
  newchoices <- NULL
  Anzahl <- input$Elements.to.add0
  var <- paste("addelement0choice",1:Anzahl,sep="")
  if(input$weitere0==TRUE){
    for(i in var)
    {
      newchoices <- append(newchoices, input[[i]])
      choices.elements0 <- c(choices.elements.default,newchoices)
    }}else{choices.elements0 <- choices.elements.default}
  lastrow <-  length(inputs_data_frame$InputId)
  for(i in 1:length(choices.elements0))
  {inputs_data_frame[lastrow+i,2] <- choices.elements0[i]
  inputs_data_frame[lastrow+i,1] <- "Elementsadd0"}
  #inputs_data_frame[lastrow+1,1] <- length(choices.elements0)
  
  
  #Größenklassen 
  Total.Größenklassen <- input$Total.Größenklassen 
  lastrow <-  length(inputs_data_frame$InputId)
  Klassen.Grenzen <- paste("Grenze",1:Total.Größenklassen,sep="")
  
  for(i in 1:(Total.Größenklassen-2))
  {
    Grenze <- Klassen.Grenzen[i]
    value <- input[[Klassen.Grenzen[i]]]
    inputs_data_frame[lastrow+i,1] <- Grenze
    inputs_data_frame[lastrow+i,2] <- value
  }
  
  Anzahl.Klassen <- input$Darstellungen.Klassen.Anzahl
  lastrow <-  length(inputs_data_frame$InputId)
  Klassen <- paste("Klasse.",1:Anzahl.Klassen,sep="")
  
  for(i in 1:Anzahl.Klassen)
  {
    Klasse <- Klassen[i]
    value <- input[[Klassen[i]]]
    inputs_data_frame[lastrow+i,1] <- Klasse
    inputs_data_frame[lastrow+i,2] <- value
  }
  
  
  lastrow <- length(inputs_data_frame$InputId)
  inputs_data_frame[lastrow+1,1] <- "Version_Settings"
  inputs_data_frame[lastrow+1,2] <- "v1.2"
  #Save inputs 
  if(options.save()==0)
  {
    Ierror <-  safewrite.csv(inputs_data_frame, filename = paste(Datapath.location.settings()))
  }
  if(options.save()==1)
  {
    Ierror <-  safewrite.csv(inputs_data_frame, filename = paste("03 - Einstellungen/",input$Dateiname.Settings,".csv", sep = ""))
    if(Ierror==0)
    {
      Datapath.location.settings(paste("03 - Einstellungen/",input$Dateiname.Settings,".csv", sep = ""))
      output$outDatapath <- renderText(Datapath.location.settings())
    }
  }
  if(Ierror==0)
  {
    sendSweetAlert(session, title = "Einstellungen erfolgreich gespeichert", type = "success")
  }
  
  
}}
)