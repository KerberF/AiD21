##Rulefileeditor 

#creating variable 
Datapath.location.Rulefileedit <- reactiveVal("Kein Rulefile ausgewählt.")  

#update textbox with selected file
observeEvent(Datapath.location.Rulefileedit(),
             {
               
               if(length(Datapath.location.Rulefileedit())==0)
               {
                 output$outRulefileedit <- renderText("Kein Rulefile ausgewählt.")
               }else{
                 output$outRulefileedit <- renderText(Datapath.location.Rulefileedit())
               }
             })


##Change class order 

#Update available classes
observeEvent(input$updateclasses,{
  if(iv_RulefileEditor$is_valid())
  {
    AnzahlHauptklassen <- input$AnzahlHauptklassen
    AnzahlVorklassen <- input$AnzahlVorklassen
    Klassen <- "Bitte Auswahl aktualisieren"
    if(AnzahlHauptklassen>0)
    {
      Hauptklassen <- paste("Hauptklasse",1:AnzahlHauptklassen,sep="")
      Klassennamen <- NULL
      
      for(i in 1:AnzahlHauptklassen)
      {
        Klassennamen[i] <- input[[Hauptklassen[i]]]
      }
      Klassen <- Klassennamen
    }
    
    
    if(AnzahlVorklassen>0)
    {
      Vorklassen <- paste("Vorklasse",1:AnzahlVorklassen,sep="")
      PreKlassennamen <- NULL
      for(i in 1:AnzahlVorklassen)
      {
        PreKlassennamen[i] <- input[[Vorklassen[i]]]
      }
      Klassen <- PreKlassennamen
    }
    
    
    if(AnzahlHauptklassen>0&&AnzahlVorklassen>0)
    {
      Klassen <- c(Klassennamen, PreKlassennamen)
    }
    updateSelectInput(inputId = "Reihenfolge", choices = Klassen) 
  }else{sendSweetAlert(session, title = "Bitte korrekte Eingabe vornehmen.", type = "error")}
})


