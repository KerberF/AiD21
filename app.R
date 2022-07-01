###ASPEX-Auswertung


#Installing packaged if necessary: 
#install.packages("ellipsis")
#install.packages("shiny")
#install.packages("shinyFiles")
#install.packages("shinyWidgets")
#install.packages("rstudioapi")
#install.packages("svDialogs")
#install.packages("shinydashboard")
#install.packages("shinydashboardPlus")
#install.packages("dashboardthemes")
#install.packages("shinyvalidate")
#install.packages("shinythemes")
#library(dashboardthemes)
#install.packages("shinybusy")

#install.packages("readr")

#install.packages("utf8")

#Lib
library(shinydashboard)
library(shinydashboardPlus)
library(shiny)
library(shinyFiles)
library(shinyWidgets)
library(shinyvalidate)
library(shinybusy)
#library(utf8)
#library(readr)
#library(shinyjs)

#jsResetCode <- "shinyjs.reset = function() {history.go(0)}" # Define the js method that resets the page

##multilanguage: for a long weekend.... 

#https://www.r-bloggers.com/2014/11/another-take-on-building-a-multi-lingual-shiny-app/
#shiny::runGitHub("multilingualShinyApp","chrislad")



#some old functions and comands: 

#?choose.files()
#choose.files(default =paste0(getwd(), "/03 - Einstellungen/*.*"), filters = c("CSV Files (*.csv)","*.csv"), multi = FALSE)

#Funktionen 
#set_wd <- function(){
#  library("rstudioapi")
#  current_path <- getActiveDocumentContext()$path  
#  setwd(dirname(current_path))
#  print(getwd())
#}
#set_wd()


#Program version: 
current_programm_version <- "1.3.5"

program_name <- HTML(paste0("AiD21",tags$sup("©")))

options(encoding="UTF-8")

#Function to use File.chose without error after cancelcing 
fileChoose <- function(...) {
  pathname <- NULL;
  tryCatch({
    pathname <- file.choose();
  }, error = function(ex) {
      })
  pathname;
}


#Function for writing csv without generating error if file is not writeable 
safewrite.csv <- function(x, filename, rownames = TRUE)
{
  session = shiny::getDefaultReactiveDomain()
  Ierror <- tryCatch(
    {
      write.csv2(x, file =filename, row.names = rownames, fileEncoding = "ISO-8859-1")
      Ierror <- 0
    }
    ,
    error=function(cond)
    {
      #message("Test")
      closeSweetAlert(session)
      sendSweetAlert(session, title=paste("Datei ",filename," bereits geöffnet. Bitte Datei schließen oder unter neuer Version abspeichern.",sep=""), type="error",width=1500)
      #sendSweetAlert(session, title=paste(cond), type="error",width=1500) #for debugging to display real error message 
      return(1)
    },
    warning=function(cond)
    {
      #message("Test")
      closeSweetAlert(session)
      sendSweetAlert(session, title=paste("Datei ",filename," bereits geöffnet. Bitte Datei schließen oder unter neuer Version abspeichern.",sep=""), type="error",width=1500)
      return(1)
    })
  return(Ierror)
  
}




#clear current_data file for datatitles and rulefiles:
Titel <- NULL
Messfläche <- NULL
Aktiv <- NULL
Pfad <- NULL
Dateiname <- NULL
allchoices <- "Test"
Daten.Titel <- data.frame(Titel, Messfläche, Aktiv, Pfad, Dateiname)
write.csv(Daten.Titel, file = paste("05 - Scripts/Datentitel/currrent_data.csv", sep=""),row.names = FALSE, fileEncoding = "ISO-8859-1")
write.csv(Daten.Titel, file = paste("05 - Scripts/Datentitel/currrent_data_combine.csv", sep=""),row.names = FALSE, fileEncoding = "ISO-8859-1")


Klassenname <-NULL 
Klassenbedingung <- NULL
PreKlassennamen <- NULL
PreKlassenbedingungen <- NULL 
currentRulefile <- data.frame(Klassenname, Klassenbedingung, PreKlassennamen, PreKlassenbedingungen)
write.csv(currentRulefile, file = "05 - Scripts/Rulefiles/current_rulefile.csv", row.names = FALSE, fileEncoding = "ISO-8859-1")

#read names
#names <- read.csv2("names.csv")
#testname <- names$text[1]


#Festlegen von Vektoren 
#Defaultwerte für die Größenklassen
#Total.Größenklassen <- 100

default.values <- c(1,3,5,10,20,30,50,80,130,200)


#für Zusammensetzungsnormierung
choices.elements.default <- c("N","Na","Mg","Al","Si","S","K","Ca","Ti","Mn","O","Cr","Mo","Fe","C")
choices.elements <- choices.elements.default

#für Darstellungen 
Klassen.choices = c("Al2O3","Ti-N","MnO-Al2O3","MnS-Al2O3","Mn-Si-highAl","Mn-Si-lowAl","Mn-Si-Ti","SiO2","MnO-MnS","CaO-Al2O3-SiO2","CaO-CaS","MgO","Kratzer","Schmutz","FeO","andere")
mainKlassen.choices = c("Al2O3","MnO-Al2O3","Mn-Si-highAl","Mn-Si-lowAl")

#App title
title <- tags$a(tags$img(height = 50, width = 135, src = "Logo_IKFVW_new.png"), 'APSEX-Auswertung')





