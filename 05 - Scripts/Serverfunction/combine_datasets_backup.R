
#generating variable
Datapath.location.Datentitel_combine <- reactiveVal("Keine Datentitel-Datei ausgewählt.")
Speicherort_combine_csv <- reactiveVal("leer")
Speicherort_combine_txt <- reactiveVal("leer")

#browsing a file for datasettitles
observeEvent(input$location.Datentitel_combine,{ 
  Datapath.location.Datentitel_combine("")
  Projekt <- input$Projekt 
  Charge <- input$Charge
  Datapath.location.Datentitel_combine(choose.files(caption = "Titel der Messwerte auswählen",default =paste0(getwd(), "/01 - Projekte/",Projekt,"/",Charge,"/Messwerte/*.csv"), filters = cbind(c("CSV Files (*.csv)","Text Files (*.txt)"),c("*.csv","*.txt")),index = 1,multi = FALSE))
  #updateTextInput(session, "Datapath.location.Datentitel", value = paste(choose.files(caption = "Titel der Messwerte auswählen",default =paste0(getwd(), "/01 - Projekte/",Projekt,"/",Charge,"/Messwerte/*.csv"), filters = cbind(c("CSV Files (*.csv)","Text Files (*.txt)"),c("*.csv","*.txt")),index = 1,multi = FALSE)))
  
})



#updating textbox ouput
observeEvent(Datapath.location.Datentitel_combine(),
             {
               
               if(length(Datapath.location.Datentitel_combine())==0)
               {
                 output$outDatapathDatentitel_combine <- renderText("Keine Datentitel-Datei ausgewählt.")
                 Datapath.location.Datentitel_combine("Keine Datentitel-Datei ausgewählt.")
               }else{
                 output$outDatapathDatentitel_combine <- renderText(Datapath.location.Datentitel_combine())
               }
             })