#move selceted class upwards
observeEvent(input$up, {
  req(iv_RulefileEditor$is_valid())
  selected <- input$Reihenfolge
  AnzahlVorklassen <- input$AnzahlVorklassen
  AnzahlHauptklassen <- input$AnzahlHauptklassen 
  Klassenname <- 0
  Klassenbedingung <- 0
  PreKlassennamen <- 0 
  PreKlassenbedingungen <-0
  new_rulefile <- data.frame(Klassenname,Klassenbedingung,PreKlassennamen, PreKlassenbedingungen )
  
  if(AnzahlHauptklassen>0)
  {
    Hauptklassen <- paste("Hauptklasse",1:AnzahlHauptklassen,sep="")
    Hauptklassenbedingungen <- paste("Bedingung",1:AnzahlHauptklassen,sep="")
    
    
    for(i in 1:AnzahlHauptklassen)
    {
      new_rulefile[i,1] <- input[[Hauptklassen[i]]]
      new_rulefile[i,2] <- input[[Hauptklassenbedingungen[i]]]
    }
  }
  if(AnzahlVorklassen>0)
  {
    Vorklassen <- paste("Vorklasse",1:AnzahlVorklassen,sep="")
    Vorklassenbedingungen <- paste("PreBedingung",1:AnzahlVorklassen,sep="")
    
    
    
    
    for(i in 1:AnzahlVorklassen)
    {
      new_rulefile[i,3] <- input[[Vorklassen[i]]]
      new_rulefile[i,4] <- input[[Vorklassenbedingungen[i]]]
    }
  }
  names <- c("Klassenname", "Klassenbedingung", "PreKlassennamen", "PreKlassenbedingungen")
  colnames(new_rulefile) <- names
  if(AnzahlHauptklassen>0)
  {
    for(i in 1:length(new_rulefile$Klassenname))
    {
      if(paste(new_rulefile$Klassenname[i])==paste(selected))
      {
        if(i==1)
        {
          sendSweetAlert(session, title = paste("Klasse ",selected," ist bereits an erster Position.",sep=""), type = "warning")
        }else{
          upperclass <- new_rulefile$Klassenname[i-1]
          upperclasscond <- new_rulefile$Klassenbedingung[i-1]
          new_rulefile$Klassenname[i-1]  <- new_rulefile$Klassenname[i]
          new_rulefile$Klassenbedingung[i-1] <-new_rulefile$Klassenbedingung[i]
          new_rulefile$Klassenname[i]  <- upperclass
          new_rulefile$Klassenbedingung[i] <-upperclasscond 
          output$Hauptklassen <- renderUI( 
            {
              lapply(1:AnzahlHauptklassen, function(j)
              {
                list( div(style="display: inline-block;vertical-align:top; width: 20%;", textInput(inputId = paste("Hauptklasse",j,sep=""),label = NULL, value = new_rulefile$Klassenname[j])), 
                      div(style="display: inline-block;vertical-align:top; width: 75%;", textInput(inputId = paste("Bedingung",j,sep=""), label = NULL, value = new_rulefile$Klassenbedingung[j], width = 1000)))
                
              })
            })
        }
      }
    }}
  if(AnzahlVorklassen>0)
  {
    
    for(i in 1:length(new_rulefile$PreKlassennamen))
    {
      if(paste(new_rulefile$PreKlassennamen[i])==paste(selected))
      {
        if(i==1)
        {
          sendSweetAlert(session, title = paste("Klasse ",selected," ist bereits an erster Position.",sep=""), type = "warning")
        }else{
          upperclass <- new_rulefile$PreKlassennamen[i-1]
          upperclasscond <- new_rulefile$PreKlassenbedingungen[i-1]
          new_rulefile$PreKlassennamen[i-1]  <- new_rulefile$PreKlassennamen[i]
          new_rulefile$PreKlassenbedingungen[i-1] <-new_rulefile$PreKlassenbedingungen[i]
          new_rulefile$PreKlassennamen[i]  <- upperclass
          new_rulefile$PreKlassenbedingungen[i] <-upperclasscond 
          output$Vorklassen <- renderUI( 
            {
              lapply(1:AnzahlVorklassen, function(j)
              {
                list( div(style="display: inline-block;vertical-align:top; width: 20%;", textInput(inputId = paste("Vorklasse",j,sep=""),label = NULL, value = new_rulefile$PreKlassennamen[j])), 
                      div(style="display: inline-block;vertical-align:top; width: 75%;", textInput(inputId = paste("PreBedingung",j,sep=""), label = NULL, value = new_rulefile$PreKlassenbedingungen[j], width = 1000)))
                
              })
            })
        }
      }
    }
  }
  safewrite.csv(new_rulefile, "05 - Scripts/Rulefiles/current_rulefile.csv", rownames = FALSE)
  
})


