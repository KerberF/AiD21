
##Datenbank 
observeEvent(input$updateDatenbank, 
             {
               current <- input$allProjects 
               updateSelectInput(inputId = "allProjects", choices = dir(path = "01 - Projekte"), selected = current)
             })
observeEvent(input$updateDatenbank, 
             {
               current <- input$possibleChargen 
               updateSelectInput(inputId = "possibleChargen", choices = dir(path = paste("01 - Projekte/",input$allProjects,sep="")), selected = current)
             })
observeEvent(input$updateDatenbank, 
             {
               current <- input$possibleVersions 
               allchoices <- NULL
               allchoices = dir(path = paste("01 - Projekte/",input$allProjects,"/",input$possibleChargen,"/Ergebnisse",sep=""))
               for(i in 1:length(allchoices))
               {
                 
                 if(isTRUE(allchoices[i]=="Parameterlog"))
                 {
                   allchoices <- allchoices[-i]
                 }
               }
               updateSelectInput(inputId = "possibleVersions",choices = allchoices, selected = current)               
             })

observeEvent(input$allProjects, 
             {
               updateSelectInput(inputId = "possibleChargen", choices = dir(path = paste("01 - Projekte/",input$allProjects,sep="")))
             })

observeEvent(input$possibleChargen, 
             {
               allchoices <- NULL
               allchoices = dir(path = paste("01 - Projekte/",input$allProjects,"/",input$possibleChargen,"/Ergebnisse",sep=""))
               for(i in 1:length(allchoices))
               {
                 
                 if(isTRUE(allchoices[i]=="Parameterlog"))
                 {
                   allchoices <- allchoices[-i]
                 }
               }
               updateSelectInput(inputId = "possibleVersions",choices = allchoices)               
             })


observeEvent(input$clearall,
             {
               data <- NULL
               output$Table1 <- renderTable(data)
               output$Table2 <- renderTable(data)
               output$Table3 <- renderTable(data)
               output$Table4 <- renderTable(data)
               output$Table5 <- renderTable(data)
               
               
             })

output$ButtonsResulttables <- renderUI( 
  {req(iv_Datenbank$is_valid())
    number <- as.integer(input$Anzahl.Tabellen)
    list(actionBttn(inputId = "updateDatenbank", label = "Datenbank aktualisieren", style = "unite", size = "sm", color = "primary"),
         actionBttn(inputId = "clearall", label = "Alle entfernen", style = "unite", size = "sm", color = "primary"),
         
         lapply(1:number, function(i)
         {
           actionBttn(inputId = paste("loadData",i,sep=""), label = paste("Tabelle ",i,sep=""), style = "unite", size = "sm", color = "primary")
         }))
  })
output$Resulttables <- renderUI( 
  {
    req(iv_Datenbank$is_valid())
    number <- as.integer(input$Anzahl.Tabellen)
    lapply(1:number, function(i)
    {
      tableOutput(outputId = paste("Table",i,sep=""))
    })
  })

observeEvent(input$loadData1,
             {
               Ierror <-  tryCatch(
                 {
                   
                   data <- read.csv2(file = paste("01 - Projekte/",input$allProjects,"/",input$possibleChargen,"/Ergebnisse/",input$possibleVersions,"/Klassierung/Partikelanzahl_flächennormiert_",input$possibleChargen,"_",input$possibleVersions,".csv",sep=""), header = TRUE)
                   Ierror <- 0
                 }
                 ,
                 error=function(cond)
                 {
                   return(1)
                 }
                 , 
                 warning=function(cond)
                 {
                   return(1)
                 }
               ) 
               if(Ierror==1)
               {
                 Ierror <-  tryCatch(
                   {
                     
                     data <- read.csv2(file = paste("01 - Projekte/",input$allProjects,"/",input$possibleChargen,"/Ergebnisse/",input$possibleVersions,"/Zusammensetzung/Partikelanzahl_flächennormiert_",input$possibleChargen,"_",input$possibleVersions,".csv",sep=""), header = TRUE)
                     Ierror <- 0
                   }
                   ,
                   error=function(cond)
                   {
                     sendSweetAlert(session, title = "Kann ausgewählte Datei nicht öffnen.", type = "warning", width = 600)
                     return(1)
                   }
                   , 
                   warning=function(cond)
                   {
                     sendSweetAlert(session, title = "Kann ausgewählte Datei nicht öffnen.", type = "warning", width = 600)
                     return(1)
                     
                   }
                 ) 
               }
               
               
               
               
               if(Ierror==0)
               {
                 names <- colnames(data)
                 names[1] <- paste(input$possibleChargen," - ",input$possibleVersions,sep="")
                 colnames(data) <- names
                 output$Table1 <- renderTable(data)
               }
             })

