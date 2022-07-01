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

if(Darstellung.Klassen==TRUE)
{
  Classes.plot.for.Dok <- 0
  for(v in 1:Darstellungen.Klassen.Anzahl)
  {
    Classes.plot.for.Dok[v] <- paste(get(Klassentitel[v]))
  }
}



writeLines(c
           (
             paste("###################################################################################"),
             paste("Charge: ",Charge,sep=""),
             paste("Version: ",Version,sep=""),
             paste("Anzahl der Proben:",Total.Samples),
             paste("Proben:"),
             Samples.for.Dok,
             paste("\nReferenzfläche:", Referenzfläche,"mm²"),
             paste("\n###################################################################################"),
             paste("\nZusammensetzungsnormierung: ",if(Normierung.vorher==TRUE){"Ja"},if(Normierung.vorher==FALSE){"Nein"},sep=""),
             if(Normierung.vorher==TRUE){paste("\n  >für Normierung verwendete Elemente: ")},
             if(Normierung.vorher==TRUE){paste("     -",Elements)},
             if(Normierung.vorher==TRUE){paste("\n  >auf 0 gesetzte Elemente: ")},
             if(Normierung.vorher==TRUE){paste("     -",Elements.0)},
             paste("\n###################################################################################"),
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
             paste("\n >Abstandsüberprüfung: ",if(Abstandsüberprüfung==TRUE){"Ja"},if(Abstandsüberprüfung==FALSE){"Nein"},sep=""),
             if(Abstandsüberprüfung==TRUE){paste("   -Ausführliche Abstandsüberprüfung: ",if(Ausfuehrlicher.Abstandspruefer==TRUE){"Ja"},if(Ausfuehrlicher.Abstandspruefer==FALSE){"Nein"},sep="")},
             if(Abstandsüberprüfung==TRUE){paste("   -Minimaler Abstand: ", min.Abstand,"mm")},
             paste("\n >Berechnung der Flächenanteile: ",if(Berechnung.Flächenanteile==TRUE){"Ja"},if(Berechnung.Flächenanteile==FALSE){"Nein"},sep=""),
             paste("\nClusterprüfung: ",if(Clusterprüfung==TRUE){"Ja"},if(Clusterprüfung==FALSE){"Nein"},sep=""),
             if(Clusterprüfung==TRUE){paste(" -Anzahl der Spalten: ", Anzahl.Spalten)},
             if(Clusterprüfung==TRUE){paste(if(Quadrate ==TRUE){" -Quadrate: Ja  \n -Anzahl der Reihen: Berechnet aus Anzahl der Spalten"},if(Quadrate==FALSE){paste(" -Anzahl der Reihen:",Anzahl.Reihen)},sep="")},
             if(Clusterprüfung==TRUE){paste(" -Darstellungen: ",if(Darstellungen.Clusterprüfung==TRUE){"Ja"},if(Darstellungen.Clusterprüfung==FALSE){"Nein"},sep="")},
             paste("\n >Positionsnormierung: ",if(Position.Normierung==TRUE){"Ja"},if(Position.Normierung==FALSE){"Nein"},sep=""),
             paste("\n###################################################################################"),
             paste("\nPartikelgrößenbestimmung:"),
             paste("\n  >Partikelgrößenbestimmung durchgeführt mittels: ",Merkmal.Größenklassierung),
             paste("  >Anzahl der Partikelgrößenklassen:",Total.Größenklassen),
             paste("  >Partikelgrößenklassen:"),
             paste("    -",Partikelklassen),
             paste("\n  >Partikelgrößenbestimmung für alle Partikel gemeinsam: ",if(alle.Partikel==TRUE){"Ja"},if(alle.Partikel==FALSE){"Nein"},sep=""),
             paste("  >Partikelgrößenbestimmung nach Klassen getrennt: ",if(nach.Klassen==TRUE){"Ja"},if(nach.Klassen==FALSE){"Nein"},sep=""),
             paste("  >Speicherung nach Klassen: ",if(Speicherung.Klassen==TRUE){"Ja"},if(Speicherung.Klassen==FALSE){"Nein"},sep=""),
             paste("  >Ermittlung des Äquivalentdurchmesser: ",if(Ermittlung.Dequi==TRUE){"Ja"},if(Ermittlung.Dequi==FALSE){"Nein"},sep=""),
             paste("\n###################################################################################"),
             paste("\nDarstellung: "),
             paste("\n >Was wurde dargestellt? "),
             paste("   -x-Achse:",plot.x),
             paste("   -y-Achse:",plot.y),
             paste("   -z-Achse:",plot.z),
             paste("\n >Skalierung:"),
             paste("   -x-Achse: min = ",Skalierung.x[1], "; max = ",Skalierung.x[2],sep=""),
             paste("   -y-Achse: min = ",Skalierung.y[1], "; max = ",Skalierung.y[2],sep=""),
             if(Darstellung.gesamt==TRUE){paste("   -z-Achse: min = ",min, "; max = ",max," (Werte für den Intensitätsverlauf)", sep="")},
             if(Darstellung.Klassen==TRUE){paste("   -z-Achse: min = 0; max = ",max," (Werte für den Intensitätsverlauf)", sep="")},
             paste("\n >Position Legende:"),
             paste("   -x:",Position.Legende.x),
             paste("   -y:",Position.Legende.y),
             paste("\n >Ausgabe als PDF:"),
             paste("   -Abbildungen pro Zeile:",figure.col),
             paste("   -Abbildungen pro Spalte:",figure.rows),
             paste("   -Zuammenfassung in mehrseitiger PDF: ",if(Mehrseitige.PDF==TRUE){"Ja"},if(Mehrseitige.PDF==FALSE){"Nein"},sep=""),
             paste("\n >Darstellung aller Partikel: ",if(Darstellung.gesamt==TRUE){"Ja"},if(Darstellung.gesamt==FALSE){"Nein"},sep=""),
             paste(" >Darstellung nach Klassen: ",if(Darstellung.Klassen==TRUE){"Ja"},if(Darstellung.Klassen==FALSE){"Nein"},sep=""),
             if(Darstellung.Klassen==TRUE){paste(" >Darstellung in Farbe: ",if(Farbig==TRUE){"Ja"},if(Farbig==FALSE){"Nein"},sep="")},
             if(Darstellung.Klassen==TRUE){paste(" >Darstellung mit gefüllten Symbolen: ",if(Symbole.Füllung==TRUE){"Ja"},if(Symbole.Füllung==FALSE){"Nein"},sep="")},
             if(Darstellung.Klassen==TRUE){paste("\n >Dargestellte Klassen:")},
             if(Darstellung.Klassen==TRUE){paste("   -",Classes.plot.for.Dok)},
             paste("\n###################################################################################") 
             
             
             
             
           ),paste(Speicherort,"/01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/Parameterlog/",format(Sys.time(),"%y%m%d_%H.%M.%S"),"_",Charge,"_",Durchgeführt,"_",Version,".txt",sep=""))