#move selected class down
observeEvent(input$down, {
  req(iv_RulefileEditor$is_valid())
  selected <- input$Reihenfolge
  
  AnzahlVorklassen <- input$AnzahlVorklassen
  AnzahlHauptklassen <- input$AnzahlHauptklassen 
  Klassenname <- 0
  Klassenbedingung <- 0
  PreKlassennamen <- 0 
  PreKlassenbedingungen <-0
  new_rulefile <- data.frame(Klassenname,Klassenbedingung,PreKlassennamen, PreKlassenbedingungen )
  if(AnzahlHauptklassen>0)
  {
    Hauptklassen <- paste("Hauptklasse",1:AnzahlHauptklassen,sep="")
    Hauptklassenbedingungen <- paste("Bedingung",1:AnzahlHauptklassen,sep="")
    
    
    for(i in 1:AnzahlHauptklassen)
    {
      new_rulefile[i,1] <- input[[Hauptklassen[i]]]
      new_rulefile[i,2] <- input[[Hauptklassenbedingungen[i]]]
    }
  }
  if(AnzahlVorklassen>0)
  {
    Vorklassen <- paste("Vorklasse",1:AnzahlVorklassen,sep="")
    Vorklassenbedingungen <- paste("PreBedingung",1:AnzahlVorklassen,sep="")
    for(i in 1:AnzahlVorklassen)
    {
      new_rulefile[i,3] <- input[[Vorklassen[i]]]
      new_rulefile[i,4] <- input[[Vorklassenbedingungen[i]]]
    }
  }
  names <- c("Klassenname", "Klassenbedingung", "PreKlassennamen", "PreKlassenbedingungen")
  colnames(new_rulefile) <- names
  if(AnzahlHauptklassen >0)
  {
    for(i in 1:length(new_rulefile$Klassenname))
    {
      if(paste(new_rulefile$Klassenname[i])==paste(selected))
      {
        if(i==AnzahlHauptklassen)
        {
          sendSweetAlert(session, title = paste("Klasse ",selected," ist bereits an letzter Position.",sep=""), type = "warning")
        }else{
          lowerclass <- new_rulefile$Klassenname[i+1]
          lowerclasscond <- new_rulefile$Klassenbedingung[i+1]
          new_rulefile$Klassenname[i+1]  <- new_rulefile$Klassenname[i]
          new_rulefile$Klassenbedingung[i+1] <-new_rulefile$Klassenbedingung[i]
          new_rulefile$Klassenname[i]  <- lowerclass
          new_rulefile$Klassenbedingung[i] <-lowerclasscond 
          selected <- "ist bereits erledigt"
          output$Hauptklassen <- renderUI( 
            {
              lapply(1:AnzahlHauptklassen, function(j)
              {
                list( div(style="display: inline-block;vertical-align:top; width: 20%;", textInput(inputId = paste("Hauptklasse",j,sep=""),label = NULL, value = new_rulefile$Klassenname[j])), 
                      div(style="display: inline-block;vertical-align:top; width: 75%;", textInput(inputId = paste("Bedingung",j,sep=""), label = NULL, value = new_rulefile$Klassenbedingung[j], width = 1000)))
                
              })
            })
        }
      }
    }
  }
  if(AnzahlVorklassen>0)
  {
    for(i in 1:length(new_rulefile$PreKlassennamen))
    {
      if(paste(new_rulefile$PreKlassennamen[i])==paste(selected))
      {
        if(i==AnzahlVorklassen)
        {
          sendSweetAlert(session, title = paste("Klasse ",selected," ist bereits an letzer Position.",sep=""), type = "warning")
        }else{
          lowerclass <- new_rulefile$PreKlassennamen[i+1]
          lowerclasscond <- new_rulefile$PreKlassenbedingungen[i+1]
          new_rulefile$PreKlassennamen[i+1]  <- new_rulefile$PreKlassennamen[i]
          new_rulefile$PreKlassenbedingungen[i+1] <-new_rulefile$PreKlassenbedingungen[i]
          new_rulefile$PreKlassennamen[i]  <- lowerclass
          new_rulefile$PreKlassenbedingungen[i] <-lowerclasscond 
          selected <- "ist bereits erledigt"
          output$Vorklassen <- renderUI( 
            {
              lapply(1:AnzahlVorklassen, function(j)
              {
                list( div(style="display: inline-block;vertical-align:top; width: 20%;", textInput(inputId = paste("Vorklasse",j,sep=""),label = NULL, value = new_rulefile$PreKlassennamen[j])), 
                      div(style="display: inline-block;vertical-align:top; width: 75%;", textInput(inputId = paste("PreBedingung",j,sep=""), label = NULL, value = new_rulefile$PreKlassenbedingungen[j], width = 1000)))
                
              })
            })
        }
      }
    }
  }
  safewrite.csv(new_rulefile, "05 - Scripts/Rulefiles/current_rulefile.csv", rownames = FALSE)
  
})








