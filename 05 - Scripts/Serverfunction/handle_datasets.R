
#generating variable
Datapath.location.Datentitel <- reactiveVal("Keine Datentitel-Datei ausgewählt.")


#browsing a file for datasettitles
observeEvent(input$location.Datentitel,{ 
  
  #Datapath.location.Datentitel("")
  Projekt <- input$Projekt 
  Charge <- input$Charge
  path <- choose.files(caption = "Titel der Messwerte auswählen",default =paste0(getwd(), "/01 - Projekte/",Projekt,"/",Charge,"/Messwerte/*.csv"), filters = cbind(c("CSV Files (*.csv)","Text Files (*.txt)"),c("*.csv","*.txt")),index = 1,multi = FALSE)
  if(length(path)!=0)
  {
    Datapath.location.Datentitel(path) 
  }
  
  
  #updateTextInput(session, "Datapath.location.Datentitel", value = paste(choose.files(caption = "Titel der Messwerte auswählen",default =paste0(getwd(), "/01 - Projekte/",Projekt,"/",Charge,"/Messwerte/*.csv"), filters = cbind(c("CSV Files (*.csv)","Text Files (*.txt)"),c("*.csv","*.txt")),index = 1,multi = FALSE)))
  
})



#updating textbox ouput
observeEvent(Datapath.location.Datentitel(),
             {
               output$outDatapathDatentitel <- renderText(Datapath.location.Datentitel())
             })



#update displayed output based on the selected file --> is triggered by pressing 'Durchsuchen' 
observeEvent(Datapath.location.Datentitel(),
             {
               
               file.Datentitel <- Datapath.location.Datentitel()
               if(length(Datapath.location.Datentitel())==0)
               {}else{
                 output$all.Datasets <- renderUI( 
                   {
                     Ierror <- tryCatch(
                       {
                         Daten.Titel <- read.table(file=file.Datentitel, header=TRUE, dec=",", sep=";", fileEncoding = "ISO-8859-1") 
                         
                         Ierror <- 0
                       },
                       error=function(cond)
                       {
                         return(1)
                       },
                       warning=function(cond)
                       {
                         return(1)
                       }
                       
                     )
                     if(Ierror==0)
                     {
                       sizeTable <- dim(Daten.Titel)
                       Inumber <- length(Daten.Titel$Titel)
                       if(sizeTable[2]==2)
                       {  
                         Aktiv <- paste(rep("TRUE",Inumber))
                         Pfad <- paste(rep("Kein Pfad angegeben.",Inumber))
                         Dateiname <- NULL
                         for(i in 1:sizeTable[1])
                         {
                           Dateiname[i] <- Daten.Titel$Titel[i]
                         }
                         Daten.Titel <- data.frame(Daten.Titel,Aktiv, Pfad, Dateiname)
                       }
                       if(sizeTable[2]==3)
                       {  
                         
                         Pfad <- paste(rep("Kein Pfad angegeben.", Inumber))
                         Dateiname <- NULL
                         for(i in 1:sizeTable[1])
                         {
                           Dateiname[i] <- Daten.Titel$Titel[i]
                         }
                         Daten.Titel <- data.frame(Daten.Titel, Pfad, Dateiname)
                       }
                       if(sizeTable[2]==4)
                       {  
                         Dateiname <- NULL
                         for(i in 1:sizeTable[1])
                         {
                           Dateiname[i] <- Daten.Titel$Titel[i]
                         }
                         Daten.Titel <- data.frame(Daten.Titel, Dateiname)
                       }
                       safewrite.csv(Daten.Titel, filename = paste("05 - Scripts/Datentitel/currrent_data.csv", sep=""),rownames = FALSE)
                       updateSelectInput(session, inputId = "Order.datasets", choices = Daten.Titel$Titel)
                       updateNumericInput(inputId="dummy", value = 1)
                       updateNumericInput(inputId="dummy2", value = 1)
                       lapply(1:Inumber, function(i) 
                       {
                         
                         list( div(style="display: inline-block;vertical-align:top; width: 5%", h5(paste("#",i,":",sep=""))),
                               div(style="display: inline-block;vertical-align:top; width: 25%", h5(paste(Daten.Titel$Dateiname[i],sep=""))),
                               div(style="display: inline-block;vertical-align:top; width: 35%",  textInput(inputId = paste("displayed_titleSample",i,sep=""), label = NULL, value = Daten.Titel$Titel[i])),
                               div(style="display: inline-block;vertical-align:top; width: 3%;",  h5(strong(""))),
                               div(style="display: inline-block;vertical-align:top; width: 10%",  materialSwitch(inputId = paste("Sample",i,sep=""), label = NULL,inline = TRUE,  status = "primary",  value = if(Daten.Titel$Aktiv[i]=="TRUE"){TRUE}else{FALSE})), 
                               div(style="display: inline-block;vertical-align:top; width: 10%;", numericInput(inputId = paste("Area.Sample",i,sep=""),  label = NULL, value = Daten.Titel$Messfläche[i] ,min = 0 )),
                               div(style="display: inline-block;vertical-align:top; width: 3%;",  h5(strong(""))),
                               div(style="display: inline-block;vertical-align:top; width: 5%;", awesomeCheckbox(inputId = paste("remove.Sample",i,sep=""), label = NULL)))
                       })
                       
                     }else{updateNumericInput(inputId="dummy", value = 0) 
                       h5("Keine gültige Datentitel-Datei gewählt bzw. keine Datensätze geladen.")}
                     
                   })
               }
               
             })

