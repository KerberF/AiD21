#actual determining of the particle size distribution


#Allgemeine Informationen
Projekt <- input$Projekt
Charge <- input$Charge
#Total.Samples <- input$Total.Samples  
Referenzfläche <- input$Referenzfläche
Version <- input$Version 
Dateiformat.Messwerte <- input$Dateiformat.Messwerte
Trennzeichen <- input$Trennzeichen
Dezimalzeichen <- input$Dezimalzeichen
file.Datentitel <- Datapath.location.Datentitel()
file.Rulefile <- Datapath.location.Rulefile()
Name.Rulefile <- Datapath.location.Rulefile()
Vorklassierung <- input$Vorklassierung 
Abstandsüberprüfung <- input$Abstandsüberprüfung
min.Abstand <- input$min.Abstand 
Ausfuehrlicher.Abstandspruefer <- input$Ausfuehrlicher.Abstandspruefer

#Einstellungen Partikelgrößenbestimmungen
Merkmal.Größenklassierung <- input$Klassierungsmerkmal
if(Merkmal.Größenklassierung == "andere")
{
  Merkmal.Größenklassierung <- input$custom.Merkmal
}
Ermittlung.Dequi <- input$Ermittlung.Dequi
Total.Größenklassen <- input$Total.Größenklassen

#Einlesen der Klassengrenzen 
Klassen.Grenzen <- paste("Grenze",1:Total.Größenklassen,sep="")
Grenze1 <- 0
for(i in 2:(Total.Größenklassen-1))
{
  Grenze <- Klassen.Grenzen[i]
  value <- input[[Klassen.Grenzen[i-1]]]
  assign(Grenze, value)
}
Grenze <- Klassen.Grenzen[Total.Größenklassen]
value <- input$letzte 
assign(Grenze, value)
alle.Partikel <- input$alle.Partikel 
nach.Klassen <- input$nach.Klassen 
Speicherung.Klassen <- input$Speicherung.Klassen 
Kenngrößen <- input$Kenngrößen
source("05 - Scripts/Run/Run_Partikelgrößenbestimmung.R", local = TRUE)
source("05 - Scripts/Report/Report_new.R", local = TRUE)
#Sys.sleep(1)
if(Ierror==0)
{
  closeSweetAlert(session)
  sendSweetAlert(session, title="Partikelgrößenbestimmung abgeschlossen", type="success")
}