#open a rulefile
observeEvent(input$openRulefile,{
  Pfad <- choose.files(caption = "Rulefile auswählen",default =paste0(getwd(), "/02 - Rulefiles/*.csv"), filters = c("CSV Files (*.csv)","*.csv"),index = 1,multi = FALSE)
  Datapath.location.Rulefileedit(Pfad)
  if(length(Pfad)!=0)
  {
    Ierror <-  tryCatch(
      {
        currentRulefile <- read.csv(Pfad, header = TRUE, sep = ";", dec = ",", fileEncoding = "ISO-8859-1")
        #currentRulefile <- read.csv2("02 - Rulefiles/neu.csv", header = TRUE)
        Ierror <- 0
      }
      ,
      error=function(cond)
      {
        sendSweetAlert(session, title = paste("Kann Datei ",Pfad," nicht öffnen.",sep=""), type = "warning")
        return(1)
      }
      , 
      warning=function(cond)
      {
        sendSweetAlert(session, title = paste("Kann Datei ",Pfad," nicht öffnen.",sep=""), type = "warning")
        return(1)
        
      }
    )
    
    if(Ierror==0)
    {
      Ierror <- safewrite.csv(currentRulefile, "05 - Scripts/Rulefiles/current_rulefile.csv", rownames = FALSE)
      if(Ierror==0)
      {
        if(length(currentRulefile$Klassenname)!=0&&length(currentRulefile$Klassenbedingung)!=0&&length(currentRulefile$PreKlassennamen)!=0&&length(currentRulefile$PreKlassenbedingungen)!=0)
        {
          
          
          
          
          AnzahlHauptklassen <- 0
          for(i in 1:length(currentRulefile$Klassenname)) #Bestimmt die Anzahl an Klassen
          {
            if(paste(currentRulefile[i,1])!=""&& paste(currentRulefile[i,1])!="NA")
            {
              AnzahlHauptklassen <- AnzahlHauptklassen+1
            }
          }
          if(is.na(currentRulefile[1,1]))
          {
            AnzahlHauptklassen <- 0
          }
          
          
          updateNumericInput(inputId = "AnzahlHauptklassen", value = AnzahlHauptklassen)
          output$Hauptklassen <- renderUI( 
            {
              lapply(1:AnzahlHauptklassen, function(i)
              {
                list( div(style="display: inline-block;vertical-align:top; width: 20%;", textInput(inputId = paste("Hauptklasse",i,sep=""),label = NULL, value = currentRulefile$Klassenname[i])), 
                      div(style="display: inline-block;vertical-align:top; width: 75%;", textInput(inputId = paste("Bedingung",i,sep=""), label = NULL, value = currentRulefile$Klassenbedingung[i], width = 1000)))
                
              })
            })
          if(length(currentRulefile$PreKlassennamen)>0)
          {
            PreRulefile <- data.frame(currentRulefile$PreKlassennamen,currentRulefile$PreKlassenbedingungen)
            
            AnzahlPreklassen <- 0
            for(i in 1:length(PreRulefile$currentRulefile.PreKlassennamen)) #Bestimmt die Anzahl an PreKlassen
            {
              if(paste(PreRulefile[i,1])!="" && paste(currentRulefile[i,1])!="NA")
              {
                
                AnzahlPreklassen <- AnzahlPreklassen+1
              }
            }
            if(is.na(PreRulefile[1,1]))
            {
              AnzahlPreklassen <- 0
            }
            if(AnzahlPreklassen==0)
            {
              output$Vorklassen <- renderUI({h5("Keine Vorklassen vorhanden.")})
            }else{
              updateNumericInput(inputId = "AnzahlVorklassen", value = AnzahlPreklassen)
              output$Vorklassen <- renderUI( 
                {
                  
                  lapply(1:AnzahlPreklassen, function(i)
                  {
                    list( div(style="display: inline-block;vertical-align:top; width: 20%;", textInput(inputId = paste("Vorklasse",i,sep=""),label = NULL, value = currentRulefile$PreKlassennamen[i])), 
                          div(style="display: inline-block;vertical-align:top; width: 70%;", textInput(inputId = paste("PreBedingung",i,sep=""), label = NULL, value = currentRulefile$PreKlassenbedingungen[i], width = 1000)))
                    
                  })
                })
            }#close else
          }
          
        }else{sendSweetAlert(session, title = "Ausgewählte Datei hat kein gültiges Format.", type = "error")
          Datapath.location.Rulefileedit("Kein Rulefile ausgewählt.")
        } 
        
      }
    }
  }
  
  
})