#confirm to remove all datasets
observeEvent(input$remove.Datasets, 
             {
               confirmSweetAlert(session, inputId = "confirm.remove.Datasets", title = "Alle Datensätze entfernen?", type = "question", btn_labels = c("Nein","Ja"))
               
             })
#removing if confirmed
observeEvent(input$confirm.remove.Datasets, 
             {
               if(input$confirm.remove.Datasets==TRUE)
               {
                 Titel <- NULL
                 Messfläche <- NULL
                 Aktiv <- NULL
                 Pfad <- NULL
                 Dateiname <- NULL
                 Daten.Titel <- data.frame(Titel, Messfläche, Aktiv, Pfad, Dateiname)
                 safewrite.csv(Daten.Titel, filename = paste("05 - Scripts/Datentitel/currrent_data.csv", sep=""),rownames = FALSE)
                 updateNumericInput(inputId="dummy", value = 0)
                 updateNumericInput(inputId="dummy2", value = 0)
                 updateSelectInput(session, inputId = "Order.datasets", choices = "Keine Datensätze vorhanden")
                 output$all.Datasets <-renderUI(
                   h5("Keine gültige Datentitel-Datei gewählt bzw. keine Datensätze geladen.")
                 ) 
               }
             })

#confirm to remove selected datasets
observeEvent(input$remove.selectedDatasets, 
             {
               confirmSweetAlert(session, inputId = "confirm.remove.selectedDatasets", title = "Ausgewählte Datensätze entfernen?", type = "question", btn_labels = c("Nein","Ja"))
               
             })

#remove selected datasets if confirmed
observeEvent(input$confirm.remove.selectedDatasets, 
             {
               if(input$confirm.remove.selectedDatasets==TRUE)
               {
                 
                 Ierror <-  tryCatch(
                   {
                     
                     Daten.Titel <- read.csv("05 - Scripts/Datentitel/currrent_data.csv", header = TRUE, sep = ";", dec = ",", fileEncoding = "ISO-8859-1")
                     Ierror <- 0
                   }
                   ,
                   error=function(cond)
                   {
                     sendSweetAlert(session, title = "Keine Datensätze ausgewählt.", type = "warning")
                     return(1)
                   }
                   , 
                   warning=function(cond)
                   {
                     sendSweetAlert(session, title = "Keine Datensätze ausgewählt.", type = "warning")
                     return(1)
                     
                   }
                 )
                 if(Ierror==0)
                 {
                   
                   Inumber <- length(Daten.Titel$Titel)
                   
                   Samples <- paste("Sample",1:Inumber,sep="")
                   Area.Samples <- paste("Area.Sample",1:Inumber,sep="")
                   displayed_title <- paste("displayed_titleSample",1:Inumber,sep="")
                   
                   for(i in 1:Inumber)
                   {
                     Daten.Titel$Aktiv[i] <- input[[Samples[i]]]
                     Daten.Titel$Messfläche[i] <-  input[[Area.Samples[i]]]
                     Daten.Titel$Titel[i] <- input[[displayed_title[i]]]
                   }
                   
                   
                   
                   Samples <- paste("remove.Sample",1:Inumber,sep = "")
                   to.remove <- NULL
                   for(i in 1:Inumber)
                   {
                     if(input[[Samples[i]]]==TRUE)
                     {
                       to.remove <- c(to.remove,i)
                     }
                   }
                   if(is.null(to.remove))
                   {
                     sendSweetAlert(session, title = "Keine Datensätze ausgewählt.", type = "warning")
                   }else{
                     
                     Daten.Titel <- Daten.Titel[-(to.remove),]
                     if(length(Daten.Titel$Titel)>=1)
                     {
                       
                       Inumber <- length(Daten.Titel$Titel)
                       safewrite.csv(Daten.Titel, filename = paste("05 - Scripts/Datentitel/currrent_data.csv", sep=""),rownames = FALSE)
                       updateSelectInput(session, inputId = "Order.datasets", choices = Daten.Titel$Titel)
                       updateNumericInput(inputId="dummy", value = 1)
                       updateNumericInput(inputId="dummy2", value = 1)
                       output$all.Datasets <- renderUI(
                         {
                           lapply(1:Inumber, function(i) 
                           {
                             
                             list( div(style="display: inline-block;vertical-align:top; width: 5%", h5(paste("#",i,":",sep=""))),
                                   div(style="display: inline-block;vertical-align:top; width: 25%", h5(paste(Daten.Titel$Dateiname[i],sep=""))),
                                   div(style="display: inline-block;vertical-align:top; width: 35%",  textInput(inputId = paste("displayed_titleSample",i,sep=""), label = NULL, value = Daten.Titel$Titel[i])),
                                   div(style="display: inline-block;vertical-align:top; width: 3%;",  h5(strong(""))),
                                   div(style="display: inline-block;vertical-align:top; width: 10%",  materialSwitch(inputId = paste("Sample",i,sep=""), label = NULL,inline = TRUE,  status = "primary",  value = if(Daten.Titel$Aktiv[i]=="TRUE"){TRUE}else{FALSE})), 
                                   div(style="display: inline-block;vertical-align:top; width: 10%;", numericInput(inputId = paste("Area.Sample",i,sep=""),  label = NULL, value = Daten.Titel$Messfläche[i] ,min = 0 )),
                                   div(style="display: inline-block;vertical-align:top; width: 3%;",  h5(strong(""))),
                                   div(style="display: inline-block;vertical-align:top; width: 5%;", awesomeCheckbox(inputId = paste("remove.Sample",i,sep=""), label = NULL)))
                           })       
                         }) 
                     }else{
                       Titel <- NULL
                       Messfläche <- NULL
                       Aktiv <- NULL
                       Pfad <- NULL 
                       Dateiname <- NULL
                       Daten.Titel <- data.frame(Titel, Messfläche, Aktiv, Pfad, Dateiname)
                       safewrite.csv(Daten.Titel, filename = paste("05 - Scripts/Datentitel/currrent_data.csv", sep=""),rownames = FALSE)
                       updateNumericInput(inputId="dummy", value = 0)
                       updateNumericInput(inputId="dummy2", value = 0)
                       updateSelectInput(session, inputId = "Order.datasets", choices = "Keine Datensätze vorhanden")
                       output$all.Datasets <-renderUI(
                         h5("Keine gültige Datentitel-Datei gewählt bzw. keine Datensätze geladen.")
                       ) 
                     }
                   }
                   
                 }}
               
             }
)


