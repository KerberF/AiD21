##Dokumentation aller verwendeten Eigenschaften
if(Vorklassierung==TRUE)
{
  PreClasses.for.Dok <-0
  for(i in 1:Total.PreClasses)
  {
    PreClasses.for.Dok[i] <-  paste("     - ",get(PreClasses[i]),": ",get(Condition.PreClasses[i]),sep="")
  }
}
Classes.for.Dok <-0
for(i in 1:Total.Classes)
{
  Classes.for.Dok[i] <-  paste("     - ",get(Classes[i]),": ",get(Condition.Classes[i]),sep="")
}

Samples.for.Dok <-0
for(i in 1:Total.Samples)
{
  Samples.for.Dok[i] <-  paste("     - ",get(Title.Sample.all[i]),"; Messfläche: ",get(Messfläche.all[i])," mm²",sep="")
}


writeLines(c
           (
             paste("############################################################"),
             paste("Charge: ",Charge,sep=""),
             paste("Anzahl der Proben:",Total.Samples),
             paste("Proben:"),
             Samples.for.Dok,
             paste("\nReferenzfläche:", Referenzfläche,"mm²"),
             paste("\n############################################################"),
             paste("\nZusammensetzungsnormierung: ",if(Normierung.vorher==TRUE){"Ja"},if(Normierung.vorher==FALSE){"Nein"},sep=""),
             if(Normierung.vorher==TRUE){paste("\n  >für Normierung verwendete Elemente: ")},
             if(Normierung.vorher==TRUE){paste("     -",Elements)},
             if(Normierung.vorher==TRUE){paste("\n  >auf 0 gesetzte Elemente: ")},
             if(Normierung.vorher==TRUE){paste("     -",Elements.0)},
             paste("\n############################################################"),
             paste("\nPartikelklassierung:"),
             paste("\n  >Rulefile:",Name.Rulefile),
             paste("\n  >Vorklassierung: ",if(Vorklassierung==TRUE){"Ja"},if(Vorklassierung==FALSE){"Nein"},sep=""),
             if(Vorklassierung==TRUE){paste("  >Anzahl der Vorklassen:", Total.PreClasses)},
             paste("  >Anzahl der Klassen:", Total.Classes),
             if(Vorklassierung==TRUE){
               paste("\n  >Vorklassen:")},
             if(Vorklassierung==TRUE){PreClasses.for.Dok},
             paste("\n  >Klassen:") ,    
             Classes.for.Dok,
             paste("\n############################################################"),
             paste("\nAbstandsüberprüfung: ",if(Abstandsüberprüfung==TRUE){"Ja"},if(Abstandsüberprüfung==FALSE){"Nein"},sep=""),
             if(Abstandsüberprüfung==TRUE){paste("Ausführliche Abstandsüberprüfung: ",if(Ausfuehrlicher.Abstandspruefer==TRUE){"Ja"},if(Ausfuehrlicher.Abstandspruefer==FALSE){"Nein"},sep="")},
             if(Abstandsüberprüfung==TRUE){paste("Minimaler Abstand: ", min.Abstand,"mm")},
             paste("\nBerechnung der Flächenanteile: ",if(Berechnung.Flächenanteile==TRUE){"Ja"},if(Berechnung.Flächenanteile==FALSE){"Nein"},sep=""),
             paste("\nPositionsnormierung: ",if(Position.Normierung==TRUE){"Ja"},if(Position.Normierung==FALSE){"Nein"},sep=""),
             paste("\n############################################################"),
             paste("\nPartikelgrößenbestimmung:"),
             paste("\n  >Partikelgrößenbestimmung durchgeführt mittels: ",Merkmal.Größenklassierung),
             paste("  >Anzahl der Partikelgrößenklassen:",Total.Größenklassen),
             paste("  >Partikelgrößenklassen:"),
             paste("    -",Partikelklassen),
             paste("\n  >Partikelgrößenbestimmung für alle Partikel gemeinsam: ",if(alle.Partikel==TRUE){"Ja"},if(alle.Partikel==FALSE){"Nein"},sep=""),
             paste("  >Partikelgrößenbestimmung nach Klassen getrennt: ",if(nach.Klassen==TRUE){"Ja"},if(nach.Klassen==FALSE){"Nein"},sep=""),
             paste("  >Speicherung nach Klassen: ",if(Speicherung.Klassen==TRUE){"Ja"},if(Speicherung.Klassen==FALSE){"Nein"},sep=""),
             paste("  >Ermittlung des Äquivalentdurchmesser: ",if(Ermittlung.Dequi==TRUE){"Ja"},if(Ermittlung.Dequi==FALSE){"Nein"},sep="")
             
             
             
             
             
             
             
             
           ),paste(Speicherort,"/01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/Parameterlog/",format(Sys.time(),"%y%m%d_%H.%M.%S"),"_",Charge,"_",Durchgeführt,".txt",sep=""))