#number of pre classes
observeEvent(input$AnzahlVorklassen, {
  req(iv_RulefileEditor$is_valid())
  req(input$AnzahlVorklassen)
  
  tryCatch(
    {
      currentRulefile <- read.csv("05 - Scripts/Rulefiles/current_rulefile.csv", header = TRUE, dec = ",", sep = ";",fileEncoding = "ISO-8859-1")
    }
    ,
    error=function(cond)
    {
      
      
    }
    , 
    warning=function(cond)
    {
      
      
    }
  )
  
  
  AnzahlPreklassen <- input$AnzahlVorklassen
  if(AnzahlPreklassen==0)
  {
    output$Vorklassen <- renderUI(h5("Keine Vorklassen vorhanden."))
  }
  else{
    output$Vorklassen <- renderUI( 
      {
        lapply(1:AnzahlPreklassen, function(i)
        {
          list( div(style="display: inline-block;vertical-align:top; width: 20%;", textInput(inputId = paste("Vorklasse",i,sep=""),label = NULL, value = currentRulefile$PreKlassennamen[i])), 
                div(style="display: inline-block;vertical-align:top; width: 70%;", textInput(inputId = paste("PreBedingung",i,sep=""), label = NULL, value = currentRulefile$PreKlassenbedingungen[i], width = 1000)))
          
        })
      })
    
  }
  
})

#number of main classes
observeEvent(input$AnzahlHauptklassen, {
  req(iv_RulefileEditor$is_valid())
  req(input$AnzahlHauptklassen)
  tryCatch(
    {
      currentRulefile <- read.csv("05 - Scripts/Rulefiles/current_rulefile.csv", header = TRUE, dec = ",", sep = ";",fileEncoding = "ISO-8859-1")
    }
    ,
    error=function(cond)
    {
      
      
    }
    , 
    warning=function(cond)
    {
      
      
    }
  )
  
  
  AnzahlHauptklassen <- input$AnzahlHauptklassen
  if(AnzahlHauptklassen==0)
  {
    output$Hauptklassen <- renderUI(h5("Keine Hauptklassen vorhanden."))
  }
  else{
    output$Hauptklassen <- renderUI( 
      {
        lapply(1:AnzahlHauptklassen, function(i)
        {
          list( div(style="display: inline-block;vertical-align:top; width: 20%;", textInput(inputId = paste("Hauptklasse",i,sep=""),label = NULL, value = currentRulefile$Klassenname[i])), 
                div(style="display: inline-block;vertical-align:top; width: 70%;", textInput(inputId = paste("Bedingung",i,sep=""), label = NULL, value = currentRulefile$Klassenbedingung[i], width = 1000)))
          
        })
      })
    
  }
  
})
#confirm to save current rulefile
observeEvent(input$saveRulefile,{
  req(iv_RulefileEditor$is_valid())
  if(Datapath.location.Rulefileedit()=="Kein Rulefile ausgewählt.")
  {sendSweetAlert(session, title = "Keine Rulefile ausgewählt. Bitte Funktion 'Speichern unter' nutzen.", type = "warning")}else{
    confirmSweetAlert(session, inputId = "Confirm.save.Rulefile", title = paste("Aktuell geladenes Rulefile überschreiben?"), type = "question", btn_labels = c("Nein","Ja"),  width = 1200)
  }
})