#add a new dataset and update the displayed output 
observeEvent(input$add.Daten, 
             {
               
               tryCatch(
                 {
                   Daten.Titel <- read.csv("05 - Scripts/Datentitel/currrent_data.csv", header = TRUE, sep = ";", dec = ",", fileEncoding = "ISO-8859-1")
                 }
                 ,
                 error=function(cond)
                 {
                   Titel <- NULL
                   Messfläche <- NULL
                   Aktiv <- NULL
                   Pfad <- NULL 
                   Dateiname <- NULL
                   Daten.Titel <- data.frame(Titel, Messfläche, Aktiv, Pfad, Dateiname)
                   
                 }
                 , 
                 warning=function(cond)
                 {
                   Titel <- NULL
                   Messfläche <- NULL
                   Aktiv <- NULL
                   Pfad <- NULL 
                   Dateiname <- NULL
                   Daten.Titel <- data.frame(Titel, Messfläche, Aktiv, Pfad, Dateiname)
                   
                 }
               )
               if(length(Daten.Titel$Titel!=0))
               {
                 Inumber <- length(Daten.Titel$Titel)
                 
                 Samples <- paste("Sample",1:Inumber,sep="")
                 Area.Samples <- paste("Area.Sample",1:Inumber,sep="")
                 displayed_title <- paste("displayed_titleSample",1:Inumber,sep="")
                 
                 for(i in 1:Inumber)
                 {
                   Daten.Titel$Aktiv[i] <- input[[Samples[i]]]
                   Daten.Titel$Messfläche[i] <-  input[[Area.Samples[i]]]
                   Daten.Titel$Titel[i] <- input[[displayed_title[i]]]
                 }
               }
               
               Projekt <- input$Projekt
               Charge <- input$Charge
               Pfade <- choose.files(caption = "Messdaten auswählen",default =paste0(getwd(), "/01 - Projekte/",Projekt,"/",Charge,"/Messwerte/*.csv"), filters = cbind(c("CSV Files (*.csv)","Text Files (*.txt)"),c("*.csv","*.txt")),index = 1,multi = TRUE)
               SnamesSamples  <- NULL 
               if(length(Pfade)!=0)
               {
                 InumberFiles <- length(Pfade)
                 
                 for(i in 1:InumberFiles)
                 {
                   Snamesplitted <- unlist(strsplit(Pfade[i], split = "\\\\"))
                   last <- length(Snamesplitted)
                   Snamesplitted[last] <- gsub(".csv","",Snamesplitted[last]) 
                   SnamesSamples[i]<-Snamesplitted[last]  
                 }
                 
                 Titel <- SnamesSamples
                 Messfläche <- rep(0, InumberFiles)
                 Aktiv <- rep("TRUE", InumberFiles)
                 Pfad <- Pfade
                 Dateiname <- SnamesSamples
                 
                 #Hinzufügen von neu eingelesenen Daten zu Datentitel 
                 addDatentitel <- data.frame(Titel, Messfläche, Aktiv, Pfad, Dateiname)
                 Daten.Titel <- rbind(Daten.Titel, addDatentitel) 
                 Inumber <- length(Daten.Titel$Titel)
                 if(isTRUE(grepl(".csv",Datapath.location.Datentitel())))
                 {
                   
                   
                 }
                 #Zwischenablage
                 safewrite.csv(Daten.Titel, filename = paste("05 - Scripts/Datentitel/currrent_data.csv", sep=""),rownames = FALSE)
                 updateSelectInput(session, inputId = "Order.datasets", choices = Daten.Titel$Titel)
                 updateNumericInput(inputId="dummy", value = 1)
                 updateNumericInput(inputId="dummy2", value = 1)
                 output$all.Datasets <- renderUI(
                   {
                     lapply(1:Inumber, function(i) 
                     {
                       
                       list( div(style="display: inline-block;vertical-align:top; width: 5%", h5(paste("#",i,":",sep=""))),
                             div(style="display: inline-block;vertical-align:top; width: 25%", h5(paste(Daten.Titel$Dateiname[i],sep=""))),
                             div(style="display: inline-block;vertical-align:top; width: 35%",  textInput(inputId = paste("displayed_titleSample",i,sep=""), label = NULL, value = Daten.Titel$Titel[i])),
                             div(style="display: inline-block;vertical-align:top; width: 3%;",  h5(strong(""))),
                             div(style="display: inline-block;vertical-align:top; width: 10%",  materialSwitch(inputId = paste("Sample",i,sep=""), label = NULL,inline = TRUE,  status = "primary",  value = if(Daten.Titel$Aktiv[i]=="TRUE"){TRUE}else{FALSE})), 
                             div(style="display: inline-block;vertical-align:top; width: 10%;", numericInput(inputId = paste("Area.Sample",i,sep=""),  label = NULL, value = Daten.Titel$Messfläche[i] ,min = 0 )),
                             div(style="display: inline-block;vertical-align:top; width: 3%;",  h5(strong(""))),
                             div(style="display: inline-block;vertical-align:top; width: 5%;", awesomeCheckbox(inputId = paste("remove.Sample",i,sep=""), label = NULL)))
                       
                     })       
                   })
                 
               }#else{ output$all.Datasets <- renderUI(h5("Keine gültige Datentitel-Datei gewählt bzw. keine Datensätze geladen."))}
               
               
             })