writeLines(c
           (
             paste("############################################################"),
             paste("Charge: ",Charge,sep=""),
             paste("Anzahl der Proben:",Total.Samples),
             paste("Proben:"),
             Samples.for.Dok,
             paste("\nReferenzfläche:", Referenzfläche,"mm²"),
             paste("\n############################################################"),
             paste("\nZusammensetzungsnormierung: ",if(Normierung.vorher==TRUE){"Ja"},if(Normierung.vorher==FALSE){"Nein"},sep=""),
             if(Normierung.vorher==TRUE){paste("\n  >für Normierung verwendete Elemente: ")},
             if(Normierung.vorher==TRUE){paste("     -",Elements)},
             if(Normierung.vorher==TRUE){paste("\n  >auf 0 gesetzte Elemente: ")},
             if(Normierung.vorher==TRUE){paste("     -",Elements.0)},
             paste("\n############################################################"),
             paste("\nPartikelklassierung:"),
             paste("\n  >Rulefile:",Name.Rulefile),
             paste("\n  >Vorklassierung: ",if(Vorklassierung==TRUE){"Ja"},if(Vorklassierung==FALSE){"Nein"},sep=""),
             if(Vorklassierung==TRUE){paste("  >Anzahl der Vorklassen:", Total.PreClasses)},
             paste("  >Anzahl der Klassen:", Total.Classes),
             if(Vorklassierung==TRUE){
               paste("\n  >Vorklassen:")},
             if(Vorklassierung==TRUE){PreClasses.for.Dok},
             paste("\n  >Klassen:") ,    
             Classes.for.Dok,
             paste("\n############################################################"),
             paste("\nAbstandsüberprüfung: ",if(Abstandsüberprüfung==TRUE){"Ja"},if(Abstandsüberprüfung==FALSE){"Nein"},sep=""),
             if(Abstandsüberprüfung==TRUE){paste("Ausführliche Abstandsüberprüfung: ",if(Ausfuehrlicher.Abstandspruefer==TRUE){"Ja"},if(Ausfuehrlicher.Abstandspruefer==FALSE){"Nein"},sep="")},
             if(Abstandsüberprüfung==TRUE){paste("Minimaler Abstand: ", min.Abstand,"mm")},
             paste("\nBerechnung der Flächenanteile: ",if(Berechnung.Flächenanteile==TRUE){"Ja"},if(Berechnung.Flächenanteile==FALSE){"Nein"},sep=""),
             paste("\nPositionsnormierung: ",if(Position.Normierung==TRUE){"Ja"},if(Position.Normierung==FALSE){"Nein"},sep=""),
             paste("\n############################################################"),
             paste("\nPartikelgrößenbestimmung:"),
             paste("\n  >Partikelgrößenbestimmung durchgeführt mittels: ",Merkmal.Größenklassierung),
             paste("  >Anzahl der Partikelgrößenklassen:",Total.Größenklassen),
             paste("  >Partikelgrößenklassen:"),
             paste("    -",Partikelklassen),
             paste("\n  >Partikelgrößenbestimmung für alle Partikel gemeinsam: ",if(alle.Partikel==TRUE){"Ja"},if(alle.Partikel==FALSE){"Nein"},sep=""),
             paste("  >Partikelgrößenbestimmung nach Klassen getrennt: ",if(nach.Klassen==TRUE){"Ja"},if(nach.Klassen==FALSE){"Nein"},sep=""),
             paste("  >Speicherung nach Klassen: ",if(Speicherung.Klassen==TRUE){"Ja"},if(Speicherung.Klassen==FALSE){"Nein"},sep=""),
             paste("  >Ermittlung des Äquivalentdurchmesser: ",if(Ermittlung.Dequi==TRUE){"Ja"},if(Ermittlung.Dequi==FALSE){"Nein"},sep="")
             
             
             
             
             
             
             
             
           ),paste(Speicherort,"/04 - Log/",format(Sys.time(),"%y%m%d_%H.%M.%S"),"_",Charge,"_",Durchgeführt,".txt",sep=""))