#start userinterface
ui <-   dashboardPage(skin = "black",title = "AiD21", 
                    
 #Header
    dashboardHeader(title = program_name, disable = FALSE,titleWidth = NULL ,  
                    tags$li(a(href = 'https://tu-freiberg.de/ikfvw', target ="_blank",
                              img(src = 'Logo_IKFVW_new3.png',
                                  title = "IKFVW Freiberg", height = "40px"),
                              style = "padding-top:5px; padding-bottom:5px;"),
                            class = "dropdown"),
                    
                    
                    tags$li(a(href = 'https://tu-freiberg.de', target="_blank",
                              img(src = 'TULogo2.png',
                                  title = "TU Bergakademie Freiberg", height = "40px"),
                              style = "padding-top:5px; padding-bottom:5px;"),
                            class = "dropdown"),
                    
                    dropdownMenu( headerText= strong("Information"), badgeStatus = NULL,  type = "notifications",icon = icon("info-circle"),
                                  #notificationItem("Version v1.3 by Florian Kerber", status = "primary", icon = icon("copyright")),
                                  tags$li(
                                    a(tagAppendAttributes(icon("copyright"), class = "primary"),
                                      paste("Version ",current_programm_version," by Florian Kerber",sep=""))
                                  )
                    ), 
                     dropdownMenu(
                      tags$li(
                        a(href = "https://tu-freiberg.de/ikfvw/keramik/dipl-ing-florian-kerber",
                          target = "_blank",
                          tagAppendAttributes(icon("id-badge"), class = "primary"),
                          "Dipl.-Ing. Florian Kerber")
                      ),
                      tags$li(
                        a(href = "mailto:florian.kerber@ikfvw.tu-freiberg.de",
                          target = "_blank",
                          tagAppendAttributes(icon("envelope"), class = "primary"),
                          "florian.kerber@ikfvw.tu-freiberg.de")
                      ),
                      tags$li(
                        a(href = "https://tu-freiberg.de/ikfvw",
                          target = "_blank",
                          tagAppendAttributes(icon("bookmark"), class = "primary"),
                          "https://tu-freiberg.de/ikfvw")
                      ),
                      headerText= strong("Kontakt"), badgeStatus = NULL,  type = "notifications",icon = icon("address-card")), 

                  dropdownMenu( headerText= strong("Hilfe"), badgeStatus = NULL,  type = "notifications",icon = icon("question-circle"),
                                #notificationItem("Dokumentation", href="Hilfe.pdf", status = "primary", icon = icon("file")),
                                #tags$li(a(href="Hilfe.pdf", target="_blank", tagAppendAttributes(icon=icon("file"), class = "text-info"), "google.com"))
                                tags$li(
                                  a(href = "Hilfe.pdf",
                                    target = "_blank",
                                    tagAppendAttributes(icon("file"), class = "primary"),
                                    "Dokumentation")
                                )
                  )
                  
                    
                    ), #end dashboard header
    
 #Sidebar menu, just creating tabs, no content
 dashboardSidebar(
    sidebarMenu(id = "Funktionen",
      menuItem("Home", tabName= "Home", icon=icon("home")),
      menuItem("Allgemeine Einstellungen", tabName = "AllgemeineEinstellungen", icon = icon("cogs")),
      menuItem("Auswertung", tabName = "Auswertung",icon = icon("poll"),startExpanded = TRUE,
      menuSubItem("Partikelklassierung", icon = icon("braille"), tabName = "Partikelklassierung"),
      menuSubItem("Partikelgrößenbestimmung", tabName = "Partikelgrößenbestimmung", icon = icon("chart-bar")), 
      menuSubItem("Darstellungen", tabName = "Darstellungen", icon = icon("images"))),
      menuItem("Tools", tabName = "Tools", icon = icon("tools"),
      menuSubItem("Datenbank", tabName = "Datenbank", icon = icon("folder")), 
      menuSubItem("Rulefile-Editor", tabName = "RulefileEditor", icon = icon("list")),
      menuSubItem("Datensätze kombinieren", tabName = "Dataset_combine", icon = icon("file-csv")))
      
      )
    

  ),

  
  dashboardBody(
    
    ##Titel und Logo in Tab: 
    tags$head(tags$link(rel = "icon", type = "image/png", href = "Logo_IKFVW_icon.png"),
              includeCSS("www/bttn.min.css")),
    ##sweet alerts: 
    useSweetAlert(),

    
    
    #some html settings
    tags$head(tags$style(HTML(".shiny-notification {
             position:fixed;
             top: calc(50%);
             left: calc(50%);
    }
        .bttn-pill.bttn-primary {
    background: #3c8dbc;
    color: #fff;
        }
        .bttn-simple.bttn-primary {
    background: #3c8dbc;
    color: #fff;
}     
.box.box-solid.box-navy>.box-header {
    color: #fff;
    background: #3c8dbc;
    background-color: #3c8dbc;
}
.box.box-navy {
    border-top-color: #3c8dbc;
}
.nav-tabs-custom>.nav-tabs>li.active {
    border-top-color: #3c8dbc;
}

.irs--shiny .irs-bar {
    top: 25px;
    height: 8px;
    border-top: 1px solid #3c8dbc;
    border-bottom: 1px solid #3c8dbc;
    background: #3c8dbc;
}
.irs--shiny .irs-from, .irs--shiny .irs-to, .irs--shiny .irs-single {
    color: #fff;
    text-shadow: none;
    padding: 1px 3px;
    background-color: #3c8dbc;
    border-radius: 3px;
    font-size: 11px;
    line-height: 1.333;
}
 .navbar-custom-menu>.navbar-nav>li>.dropdownButton {
  width:900px;
  }

"
        )
      )), #end html settings 

    
    #add spinner, if server is processing any functions 
    add_busy_spinner(spin = "fading-circle", onstart = FALSE, position = "bottom-right"),
    
    
    
    #Filling different tabs with content
    tabItems(
      
            tabItem(tabName = "AllgemeineEinstellungen",

              fluidRow(
              column(5,
                     box(title = "Einstellungen laden und speichern", id="Parameterset", solidHeader = TRUE, collapsible = FALSE, status = "navy",  collapsed = FALSE, width = NULL,
                         h5(strong("Einstellungen laden:")),
                         wellPanel(style="background:ghostwhite",
                                   textOutput(outputId = "outDatapath")),
                         actionBttn(inputId = "location.settings", label = "Laden", style = "unite", size = "sm", color = "primary"),
                         actionBttn(inputId = "save.settings", label = "Speichern", style = "unite", size = "sm", color = "primary"),
                         actionBttn(inputId = "save.as.settings", label = "Speichern unter", style = "unite", size = "sm", color = "primary")),
                     
                box(title = "Bezeichnung", id="Bezeichnung", solidHeader = TRUE, collapsible = FALSE, status = "navy",width = NULL,  
                textInput(inputId = "Projekt", label = "Projekt", value = "Projektname"),
                textInput(inputId = "Charge", label = "Charge", value="Chargenname"),
                textInput(inputId = "Version", label = "Version", value="v1.0"),
                
                
                #Probeninformation
                conditionalPanel(#Hilfsvariablen, um alle Einstellungen zu erfassen. sind nicht sichtbar
                  condition = "input.Referenzfläche=='aasdassgwert34'",
                  div(style="display: inline-block;vertical-align:top; width: 48%;", numericInput(inputId = "Total.Samples", label = "Probenanzahl", value=1, min = 1))),
                
               
               
                actionBttn(inputId = "Ordner.erstellen", label = "Ordner erstellen", style = "unite", size = "sm", color = "primary")
               
              ),
              conditionalPanel(#Hilfsvariablen, um alle Einstellungen zu erfassen. sind nicht sichtbar
                condition = "input.Referenzfläche=='aasdassgwert34'",
                numericInput(inputId = "collect.SettingsA",label = NULL,value = 0),
                numericInput(inputId = "collect.SettingsB",label = NULL, value = 0),
                numericInput(inputId = "collect.SettingsC",label = NULL, value = 0),
                numericInput(inputId = "collect.SettingsD",label = NULL, value = 0), 
                numericInput(inputId = "collect.SettingsE",label = NULL, value = 0), 
                numericInput(inputId = "collect.SettingsF",label = NULL, value = 0), 
                numericInput(inputId = "collect.SettingsG",label = NULL, value = 0), 
                numericInput(inputId = "collect.SettingsH",label = NULL, value = 0),
                numericInput(inputId = "collect.SettingsI",label = NULL, value = 0),
                numericInput(inputId = "dummy",label = NULL, value = 0),
                numericInput(inputId = "dummycombine",label = NULL, value = 0),
                numericInput(inputId = "dummy2",label = NULL, value = 0),
                numericInput(inputId = "dummy2combine",label = NULL, value = 0),
                numericInput(inputId = "dummy3",label = NULL, value = 0),
                numericInput(inputId = "dummy3combine",label = NULL, value = 0)
                ), 
              box(title = "Rulefile", id="Rulefile", solidHeader = TRUE, collapsible = FALSE, status = "navy", width = NULL, 
                  
                  
                  h5(strong("Rulefile auswählen:")),
                  wellPanel(style="background:ghostwhite",
                            textOutput(outputId = "outDatapathRulefile")),
                  actionBttn(inputId = "location.Rulefile", label = "Durchsuchen", style = "unite", size = "sm", color = "primary")
              )  
              ), #close Bezeichnung
      
      
      column(7,
              box(title = "Messwerte", id="Messwerte", solidHeader = TRUE, collapsible = FALSE, status = "navy", width = NULL, 
                conditionalPanel(condition = "input.Referenzfläche=='aasdassgwert34'",
                div(style="display: inline-block;vertical-align:top; width: 33%;", selectInput(inputId = "Dateiformat.Messwerte", label = "Dateiformat der Messwerte", choices = c(".csv",".txt"),selected = ".csv" )),
                div(style="display: inline-block;vertical-align:top; width: 33%;", selectInput(inputId = "Trennzeichen", label = "Trennzeichen", choices = c("Semikolon"=";","Komma" = ",","Punkt"= ".","Tabulator" = " "),selected = ","  )),
                div(style="display: inline-block;vertical-align:top; width: 33%;",selectInput(inputId = "Dezimalzeichen", label = "Dezimalzeichen", choices = c("Komma"=",","Punkt"="."),selected = "."  ), style = "float:right")),
                
                
                #Datentitel laden
               
                h5(strong("Datentitel der Messwerte laden:")),
                wellPanel(style="background:ghostwhite",
                          textOutput(outputId = "outDatapathDatentitel"),
                ),
                fluidRow(column(8,
                                actionBttn(inputId = "location.Datentitel", label = "Durchsuchen", style = "unite", size = "sm", color = "primary"),
                                actionBttn(inputId = "save.new.Datentitel", label = "Speichern unter", style = "unite", size = "sm", color = "primary"),        
                                actionBttn(inputId = "save.old.Datentitel", label = "Speichern", style = "unite", size = "sm", color = "primary"), 
                                actionBttn(inputId = "add.old.Datentitel", label = "Zu Datentiteldatei hinzufügen", style = "unite", size = "sm", color = "primary")),

                         column(4,
                                div(style="display: inline-block;vertical-align:top;",h5(strong("Referenzfläche in mm²:"))),
                                div(style="display: inline-block;vertical-align:top;",numericInput(inputId = "Referenzfläche", label = NULL, step = 0.1, value = 100, min = 0, width = 125)))
                ),
                
 
                
                hr(), 
                fluidRow(
              column(12, h4(strong("Datensätze bearbeiten:"))), 
              column(12, h5(strong("Hinzufügen und Entfernen:"))),     
              column(12, #actionBttn(inputId = "open.Daten", label = "Messdaten öffnen", style = "unite", size = "sm", color = "primary"),
                          actionBttn(inputId = "add.Daten", label = "Hinzufügen", style = "unite", size = "sm", color = "primary"), 
                          actionBttn(inputId = "remove.Datasets", label = "Alle entfernen", style = "unite", size = "sm", color = "primary"), 
                          actionBttn(inputId = "remove.selectedDatasets", label = "Markierte entfernen", style = "unite", size = "sm", color = "primary")),
                        
              column(12, 
                     conditionalPanel(condition = "input.dummy==1",
                                       h5(strong("Reihenfolge anpassen:")))), 
              column(12, 
                     conditionalPanel(condition = "input.dummy2==1",
                                      
                                      div(style="display: inline-block;vertical-align:top;",selectInput(inputId = "Order.datasets", label = NULL, choices = c("Bitte Auswahl aktualisieren"), width = 350)),                     
                                     div(style="display: inline-block;vertical-align:top;",actionBttn(inputId = "up.dataset", label = "nach oben", style = "unite", size = "sm", color = "primary")),
                                      div(style="display: inline-block;vertical-align:top;",actionBttn(inputId = "down.dataset", label = "nach unten", style = "unite", size = "sm", color = "primary")))
              ), 
              column(12, 
                     conditionalPanel(condition="input.dummy2==2",
                                      div(style="display: inline-block;vertical-align:top;",selectInput(inputId = "Order.datasets_placeholder", label = NULL, choices = c("Reihenfolge wird angepasst..."), width = 350)),   
                                                     )
                     ),          
                 
                  column(12, h5(strong("Verfügbare Datensätze:"))),   
              column(12, 
                     conditionalPanel(condition = "input.dummy==1",
              actionBttn(inputId = "all.active", label = "Alle aktivieren", style = "unite", size = "sm", color = "primary"),
              actionBttn(inputId = "all.inactive", label = "Alle deaktivieren", style = "unite", size = "sm", color = "primary"))),    
              column(12, 
                     conditionalPanel(condition = "input.dummy==1", 
                                      div(style="display: inline-block;vertical-align:top; width: 5%;",  h5(strong("Nr:"))),
                                      div(style="display: inline-block;vertical-align:top; width: 25%;",  h5(strong("Versuchsbezeichnung:"))),
                                      div(style="display: inline-block;vertical-align:top; width: 35%;",  h5(strong("Anzuzeigender Titel:"))),
                                      div(style="display: inline-block;vertical-align:top; width: 3%;",  h5(strong(""))),
                                      div(style="display: inline-block;vertical-align:top; width: 10%;",  h5(strong("Aktiv:"))),
                                      div(style="display: inline-block;vertical-align:top; width: 10%;",  h5(strong("Messfläche in mm²:"))),
                                      div(style="display: inline-block;vertical-align:top; width: 3%;",  h5(strong(""))),
                                      div(style="display: inline-block;vertical-align:top; width: 5%;",  h5(strong(tags$i(class = "far fa-trash-alt", style="font-size: 20px")))))), 
              column(12,
                       
                uiOutput(outputId = "all.Datasets")
                )

            )))
              ) #close Messwerte
    #close Rulefile
      
      ),
    
    tabItem(tabName = "Partikelklassierung",
            fluidRow(
              column(4,
                     box(title = strong("Funktionen Partikelklassierung"), id="FkPartikelklassierung", solidHeader = TRUE, collapsible = FALSE, status = "navy", width = NULL , 
                         #Partikelklassierung
                         
                        
                         
                         #Abstandsüberprüfung, Vorklassierung, Normierung vorher
                         checkboxInput(inputId = "Vorklassierung", label = "Vorklassierung", value = TRUE),
                         checkboxInput(inputId = "Normierungvorher", label = "Normierung der Partikelzusammensetzung", value = TRUE),
                         checkboxInput(inputId = "Abstandsüberprüfung", label = "Abstandsüberprüfung", value = TRUE),
                         checkboxInput(inputId = "PCA", label = "Principle component analysis", value = FALSE),
                         conditionalPanel(condition = "input.PCA==true",
                                          wellPanel(style = "padding:5px;width:60%;",
                                          div(style="display: inline-block;vertical-align:top; width: 3%;",),
                                                    div(style="display: inline-block;vertical-align:top; width: 45%;",checkboxInput(inputId = "PCAcenter", label = "Center the data", value = TRUE)),
                                                     div(style="display: inline-block;vertical-align:top; width: 45%;",checkboxInput(inputId = "PCAscale", label = "Scale the data", value = FALSE)))),
                         #Positionsnormierung
                         checkboxInput(inputId = "Position.Normierung", label = "Normierung der x- und y- Koordinaten", value = TRUE),

                         checkboxInput(inputId = "Berechnung.Flächenanteile", label = "Berechnung der Flächenanteile"),
                         
                         #Clusterprüfung
                         checkboxInput(inputId = "Clusterprüfung", label = "Clusterprüfung"),
                         checkboxInput(inputId = "PGVimAnschluss", label = "Automatische Partikelgrößenbestimmung"),
                         #Partikleklassierung ausführen
                         div(style = "float:center", actionBttn(inputId = "Partikelklassierung", label = strong("Partikelklassierung starten"), style="unite", size = "sm", color = "primary"))
                         
                     ),#close wellPanel
                     
                     
                     
                     
              ),#close column
              column(8,
                     
                     
                     box(title = "Zusammensetzungsnormierung", id="Panel.Zusammensetzungsnormierung",solidHeader = TRUE, collapsible = TRUE, status = "navy", width = NULL , collapsed = FALSE, 
                         fluidRow(
                           box(title = "Welche Elemente sollen dafür berücksichigt werden?", id= "Panel.Elements", width = 6,status = "navy",collapsible = FALSE, solidHeader = FALSE, 
                               checkboxGroupInput(inputId = "Elements", label = NULL, choices = choices.elements, selected = c("N","Na","Mg","Al","Si","S","K","Ca","Ti","Mn","O","Cr")),
                               checkboxInput(inputId = "weitere", label = "weitere")
                           ),
                           box(title = "Welche Elemente sollen auf 0 gesetzt werden?",id="Panel.Elements0", width = 6,status = "navy",collapsible = FALSE, solidHeader = FALSE, 
                               checkboxGroupInput(inputId = "Elements0", label = NULL, choices = choices.elements, selected = c("Fe","C")),
                               checkboxInput(inputId = "weitere0", label = "weitere")
                           )
                           
                         ),
                         conditionalPanel(
                           condition = "input.weitere==true || input.weitere0==true",
                           fluidRow(
                             column(6,
                                    conditionalPanel(
                                      condition = "input.weitere==true",
                                      box(title = "Weitere Elemente hinzufügen:", width = NULL, status = "navy",collapsible = FALSE, solidHeader = FALSE,
                                          numericInput(inputId = "Elements.to.add", label =NULL , value = 1, step = 1, min=1),
                                          uiOutput(outputId = "add.element.choice"), actionBttn(inputId = "add.element", label = "Hinzufügen", style = "unite", size = "sm", color = "primary")
                                      ))), 
                             column(6, 
                                    conditionalPanel(
                                      condition = "input.weitere0==true",
                                      box(title = "Weitere Elemente hinzufügen:", width = NULL, status = "navy",collapsible = FALSE, solidHeader = FALSE,
                                          numericInput(inputId = "Elements.to.add0", label =NULL , value = 1, step = 1, min=1),
                                          uiOutput(outputId = "add.element.choice0"), actionBttn(inputId = "add.element0", label = "Hinzufügen", style = "unite", size = "sm", color = "primary")
                                      ))
                             ))
                           
                           
                           
                         )
                     ),
                     box( title = "Abstandsüberprüfung", id="Panel.Abstandsüberprüfung",solidHeader = TRUE, collapsible = TRUE, status = "navy", width = NULL , collapsed = FALSE, 
                          #h4(strong("Abstandsüberprüfung")),
                          strong("Minimaler Abstand in mm zwischen separat gezählten Partikeln:"),
                          br(),
                          div(style="display: inline-block;vertical-align:top; width: 25%;", numericInput(inputId = "min.Abstand", label = NULL, value = 0.02, step = 0.001, min = 0), style = "float:left"),
                          div(style="display: inline-block;vertical-align:top; width: 2%;", br()),
                          div(style="display: inline-block;vertical-align:top; width: 25%;",checkboxInput(inputId = "Ausfuehrlicher.Abstandspruefer", label = "Erweiterter Abstandsüberprüfer", value = TRUE)),
                          div(style="display: inline-block;vertical-align:top; width: 35%;",checkboxInput(inputId = "mdv_only_mainClass", label = "nur für Hauptklassierung", value = TRUE))
                          
                     ),
                     box(title = "Clusterprüfung", id="Panel.Clusterprüfung",solidHeader = TRUE, collapsible = TRUE, status = "navy", width = NULL , collapsed = FALSE, 
                         h4(strong("Clusterprüfung")),
                         numericInput(inputId = "Anzahl.Spalten", label = "Anzahl der Spalten", step = 1, value = 4, width = "100%", min = 1),
                         checkboxInput(inputId = "Quadrate", label= "Quadratische Feldgeometrie"),
                         conditionalPanel(
                           condition = "input.Quadrate == false",
                           numericInput(inputId = "Anzahl.Reihen", label = "Anzahl der Reihen", step = 1, value = 4, width = "100%", min = 1)
                         ),
                         
                         
                         checkboxInput(inputId = "Darstellungen.Clusterprüfung", label= "Darstellungen generieren")
                     )
                     
                     
                     
                     
              ))
            
            
            
            
    ),#close Partikelklassierung
        tabItem(tabName = "Partikelgrößenbestimmung",
                        fluidRow(
                           column(5,
                                  box(title =strong("Funktionen Partikelgrößenbestimmung"),  solidHeader = TRUE, collapsible = TRUE, status = "navy", width = NULL , collapsed = FALSE,
                                      selectInput(inputId = "Klassierungsmerkmal", label = "Klassierungsmerkmal", choices=c("Partikelfläche"="AREA","Wurzel der Partikelfläche"="sqrt(AREA)","Äquivalentdurchmesser"="sqrt(4*AREA/pi)","mittlerer Partikeldurchmesser"="DAVG","minimaler Partikeldruchmesser"="DMIN","maximaler Partikeldurchmesser"="DMAX","andere")),
                                      conditionalPanel(
                                        condition = "input.Klassierungsmerkmal=='andere'",
                                        "Merkmal hinzufügen:",
                                        textInput(inputId = "custom.Merkmal", label = NULL,value = "keins" )
                                      ),  
                                      checkboxInput(inputId = "Ermittlung.Dequi", label = "Berechnung des Äuqivalentdurchmessers"),
                                      numericInput(inputId = "Total.Größenklassen", label = "Anzahl der Größenklassen", value = 11, min = 3),
                                      
                                      
                                      
                                      
                                      checkboxInput(inputId = "alle.Partikel", label = "für alle Partikel", value = TRUE),
                                      checkboxInput(inputId = "nach.Klassen", label = "für die einzelnen Klassen", value = TRUE),
                                      checkboxInput(inputId = "Speicherung.Klassen", label = "Speicherung nach Klassen", value = TRUE),
                                      checkboxInput(inputId = "Kenngrößen", label = "Ermittlung von Kenngrößen (x10, x50 und x90)", value = TRUE),
                                      
                                      #Partikelgrößenbestimmung ausführen
                                      actionBttn(inputId = "Partikelgrößenbestimmung", label = strong("Partikelgrößenbestimmung starten"), style = "unite", color = "primary", size = "sm")
                                      
                                      
                                      
                                      
                                    )),
                           column(7,
                                  box(title = "Größenklassen", solidHeader = TRUE, collapsible = TRUE, status = "navy", width = NULL , collapsed = FALSE,
                                    uiOutput(outputId = "Größenklassen"),
                                    #div(style="display: inline-block;vertical-align:top; width: 48%;",numericInput(inputId = "letzte", label = "Obergrenze Klasse 10", value = 200, min = 0)),
                                    strong(textOutput(outputId = "letzte.Klasse")),
                                    conditionalPanel(
                                      condition = "input.Klassierungsmerkmal=='AREA'",
                                      h4("Einheit: µm²")
                                    ),
                                    conditionalPanel(
                                      condition = "input.Klassierungsmerkmal=='Dequi'||input.Klassierungsmerkmal=='DMAX'||input.Klassierungsmerkmal=='DMIN'||input.Klassierungsmerkmal=='DAVG'||input.Klassierungsmerkmal=='sqrt(AREA)'||input.Klassierungsmerkmal=='sqrt(4*AREA/pi)'",
                                      h4("Einheit: µm")
                                    ),
                                    conditionalPanel(
                                      condition = "input.Klassierungsmerkmal!='Dequi'&&input.Klassierungsmerkmal!='DMAX'&&input.Klassierungsmerkmal!='DMIN'&&input.Klassierungsmerkmal!='DAVG'&&input.Klassierungsmerkmal!='AREA'&&input.Klassierungsmerkmal!='sqrt(AREA)'&&input.Klassierungsmerkmal!='sqrt(4*AREA/pi)'",
                                      h4("Einheit: -")
                                    ),
                                    
                                    
                                    br(),
                                    actionBttn(inputId = "Anwenden.Größenklassen", label = "Grenzen Anwenden", style = "unite", size = "sm", color = "primary")
                                  )
                           )
                         )
              ),
      
    #Darstellungen 
      tabItem(tabName = "Darstellungen",
                         fluidRow(
                           column(3,
                                  box(title =strong("Darstellungen"), solidHeader = TRUE, collapsible = TRUE, status = "navy", width = NULL , collapsed = FALSE,
                                    tabBox(title = NULL,width = NULL, 
                                                  tabPanel("Eingabe",
                                                           selectInput(inputId = "xplot", label = "x-Achse", choices = c("AREA","DMAX","DMIN","DAVE","ASPECT","X_ABS","Y_ABS","N","Na","Mg","Al","Si","S","K","Ca","Ti","Mn","O","Cr","Mo","Fe","C"),selected = "Al"),
                                                           selectInput(inputId = "yplot", label = "y-Achse", choices = c("AREA","DMAX","DMIN","DAVE","ASPECT","X_ABS","Y_ABS","N","Na","Mg","Al","Si","S","K","Ca","Ti","Mn","O","Cr","Mo","Fe","C"), selected = "Mn"),
                                                           selectInput(inputId = "zplot", label = "Helligkeitsverlauf", choices = c("kein Helligkeitsverlauf","AREA","DMAX","DMIN","DAVE","ASPECT","X_ABS","Y_ABS","N","Na","Mg","Al","Si","S","K","Ca","Ti","Mn","O","Cr","Mo","Fe","C"), selected = "Si"),
                                                           actionBttn(inputId = "update.choices",label = "Auswahl aktualisieren", style = "unite", size = "sm", color = "primary"),
                                                           
                                                           selectInput(inputId = "Darstellungen_gesamt_Klassen", label = "Darstellungsart", choices = c("Rohdaten","Hauptklassen normiert","Hauptklassen unnormiert","ausgewählte Hauptklassen"),selected = "ausgewählte Hauptklassen"),
                                                           
                                                           conditionalPanel(
                                                             condition = "input.Darstellungen_gesamt_Klassen == 'gesamt'",
                                                             checkboxInput(inputId = "Daten.normiert", label = "Normierte Zusammensetzung darstellen", value = TRUE))
                                                           
                                                  ),
                                                  tabPanel("Ausgabe PDF",
                                                           numericInput(inputId = "figure.rows", label = "Anzahl Bilder pro Spalte", value = 3, min = 1),
                                                           numericInput(inputId = "figure.col", label = "Anzahl Bilder pro Reihe", value = 2, min = 1), 
                                                           checkboxInput(inputId = "Klassennamen.in.Datei", label = "Dargestelle Klassen in PDF-Dateinname", value = TRUE)
                                                  )
                                      
                                     
                                    ),
                                    #checkboxInput(inputId = "PlotVorschau", label = "Vorschau", value = FALSE), 
                                    actionBttn(inputId = "Plot.preview", label = strong("Vorschau"), style = "unite", size = "sm", color = "primary"), 
                                    
                                    actionBttn(inputId = "Darstellungen.erzeugen", label = strong("Darstellungen erzeugen"), style = "unite", size = "sm", color = "primary") 
                                    
                                  )),
                           column(4,
                                  box(title ="Einstellungen", solidHeader = TRUE, collapsible = TRUE, status = "navy", width = NULL , collapsed = FALSE,
                                      div(style="display: inline-block;vertical-align:top;",  dropdownButton(width = 450, icon = icon("sliders"),tooltip = FALSE, label = "Skalierung der Achsen",circle = FALSE,size = "default",status = "default",
                                                     div(style="display: inline-block;vertical-align:top; width: 100%;", sliderInput(inputId = "Skalierung.x", label = "Skalierung der x-Achse", value = c(0,60), min = 0, max = 100)),
                                                     div(style="display: inline-block;vertical-align:top; width: 100%;", sliderInput(inputId = "Skalierung.y", label = "Skalierung der y-Achse", value = c(0,60), min = 0, max = 100)),
                                                     conditionalPanel(
                                                       condition = "input.zplot!= 'kein Helligkeitsverlauf'",
                                                       
                                                       sliderInput(inputId = "Skalierung.z", label = "Skalierung des Helligkeitsverlaufes", value = 25, min = 1, max = 100, width = "100%")   
                                                     )
                                                     
                                                     
                                                     
                                      )),
                                      div(style="display: inline-block;vertical-align:top;",dropdownButton(width = 450, icon = icon("list"),tooltip = FALSE, label = "Legende",circle = FALSE,size = "default",status = "default",
                                                   
                                                     
                                                     div(style="display: inline-block;vertical-align:top; width: 100%;", sliderInput(inputId = "Position.Legendex", label = "x-Position der Legende", value = c(20),min = 0, max = 100)),
                                                     div(style="display: inline-block;vertical-align:top; width: 100%;", sliderInput(inputId = "Position.Legendey", label = "y-Position der Legende", value = c(20),min = 0, max = 100)),
                                                     div(style="display: inline-block;vertical-align:top; width: 100%;", sliderInput(inputId = "fontsize.legend", label = "Schriftgröße Legende", value = c(1.5),min = 0.1, max = 5, step = 0.1)),
                                                     div(style="display: inline-block;vertical-align:top; width: 100%;", sliderInput(inputId = "fontsize.legendpt", label = "Größe der Legendensymbole", value = c(1.2),min = 0.1, max = 5, step = 0.1)),
                                                     conditionalPanel(
                                                       condition = "input.zplot!= 'kein Helligkeitsverlauf'",
                                                       
                                                       h5(strong("Helligkeitsverlauf in Legende anzeigen")),
                                                       materialSwitch(inputId = "gradient")   
                                                     )
                                                     
                                                     
                                                     
                                      )),
                                      
                                      div(style="display: inline-block;vertical-align:top;",dropdownButton(width = 450, icon = icon("font"),tooltip = FALSE, label = "Beschriftung",circle = FALSE,size = "default",status = "default",
                                                                                                           
                                                                                                           
                                                                                                           div(style="display: inline-block;vertical-align:top; width: 100%;", selectInput(inputId = "language", label = "Sprache", choices = c("deutsch","englisch"),selected = "deutsch")),
                                                                                                           div(style="display: inline-block;vertical-align:top; width: 100%;", sliderInput(inputId = "fontsize.main", label = "Schriftgröße Haupttitel", value = c(1.7),min = 0.1, max = 5, step = 0.1)),
                                                                                                           div(style="display: inline-block;vertical-align:top; width: 100%;", sliderInput(inputId = "fontsize.lab", label = "Schriftgröße Achstentitel", value = c(1.6),min = 0.1, max = 5, step = 0.1)),
                                                                                                           div(style="display: inline-block;vertical-align:top; width: 100%;", sliderInput(inputId = "fontsize.axis", label = "Schriftgröße Achsenbeschriftung", value = c(1.6),min = 0.1, max = 5, step = 0.1)),
                                                                                                           div(style="display: inline-block;vertical-align:top; width: 100%;", sliderInput(inputId = "size.symbols", label = "Größe der Symbole", value = c(1.1),min = 0.1, max = 5, step = 0.1))
                                                                                                           
                                      ))
                                      
                                      ),
                                  
                                  box(title ="Darstellungen von Klassen",id="Darstellungen.Klassen", solidHeader = TRUE, collapsible = TRUE, status = "navy", width = NULL , collapsed = FALSE,
                                      numericInput(inputId = "Darstellungen.Klassen.Anzahl", label = "Anzahl der darzustellenden Klassen", value = 4, min = 1, max=10),
                                      uiOutput(outputId = "Anzahl.Klassen"),
                                      actionBttn(inputId = "update.choices.classes", label = "Auswahl aktualisieren", style = "unite", size = "sm", color = "primary"),
                                      checkboxInput(inputId = "Farbig", label = "Farbig", value = TRUE), 
                                      checkboxInput(inputId = "Symbole.Füllung", label = "Symbole mit schwarzer Umrandung", value = TRUE)
                                    )
                                    
                                    
                                  
                           ),
                           column(5, 
                                     box(title ="Vorschau",id="Panel.Plot.Vorschau", solidHeader = TRUE, collapsible = TRUE, status = "navy", width = NULL , collapsed = FALSE,
                                     
                                         plotOutput(outputId = "Vorschau", height ="842px", width="595px")),
                           )
                           
                           )
                         
                       
              
              
              
              
              
              
              
              
              ), #close Darstellungen 
    tabItem(tabName = "Datenbank", 
            fluidRow(
            column(12,
            div(style="display: inline-block;vertical-align:top; width: 10%;", numericInput(inputId = "Anzahl.Tabellen", label= "Anzahl Tabellen",max = 5, min = 1, value = 1)),
            div(style="display: inline-block;vertical-align:top; width: 20%;", selectInput(inputId = "allProjects", label = "Projekt", choices = dir(path= "01 - Projekte"))),
            div(style="display: inline-block;vertical-align:top; width: 20%;", selectInput(inputId = "possibleChargen", label = "Charge", choices = "Projekt auswählen")),
            div(style="display: inline-block;vertical-align:top; width: 20%;", selectInput(inputId = "possibleVersions", label = "Version", choices = "Projekt und Charge auswählen")))),
            fluidRow(
            column(12,
            uiOutput("ButtonsResulttables"),
            uiOutput("Resulttables")
            ))
            
            ),#close Datenbank
    
    tabItem(tabName = "RulefileEditor",
            fluidRow(
              column(12,
              box(title ="Einstellungen", solidHeader = TRUE, collapsible = FALSE, status = "navy", width = NULL , 
              column(6,   
                     
                      h5(strong("Rulefile auswählen:")),
                     wellPanel(style="background:ghostwhite",
                               textOutput(outputId = "outRulefileedit")),
                     actionBttn(inputId = "openRulefile", label = "Öffnen", style = "unite", size = "sm", color = "primary"),
                     actionBttn(inputId = "saveRulefile", label = "Speichern", style = "unite", size = "sm", color = "primary"),
                     actionBttn(inputId = "saveasRulefile", label = "Speichern unter",style = "unite", size = "sm", color = "primary")
                     
              ), 
              
               column(2, 
                     div(style="display: inline-block;vertical-align:top; ", numericInput(inputId = "AnzahlVorklassen", label = "Anzahl der Vorklassen", value = 1, min = 0, width = 220)),    
                     div(style="display: inline-block;vertical-align:top; ",numericInput(inputId = "AnzahlHauptklassen", label = "Anzahl der Hauptklassen", value = 1, min = 0, width = 220))),
              column(3, 
                     selectInput(inputId = "Reihenfolge", label = "Reihenfolge anpassen:", choices = c("Bitte Auswahl aktualisieren")),                     
                     actionBttn(inputId = "updateclasses", label = "Aktualisieren", style = "unite", size = "sm", color = "primary"),
                     actionBttn(inputId = "up", label = "nach oben", style = "unite", size = "sm", color = "primary"),
                     actionBttn(inputId = "down", label = "nach unten", style = "unite", size = "sm", color = "primary")
              )
              
              
            ))),
            fluidRow(
              column(12,
                     box(title ="Vorklassen", solidHeader = TRUE, collapsible = FALSE, status = "navy", width = NULL , 
                     #h3("Vorklassen"),
                    div(style="display: inline-block;vertical-align:top; width: 20%;",  h5(strong("Klassennamen:"))),
                    div(style="display: inline-block;vertical-align:top; width: 75%;",  h5(strong("Bedingungen:"))),  
                    uiOutput("Vorklassen")
                             )),
              column(12,
                     box(title ="Hauptklassen", solidHeader = TRUE, collapsible = FALSE, status = "navy", width = NULL , 
                     #h3("Hauptklassen"),
                     div(style="display: inline-block;vertical-align:top; width: 20%;",  h5(strong("Klassennamen:"))),
                     div(style="display: inline-block;vertical-align:top; width: 75%;",  h5(strong("Bedingungen:"))),
                     uiOutput("Hauptklassen")
                   ))
              
            )
            
            
            
            
            
            
            ),#close Rulefile-Editor
    
    tabItem(tabName = "Dataset_combine",
            fluidRow(
              column(12,
                     box(title ="Einstellungen", solidHeader = TRUE, collapsible = FALSE, status = "navy", width = NULL , 
                     h5(strong("Datensätze über Datentitel-Datei laden:")),
                     wellPanel(style="background:ghostwhite",
                               textOutput(outputId = "outDatapathDatentitel_combine"),
                     ),
                     fluidRow(column(8,
                                     actionBttn(inputId = "location.Datentitel_combine", label = "Durchsuchen", style = "unite", size = "sm", color = "primary"),
                                    ),
                    ),
                     
                     hr(), 
                     fluidRow(
                       column(12, h5(strong("Datensätze Hinzufügen und Entfernen:"))),     
                       column(12, #actionBttn(inputId = "open.Daten", label = "Messdaten öffnen", style = "unite", size = "sm", color = "primary"),
                              actionBttn(inputId = "add.Daten_combine", label = "Hinzufügen", style = "unite", size = "sm", color = "primary"), 
                              actionBttn(inputId = "remove.Datasets_combine", label = "Alle entfernen", style = "unite", size = "sm", color = "primary"), 
                              actionBttn(inputId = "remove.selectedDatasets_combine", label = "Markierte entfernen", style = "unite", size = "sm", color = "primary")),
                       
                       column(12, h5(strong("Verfügbare Datensätze:"))),   
                       column(12, 
                              conditionalPanel(condition = "input.dummycombine==1",
                                               actionBttn(inputId = "combine_active_datasets", label = "Aktive Datensätze kombinieren und speichern unter", style = "unite", size = "sm", color = "primary"),
                                               actionBttn(inputId = "all.active_combine", label = "Alle aktivieren", style = "unite", size = "sm", color = "primary"),
                                               actionBttn(inputId = "all.inactive_combine", label = "Alle deaktivieren", style = "unite", size = "sm", color = "primary"))),    
                       column(12, 
                              conditionalPanel(condition = "input.dummycombine==1", 
                                               div(style="display: inline-block;vertical-align:top; width: 5%;",  h5(strong("Nr:"))),
                                               div(style="display: inline-block;vertical-align:top; width: 49%;",  h5(strong("Titel:"))),
                                               div(style="display: inline-block;vertical-align:top; width: 3%;",  h5(strong(""))),
                                               div(style="display: inline-block;vertical-align:top; width: 10%;",  h5(strong("Aktiv:"))),
                                               div(style="display: inline-block;vertical-align:top; width: 20%;",  h5(strong("Messfläche in mm²:"))),
                                               div(style="display: inline-block;vertical-align:top; width: 3%;",  h5(strong(""))),
                                               div(style="display: inline-block;vertical-align:top; width: 5%;",  h5(strong("Entfernen:"))))), 
                       column(12,
                              
                              uiOutput(outputId = "all.Datasets_combine")
                       )
                     
                     
                     )))
              
            )#close fluidRow
            
            
            
                      ), #close Dataset_combine
 
    tabItem(tabName = "Home",
            fluidRow(
              column(12,
            h1(strong(program_name)),
            h4(paste("Version ",current_programm_version," by Dipl.-Ing. Florian Kerber",sep=""))),
            column(12,offset = 2,
                  hr(),
                  hr(),
                  #actionButton(inputId = "test", label = "Refresh"),
                  img(src='Logo_IKFVW_icon.png', height = "470px",align = "center"),
                  img(src='TULogo.png', height = "450px")
                  
            
            ))

            )#close Home
  )))

  