#save current datasets and areas as a file, asking for filename --> save as 
observeEvent(input$save.new.Datentitel, 
             { inputSweetAlert(inputId = "Dateiname.Datentitel", title = "Bitte Dateinamen angeben.", type = "info",session)})
#actual saving after getting a filename 
observeEvent(input$Dateiname.Datentitel, 
             {
               if(input$Dateiname.Datentitel!="")
               {
                 Name <- input$Dateiname.Datentitel
                 Projekt <- input$Projekt
                 Charge <- input$Charge
                 Speicherort <- choose.dir(caption = "Bitte einen Speicherort wählen", default = paste(getwd(),"/01 - Projekte/",Projekt,"/",Charge,"/Messwerte/",sep=""))
                 if(!is.na(Speicherort))
                 {
                   Speicherort <- paste(Speicherort,"\\",Name,".csv", sep="")
                   
                   Ierror <-  tryCatch(
                     {
                       
                       Daten.Titel <- read.csv("05 - Scripts/Datentitel/currrent_data.csv", header = TRUE, sep = ";", dec = ",", fileEncoding = "ISO-8859-1")
                       Ierror <- 0
                     }
                     ,
                     error=function(cond)
                     {
                       sendSweetAlert(session, title = "Keine Datensätze vorhanden.", type = "warning")
                       return(1)
                     }
                     , 
                     warning=function(cond)
                     {
                       sendSweetAlert(session, title = "Keine Datensätze vorhanden.", type = "warning")
                       return(1)
                       
                     }
                   )
                   if(Ierror==0)
                   {
                     
                     Inumber <- length(Daten.Titel$Titel)
                     
                     Samples <- paste("Sample",1:Inumber,sep="")
                     Area.Samples <- paste("Area.Sample",1:Inumber,sep="")
                     displayed_title <- paste("displayed_titleSample",1:Inumber,sep="")
                     
                     for(i in 1:Inumber)
                     {
                       Daten.Titel$Aktiv[i] <- input[[Samples[i]]]
                       Daten.Titel$Messfläche[i] <-  input[[Area.Samples[i]]]
                       Daten.Titel$Titel[i] <- input[[displayed_title[i]]]
                     }
                     
                     Ierror <-    safewrite.csv(Daten.Titel, filename = Speicherort, rownames = FALSE) 
                     
                     if(Ierror==0)
                     {
                       Datapath.location.Datentitel(paste("Leer"))
                       Datapath.location.Datentitel(paste(Speicherort))
                       sendSweetAlert(session, title = "Datentitel erfolreich gespeichert.", type = "success")
                     }
                     
                   }
                   
                 }
               }
               
             })