#update displayed output based on the selected file --> is triggered by pressing 'Durchsuchen' 
observeEvent(Datapath.location.Datentitel_combine(),
             {
               
               file.Datentitel <- Datapath.location.Datentitel_combine()
               if(length(Datapath.location.Datentitel_combine())==0)
               {}else{
                 output$all.Datasets_combine <- renderUI( 
                   {
                     Ierror <- tryCatch(
                       {
                         Daten.Titel <- read.table(file=file.Datentitel, header=TRUE, dec=",", sep=";") 
                         
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
                       number <- length(Daten.Titel$Titel)
                       if(sizeTable[2]==2)
                       {  
                         Aktiv <- paste(rep("TRUE",number))
                         Pfad <- paste(rep("Kein Pfad angegeben.",number))
                         Daten.Titel <- data.frame(Daten.Titel,Aktiv, Pfad)
                       }
                       if(sizeTable[2]==3)
                       {  
                         
                         Pfad <- paste(rep("Kein Pfad angegeben.", number))
                         Daten.Titel <- data.frame(Daten.Titel, Pfad)
                       }
                       safewrite.csv(Daten.Titel, filename = paste("05 - Scripts/Datentitel/currrent_data_combine.csv", sep=""),rownames = FALSE)
                       updateNumericInput(inputId="dummycombine", value = 1)
                       lapply(1:number, function(i) 
                       {
                         
                         list( div(style="display: inline-block;vertical-align:top; width: 65%",  switchInput(inputId = paste("Sample_combine",i,sep=""),onLabel = "Aktiv", offLabel = "Nicht Aktiv", label = Daten.Titel$Titel[i],  labelWidth = 350,handleWidth = 100, value = if(Daten.Titel$Aktiv[i]=="TRUE"){TRUE}else{FALSE})), 
                               div(style="display: inline-block;vertical-align:top; width: 20%;", numericInput(inputId = paste("Area.Sample_combine",i,sep=""), label = NULL, value = Daten.Titel$Messfläche[i])),
                               div(style="display: inline-block;vertical-align:top; width: 5%;",  h5(strong(""))),
                               div(style="display: inline-block;vertical-align:top; width: 5%;", awesomeCheckbox(inputId = paste("remove.Sample_combine",i,sep=""), label = NULL)))
                       })
                       
                     }else{updateNumericInput(inputId="dummycombine", value = 0) 
                       h5("Keine gültige Datentitel-Datei gewählt bzw. keine Datensätze geladen.")}
                     
                   })
               }
               
             })

#confirm to remove all datasets
observeEvent(input$remove.Datasets_combine, 
             {
               confirmSweetAlert(session, inputId = "confirm.remove.Datasets_combine", title = "Alle Datensätze entfernen?", type = "question", btn_labels = c("Nein","Ja"))
               
             })
#removing if confirmed
observeEvent(input$confirm.remove.Datasets_combine, 
             {
               if(input$confirm.remove.Datasets_combine==TRUE)
               {
                 Titel <- NULL
                 Messfläche <- NULL
                 Aktiv <- NULL
                 Pfad <- NULL 
                 Daten.Titel <- data.frame(Titel, Messfläche, Aktiv, Pfad)
                 safewrite.csv(Daten.Titel, filename = paste("05 - Scripts/Datentitel/currrent_data_combine.csv", sep=""),rownames = FALSE)
                 updateNumericInput(inputId="dummycombine", value = 0)
                 
                 
                 output$all.Datasets_combine <-renderUI(
                   h5("Keine gültige Datentitel-Datei gewählt bzw. keine Datensätze geladen.")
                 ) 
               }
             })

#confirm to remove selected datasets
observeEvent(input$remove.selectedDatasets_combine, 
             {
               confirmSweetAlert(session, inputId = "confirm.remove.selectedDatasets_combine", title = "Ausgewählte Datensätze entfernen?", type = "question", btn_labels = c("Nein","Ja"))
               
             })

#remove selected datasets if confirmed
observeEvent(input$confirm.remove.selectedDatasets_combine, 
             {
               if(input$confirm.remove.selectedDatasets_combine==TRUE)
               {
                 
                 Ierror <-  tryCatch(
                   {
                     
                     Daten.Titel <- read.csv("05 - Scripts/Datentitel/currrent_data_combine.csv", header = TRUE, sep = ";", dec = ",")
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
                   
                   number <- length(Daten.Titel$Titel)
                   
                   Samples <- paste("Sample_combine",1:number,sep="")
                   Area.Samples <- paste("Area.Sample_combine",1:number,sep="")
                   for(i in 1:number)
                   {
                     Daten.Titel$Aktiv[i] <- input[[Samples[i]]]
                     Daten.Titel$Messfläche[i] <-  input[[Area.Samples[i]]]
                   }
                   
                   
                   
                   Samples <- paste("remove.Sample_combine",1:number,sep = "")
                   to.remove <- NULL
                   for(i in 1:number)
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
                       
                       number <- length(Daten.Titel$Titel)
                       safewrite.csv(Daten.Titel, filename = paste("05 - Scripts/Datentitel/currrent_data_combine.csv", sep=""),rownames = FALSE)
                       updateNumericInput(inputId="dummycombine", value = 1)
                       output$all.Datasets_combine <- renderUI(
                         {
                           lapply(1:number, function(i) 
                           {
                             
                             list( div(style="display: inline-block;vertical-align:top; width: 65%",  switchInput(inputId = paste("Sample_combine",i,sep=""),onLabel = "Aktiv", offLabel = "Nicht Aktiv", label = Daten.Titel$Titel[i],  labelWidth = 350,handleWidth = 100, value = if(Daten.Titel$Aktiv[i]=="TRUE"){TRUE}else{FALSE})), 
                                   div(style="display: inline-block;vertical-align:top; width: 20%;", numericInput(inputId = paste("Area.Sample_combine",i,sep=""),  label = NULL, value = Daten.Titel$Messfläche[i] ,min = 0 )),
                                   div(style="display: inline-block;vertical-align:top; width: 5%;",  h5(strong(""))),
                                   div(style="display: inline-block;vertical-align:top; width: 5%;", awesomeCheckbox(inputId = paste("remove.Sample_combine",i,sep=""), label = NULL)))
                           })       
                         }) 
                     }else{
                       Titel <- NULL
                       Messfläche <- NULL
                       Aktiv <- NULL
                       Pfad <- NULL 
                       Daten.Titel <- data.frame(Titel, Messfläche, Aktiv, Pfad)
                       safewrite.csv(Daten.Titel, filename = paste("05 - Scripts/Datentitel/currrent_data_combine.csv", sep=""),rownames = FALSE)
                       updateNumericInput(inputId="dummycombine", value = 0)
                       output$all.Datasets_combine <-renderUI(
                         h5("Keine gültige Datentitel-Datei gewählt bzw. keine Datensätze geladen.")
                       ) 
                     }
                   }
                   
                 }}
               
             }
)