#save current rulefile
observeEvent(input$Confirm.save.Rulefile,{
  req(iv_RulefileEditor$is_valid())
  if(isTRUE(input$Confirm.save.Rulefile))
  {
    AnzahlVorklassen <- input$AnzahlVorklassen
    AnzahlHauptklassen <- input$AnzahlHauptklassen 
    Klassenname <- NULL
    Klassenbedingung <- NULL
    PreKlassennamen <- NULL 
    PreKlassenbedingungen <-NULL
    Hauptklassen <- paste("Hauptklasse",1:AnzahlHauptklassen,sep="")
    Hauptklassenbedingungen <- paste("Bedingung",1:AnzahlHauptklassen,sep="")
    Vorklassen <- paste("Vorklasse",1:AnzahlVorklassen,sep="")
    Vorklassenbedingungen <- paste("PreBedingung",1:AnzahlVorklassen,sep="")
    new_rulefile <- data.frame(Klassenname,Klassenbedingung,PreKlassennamen, PreKlassenbedingungen )
    for(i in 1:AnzahlHauptklassen)
    {
      new_rulefile[i,1] <- input[[Hauptklassen[i]]]
      new_rulefile[i,2] <- input[[Hauptklassenbedingungen[i]]]
    }
    
    for(i in 1:AnzahlVorklassen)
    {
      new_rulefile[i,3] <- input[[Vorklassen[i]]]
      new_rulefile[i,4] <- input[[Vorklassenbedingungen[i]]]
    }
    
    names <- c("Klassenname", "Klassenbedingung", "PreKlassennamen", "PreKlassenbedingungen")
    colnames(new_rulefile) <- names
    groesse <- dim(new_rulefile)
    for(i in 1:groesse[1])
    {
      for(j in 1:groesse[2])
      {
        if(is.na(new_rulefile[i,j]))
        {
          new_rulefile[i,j] <- ""
        }
      }
    }
    
    Ierror <- safewrite.csv(new_rulefile,Datapath.location.Rulefileedit(), rownames = FALSE)
    safewrite.csv(new_rulefile, "05 - Scripts/Rulefiles/current_rulefile.csv", rownames = FALSE)
    if(Ierror==0)
    {
      sendSweetAlert(session, title = "Rulefile erfolgreich gespeichert.", type = "success")
    }
  } 
  
})


#confirm to save current rulefile as...
observeEvent(input$saveasRulefile, 
             { req(iv_RulefileEditor$is_valid())
               inputSweetAlert(inputId = "Dateiname.Rulefile", title = "Bitte Dateinamen angeben.", type = "info",session)})