#add current datasets to an existing dataset-file
observeEvent(input$add.old.Datentitel, 
             {
               
               Projekt <- input$Projekt 
               Charge <- input$Charge
               add.to.Datentitel <- choose.files(caption = "Titel der Messwerte auswählen",default =paste0(getwd(), "/01 - Projekte/",Projekt,"/",Charge,"/Messwerte/*.csv"), filters = cbind(c("CSV Files (*.csv)","Text Files (*.txt)"),c("*.csv","*.txt")),index = 1,multi = FALSE)
               if(length(add.to.Datentitel)!=0)
               {
                 Ierror <-  tryCatch(
                   {
                     add.Daten.Titel <- read.csv("05 - Scripts/Datentitel/currrent_data.csv", header = TRUE, sep = ";", dec = ",", fileEncoding = "ISO-8859-1")
                     Ierror <- 0
                   }
                   ,
                   error=function(cond)
                   {
                     sendSweetAlert(session, title = "Keine Datensätze vorhanden.", type = "warning")
                     return(1)
                   }
                   , 
                   warning=function(cond)
                   {
                     sendSweetAlert(session, title = "Keine Datensätze vorhanden.", type = "warning")
                     return(1)
                     
                   }
                 ) 
                 if(Ierror==0)
                 {
                   Ierror <-  tryCatch(
                     {
                       
                       old.Daten.Titel <- read.csv(add.to.Datentitel, header = TRUE, sep=";", dec = ",", fileEncoding = "ISO-8859-1")
                       Ierror <- 0
                     }
                     ,
                     error=function(cond)
                     {
                       sendSweetAlert(session, title = paste("Datei ",add.to.Datentitel," nicht lesbar.",sep=""), type = "warning", width = 1500)
                       return(1)
                     }
                     , 
                     warning=function(cond)
                     {
                       sendSweetAlert(session, title = paste("Datei ",add.to.Datentitel," nicht lesbar.",sep=""), type = "warning", width = 1500)
                       return(1)
                       
                     }
                   ) 
                   if(Ierror==0)
                   {
                     #add Spalten, falls diese fehlen
                     sizeTable <- dim(old.Daten.Titel)
                     if(length(old.Daten.Titel$Titel)==0)
                     {sendSweetAlert(session, title = "Keine gültige Datentitel-Datei ausgewählt.", type = "warning")}
                     else{
                       
                       Inumber <- length(old.Daten.Titel$Titel)
                       if(sizeTable[2]==2)
                       {  
                         Aktiv <- paste(rep("TRUE",Inumber))
                         Pfad <- paste(rep("Kein Pfad angegeben.",Inumber))
                         Dateiname <- NULL
                         for(i in 1:sizeTable[1])
                         {
                           Dateiname[i] <- old.Daten.Titel$Titel[i]
                         }
                         old.Daten.Titel <- data.frame(old.Daten.Titel,Aktiv, Pfad, Dateiname)
                       }
                       if(sizeTable[2]==3)
                       {  
                         
                         Pfad <- paste(rep("Kein Pfad angegeben.", Inumber))
                         Dateiname <- NULL
                         for(i in 1:sizeTable[1])
                         {
                           Dateiname[i] <- old.Daten.Titel$Titel[i]
                         }
                         old.Daten.Titel <- data.frame(old.Daten.Titel, Pfad, Dateiname)
                       }
                       if(sizeTable[2]==4)
                       {  
                         
                         
                         Dateiname <- NULL
                         for(i in 1:sizeTable[1])
                         {
                           Dateiname[i] <- old.Daten.Titel$Titel[i]
                         }
                         old.Daten.Titel <- data.frame(old.Daten.Titel,  Dateiname)
                       }
                       
                       
                       Inumber <- length(add.Daten.Titel$Titel)
                       
                       Samples <- paste("Sample",1:Inumber,sep="")
                       Area.Samples <- paste("Area.Sample",1:Inumber,sep="")
                       displayed_title <- paste("displayed_titleSample",1:Inumber,sep="")
                       
                       for(i in 1:Inumber)
                       {
                         add.Daten.Titel$Aktiv[i] <- input[[Samples[i]]]
                         add.Daten.Titel$Messfläche[i] <-  input[[Area.Samples[i]]]
                         add.Daten.Titel$Titel[i] <- input[[displayed_title[i]]]
                       }
                       
                       
                       Daten.Titel <- rbind(old.Daten.Titel, add.Daten.Titel)
                       Ierror <-    safewrite.csv(Daten.Titel, filename = add.to.Datentitel, rownames = FALSE)
                       
                       if(Ierror==0)
                       {
                         Datapath.location.Datentitel(paste("Leer"))
                         Datapath.location.Datentitel(paste(add.to.Datentitel))
                         sendSweetAlert(session, title = "Datentitel erfolreich gespeichert.", type = "success")
                       }
                       
                     }
                   }}
               }
             }
)
#save current datasets with the filename and directory given in the textbox above 
observeEvent(input$save.old.Datentitel,
             {
               if(length(Datapath.location.Datentitel())!=0 && Datapath.location.Datentitel()!="Keine Datentitel-Datei ausgewählt.")
               {
                 file.Datentitel <- Datapath.location.Datentitel()
                 
                 Ierror <-  tryCatch(
                   {
                     
                     add.Daten.Titel <- read.csv("05 - Scripts/Datentitel/currrent_data.csv", header = TRUE, sep = ";", dec = ",", fileEncoding = "ISO-8859-1")
                     Ierror <- 0
                   }
                   ,
                   error=function(cond)
                   {
                     sendSweetAlert(session, title = "Keine Datensätze vorhanden.", type = "warning", width = 1500)
                     return(1)
                   }
                   , 
                   warning=function(cond)
                   {
                     sendSweetAlert(session, title = "Keine Datensätze vorhanden.", type = "warning", width = 1500)
                     return(1)
                     
                   }
                 ) 
                 
                 if(Ierror==0)
                 {
                   #add Spalten, falls diese fehlen
                   
                   
                   
                   Inumber <- length(add.Daten.Titel$Titel)
                   
                   Samples <- paste("Sample",1:Inumber,sep="")
                   Area.Samples <- paste("Area.Sample",1:Inumber,sep="")
                   displayed_title <- paste("displayed_titleSample",1:Inumber,sep="")
                   
                   for(i in 1:Inumber)
                   {
                     add.Daten.Titel$Aktiv[i] <- input[[Samples[i]]]
                     add.Daten.Titel$Messfläche[i] <-  input[[Area.Samples[i]]]
                     add.Daten.Titel$Titel[i] <- input[[displayed_title[i]]]
                   }
                   
                   
                   
                   
                   
                   
                   
                   Ierror <-  safewrite.csv(add.Daten.Titel, filename = file.Datentitel, rownames = FALSE)
                   
                   if(Ierror==0)
                   {
                     Datapath.location.Datentitel(paste("Leer"))
                     Datapath.location.Datentitel(paste(file.Datentitel))
                     sendSweetAlert(session, title = "Datentitel erfolreich gespeichert.", type = "success")
                   }
                 }
                 
               }else{sendSweetAlert(session, title = "Keine Datentitel-Datei ausgewählt.", type = "warning")}
             })