observeEvent(input$loadData2,
             {
               Ierror <-  tryCatch(
                 {
                   
                   data <- read.csv2(file = paste("01 - Projekte/",input$allProjects,"/",input$possibleChargen,"/Ergebnisse/",input$possibleVersions,"/Klassierung/Partikelanzahl_flächennormiert_",input$possibleChargen,"_",input$possibleVersions,".csv",sep=""), header = TRUE)
                   Ierror <- 0
                 }
                 ,
                 error=function(cond)
                 {
                   return(1)
                 }
                 , 
                 warning=function(cond)
                 {
                   return(1)
                 }
               ) 
               if(Ierror==1)
               {
                 Ierror <-  tryCatch(
                   {
                     
                     data <- read.csv2(file = paste("01 - Projekte/",input$allProjects,"/",input$possibleChargen,"/Ergebnisse/",input$possibleVersions,"/Zusammensetzung/Partikelanzahl_flächennormiert_",input$possibleChargen,"_",input$possibleVersions,".csv",sep=""), header = TRUE)
                     Ierror <- 0
                   }
                   ,
                   error=function(cond)
                   {
                     sendSweetAlert(session, title = "Kann ausgewählte Datei nicht öffnen.", type = "warning", width = 600)
                     return(1)
                   }
                   , 
                   warning=function(cond)
                   {
                     sendSweetAlert(session, title = "Kann ausgewählte Datei nicht öffnen.", type = "warning", width = 600)
                     return(1)
                     
                   }
                 ) 
               }
               
               
               
               
               
               if(Ierror==0)
               {
                 names <- colnames(data)
                 names[1] <- paste(input$possibleChargen," - ",input$possibleVersions,sep="")
                 colnames(data) <- names
                 output$Table2 <- renderTable(data)
               }
             })

observeEvent(input$loadData3,
             {
               Ierror <-  tryCatch(
                 {
                   
                   data <- read.csv2(file = paste("01 - Projekte/",input$allProjects,"/",input$possibleChargen,"/Ergebnisse/",input$possibleVersions,"/Klassierung/Partikelanzahl_flächennormiert_",input$possibleChargen,"_",input$possibleVersions,".csv",sep=""), header = TRUE)
                   Ierror <- 0
                 }
                 ,
                 error=function(cond)
                 {
                   return(1)
                 }
                 , 
                 warning=function(cond)
                 {
                   return(1)
                 }
               ) 
               if(Ierror==1)
               {
                 Ierror <-  tryCatch(
                   {
                     
                     data <- read.csv2(file = paste("01 - Projekte/",input$allProjects,"/",input$possibleChargen,"/Ergebnisse/",input$possibleVersions,"/Zusammensetzung/Partikelanzahl_flächennormiert_",input$possibleChargen,"_",input$possibleVersions,".csv",sep=""), header = TRUE)
                     Ierror <- 0
                   }
                   ,
                   error=function(cond)
                   {
                     sendSweetAlert(session, title = "Kann ausgewählte Datei nicht öffnen.", type = "warning", width = 600)
                     return(1)
                   }
                   , 
                   warning=function(cond)
                   {
                     sendSweetAlert(session, title = "Kann ausgewählte Datei nicht öffnen.", type = "warning", width = 600)
                     return(1)
                     
                   }
                 ) 
               }
               
               
               
               
               
               if(Ierror==0)
               {
                 names <- colnames(data)
                 names[1] <- paste(input$possibleChargen," - ",input$possibleVersions,sep="")
                 colnames(data) <- names
                 output$Table3 <- renderTable(data)
               }
             })

