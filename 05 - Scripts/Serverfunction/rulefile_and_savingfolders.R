#Rulefile and saving folders 

#creating variable for rulefile directory 
Datapath.location.Rulefile <- reactiveVal("Kein Rulefile ausgewählt.")

#browsing a rulefile
observeEvent(input$location.Rulefile,{ 
  #updateTextInput(session, "Datapath.location.Rulefile", value = paste(choose.files(caption = "Rulefile auswählen",default =paste0(getwd(), "/02 - Rulefiles/*.csv"), filters = c("CSV Files (*.csv)","*.csv"),index = 1,multi = FALSE)))
  Datapath.location.Rulefile(choose.files(caption = "Rulefile auswählen",default =paste0(getwd(), "/02 - Rulefiles/*.csv"), filters = c("CSV Files (*.csv)","*.csv"),index = 1,multi = FALSE))
})

#updating textbox output after browsing 
observeEvent(Datapath.location.Rulefile(),
             {
               
               if(length(Datapath.location.Rulefile())==0)
               {
                 output$outDatapathRulefile <- renderText("Kein Rulefile ausgewählt.")
                 Datapath.location.Rulefile("Kein Rulefile ausgewählt.")
               }else{
                 output$outDatapathRulefile <- renderText(Datapath.location.Rulefile())
               }
             })



#Erzeugung aller notwendigen Ordner 
observeEvent(input$Ordner.erstellen,  {
  if(iv_Bezeichnung$is_valid())
  {
    angelegt <- 0
    a <- 0
    Projekt <- input$Projekt
    Charge <- input$Charge
    Version <- input$Version 
    
    source(paste("05 - Scripts/Variablen/Ordnerstruktur.R",sep=""), local = TRUE)
    sendSweetAlert(session, title=erstellt, type="success")
  }else{sendSweetAlert(session, title = "Bitte korrekte Eingabe vornehmen.", type = "error")}
})