#set all datasets as 'active'
observeEvent(input$all.active,
             {
               Ierror <-  tryCatch(
                 {
                   
                   Daten.Titel <- read.csv("05 - Scripts/Datentitel/currrent_data.csv", header = TRUE, sep = ";", dec = ",", fileEncoding = "ISO-8859-1")
                   Ierror <- 0
                 }
                 ,
                 error=function(cond)
                 {
                   sendSweetAlert(session, title = "Keine Datensätze vorhanden.", type = "warning", width = 1500)
                   return(1)
                 }
                 , 
                 warning=function(cond)
                 {
                   sendSweetAlert(session, title = "Keine Datensätze vorhanden.", type = "warning", width = 1500)
                   return(1)
                   
                 }
               ) 
               
               if(Ierror==0)
               {
                 #add Spalten, falls diese fehlen
                 
                 
                 
                 Inumber <- length(Daten.Titel$Titel)
                 
                 Samples <- paste("Sample",1:Inumber,sep="")
                 Area.Samples <- paste("Area.Sample",1:Inumber,sep="")
                 displayed_title <- paste("displayed_titleSample",1:Inumber,sep="")
                 
                 for(i in 1:Inumber)
                 {
                   Daten.Titel$Aktiv[i] <- input[[Samples[i]]]
                   Daten.Titel$Messfläche[i] <-  input[[Area.Samples[i]]]
                   Daten.Titel$Titel[i] <- input[[displayed_title[i]]]
                 }
                 
                 
                 #Zwischenablage
                 safewrite.csv(Daten.Titel, filename = paste("05 - Scripts/Datentitel/currrent_data.csv", sep=""),rownames = FALSE)
                 
                 output$all.Datasets <- renderUI(
                   {
                     lapply(1:Inumber, function(i) 
                     {
                       
                       list( div(style="display: inline-block;vertical-align:top; width: 5%", h5(paste("#",i,":",sep=""))),
                             div(style="display: inline-block;vertical-align:top; width: 25%", h5(paste(Daten.Titel$Dateiname[i],sep=""))),
                             div(style="display: inline-block;vertical-align:top; width: 35%",  textInput(inputId = paste("displayed_titleSample",i,sep=""), label = NULL, value = Daten.Titel$Titel[i])),
                             div(style="display: inline-block;vertical-align:top; width: 3%;",  h5(strong(""))),
                             div(style="display: inline-block;vertical-align:top; width: 10%",  materialSwitch(inputId = paste("Sample",i,sep=""), label = NULL,inline = TRUE,  status = "primary",  value = TRUE)), 
                             div(style="display: inline-block;vertical-align:top; width: 10%;", numericInput(inputId = paste("Area.Sample",i,sep=""),  label = NULL, value = Daten.Titel$Messfläche[i] ,min = 0 )),
                             div(style="display: inline-block;vertical-align:top; width: 3%;",  h5(strong(""))),
                             div(style="display: inline-block;vertical-align:top; width: 5%;", awesomeCheckbox(inputId = paste("remove.Sample",i,sep=""), label = NULL)))
                     })       
                   })  
                 
               }
               
               
             })


#set all datasets as 'inactive'
observeEvent(input$all.inactive,
             {
               Ierror <-  tryCatch(
                 {
                   
                   Daten.Titel <- read.csv("05 - Scripts/Datentitel/currrent_data.csv", header = TRUE, sep = ";", dec = ",", fileEncoding = "ISO-8859-1")
                   Ierror <- 0
                 }
                 ,
                 error=function(cond)
                 {
                   sendSweetAlert(session, title = "Keine Datensätze zum hinzufügen ausgewählt.", type = "warning", width = 1500)
                   return(1)
                 }
                 , 
                 warning=function(cond)
                 {
                   sendSweetAlert(session, title = "Keine Datensätze zum hinzufügen ausgewählt.", type = "warning", width = 1500)
                   return(1)
                   
                 }
               ) 
               
               if(Ierror==0)
               {
                 #add Spalten, falls diese fehlen
                 
                 
                 
                 Inumber <- length(Daten.Titel$Titel)
                 
                 Samples <- paste("Sample",1:Inumber,sep="")
                 Area.Samples <- paste("Area.Sample",1:Inumber,sep="")
                 displayed_title <- paste("displayed_titleSample",1:Inumber,sep="")
                 
                 for(i in 1:Inumber)
                 {
                   Daten.Titel$Aktiv[i] <- input[[Samples[i]]]
                   Daten.Titel$Messfläche[i] <-  input[[Area.Samples[i]]]
                   Daten.Titel$Titel[i] <- input[[displayed_title[i]]]
                 }
                 
                 
                 
                 #Zwischenablage
                 safewrite.csv(Daten.Titel, filename = paste("05 - Scripts/Datentitel/currrent_data.csv", sep=""),rownames = FALSE)
                 
                 output$all.Datasets <- renderUI(
                   {
                     lapply(1:Inumber, function(i) 
                     {
                       
                       list( div(style="display: inline-block;vertical-align:top; width: 5%", h5(paste("#",i,":",sep=""))),
                             div(style="display: inline-block;vertical-align:top; width: 25%", h5(paste(Daten.Titel$Dateiname[i],sep=""))),
                             div(style="display: inline-block;vertical-align:top; width: 35%",  textInput(inputId = paste("displayed_titleSample",i,sep=""), label = NULL, value = Daten.Titel$Titel[i])),
                             div(style="display: inline-block;vertical-align:top; width: 3%;",  h5(strong(""))),
                             div(style="display: inline-block;vertical-align:top; width: 10%",  materialSwitch(inputId = paste("Sample",i,sep=""), label = NULL,inline = TRUE,  status = "primary",  value = FALSE)), 
                             div(style="display: inline-block;vertical-align:top; width: 10%;", numericInput(inputId = paste("Area.Sample",i,sep=""),  label = NULL, value = Daten.Titel$Messfläche[i] ,min = 0 )),
                             div(style="display: inline-block;vertical-align:top; width: 3%;",  h5(strong(""))),
                             div(style="display: inline-block;vertical-align:top; width: 5%;", awesomeCheckbox(inputId = paste("remove.Sample",i,sep=""), label = NULL)))
                     })       
                   })  
                 
               }
               
               
             })