#add a new dataset and update the displayed output 
observeEvent(input$add.Daten_combine, 
             {
               
               tryCatch(
                 {
                   Daten.Titel <- read.csv("05 - Scripts/Datentitel/currrent_data_combine.csv", header = TRUE, sep = ";", dec = ",")
                 }
                 ,
                 error=function(cond)
                 {
                   Titel <- NULL
                   Messfläche <- NULL
                   Aktiv <- NULL
                   Pfad <- NULL 
                   Daten.Titel <- data.frame(Titel, Messfläche, Aktiv, Pfad)
                   
                 }
                 , 
                 warning=function(cond)
                 {
                   Titel <- NULL
                   Messfläche <- NULL
                   Aktiv <- NULL
                   Pfad <- NULL 
                   Daten.Titel <- data.frame(Titel, Messfläche, Aktiv, Pfad)
                   
                 }
               )
               if(length(Daten.Titel$Titel!=0))
               {
                 Inumber <- length(Daten.Titel$Titel)
                 
                 Samples <- paste("Sample_combine",1:Inumber,sep="")
                 Area.Samples <- paste("Area.Sample_combine",1:Inumber,sep="")
                 for(i in 1:Inumber)
                 {
                   Daten.Titel$Aktiv[i] <- input[[Samples[i]]]
                   Daten.Titel$Messfläche[i] <-  input[[Area.Samples[i]]]
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
                 
                 #Hinzufügen von neu eingelesenen Daten zu Datentitel 
                 addDatentitel <- data.frame(Titel, Messfläche, Aktiv, Pfad)
                 Daten.Titel <- rbind(Daten.Titel, addDatentitel) 
                 number <- length(Daten.Titel$Titel)
                 if(isTRUE(grepl(".csv",Datapath.location.Datentitel_combine())))
                 {
                   
                   
                 }
                 #Zwischenablage
                 safewrite.csv(Daten.Titel, filename = paste("05 - Scripts/Datentitel/currrent_data_combine.csv", sep=""),rownames = FALSE)
                 updateNumericInput(inputId="dummycombine", value = 1)
                 output$all.Datasets_combine <- renderUI(
                   {
                     lapply(1:number, function(i) 
                     {
                       
                       list( div(style="display: inline-block;vertical-align:top; width: 65%",  switchInput(inputId = paste("Sample_combine",i,sep=""),onLabel = "Aktiv", offLabel = "Nicht Aktiv", label = Daten.Titel$Titel[i],  labelWidth = 350,handleWidth = 100, value = if(Daten.Titel$Aktiv[i]=="TRUE"){TRUE}else{FALSE})), 
                             div(style="display: inline-block;vertical-align:top; width: 20%;", numericInput(inputId = paste("Area.Sample_combine",i,sep=""),  label = NULL, value = Daten.Titel$Messfläche[i] ,min = 0 )),
                             div(style="display: inline-block;vertical-align:top; width: 5%;",  h5(strong(""))),
                             div(style="display: inline-block;vertical-align:top; width: 5%;", awesomeCheckbox(inputId = paste("remove.Sample_combine",i,sep=""), label = NULL)))
                       
                     })       
                   })  
               }#else{ output$all.Datasets <- renderUI(h5("Keine gültige Datentitel-Datei gewählt bzw. keine Datensätze geladen."))}
               
               
             })



#set all datasets as 'active'
observeEvent(input$all.active_combine,
             {
               Ierror <-  tryCatch(
                 {
                   
                   Daten.Titel <- read.csv("05 - Scripts/Datentitel/currrent_data_combine.csv", header = TRUE, sep = ";", dec = ",")
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
                 
                 Samples <- paste("Sample_combine",1:Inumber,sep="")
                 Area.Samples <- paste("Area.Sample_combine",1:Inumber,sep="")
                 for(i in 1:Inumber)
                 {
                   Daten.Titel$Aktiv[i] <- input[[Samples[i]]]
                   Daten.Titel$Messfläche[i] <-  input[[Area.Samples[i]]]
                 }
                 
                 
                 
                 #Zwischenablage
                 safewrite.csv(Daten.Titel, filename = paste("05 - Scripts/Datentitel/currrent_data_combine.csv", sep=""),rownames = FALSE)
                 
                 output$all.Datasets_combine <- renderUI(
                   {
                     lapply(1:Inumber, function(i) 
                     {
                       
                       list( div(style="display: inline-block;vertical-align:top; width: 65%",  switchInput(inputId = paste("Sample_combine",i,sep=""),onLabel = "Aktiv", offLabel = "Nicht Aktiv", label = Daten.Titel$Titel[i],  labelWidth = 350,handleWidth = 100, value = TRUE)), 
                             div(style="display: inline-block;vertical-align:top; width: 20%;", numericInput(inputId = paste("Area.Sample_combine",i,sep=""),  label = NULL, value = Daten.Titel$Messfläche[i] ,min = 0 )),
                             div(style="display: inline-block;vertical-align:top; width: 5%;",  h5(strong(""))),
                             div(style="display: inline-block;vertical-align:top; width: 5%;", awesomeCheckbox(inputId = paste("remove.Sample_combine",i,sep=""), label = NULL)))
                     })       
                   })  
                 
               }
               
               
             })


#set all datasets as 'inactive'
observeEvent(input$all.inactive_combine,
             {
               Ierror <-  tryCatch(
                 {
                   
                   Daten.Titel <- read.csv("05 - Scripts/Datentitel/currrent_data_combine.csv", header = TRUE, sep = ";", dec = ",")
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
                 
                 Samples <- paste("Sample_combine",1:Inumber,sep="")
                 Area.Samples <- paste("Area.Sample_combine",1:Inumber,sep="")
                 for(i in 1:Inumber)
                 {
                   Daten.Titel$Aktiv[i] <- input[[Samples[i]]]
                   Daten.Titel$Messfläche[i] <-  input[[Area.Samples[i]]]
                 }
                 
                 
                 
                 #Zwischenablage
                 safewrite.csv(Daten.Titel, filename = paste("05 - Scripts/Datentitel/currrent_data_combine.csv", sep=""),rownames = FALSE)
                 
                 output$all.Datasets_combine <- renderUI(
                   {
                     lapply(1:Inumber, function(i) 
                     {
                       
                       list( div(style="display: inline-block;vertical-align:top; width: 65%",  switchInput(inputId = paste("Sample_combine",i,sep=""),onLabel = "Aktiv", offLabel = "Nicht Aktiv", label = Daten.Titel$Titel[i],  labelWidth = 350,handleWidth = 100, value = FALSE)), 
                             div(style="display: inline-block;vertical-align:top; width: 20%;", numericInput(inputId = paste("Area.Sample_combine",i,sep=""),  label = NULL, value = Daten.Titel$Messfläche[i] ,min = 0 )),
                             div(style="display: inline-block;vertical-align:top; width: 5%;",  h5(strong(""))),
                             div(style="display: inline-block;vertical-align:top; width: 5%;", awesomeCheckbox(inputId = paste("remove.Sample_combine",i,sep=""), label = NULL)))
                     })       
                   })  
                 
               }
               
               
             })


#combine datasets 
observeEvent(input$combine_active_datasets, 
             { inputSweetAlert(inputId = "name_combined_Sample", title = "Bitte Dateinamen angeben.", type = "info",session)})


observeEvent(input$name_combined_Sample,
             {
               if(input$name_combined_Sample!="")
               {
                 Name <- input$name_combined_Sample
                 Projekt <- input$Projekt
                 Charge <- input$Charge
                 Speicherort <- choose.dir(caption = "Bitte einen Speicherort wählen", default = paste(getwd(),"/01 - Projekte/",Projekt,"/",Charge,"/Messwerte/",sep=""))
                 if(!is.na(Speicherort))
                 {
                   Speicherort_txt <- paste(Speicherort,"\\",Name,".txt", sep="")
                   Speicherort_csv <- paste(Speicherort,"\\",Name,".csv", sep="")
                   
                   
                   Ierror <- tryCatch(
                     {
                       
                       test <- read.csv(Speicherort_csv, header = TRUE, sep = ";", dec = ",")
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
                   if(Ierror==0)
                   {
                     Speicherort_combine_csv(Speicherort_csv)
                     Speicherort_combine_txt(Speicherort_txt)
                     confirmSweetAlert(session, inputId = "Confirm.overwrite.file", title = "Dateiname bereits vorhanden, überschreiben?", type = "question", btn_labels = c("Nein","Ja"),  width = 1200)
                     Ierror <- 0
                   }else{
                     
                     Ierror <-  tryCatch(
                       {
                         
                         Daten.Titel <- read.csv("05 - Scripts/Datentitel/currrent_data_combine.csv", header = TRUE, sep = ";", dec = ",")
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
                       
                       
                       
                       Inumber <- length(Daten.Titel$Titel)
                       
                       Samples <- paste("Sample_combine",1:Inumber,sep="")
                       Area.Samples <- paste("Area.Sample_combine",1:Inumber,sep="")
                       for(i in 1:Inumber)
                       {
                         Daten.Titel$Aktiv[i] <- input[[Samples[i]]]
                         Daten.Titel$Messfläche[i] <-  input[[Area.Samples[i]]]
                       }
                       
                       
                       
                       #Zwischenablage
                       safewrite.csv(Daten.Titel, filename = paste("05 - Scripts/Datentitel/currrent_data_combine.csv", sep=""),rownames = FALSE)
                       
                       
                       source("05 - Scripts/Samples/Dateneinleser_combine.R", local = TRUE)
                       if(Ierror==0)
                       {
                         combined_Sample <- get(Samples[1])
                         combined_area <- get(Messfläche.all[1])
                         dim_combined_Sample <- dim(combined_Sample)
                         if(Total.Samples>=2)
                         {
                           for(i in 2:Total.Samples)
                           {
                             if(Ierror==0)
                             {
                               Sample<- get(Samples[i]) 
                               Messfläche <- get(Messfläche.all[i]) 
                               dim_add_Sample <- dim(Sample) 
                               if(dim_add_Sample[2]==dim_combined_Sample[2])
                               {
                                 combined_Sample <-  rbind(combined_Sample, Sample) 
                                 combined_area <- combined_area+Messfläche
                               }else{
                                 sendSweetAlert(session, title = "Zu kombinierende Datensätze haben nicht die gleiche Spaltenanzahl. Kombinieren nicht möglich.", type = "error", width = 1500)
                                 Ierror <- 1
                               }}
                             
                           }
                         } 
                         dim_combined_Sample <- dim(combined_Sample)
                         for(i in 1:dim_combined_Sample[1])
                         {
                           combined_Sample$PART[i] <- i
                         }
                         safewrite.csv(combined_Sample, filename = Speicherort_csv, rownames = FALSE) 
                         writeLines(c(
                           paste("###################################################################################"),
                           paste("Kombinierte Datensätze:"),
                           paste("    -",Daten.Titel$Titel,sep = ""),
                           paste("Kombinierte Messfläche:"),
                           paste("    -",combined_area," mm²",sep = "")
                           
                           
                           
                         ),Speicherort_txt
                         )   
                         
                       }}}
                   
                 }
               }
               
               
             })


observeEvent(input$Confirm.overwrite.file,{
  if(isTRUE(input$Confirm.overwrite.file))
  {
    Ierror <-  tryCatch(
      {
        
        Daten.Titel <- read.csv("05 - Scripts/Datentitel/currrent_data_combine.csv", header = TRUE, sep = ";", dec = ",")
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
      
      
      
      Inumber <- length(Daten.Titel$Titel)
      
      Samples <- paste("Sample_combine",1:Inumber,sep="")
      Area.Samples <- paste("Area.Sample_combine",1:Inumber,sep="")
      for(i in 1:Inumber)
      {
        Daten.Titel$Aktiv[i] <- input[[Samples[i]]]
        Daten.Titel$Messfläche[i] <-  input[[Area.Samples[i]]]
      }
      
      
      
      #Zwischenablage
      safewrite.csv(Daten.Titel, filename = paste("05 - Scripts/Datentitel/currrent_data_combine.csv", sep=""),rownames = FALSE)
      
      
      source("05 - Scripts/Samples/Dateneinleser_combine.R", local = TRUE)
      if(Ierror==0)
      {
        combined_Sample <- get(Samples[1])
        combined_area <- get(Messfläche.all[1])
        dim_combined_Sample <- dim(combined_Sample)
        if(Total.Samples>=2)
        {
          for(i in 2:Total.Samples)
          {
            if(Ierror==0)
            {
              Sample<- get(Samples[i]) 
              Messfläche <- get(Messfläche.all[i]) 
              dim_add_Sample <- dim(Sample) 
              if(dim_add_Sample[2]==dim_combined_Sample[2])
              {
                combined_Sample <-  rbind(combined_Sample, Sample) 
                combined_area <- combined_area+Messfläche
              }else{
                sendSweetAlert(session, title = "Zu kombinierende Datensätze haben nicht die gleiche Spaltenanzahl. Kombinieren nicht möglich.", type = "error", width = 1500)
                Ierror <- 1
              }}
            
          }
        } 
        
        dim_combined_Sample <- dim(combined_Sample)
        for(i in 1:dim_combined_Sample[1])
        {
          combined_Sample$PART[i] <- i
        }
        safewrite.csv(combined_Sample, filename = Speicherort_combine_csv(), rownames = FALSE) 
        
        writeLines(c(
          paste("###################################################################################"),
          paste("Kombinierte Datensätze:"),
          paste("    -",Daten.Titel$Titel,sep = ""),
          paste("Kombinierte Messfläche:"),
          paste("    -",combined_area," mm²",sep = "")
        ),paste(Speicherort_combine_txt())
        )
        
      }}}
  
  
})