writeLines(c
           (
             paste("###################################################################################"),
             paste("Charge: ",Charge,sep=""),
             paste("Version: ",Version,sep=""),
             paste("Anzahl der Proben:",Total.Samples),
             paste("Proben:"),
             Samples.for.Dok,
             paste("\nReferenzfläche:", Referenzfläche,"mm²"),
             paste("\n###################################################################################"),
             paste("\nZusammensetzungsnormierung: ",if(Normierung.vorher==TRUE){"Ja"},if(Normierung.vorher==FALSE){"Nein"},sep=""),
             if(Normierung.vorher==TRUE){paste("\n  >für Normierung verwendete Elemente: ")},
             if(Normierung.vorher==TRUE){paste("     -",Elements)},
             if(Normierung.vorher==TRUE){paste("\n  >auf 0 gesetzte Elemente: ")},
             if(Normierung.vorher==TRUE){paste("     -",Elements.0)},
             paste("\n###################################################################################"),
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
             paste("\n >Abstandsüberprüfung: ",if(Abstandsüberprüfung==TRUE){"Ja"},if(Abstandsüberprüfung==FALSE){"Nein"},sep=""),
             if(Abstandsüberprüfung==TRUE){paste("   -Ausführliche Abstandsüberprüfung: ",if(Ausfuehrlicher.Abstandspruefer==TRUE){"Ja"},if(Ausfuehrlicher.Abstandspruefer==FALSE){"Nein"},sep="")},
             if(Abstandsüberprüfung==TRUE){paste("   -Minimaler Abstand: ", min.Abstand,"mm")},
             paste("\n >Berechnung der Flächenanteile: ",if(Berechnung.Flächenanteile==TRUE){"Ja"},if(Berechnung.Flächenanteile==FALSE){"Nein"},sep=""),
             paste("\nClusterprüfung: ",if(Clusterprüfung==TRUE){"Ja"},if(Clusterprüfung==FALSE){"Nein"},sep=""),
             if(Clusterprüfung==TRUE){paste(" -Anzahl der Spalten: ", Anzahl.Spalten)},
             if(Clusterprüfung==TRUE){paste(if(Quadrate ==TRUE){" -Quadrate: Ja  \n -Anzahl der Reihen: Berechnet aus Anzahl der Spalten"},if(Quadrate==FALSE){paste(" -Anzahl der Reihen:",Anzahl.Reihen)},sep="")},
             if(Clusterprüfung==TRUE){paste(" -Darstellungen: ",if(Darstellungen.Clusterprüfung==TRUE){"Ja"},if(Darstellungen.Clusterprüfung==FALSE){"Nein"},sep="")},
             paste("\n >Positionsnormierung: ",if(Position.Normierung==TRUE){"Ja"},if(Position.Normierung==FALSE){"Nein"},sep=""),
             paste("\n###################################################################################"),
             paste("\nPartikelgrößenbestimmung:"),
             paste("\n  >Partikelgrößenbestimmung durchgeführt mittels: ",Merkmal.Größenklassierung),
             paste("  >Anzahl der Partikelgrößenklassen:",Total.Größenklassen),
             paste("  >Partikelgrößenklassen:"),
             paste("    -",Partikelklassen),
             paste("\n  >Partikelgrößenbestimmung für alle Partikel gemeinsam: ",if(alle.Partikel==TRUE){"Ja"},if(alle.Partikel==FALSE){"Nein"},sep=""),
             paste("  >Partikelgrößenbestimmung nach Klassen getrennt: ",if(nach.Klassen==TRUE){"Ja"},if(nach.Klassen==FALSE){"Nein"},sep=""),
             paste("  >Speicherung nach Klassen: ",if(Speicherung.Klassen==TRUE){"Ja"},if(Speicherung.Klassen==FALSE){"Nein"},sep=""),
             paste("  >Ermittlung des Äquivalentdurchmesser: ",if(Ermittlung.Dequi==TRUE){"Ja"},if(Ermittlung.Dequi==FALSE){"Nein"},sep=""),
             paste("\n###################################################################################"),
             paste("\nDarstellung: "),
             paste("\n >Was wurde dargestellt? "),
             paste("   -x-Achse:",plot.x),
             paste("   -y-Achse:",plot.y),
             paste("   -z-Achse:",plot.z),
             paste("\n >Skalierung:"),
             paste("   -x-Achse: min = ",Skalierung.x[1], "; max = ",Skalierung.x[2],sep=""),
             paste("   -y-Achse: min = ",Skalierung.y[1], "; max = ",Skalierung.y[2],sep=""),
             if(Darstellung.gesamt==TRUE){paste("   -z-Achse: min = ",min, "; max = ",max," (Werte für den Intensitätsverlauf)", sep="")},
             if(Darstellung.Klassen==TRUE){paste("   -z-Achse: min = 0; max = ",max," (Werte für den Intensitätsverlauf)", sep="")},
             paste("\n >Position Legende:"),
             paste("   -x:",Position.Legende.x),
             paste("   -y:",Position.Legende.y),
             paste("\n >Ausgabe als PDF:"),
             paste("   -Abbildungen pro Zeile:",figure.col),
             paste("   -Abbildungen pro Spalte:",figure.rows),
             paste("   -Zuammenfassung in mehrseitiger PDF: ",if(Mehrseitige.PDF==TRUE){"Ja"},if(Mehrseitige.PDF==FALSE){"Nein"},sep=""),
             paste("\n >Darstellung aller Partikel: ",if(Darstellung.gesamt==TRUE){"Ja"},if(Darstellung.gesamt==FALSE){"Nein"},sep=""),
             paste(" >Darstellung nach Klassen: ",if(Darstellung.Klassen==TRUE){"Ja"},if(Darstellung.Klassen==FALSE){"Nein"},sep=""),
             if(Darstellung.Klassen==TRUE){paste(" >Darstellung in Farbe: ",if(Farbig==TRUE){"Ja"},if(Farbig==FALSE){"Nein"},sep="")},
             if(Darstellung.Klassen==TRUE){paste(" >Darstellung mit gefüllten Symbolen: ",if(Symbole.Füllung==TRUE){"Ja"},if(Symbole.Füllung==FALSE){"Nein"},sep="")},
             if(Darstellung.Klassen==TRUE){paste("\n >Dargestellte Klassen:")},
             if(Darstellung.Klassen==TRUE){paste("   -",Classes.plot.for.Dok)},
             paste("\n###################################################################################") 
             
             
             
             
             
             
             
           ),paste(Speicherort,"/04 - Log/",format(Sys.time(),"%y%m%d_%H.%M.%S"),"_",Charge,"_",Durchgeführt,"_",Version,".txt",sep=""))