#Changing order of the datasets
#moving selected dataset one place up 

observeEvent(input$up.dataset, {
  
  updateNumericInput(inputId="dummy2", value = 2)
  updateNumericInput(inputId="dummy3", value = 1)
  
})

observeEvent(input$dummy3, {
  if(input$dummy3==1)
  {
    updateNumericInput(inputId="dummy3", value = 0)
    selected <- input$Order.datasets
    Daten.Titel <- read.csv("05 - Scripts/Datentitel/currrent_data.csv", header = TRUE, sep = ";", dec = ",", fileEncoding = "ISO-8859-1")
    
    Inumber <- length(Daten.Titel$Titel)
    
    Samples <- paste("Sample",1:Inumber,sep="")
    Area.Samples <- paste("Area.Sample",1:Inumber,sep="")
    displayed_title <- paste("displayed_titleSample",1:Inumber,sep="")
    
    for(i in 1:Inumber)
    {
      Daten.Titel$Aktiv[i] <- input[[Samples[i]]]
      Daten.Titel$Messfläche[i] <-  input[[Area.Samples[i]]]
      Daten.Titel$Titel[i] <- input[[displayed_title[i]]]
    }
    
    for(i in 1:length(Daten.Titel$Titel))
    {
      if(paste(Daten.Titel$Titel[i])==paste(selected))
      {
        if(i==1)
        {
          sendSweetAlert(session, title = paste("Datensatz ",selected," ist bereits an erster Position.",sep=""), type = "warning")
        }else{
          upper.dataset.title <- Daten.Titel$Titel[i-1]
          upper.dataset.area <- Daten.Titel$Messfläche[i-1]
          upper.dataset.state <- Daten.Titel$Aktiv[i-1]
          upper.dataset.path <- Daten.Titel$Pfad[i-1]
          upper.dataset.filename <- Daten.Titel$Dateiname[i-1]
          
          Daten.Titel$Titel[i-1] <-  Daten.Titel$Titel[i]
          Daten.Titel$Messfläche[i-1] <- Daten.Titel$Messfläche[i]
          Daten.Titel$Aktiv[i-1] <-      Daten.Titel$Aktiv[i]
          Daten.Titel$Pfad[i-1] <-  Daten.Titel$Pfad[i]
          Daten.Titel$Dateiname[i-1] <- Daten.Titel$Dateiname[i]
          
          Daten.Titel$Titel[i] <- upper.dataset.title
          Daten.Titel$Messfläche[i] <- upper.dataset.area
          Daten.Titel$Aktiv[i] <- upper.dataset.state
          Daten.Titel$Pfad[i] <- upper.dataset.path
          Daten.Titel$Dateiname[i] <- upper.dataset.filename
          
          safewrite.csv(Daten.Titel, filename = paste("05 - Scripts/Datentitel/currrent_data.csv", sep=""),rownames = FALSE)
          
          updateSelectInput(session, inputId = "Order.datasets", choices = Daten.Titel$Titel, selected = selected)
          
          output$all.Datasets <- renderUI(
            {
              lapply(1:Inumber, function(i) 
              {
                
                list( div(style="display: inline-block;vertical-align:top; width: 5%", h5(paste("#",i,":",sep=""))),
                      div(style="display: inline-block;vertical-align:top; width: 25%", h5(paste(Daten.Titel$Dateiname[i],sep=""))),
                      div(style="display: inline-block;vertical-align:top; width: 35%",  textInput(inputId = paste("displayed_titleSample",i,sep=""), label = NULL, value = Daten.Titel$Titel[i])),
                      div(style="display: inline-block;vertical-align:top; width: 3%;",  h5(strong(""))),
                      div(style="display: inline-block;vertical-align:top; width: 10%",  materialSwitch(inputId = paste("Sample",i,sep=""), label = NULL,inline = TRUE,  status = "primary",  value = if(Daten.Titel$Aktiv[i]=="TRUE"){TRUE}else{FALSE})), 
                      div(style="display: inline-block;vertical-align:top; width: 10%;", numericInput(inputId = paste("Area.Sample",i,sep=""),  label = NULL, value = Daten.Titel$Messfläche[i] ,min = 0 )),
                      div(style="display: inline-block;vertical-align:top; width: 3%;",  h5(strong(""))),
                      div(style="display: inline-block;vertical-align:top; width: 5%;", awesomeCheckbox(inputId = paste("remove.Sample",i,sep=""), label = NULL)))
              })       
            })
        }
      }
    }
    updateNumericInput(inputId="dummy2", value = 1)
  }
})