####################################################################################

server <- function(input, output, session){

  ##open a window and close it right after opening --> to avoid open first dialog in background
  windows(0.3,0.4)
  graphics.off()
  
  

###Safety 
  
  #Conditions for all input variables  
  source("05 - Scripts/Serverfunction/conditions_variables.R", local = TRUE)

  
###General settings
  
  #update boxes: 
  source("05 - Scripts/Serverfunction/update_boxes.R", local = TRUE)
  
 
  #Load and save settings
  source("05 - Scripts/Serverfunction/load_settings.R", local = TRUE)
  source("05 - Scripts/Serverfunction/save_settings.R", local = TRUE)
  
 
  #Rulefile and savingfolders 
  source("05 - Scripts/Serverfunction/rulefile_and_savingfolders.R", local = TRUE)
  
 
  #Handle datasets
  source("05 - Scripts/Serverfunction/handle_datasets.R", local = TRUE)

###Particle classification and particle distribution   
 
  #Adding elements for element normalization
  source("05 - Scripts/Serverfunction/add_elements.R", local = TRUE)

 
  #Run particle classification
  source("05 - Scripts/Serverfunction/particle_classification.R", local = TRUE)
 
 
  #Run particle size distribution
  source("05 - Scripts/Serverfunction/particle_size_distribution.R", local = TRUE)
  

###Plots 
  
  #Update input choices for plot settings
  source("05 - Scripts/Serverfunction/update_choices_plotsettings.R", local = TRUE)
 
 
  #Plot preview
  source("05 - Scripts/Serverfunction/plot_preview.R", local = TRUE)

 
  #Generating plots
  source("05 - Scripts/Serverfunction/generating_plots.R", local = TRUE)
  
 
###Tools  
  
  #Rulefile-Editor
  source("05 - Scripts/Serverfunction/Rulefileeditor.R", local = TRUE)
  
  #Database
  source("05 - Scripts/Serverfunction/database.R", local = TRUE)
  
  #Combine datasets
  source("05 - Scripts/Serverfunction/combine_datasets.R", local = TRUE)
  

 
    session$onSessionEnded(stopApp)
}

shinyApp(ui = ui, server = server, options = list(port=7990))

