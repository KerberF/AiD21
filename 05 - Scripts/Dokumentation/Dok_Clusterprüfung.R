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
             paste("###################################################################################"),
             paste("Charge: ",Charge,sep=""),
             paste("Version: ",Version,sep=""),
             paste("Anzahl der Proben:",Total.Samples),
             paste("Proben:"),
             Samples.for.Dok,
             paste("\nReferenzfläche:", Referenzfläche,"mm²"),
             paste("\n###################################################################################"),
             paste("\nVerwendete Partikelklassierung:"),
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
             paste("\n###################################################################################"),
             paste("\nClusterprüfung: ",if(Clusterprüfung==TRUE){"Ja"},if(Clusterprüfung==FALSE){"Nein"},sep=""),
             if(Clusterprüfung==TRUE){paste(" -Anzahl der Spalten: ", Anzahl.Spalten)},
             if(Clusterprüfung==TRUE){paste(if(Quadrate ==TRUE){" -Quadrate: Ja  \n -Anzahl der Reihen: Berechnet aus Anzahl der Spalten"},if(Quadrate==FALSE){paste(" -Anzahl der Reihen:",Anzahl.Reihen)},sep="")},
             if(Clusterprüfung==TRUE){paste(" -Darstellungen: ",if(Darstellungen.Clusterprüfung==TRUE){"Ja"},if(Darstellungen.Clusterprüfung==FALSE){"Nein"},sep="")},
             paste("\n###################################################################################")
             
             
             
             
             
             
             
           ),paste(Speicherort,"/01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/Parameterlog/",format(Sys.time(),"%y%m%d_%H.%M.%S"),"_",Projekt,"_",Charge,"_",Durchgeführt,"_",Version,".txt",sep=""))



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
             paste("\nVerwendete Partikelklassierung:"),
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
             paste("\n###################################################################################"),
             paste("\nClusterprüfung: ",if(Clusterprüfung==TRUE){"Ja"},if(Clusterprüfung==FALSE){"Nein"},sep=""),
             if(Clusterprüfung==TRUE){paste(" -Anzahl der Spalten: ", Anzahl.Spalten)},
             if(Clusterprüfung==TRUE){paste(if(Quadrate ==TRUE){" -Quadrate: Ja  \n -Anzahl der Reihen: Berechnet aus Anzahl der Spalten"},if(Quadrate==FALSE){paste(" -Anzahl der Reihen:",Anzahl.Reihen)},sep="")},
             if(Clusterprüfung==TRUE){paste(" -Darstellungen: ",if(Darstellungen.Clusterprüfung==TRUE){"Ja"},if(Darstellungen.Clusterprüfung==FALSE){"Nein"},sep="")},
             paste("\n###################################################################################")
             
             
             
             
             
           ),paste(Speicherort,"/04 - Log/",format(Sys.time(),"%y%m%d_%H.%M.%S"),"_",Projekt,"_",Charge,"_",Durchgeführt,"_",Version,".txt",sep=""))


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
             paste("\nVerwendete Partikelklassierung:"),
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
             paste("\n###################################################################################"),
             paste("\nClusterprüfung: ",if(Clusterprüfung==TRUE){"Ja"},if(Clusterprüfung==FALSE){"Nein"},sep=""),
             if(Clusterprüfung==TRUE){paste(" -Anzahl der Spalten: ", Anzahl.Spalten)},
             if(Clusterprüfung==TRUE){paste(if(Quadrate ==TRUE){" -Quadrate: Ja  \n -Anzahl der Reihen: Berechnet aus Anzahl der Spalten"},if(Quadrate==FALSE){paste(" -Anzahl der Reihen:",Anzahl.Reihen)},sep="")},
             if(Clusterprüfung==TRUE){paste(" -Darstellungen: ",if(Darstellungen.Clusterprüfung==TRUE){"Ja"},if(Darstellungen.Clusterprüfung==FALSE){"Nein"},sep="")},
             paste("\n###################################################################################")
             
             
             
             
             
             
             
           ),paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Log_",Projekt,"_",Charge,"_",Durchgeführt,"_",Version,".txt",sep=""))