#activating Buttons again which were deactivated to avoid changes in area and sample state by clicking up and down too fast
observeEvent(input$down.dataset, {
  
  updateNumericInput(inputId="dummy2", value = 2)
  updateNumericInput(inputId="dummy3", value = 2)
  
})



#moving selected dataset one place down
observeEvent(input$dummy3, {
  if(input$dummy3==2)
  {
    updateNumericInput(inputId="dummy3", value = 0)
    selected <- input$Order.datasets
    Daten.Titel <- read.csv("05 - Scripts/Datentitel/currrent_data.csv", header = TRUE, sep = ";", dec = ",", fileEncoding = "ISO-8859-1")
    
    Inumber <- length(Daten.Titel$Titel)
    
    Samples <- paste("Sample",1:Inumber,sep="")
    Area.Samples <- paste("Area.Sample",1:Inumber,sep="")
    displayed_title <- paste("displayed_titleSample",1:Inumber,sep="")
    
    for(i in 1:Inumber)
    {
      Daten.Titel$Aktiv[i] <- input[[Samples[i]]]
      Daten.Titel$Messfläche[i] <-  input[[Area.Samples[i]]]
      Daten.Titel$Titel[i] <- input[[displayed_title[i]]]
    }
    
    for(i in 1:length(Daten.Titel$Titel))
    {
      if(paste(Daten.Titel$Titel[i])==paste(selected))
      {
        if(i==Inumber)
        {
          sendSweetAlert(session, title = paste("Datensatz ",selected," ist bereits an letzer Position.",sep=""), type = "warning")
        }else{
          lower.dataset.title <- Daten.Titel$Titel[i+1]
          lower.dataset.area <- Daten.Titel$Messfläche[i+1]
          lower.dataset.state <- Daten.Titel$Aktiv[i+1]
          lower.dataset.path <- Daten.Titel$Pfad[i+1]
          lower.dataset.filename <- Daten.Titel$Dateiname[i+1]
          
          Daten.Titel$Titel[i+1] <-  Daten.Titel$Titel[i]
          Daten.Titel$Messfläche[i+1] <- Daten.Titel$Messfläche[i]
          Daten.Titel$Aktiv[i+1] <-      Daten.Titel$Aktiv[i]
          Daten.Titel$Pfad[i+1] <-  Daten.Titel$Pfad[i]
          Daten.Titel$Dateiname[i+1] <- Daten.Titel$Dateiname[i]
          
          Daten.Titel$Titel[i] <- lower.dataset.title
          Daten.Titel$Messfläche[i] <-  lower.dataset.area
          Daten.Titel$Aktiv[i] <-  lower.dataset.state
          Daten.Titel$Pfad[i] <-  lower.dataset.path
          Daten.Titel$Dateiname[i] <- lower.dataset.filename
          
          safewrite.csv(Daten.Titel, filename = paste("05 - Scripts/Datentitel/currrent_data.csv", sep=""),rownames = FALSE)
          updateSelectInput(session, inputId = "Order.datasets", choices = Daten.Titel$Titel, selected = selected)
          selected <- "ist bereits erledigt" #Änderung, da sonst immer weiter nach unten, weil natürlich die Schleife die nächste Zeile prüft
          
          
          
          output$all.Datasets <- renderUI(
            {
              lapply(1:Inumber, function(i) 
              {
                
                list( div(style="display: inline-block;vertical-align:top; width: 5%", h5(paste("#",i,":",sep=""))),
                      div(style="display: inline-block;vertical-align:top; width: 25%", h5(paste(Daten.Titel$Dateiname[i],sep=""))),
                      div(style="display: inline-block;vertical-align:top; width: 35%",  textInput(inputId = paste("displayed_titleSample",i,sep=""), label = NULL, value = Daten.Titel$Titel[i])),
                      div(style="display: inline-block;vertical-align:top; width: 3%;",  h5(strong(""))),
                      div(style="display: inline-block;vertical-align:top; width: 10%",  materialSwitch(inputId = paste("Sample",i,sep=""), label = NULL,inline = TRUE,  status = "primary",  value = if(Daten.Titel$Aktiv[i]=="TRUE"){TRUE}else{FALSE})), 
                      div(style="display: inline-block;vertical-align:top; width: 10%;", numericInput(inputId = paste("Area.Sample",i,sep=""),  label = NULL, value = Daten.Titel$Messfläche[i] ,min = 0 )),
                      div(style="display: inline-block;vertical-align:top; width: 3%;",  h5(strong(""))),
                      div(style="display: inline-block;vertical-align:top; width: 5%;", awesomeCheckbox(inputId = paste("remove.Sample",i,sep=""), label = NULL)))
              })       
            })
        }
      }
    }
    updateNumericInput(inputId="dummy2", value = 1)
  }
})





















