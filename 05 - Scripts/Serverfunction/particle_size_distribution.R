


#Partikelgrößenbestimmung

#Voreinstellungen zu den Größenklassen
current_Total.Größenklassen <- reactiveVal(11)
output$Größenklassen <- renderUI( 
  { req(iv_PGV$is_valid())
    #number <- input$Total.Größenklassen-2
    updateNumericInput(session, inputId = "collect.SettingsH", value = 1)
    number <- 9
    #current_classes <- read.csv2("05 - Scripts/Partikelgrößenbestimmung/current_classes.csv", header = TRUE)
    list( lapply(1:number, function(i) 
    {
      div(style="display: inline-block;vertical-align:top; width: 48%;",numericInput(inputId = paste("Grenze",i,sep=""), label = paste("Obergrenze Klasse ",i,":",sep=""),value = default.values[i], min = 0))
    }), div(style="display: inline-block;vertical-align:top; width: 48%;",numericInput(inputId = "letzte", label = paste("Obergrenze Klasse ",number+1,sep = ""), value = 200, min = 0)))
  })

observeEvent(input$Total.Größenklassen, {
  req(iv_PGV$is_valid())
  if(input$collect.SettingsH>0)
  {
    old_Größenklassen <- current_Total.Größenklassen()
    Total.Größenklassen <- input$Total.Größenklassen
    current_Total.Größenklassen(Total.Größenklassen)
    
    
    Klassen.Grenzen <- paste("Grenze",1:old_Größenklassen,sep="")
    Grenze1 <- 0
    for(i in 2:(old_Größenklassen-1))
    {
      Grenze <- Klassen.Grenzen[i]
      value <- input[[Klassen.Grenzen[i-1]]]
      assign(Grenze, value)
    }
    Grenze <- Klassen.Grenzen[old_Größenklassen]
    value <- input$letzte 
    assign(Grenze, value)
    alle_Klassen <- 0
    for(i in 2:(old_Größenklassen))
    {
      alle_Klassen[i] <- get(Klassen.Grenzen[i])
    }
    if(Total.Größenklassen>old_Größenklassen)
    {
      for(i in (length(alle_Klassen))+1:(Total.Größenklassen-old_Größenklassen))
      {
        alle_Klassen[i] <- 0
      }
    }
    
    #rendern der Felder
    output$Größenklassen <- renderUI( 
      { req(iv_PGV$is_valid())
        number <- input$Total.Größenklassen-2
        #current_classes <- read.csv2("05 - Scripts/Partikelgrößenbestimmung/current_classes.csv", header = TRUE)
        list( lapply(1:number, function(i) 
        {
          div(style="display: inline-block;vertical-align:top; width: 48%;",numericInput(inputId = paste("Grenze",i,sep=""), label = paste("Obergrenze Klasse ",i,":",sep=""),value = alle_Klassen[i+1], min = 0))
        }), div(style="display: inline-block;vertical-align:top; width: 48%;",numericInput(inputId = "letzte", label = paste("Obergrenze Klasse ",number+1,sep = ""), value = alle_Klassen[Total.Größenklassen], min = 0)))
      })
    
    
    
  }  
})

#  observeEvent(input$Total.Größenklassen,
#               {
#                 Total.Größenklassen <- input$Total.Größenklassen-1
#                 updateNumericInput(inputId = "letzte", label = paste("Obergrenze Klasse ",Total.Größenklassen,":",sep=""),value = default.values[Total.Größenklassen])
#     
#                  })




#Erfassen der letzten Grenze und Erzeugen eines Textoutputs
observeEvent(input$letzte, {
  
  Total.Größenklassen <- input$Total.Größenklassen
  Grenze <- input$letzte
  letzte.Klasse <-paste("Klasse ",Total.Größenklassen,": >",Grenze,sep="") 
  output$letzte.Klasse <- renderText(letzte.Klasse)
  
})



#output$letzte.Klasse <- renderPrint({
observeEvent(input$Anwenden.Größenklassen, {
  req(iv_PGV$is_valid())  
  Total.Größenklassen <- as.integer(input$Total.Größenklassen)
  Grenzen <- c(paste("Grenze",1:Total.Größenklassen,sep=""))
  alle.Grenzen <- 0
  for(i in Grenzen){
    alle.Grenzen <- append(alle.Grenzen, input[[i]])}
  Total.Größenklassen <- Total.Größenklassen-2
  for(i in 1:Total.Größenklassen)
  {
    updateNumericInput(inputId = paste("Grenze",i,sep=""), label = paste("Klasse ",i,": (",alle.Grenzen[i]," - ",alle.Grenzen[i+1],"]",sep=""))
  }
  Total.Größenklassen <- Total.Größenklassen+1
  value.letzte <- input$letzte
  updateNumericInput(inputId = "letzte", label = paste("Klasse ",Total.Größenklassen,": (",alle.Grenzen[Total.Größenklassen]," - ",value.letzte,"]",sep=""))
})


#Partikelklassierung
observeEvent(input$Partikelgrößenbestimmung,{
  if(iv_PGV$is_valid()){
    if(isTRUE(grepl(".csv",Datapath.location.Datentitel()))){if(isTRUE(grepl(".csv",Datapath.location.Rulefile()))){if(isTRUE(input$alle.Partikel)){
      confirmSweetAlert(session, inputId = "Run.Partikelgrößenbestimmung", title = "Partikelgrößenbestimmung starten?", type = "question", btn_labels = c("Nein","Ja"))}else{if(isTRUE(input$nach.Klassen)){
        confirmSweetAlert(session, inputId = "Run.Partikelgrößenbestimmung", title = "Partikelgrößenbestimmung starten?", type = "question", btn_labels = c("Nein","Ja"))
      }else{sendSweetAlert(session, title = "Die Klassierung kann sowohl für alle Partikel gemeinsam als auch nach Klassen getrennt durchgeführt werden. Bitte wählen sie mindestens einer dieser beiden Optionen aus.", type = "warning")}}
    }else{sendSweetAlert(session, title = "Keine Rulefile-Datei ausgewählt.", type = "warning")}
    }else{sendSweetAlert(session, title = "Keine Datentitel-Datei ausgewählt.", type = "warning")}
  }else{sendSweetAlert(session, title = "Bitte korrekte Eingabe vornehmen.", type = "error")}
  
  
})






observeEvent(input$Run.Partikelgrößenbestimmung, {if(isTRUE(input$Run.Partikelgrößenbestimmung)){
  #Progressbar 
  progressSweetAlert(session, id= "Progress.Partikelgrößenbestimmung", title = "Partikelgrößenbestimmung läuft.", display_pct = TRUE, value = 0)
  
  #determine particle distribution
  source("05 - Scripts/Serverfunction/determine_particle_distribution.R", local = TRUE)
  
}
})

