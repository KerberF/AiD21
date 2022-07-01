#Prüft die Verteilung der Partikel über die Messfläche 

#nötige Variablen
Bestimmung.Feldabmessung.y <- data.frame(1,2)
dum10 <- data.frame(row.names = c(1),matrix(1:(Total.Classes),nrow=1,ncol=Total.Classes))
colnames(dum10) <- used.Classes

#Variablen für Eigenschaften.R





#Einlesen der Daten 
for(i in 1:Total.Samples)
{
  #Öffnen einer PDF
  if(Darstellungen.Clusterprüfung==TRUE)
  {
    Ierror <- tryCatch(
      {
        pdf(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Clusterprüfung/Darstellungen/",get(Title.Sample.all[i]),"_Balkendiagramme_",Version,".pdf",sep=""),width= 8.27, height = 11.69)
        Ierror <- 0
      }
      ,
      error=function(cond)
      {
        closeSweetAlert(session)
        sendSweetAlert(session, title=paste("Datei ",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Darstellungen/gesamt/",plot.x,"_vs_",plot.y,"_vs_",plot.z,"_Sample_1-",Total.Plots,"_",Version,".pdf bereits geöffnet. Bitte Datei schließen oder unter neuer Version abspreichern.",sep=""), type="error",width=1200)
        return(1)
      },
      warning=function(cond)
      {
        closeSweetAlert(session)
        sendSweetAlert(session, title=paste("Datei ",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Darstellungen/gesamt/",plot.x,"_vs_",plot.y,"_vs_",plot.z,"_Sample_1-",Total.Plots,"_",Version,".pdf bereits geöffnet. Bitte Datei schließen oder unter neuer Version abspreichern.",sep=""), type="error",width=1200)
        return(1)
      }
      
    )
    
    par(mfrow=c(2,1))
  }
  if(Ierror==0)
  { 
    Datensatz <- read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[i]),"_all_Particles_",Version,".csv",sep=""), header=TRUE, dec=",", sep=";", fileEncoding = "ISO-8859-1")
    #Bestimmung der Feldgröße
    xmin <- min(Datensatz$X_ABS)
    xmax <- max(Datensatz$X_ABS)
    ymin <- min(Datensatz$Y_ABS)
    ymax <- max(Datensatz$Y_ABS)
    Abmessung.x = xmax-xmin
    Abmessung.y = ymax-ymin
    if(Quadrate==TRUE)
    {
      Feldabmessung.x = Abmessung.x/Anzahl.Spalten
      for(z in 1:20)
      {
        Bestimmung.Feldabmessung.y[z,1] <- abs(Feldabmessung.x - (Abmessung.y/z))
        Bestimmung.Feldabmessung.y[z,2] <- z
        
      }
      Min.Bestimmung.Feldabessungen <- Bestimmung.Feldabmessung.y[which.min(Bestimmung.Feldabmessung.y$X1),]
      Anzahl.Reihen <- Min.Bestimmung.Feldabessungen$X2
      Feldabmessung.y = Abmessung.y/Anzahl.Reihen
    }else{
      Feldabmessung.x = Abmessung.x/Anzahl.Spalten
      Feldabmessung.y = Abmessung.y/Anzahl.Reihen
    }
    
    #Variable für Ergebnisse
    dum5 <- data.frame(matrix(1:(Anzahl.Reihen*Anzahl.Spalten),ncol=Anzahl.Spalten,nrow=Anzahl.Reihen, byrow = TRUE), row.names = c(paste("Reihe_",1:Anzahl.Reihen,sep="")))
    colnames(dum5) <- c(paste("Spalte_",1:Anzahl.Spalten,sep=""))
    Ergebnis <- data.frame(dum5)
    Ergebnis.sum <- data.frame(dum10)
    Feldposition <- data.frame(matrix(1:3, byrow = TRUE,ncol = 3))
    s <-1  
    for(t in 1:Anzahl.Reihen)
    {
      for(u in 1:Anzahl.Spalten)
      {
        Feldposition[s,1] <- s
        Feldposition[s,3] <- (Anzahl.Reihen-t)
        Feldposition[s,2] <- (u)
        s <- s+1
      }
    }
    #Darstellung der Feldnummern in einem x-y Diagramm
    plot(x=Feldposition$X2, y=Feldposition$X3,  axes=FALSE, frame.plot = TRUE, xlab="Ausdehnung der Messfläche in x-Richtung", ylab="Ausdehung der Messfläche in y-Richtung", type="n", xlim = c(0,(Anzahl.Spalten+1)), main = "Feldnummerierung und deren Positionierung")
    text(x=Feldposition$X2, y=Feldposition$X3, labels = Feldposition$X1, pos = 4)
    #Auszählen der Partikel pro Feld 
    for(j in 1:Total.Classes)
    {
      Datensatz <- read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/nach Klassen/",get(Classes[j]),"_",get(Title.Sample.all[i]),"_",Version,".csv",sep=""), header=TRUE, dec=",", sep=";", fileEncoding = "ISO-8859-1")
      Field.Nr <- 1 
      if(length(Datensatz$PART)==0)
      { 
        for(l in 1:Anzahl.Reihen)
        {
          for(m in 1:Anzahl.Spalten)
          {
            Ergebnis[l,m] <- 0
            Ergebnis.sum[Field.Nr,j] <- 0
            #Erhöhrung der Fieldnummer
            Field.Nr = Field.Nr + 1
          }
        }
      } else{
        for(l in 0:(Anzahl.Reihen-1))
        {
          for(m in 1:Anzahl.Spalten)
          {
            Anzahl.pro.Field <- 0
            for(k in 1:length(Datensatz$PART))
            {
              if(Datensatz$X_ABS[k]<=(m*Feldabmessung.x) & Datensatz$X_ABS[k] >= ((m-1)*Feldabmessung.x) & Datensatz$Y_ABS[k]<=((Anzahl.Reihen-l)*Feldabmessung.y) & Datensatz$Y_ABS[k] >= ((Anzahl.Reihen-l-1)*Feldabmessung.y))
              {
                Anzahl.pro.Field = Anzahl.pro.Field+1
              } 
            }      
            Ergebnis[(Anzahl.Reihen-l),m] <- Anzahl.pro.Field 
            Ergebnis.sum[Field.Nr,j] <- Anzahl.pro.Field
            #Erhöhrung der Fieldnummer
            Field.Nr = Field.Nr + 1
            
          }
        } 
        
      }
      write.csv2(Ergebnis, file =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Clusterprüfung/Matrizen/nach Klassen/",get(Classes[j]),"_",get(Title.Sample.all[i]),"_Partikelmatrix_",Version,".csv",sep="")) 
      write.csv2(Ergebnis, file =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Clusterprüfung/Matrizen/nach Proben/",get(Title.Sample.all[i]),"_",get(Classes[j]),"_Partikelmatrix_",Version,".csv",sep=""))   
      
      
      #Entfernen aller NAs 
      for(l in 1:length(Ergebnis.sum[,j])) 
      {
        
        if(is.na(Ergebnis.sum[l,j]))
        {
          Ergebnis.sum[l,j] <- 0
        }
        
      }#Ende Entfernen NAs 
      
      
      if(Darstellungen.Clusterprüfung==TRUE)
      {
        #Darstellung Barplots, Höhe = Anzahl der Partikel in jeweiligem Feld
        barplot(Ergebnis.sum[,j], names.arg = c(1:(Anzahl.Reihen*Anzahl.Spalten)), xlab = "Feld-Nummer", ylab = "Anzahl der Partikel", main = paste(get(Classes[j])), axis.lty = 1, cex.names = 1, cex.main =1.5, cex.axis = 1, cex.lab = 1.2, las = 1
                , col="darkred")
        
      }
    }
    
    write.csv2(Ergebnis.sum, file =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Clusterprüfung/Partikel pro Feld/",get(Title.Sample.all[i]),"_Partikel_pro_Feld_",Version,".csv",sep="")) 
    if(Darstellungen.Clusterprüfung==TRUE)
    {
      dev.off()
    }
    
    #Mittelwertbildung 
    for(l in 1:length(Ergebnis.sum[1,])) 
    {
      avg <- round(mean(Ergebnis.sum[,l]),3)
      standard <- round(sd(Ergebnis.sum[,l]),3) 
      median  <-  median(Ergebnis.sum[,l]) 
      min  <-  min(Ergebnis.sum[,l]) 
      max  <-  max(Ergebnis.sum[,l]) 
      
      Partikel.pro.Field[1,l] <-avg 
      Partikel.pro.Field[2,l] <-standard 
      if(avg>0)
      {
        Partikel.pro.Field[3,l] <-round((standard/avg),3) 
      } else {Partikel.pro.Field[3,l] <- 0}
      Partikel.pro.Field[4,l] <-median 
      Partikel.pro.Field[5,l] <-min 
      Partikel.pro.Field[6,l] <-max 
    }#Ende Mittelwert
    write.csv2(Partikel.pro.Field, file =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Clusterprüfung/Statistische Auswertung/nach Proben/",get(Title.Sample.all[i]),"_",Charge,"_Clusterprüfung_",Version,".csv",sep=""))
    
    
    
    Summary.Partikel.pro.Field[i+1,] <- data.frame(Partikel.pro.Field[1,]) 
    Summary.Partikel.pro.Field[i+2+Total.Samples,] <- data.frame(Partikel.pro.Field[2,])   
    Summary.Partikel.pro.Field[i+3+2*Total.Samples,] <- data.frame(Partikel.pro.Field[3,])   
    Summary.Partikel.pro.Field[i+4+3*Total.Samples,] <- data.frame(Partikel.pro.Field[4,])   
    Summary.Partikel.pro.Field[i+5+4*Total.Samples,] <- data.frame(Partikel.pro.Field[5,])
    Summary.Partikel.pro.Field[i+6+5*Total.Samples,] <- data.frame(Partikel.pro.Field[6,])
    
  }}
if(Ierror==0)
{
  Summary.Partikel.pro.Field[1,] <- c(rep(0,times=Total.Classes))
  Summary.Partikel.pro.Field[Total.Samples+2,] <- c(rep(0,times=Total.Classes))
  Summary.Partikel.pro.Field[2*Total.Samples+3,] <- c(rep(0,times=Total.Classes))
  Summary.Partikel.pro.Field[3*Total.Samples+4,] <- c(rep(0,times=Total.Classes))
  Summary.Partikel.pro.Field[4*Total.Samples+5,] <- c(rep(0,times=Total.Classes))
  Summary.Partikel.pro.Field[5*Total.Samples+6,] <- c(rep(0,times=Total.Classes))
  
  #Reihennamen
  Mittelwert.used.Samples <- 0
  for(i in 1:Total.Samples) #Füllen des Vektors mit allen in der Analyse verwendeten Samples
  {Mittelwert.used.Samples[i] <- (paste("Mittelwert_",get(Title.Sample.all[i]),sep=""))} #Erstellt Vektor mit Namen aller eingesetzten Klassen 
  
  Standardabweichung.used.Samples <- 0
  for(i in 1:Total.Samples) #Füllen des Vektors mit allen in der Analyse verwendeten Samples
  {Standardabweichung.used.Samples[i] <- (paste("Standardabweichung_",get(Title.Sample.all[i]),sep=""))} #Erstellt Vektor mit Namen aller eingesetzten Klassen 
  
  rel.Standardabweichung.used.Samples <- 0
  for(i in 1:Total.Samples) #Füllen des Vektors mit allen in der Analyse verwendeten Samples
  {rel.Standardabweichung.used.Samples[i] <- (paste("rel. Standardabweichung_",get(Title.Sample.all[i]),sep=""))} #Erstellt Vektor mit Namen aller eingesetzten Klassen 
  
  Median.used.Samples <- 0
  for(i in 1:Total.Samples) #Füllen des Vektors mit allen in der Analyse verwendeten Samples
  {Median.used.Samples[i] <- (paste("Median_",get(Title.Sample.all[i]),sep=""))} #Erstellt Vektor mit Namen aller eingesetzten Klassen 
  
  Minimum.used.Samples <- 0
  for(i in 1:Total.Samples) #Füllen des Vektors mit allen in der Analyse verwendeten Samples
  {Minimum.used.Samples[i] <- (paste("Minimum_",get(Title.Sample.all[i]),sep=""))} #Erstellt Vektor mit Namen aller eingesetzten Klassen 
  
  Maximum.used.Samples <- 0
  for(i in 1:Total.Samples) #Füllen des Vektors mit allen in der Analyse verwendeten Samples
  {Maximum.used.Samples[i] <- (paste("Maximum_",get(Title.Sample.all[i]),sep=""))} #Erstellt Vektor mit Namen aller eingesetzten Klassen 
  Platzhalter1 <- c("--Mittelwert--")
  Platzhalter2 <- c("--Standardabweichung--")
  Platzhalter3 <- c("--rel.Standardabweichung--")
  Platzhalter4 <- c("--Median--")
  Platzhalter5 <- c("--Minimum--")
  Platzhalter6 <- c("--Maximum--")
  
  
  row.names(Summary.Partikel.pro.Field) <- c(Platzhalter1,Mittelwert.used.Samples,Platzhalter2,Standardabweichung.used.Samples,Platzhalter3,rel.Standardabweichung.used.Samples,Platzhalter4,Median.used.Samples,Platzhalter5,Minimum.used.Samples,Platzhalter6,Maximum.used.Samples)
  
  
  
  Ierror <- safewrite.csv(Summary.Partikel.pro.Field, filename =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Clusterprüfung/Clusterprüfung_Zusammenfassung_",Charge,"_",Version,".csv",sep=""))
  
  if(Ierror==0)
  {
    Summary.Clusterprüfung.nach.Klassen <- data.frame(row.names = used.Samples,matrix(1:6*Total.Samples,nrow=Total.Samples,ncol=6))
    colnames(Summary.Clusterprüfung.nach.Klassen) <- c("Mittelwert","Standardabweichung","rel. Standardabweichung","Median","Maximum","Minimum")
    
    for(i in 1:Total.Classes)
    {
      aktuelle.Klasse <-get(Classes[i])
      for(j in 1:6)
      {
        for(k in 1:Total.Samples)
        { 
          Summary.Clusterprüfung.nach.Klassen[k,j] <-Summary.Partikel.pro.Field[k*j,i]   
        }  
      }
      Ierror <- safewrite.csv(Summary.Clusterprüfung.nach.Klassen, filename =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Clusterprüfung/Statistische Auswertung/nach Klassen/",aktuelle.Klasse,"_",Charge,"_Clusterprüfung_",Version,".csv",sep=""))
    }
    
    
    
  }
  
}  






