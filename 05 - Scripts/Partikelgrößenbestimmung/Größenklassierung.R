#Größenklassierung
Cond.Merkmal <- parse(text=paste(Merkmal.Größenklassierung))

if(alle.Partikel==TRUE)
{
  for(k in 1:(Total.Größenklassen-1))
  {
    l <- (k+1)
    Gruppe <-  Sample.Gr.all[k]
    Data <- subset(Sample, eval(Cond.Merkmal) > get(Klassen.Grenzen[k]) & eval(Cond.Merkmal) <= get(Klassen.Grenzen[l]) )
    assign(Gruppe, Data)
    
  }
  
  Gruppe <- Sample.Gr.all[Total.Größenklassen]
  Data <- subset(Sample, eval(Cond.Merkmal) > get(Klassen.Grenzen[Total.Größenklassen]))
  assign(Gruppe, Data)
  
  
  for(z in 1:Total.Größenklassen) #Schreiben der Summarys
  {
    Summary.Partikelgröße[1:2,z] <- (dim(get(Sample.Gr.all[z])));
    Summary.Partikelgröße[2,z] <- round((Summary.Partikelgröße[1,z]*Referenzfläche/Messfläche),0);
  }
  
  #write.csv2(Summary.Partikelgröße, file =paste("Ergebnisse/",Charge,"/",Version,"/","Summary","/",Title.Sample,"_Summary_Partikelgröße.csv",sep=""))
  Summary.Partikelgröße.all[j,] <- data.frame(Summary.Partikelgröße[1,]) ; #Speicherung der Partikelgesamtanzahl
  Summary.Partikelgröße.all.norm[j,] <- data.frame(Summary.Partikelgröße[2,]) #Speicherung der normierten Partikelanzahl 
}

#######################################################
if(nach.Klassen==TRUE)
{
  for(a in 1:Total.Classes)
  {
    aktuelle.Klasse <- get(Classes[a]);
    
    for(k in 1:(Total.Größenklassen-1))
    {
      l <- (k+1);
      Gruppe <-  Sample.Gr.all[k];
      Data <- subset(Sample, eval(Cond.Merkmal) > get(Klassen.Grenzen[k]) & eval(Cond.Merkmal) <= get(Klassen.Grenzen[l])& Class==aktuelle.Klasse );
      assign(Gruppe, Data)
    };
    
    Gruppe <- Sample.Gr.all[Total.Größenklassen];
    Data <- subset(Sample, eval(Cond.Merkmal) > get(Klassen.Grenzen[Total.Größenklassen])& Class==aktuelle.Klasse);
    assign(Gruppe, Data);
    for(z in 1:Total.Größenklassen) #Schreiben der Summarys
    {
      Summary.Partikelgröße[1:2,z] <- (dim(get(Sample.Gr.all[z])));
      Summary.Partikelgröße[2,z] <- round((Summary.Partikelgröße[1,z]*Referenzfläche/Messfläche),0);
    };
    
    # write.csv2(Summary.Partikelgröße, file =paste("Ergebnisse/",Charge,"/",Version,"/","Summary","/",Title.Sample,"_Summary_Partikelgröße_",aktuelle.Klasse,".csv",sep="")) 
    
    
    Summary.Partikelgröße.Klassen[a,] <- data.frame(Summary.Partikelgröße[1,]) ; #Speicherung der Partikelgesamtanzahl
    Summary.Partikelgröße.Klassen.norm[a,] <- data.frame(Summary.Partikelgröße[2,]) #Speicherung der normierten Partikelanzahl 
    
    
  }
  
  ##Speicherung der Zusammenfassung
  row.names(Summary.Partikelgröße.Klassen) <- used.Classes
  row.names(Summary.Partikelgröße.Klassen.norm) <- used.Classes
  
  Ierror <- safewrite.csv(Summary.Partikelgröße.Klassen, filename =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Partikelgröße/nach Proben/",Title.Sample,"_",Charge,"_Partikelgrößen_",Version,".csv",sep=""))
  if(Ierror==0)
  {
    Ierror <- safewrite.csv(Summary.Partikelgröße.Klassen.norm, filename =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Partikelgröße/nach Proben/",Title.Sample,"_",Charge,"_Partikelgrößen_flächennormiert_",Version,".csv",sep=""))
  }
  
  
}