observeEvent(input$loadData4,
             {
               Ierror <-  tryCatch(
                 {
                   
                   data <- read.csv2(file = paste("01 - Projekte/",input$allProjects,"/",input$possibleChargen,"/Ergebnisse/",input$possibleVersions,"/Klassierung/Partikelanzahl_flächennormiert_",input$possibleChargen,"_",input$possibleVersions,".csv",sep=""), header = TRUE)
                   Ierror <- 0
                 }
                 ,
                 error=function(cond)
                 {
                   return(1)
                 }
                 , 
                 warning=function(cond)
                 {
                   return(1)
                 }
               ) 
               if(Ierror==1)
               {
                 Ierror <-  tryCatch(
                   {
                     
                     data <- read.csv2(file = paste("01 - Projekte/",input$allProjects,"/",input$possibleChargen,"/Ergebnisse/",input$possibleVersions,"/Zusammensetzung/Partikelanzahl_flächennormiert_",input$possibleChargen,"_",input$possibleVersions,".csv",sep=""), header = TRUE)
                     Ierror <- 0
                   }
                   ,
                   error=function(cond)
                   {
                     sendSweetAlert(session, title = "Kann ausgewählte Datei nicht öffnen.", type = "warning", width = 600)
                     return(1)
                   }
                   , 
                   warning=function(cond)
                   {
                     sendSweetAlert(session, title = "Kann ausgewählte Datei nicht öffnen.", type = "warning", width = 600)
                     return(1)
                     
                   }
                 ) 
               }
               
               
               
               
               if(Ierror==0)
               {
                 names <- colnames(data)
                 names[1] <- paste(input$possibleChargen," - ",input$possibleVersions,sep="")
                 colnames(data) <- names
                 output$Table4 <- renderTable(data)
               }
             })

observeEvent(input$loadData5,
             {
               Ierror <-  tryCatch(
                 {
                   
                   data <- read.csv2(file = paste("01 - Projekte/",input$allProjects,"/",input$possibleChargen,"/Ergebnisse/",input$possibleVersions,"/Klassierung/Partikelanzahl_flächennormiert_",input$possibleChargen,"_",input$possibleVersions,".csv",sep=""), header = TRUE)
                   Ierror <- 0
                 }
                 ,
                 error=function(cond)
                 {
                   return(1)
                 }
                 , 
                 warning=function(cond)
                 {
                   return(1)
                 }
               ) 
               if(Ierror==1)
               {
                 Ierror <-  tryCatch(
                   {
                     
                     data <- read.csv2(file = paste("01 - Projekte/",input$allProjects,"/",input$possibleChargen,"/Ergebnisse/",input$possibleVersions,"/Zusammensetzung/Partikelanzahl_flächennormiert_",input$possibleChargen,"_",input$possibleVersions,".csv",sep=""), header = TRUE)
                     Ierror <- 0
                   }
                   ,
                   error=function(cond)
                   {
                     sendSweetAlert(session, title = "Kann ausgewählte Datei nicht öffnen.", type = "warning", width = 600)
                     return(1)
                   }
                   , 
                   warning=function(cond)
                   {
                     sendSweetAlert(session, title = "Kann ausgewählte Datei nicht öffnen.", type = "warning", width = 600)
                     return(1)
                     
                   }
                 ) 
               }
               
               
               
               if(Ierror==0)
               {
                 names <- colnames(data)
                 names[1] <- paste(input$possibleChargen," - ",input$possibleVersions,sep="")
                 colnames(data) <- names
                 output$Table5 <- renderTable(data)
               }
             })