#collecting new filename and save
observeEvent(input$Dateiname.Rulefile,{
  if(input$Dateiname.Rulefile!="")
  {
    name <- input$Dateiname.Rulefile
    
    Ierror <- tryCatch(
      {
        test <- read.csv(paste("02 - Rulefiles/",name,".csv", sep=""), header = TRUE, dec=",", sep=";",fileEncoding = "ISO-8859-1")
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
    if(Ierror==0)
    {
      confirmSweetAlert(session, inputId = "Confirm.overwrite.Rulefile", title = paste("Datei bereits vorhanden. Überschreiben?"), type = "question", btn_labels = c("Nein","Ja"),  width = 1200)
    }else{
      
      
      
      
      
      AnzahlVorklassen <- input$AnzahlVorklassen
      AnzahlHauptklassen <- input$AnzahlHauptklassen 
      Klassenname <- NULL
      Klassenbedingung <- NULL
      PreKlassennamen <- NULL 
      PreKlassenbedingungen <-NULL
      Hauptklassen <- paste("Hauptklasse",1:AnzahlHauptklassen,sep="")
      Hauptklassenbedingungen <- paste("Bedingung",1:AnzahlHauptklassen,sep="")
      Vorklassen <- paste("Vorklasse",1:AnzahlVorklassen,sep="")
      Vorklassenbedingungen <- paste("PreBedingung",1:AnzahlVorklassen,sep="")
      new_rulefile <- data.frame(Klassenname,Klassenbedingung,PreKlassennamen, PreKlassenbedingungen )
      for(i in 1:AnzahlHauptklassen)
      {
        new_rulefile[i,1] <- input[[Hauptklassen[i]]]
        new_rulefile[i,2] <- input[[Hauptklassenbedingungen[i]]]
      }
      
      for(i in 1:AnzahlVorklassen)
      {
        new_rulefile[i,3] <- input[[Vorklassen[i]]]
        new_rulefile[i,4] <- input[[Vorklassenbedingungen[i]]]
      }
      
      names <- c("Klassenname", "Klassenbedingung", "PreKlassennamen", "PreKlassenbedingungen")
      colnames(new_rulefile) <- names
      #entfernen der NAs
      groesse <- dim(new_rulefile)
      for(i in 1:groesse[1])
      {
        for(j in 1:groesse[2])
        {
          if(is.na(new_rulefile[i,j]))
          {
            new_rulefile[i,j] <- ""
          }
        }
        
      }
      Ierror <- safewrite.csv(new_rulefile,filename = paste("02 - Rulefiles/",name,".csv", sep=""), rownames = FALSE)
      safewrite.csv(new_rulefile, "05 - Scripts/Rulefiles/current_rulefile.csv", rownames = FALSE)
      if(Ierror==0)
      {
        sendSweetAlert(session, title = "Rulefile erfolgreich gespeichert.", type = "success")
      }
    } 
  }
})

#if rulefile is aleady existing conform overwriting followed by saving
observeEvent(input$Confirm.overwrite.Rulefile,{
  if(isTRUE(input$Confirm.overwrite.Rulefile))
  {
    name <- input$Dateiname.Rulefile
    AnzahlVorklassen <- input$AnzahlVorklassen
    AnzahlHauptklassen <- input$AnzahlHauptklassen 
    Klassenname <- NULL
    Klassenbedingung <- NULL
    PreKlassennamen <- NULL 
    PreKlassenbedingungen <-NULL
    Hauptklassen <- paste("Hauptklasse",1:AnzahlHauptklassen,sep="")
    Hauptklassenbedingungen <- paste("Bedingung",1:AnzahlHauptklassen,sep="")
    Vorklassen <- paste("Vorklasse",1:AnzahlVorklassen,sep="")
    Vorklassenbedingungen <- paste("PreBedingung",1:AnzahlVorklassen,sep="")
    new_rulefile <- data.frame(Klassenname,Klassenbedingung,PreKlassennamen, PreKlassenbedingungen )
    for(i in 1:AnzahlHauptklassen)
    {
      new_rulefile[i,1] <- input[[Hauptklassen[i]]]
      new_rulefile[i,2] <- input[[Hauptklassenbedingungen[i]]]
    }
    
    for(i in 1:AnzahlVorklassen)
    {
      new_rulefile[i,3] <- input[[Vorklassen[i]]]
      new_rulefile[i,4] <- input[[Vorklassenbedingungen[i]]]
    }
    
    names <- c("Klassenname", "Klassenbedingung", "PreKlassennamen", "PreKlassenbedingungen")
    colnames(new_rulefile) <- names
    #entfernen der NAs
    groesse <- dim(new_rulefile)
    for(i in 1:groesse[1])
    {
      for(j in 1:groesse[2])
      {
        if(is.na(new_rulefile[i,j]))
        {
          new_rulefile[i,j] <- ""
        }
      }
      
    }
    Ierror <- safewrite.csv(new_rulefile,filename = paste("02 - Rulefiles/",name,".csv", sep=""), rownames = FALSE)
    safewrite.csv(new_rulefile, "05 - Scripts/Rulefiles/current_rulefile.csv", rownames = FALSE)
    if(Ierror==0)
    {
      sendSweetAlert(session, title = "Rulefile erfolgreich gespeichert.", type = "success")
    }
  } 
})
