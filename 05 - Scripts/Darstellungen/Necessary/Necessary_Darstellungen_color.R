#Necessary for plots

Total.Plots <- Total.Samples


if(language=="deutsch")
{
  x.Achse <- paste(plot.x,"-Gehalt in Ma.-%",sep = "")
  y.Achse <- paste(plot.y,"-Gehalt in Ma.-%",sep = "")
  Titel.Legende <- paste("Klassen") #muss angepasst werden, falls in z keine Gehalte dargestellt wird 
  
  if(plot.x=="DAVE")
  {
    x.Achse <- paste(plot.x," in µm",sep = "")
  }
  if(plot.x=="AREA")
  {
    x.Achse <- paste("Partikelfläche in µm²",sep = "")
  }
  if(plot.x=="Dequi")
  {
    x.Achse <- paste("Äquivalentdurchmesser in µm",sep = "")
  }
  if(plot.x=="X_ABS")
  {
    x.Achse <- paste("x-Position in mm",sep = "")
  }
  if(plot.x=="ASPECT")
  {
    x.Achse <- paste("ASPECT-Verhältnis",sep = "")
  }
  
  
  
  if(plot.y=="DAVE")
  {
    y.Achse <- paste(plot.y," in µm",sep = "")
  }
  if(plot.y=="AREA")
  {
    y.Achse <- paste("Partikelfläche in µm²",sep = "")
  }
  if(plot.y=="Dequi")
  {
    y.Achse <- paste("Äquivalentdurchmesser in µm",sep = "")
  }
  if(plot.y=="Y_ABS")
  {
    y.Achse <- paste("y-Position in mm",sep = "")
  }
  if(plot.y=="ASPECT")
  {
    y.Achse <- paste("ASPECT-Verhältnis",sep = "")
  }
}

if(language=="englisch")
{
  x.Achse <- paste(plot.x,"-content in wt%",sep = "")
  y.Achse <- paste(plot.y,"-conent in wt%",sep = "")
  Titel.Legende <- paste("Classes") #muss angepasst werden, falls in z keine Gehalte dargestellt wird 
  if(plot.x=="DAVE")
  {
    x.Achse <- paste(plot.x," in µm",sep = "")
  }
  if(plot.x=="AREA")
  {
    x.Achse <- paste("Particle area in µm²",sep = "")
  }
  if(plot.x=="Dequi")
  {
    x.Achse <- paste("Equivalent diameter in µm",sep = "")
  }
  if(plot.x=="X_ABS")
  {
    x.Achse <- paste("x-position in mm",sep = "")
  }
  if(plot.x=="ASPECT")
  {
    x.Achse <- paste("ASPECT ratio",sep = "")
  }
  
  
  
  if(plot.y=="DAVE")
  {
    y.Achse <- paste(plot.y," in µm",sep = "")
  }
  if(plot.y=="AREA")
  {
    y.Achse <- paste("Particle area in µm²",sep = "")
  }
  if(plot.y=="Dequi")
  {
    y.Achse <- paste("Equivalent diameter in µm",sep = "")
  }
  if(plot.y=="Y_ABS")
  {
    y.Achse <- paste("y-position in mm",sep = "")
  }
  if(plot.y=="ASPECT")
  {
    y.Achse <- paste("ASPECT ratio",sep = "")
  }
  
  
}


Ierror <- tryCatch(
  {
    i <- 1
    SampleNr <- Samples[i]
    Datensatz <- read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[i]),"_all_Particles_combined_",Version,".csv",sep=""), header=TRUE, dec=",", sep=";",fileEncoding = "ISO-8859-1")
    #Datensatz <- read.table(paste(Speicherort,"/01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[i]),"_all_Particles_",Version,"_normiert.csv",sep=""), header=TRUE, dec=",", sep=";")
    #Datensatz <- read.table(paste(Speicherort,"/01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[i]),"_all_Particles_Ratio",Version,".csv",sep=""), header=TRUE, dec=",", sep=";")
    assign(SampleNr, Datensatz) # Schreiben von Datensatz in eine Variable mit dem Namen von dem in "SampleNr" gespeicherten String 
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
  for(i in 1:Total.Samples)
  {
    if(Ierror==0)
    {
      SampleNr <- Samples[i]
      Ierror <- tryCatch(
        {
          Datensatz <- read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[i]),"_all_Particles_combined_",Version,".csv",sep=""), header=TRUE, dec=",", sep=";",fileEncoding = "ISO-8859-1")
          #Datensatz <- read.table(paste(Speicherort,"/01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[i]),"_all_Particles_",Version,"_normiert.csv",sep=""), header=TRUE, dec=",", sep=";")
          #Datensatz <- read.table(paste(Speicherort,"/01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[i]),"_all_Particles_Ratio",Version,".csv",sep=""), header=TRUE, dec=",", sep=";")
          Ierror <- 0
        }
        ,
        error=function(cond)
        {
          closeSweetAlert(session)
          sendSweetAlert(session, title=paste("Notwendinge Daten sind nicht vorhanden. Bitte zunächst Partikelklassierung ausführen.",sep=""), type="error",width=1200)
          return(1)
        },
        warning=function(cond)
        {
          closeSweetAlert(session)
          sendSweetAlert(session, title=paste("Notwendinge Daten sind nicht vorhanden. Bitte zunächst Partikelklassierung ausführen.",sep=""), type="error",width=1200)
          return(1)
        }
        
      )
      
      assign(SampleNr, Datensatz) # Schreiben von Datensatz in eine Variable mit dem Namen von dem in "SampleNr" gespeicherten String 
    }
    
  }
  
}else{
  Ierror <- 0
  for(i in 1:Total.Samples)
  {
    
    if(Ierror==0)
    {
      SampleNr <- Samples[i]
      Ierror <- tryCatch(
        {
          Datensatz <- read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[i]),"_all_Particles_",Version,".csv",sep=""), header=TRUE, dec=",", sep=";",fileEncoding = "ISO-8859-1")
          #Datensatz <- read.table(paste(Speicherort,"/01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[i]),"_all_Particles_",Version,"_normiert.csv",sep=""), header=TRUE, dec=",", sep=";")
          #Datensatz <- read.table(paste(Speicherort,"/01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[i]),"_all_Particles_Ratio",Version,".csv",sep=""), header=TRUE, dec=",", sep=";")        Ierror <- 0
        }
        ,
        error=function(cond)
        {
          closeSweetAlert(session)
          sendSweetAlert(session, title=paste("Notwendinge Daten sind nicht vorhanden. Bitte zunächst Partikelklassierung ausführen.",sep=""), type="error",width=1200)
          return(1)
        },
        warning=function(cond)
        {
          closeSweetAlert(session)
          sendSweetAlert(session, title=paste("Notwendinge Daten sind nicht vorhanden. Bitte zunächst Partikelklassierung ausführen.",sep=""), type="error",width=1200)
          return(1)
        }
        
      )
      
      
      
      assign(SampleNr, Datensatz) # Schreiben von Datensatz in eine Variable mit dem Namen von dem in "SampleNr" gespeicherten String 
    }
  }
}


if(Ierror==0)
{
  
  
  
  if(Farbig==TRUE)
  {
    source("05 - Scripts/Darstellungen/Necessary/Farbeinstellungen_Farbe.R",local = TRUE)
  }
  if(Farbig==FALSE)
  {
    source("05 - Scripts/Darstellungen/Necessary/Farbeinstellungen_Graustufen.R",local = TRUE)
  }
  
  
  source("05 - Scripts/Darstellungen/Necessary/Farbdefinition_unterschiedliche_Klassenanzahl.R",local = TRUE)
  source("05 - Scripts/Darstellungen/Necessary/Symboldefinition_unterschiedliche_Klassenanzahl.R",local = TRUE)
  source("05 - Scripts/Darstellungen/Necessary/Farbdefinition_unterschiedliche_Klassenanzahl_Rand.R",local = TRUE)
  
  
  
  
  
  
  
  
  #Variablen, die jeweilige Bedingung für Farbe und Symbol aus der Datei "Farbdefinition...." bzw. "Symboldefinition" in Abhängigkeit von der Anzahl an dargestellten Klassen abrufen 
  Col.Anzahl.Klassen <- paste("Col.Anzahl.Klassen.",Darstellungen.Klassen.Anzahl,sep="")
  Col.Rand.Anzahl.Klassen <- paste("Col.Rand.Anzahl.Klassen.",Darstellungen.Klassen.Anzahl,sep="")
  
  Symbol.Anzahl.Klassen <- paste("Symbol.Anzahl.Klassen.",Darstellungen.Klassen.Anzahl,sep = "")
  
  
  #generiert Variable zum Abrufen der Klassentitel, die in der Legende erscheinen sollen 
  Klassentitel <- paste("Klasse.",1:Darstellungen.Klassen.Anzahl,sep="")
  Inhalt.Legende <- 0
  for(s in 1:Darstellungen.Klassen.Anzahl)
  {
    Inhalt.Legende[s] <- get(Klassentitel[s])   
  }
  
  #generiert String mit allen verwendeten Klassen für Speicherung, Abbildungstitel etc.
  if(Klassennamen.in.Datei==TRUE)
  {
    Name.String <- get(Klassentitel[1]) 
    if(Darstellungen.Klassen.Anzahl>=2)
    {
      for(v in 2:Darstellungen.Klassen.Anzahl)
      {
        Name.String <- paste(Name.String,"_",get(Klassentitel[v]),sep="")
      }
    }
  }else{Name.String <- paste(Darstellungen.Klassen.Anzahl,"_Klassen")}
  
  
  
  #generiert Variable zum Abrufen der Symbole in der Legende
  Legendensymbole <- paste("Symbol.",1:Darstellungen.Klassen.Anzahl,sep="")
  Symbole.Legende <- 0
  for(t in 1:Darstellungen.Klassen.Anzahl)
  {
    Symbole.Legende[t] <- get(Legendensymbole[t])
  }
  
  
  ## generiert Variable zum Abrufen der Farbdefinitionen für die Legende
  Farbe.Legende <- paste("Farbe.Legende.",1:Darstellungen.Klassen.Anzahl,sep="")
  Col.Legende <- 0
  for(r in 1:Darstellungen.Klassen.Anzahl)
  {
    Col.Legende[r] <- eval(get(Farbe.Legende[r])) 
  }
  ## generiert Variable zum Abrufen der Farbdefinitionen für die Legende, Rand der Symbole
  Farbe.Legende.Rand <- paste("Farbe.Rand.",1:Darstellungen.Klassen.Anzahl,sep="")
  Col.Legende.Rand <- 0
  for(u in 1:Darstellungen.Klassen.Anzahl)
  {
    Col.Legende.Rand[u] <- eval(get(Farbe.Legende.Rand[u])) 
  }
  
  
  
  ##############################################################################################
  #tatsächlicher Plot
  #Abfragung, ob  in Z etwas dargestellt werden soll 
  
  if(plot.z=="kein Helligkeitsverlauf")
  {
    plot.z <- "PART"
    Maximum <- 1
    kein.z <- TRUE
  }else
  {
    kein.z <- FALSE
  }
  
  if(gradient==TRUE)
  {
    if(language=="deutsch")
    {
      if(kein.z==FALSE)
      {
        if(plot.z=="DAVE")
        {
          Inhalt.Legende <- c(Inhalt.Legende,paste("Helligkeitsverlauf:"),paste(plot.z," = 0 µm",sep=""), paste(plot.z," = ",Maximum," µm",sep=""))
        }else{
          if(plot.z=="AREA")
          {
            Inhalt.Legende <- c(Inhalt.Legende,paste("Helligkeitsverlauf:"),paste("Area = 0 µm²",sep=""), paste("Area = ",Maximum," µm²",sep=""))
          }else{
            if(plot.z=="Dequi")
            {
              Inhalt.Legende <- c(Inhalt.Legende,paste("Helligkeitsverlauf:"),paste("Äquivalentdurchmesser = 0 µm",sep=""), paste("Äquivalentdurchmesser = ",Maximum," µm",sep=""))
            }else{
              
              Inhalt.Legende <- c(Inhalt.Legende,paste("Helligkeitsverlauf:"),paste(plot.z,"-Content = 0 Ma.-%",sep=""), paste(plot.z,"-Content = ",Maximum," Ma.-%",sep=""))
              
              
              
            }}}}
    }
    
    
    if(language=="englisch")
    {
      if(kein.z==FALSE)
      {
        if(plot.z=="DAVE")
        {
          Inhalt.Legende <- c(Inhalt.Legende,paste("Brightness gradient:"),paste(plot.z," = 0 µm",sep=""), paste(plot.z," = ",Maximum," µm",sep=""))
        }else{
          if(plot.z=="AREA")
          {
            Inhalt.Legende <- c(Inhalt.Legende,paste("Brightness gradient:"),paste("Area = 0 µm²",sep=""), paste("Area = ",Maximum," µm²",sep=""))
          }else{
            if(plot.z=="Dequi")
            {
              Inhalt.Legende <- c(Inhalt.Legende,paste("Brightness gradient:"),paste("Equivalent diameter = 0 µm",sep=""), paste("Equivalent diameter = ",Maximum," µm",sep=""))
            }else{
              
              Inhalt.Legende <- c(Inhalt.Legende,paste("Brightness gradient:"),paste(plot.z,"-content = 0 wt%",sep=""), paste(plot.z,"-content = ",Maximum," wt%",sep=""))
              
              
              
            }}}}
    }
    
    
    
    
    
    
    Symbole.Legende <- c(Symbole.Legende,pch=4,Symbol.Verlauf.low,Symbol.Verlauf.high)
    Col.Legende <- c(Col.Legende,rgb(255,255,255,max=255), eval(Farbe.Verlauf.low),eval(Farbe.Verlauf.high))
  }
  a <- 0
  b <- 0
  #Erzeugung eines Graphic-Device
  Ierror <- tryCatch(
    {
      pdf(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Darstellungen/nach Klassen/",plot.x,"_vs_",plot.y,"_vs_",plot.z,"__",Name.String,"_farbig_",Version,".pdf",sep=""),width= 8.27, height = 11.69)
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
  if(Ierror==0)
  {
    
    
    Schrittweite <- 100/Total.Plots
    par(mfrow=c(figure.rows,figure.col),mar=c(5,5,4,2))
    if(Symbole.Füllung==TRUE)
    {
      for(j in 1:Total.Plots)
      {
        updateProgressBar(session, id= "progress.Darstellungen", title = "Darstellungen erzeugen...",  value = j*Schrittweite)
        Sample<- get(Samples[j]) 
        
        Messfläche <- get(Messfläche.all[j])
        #Title.Sample <- paste(get(Title.Sample.all[j]),"-",Name.String,sep="")
        Title.Sample <- paste(get(displayed.Title.Sample.all[j]),sep="")
        dum <- (ifelse(((Sample[,plot.z]/Maximum)+0.2)<=1,((Sample[,plot.z]/Maximum))+0.2,1))
        plot(x=Sample[,plot.x], y=Sample[,plot.y], xlim = Skalierung.x, ylim = Skalierung.y, 
             col=eval(get(Col.Rand.Anzahl.Klassen)), 
             bg= eval(get(Col.Anzahl.Klassen)),
             pch= eval(get(Symbol.Anzahl.Klassen)),
             main = Title.Sample, xlab = x.Achse, ylab = y.Achse, cex.axis=fontsize.axis, cex.lab = fontsize.lab, cex.main=fontsize.main, cex = size.symbols)
        legend(x=Position.Legende.x,y=Position.Legende.y,legend=Inhalt.Legende, cex=fontsize.legend, pt.cex = fontsize.legendpt, y.intersp = 0.7, yjust = 0.8, bty = "n", text.width = 2,
               col=Col.Legende.Rand, 
               pt.bg=Col.Legende, pch = Symbole.Legende, title = Titel.Legende)
        
      }
      
      
    }
    if(Symbole.Füllung==FALSE)
    {
      for(j in 1:Total.Plots)
      {
        updateProgressBar(session, id= "progress.Darstellungen", title = "Darstellungen erzeugen...",  value = j*Schrittweite)
        Sample<- get(Samples[j]) 
        
        Messfläche <- get(Messfläche.all[j])
        Title.Sample <- paste(get(Title.Sample.all[j]),"-",Name.String,sep="")
        dum <- (ifelse(((Sample[,plot.z]/Maximum)+0.2)<=1,((Sample[,plot.z]/Maximum))+0.2,1))
        plot(x=Sample[,plot.x], y=Sample[,plot.y], xlim = Skalierung.x, ylim = Skalierung.y, 
             col= eval(get(Col.Anzahl.Klassen)),
             pch= eval(get(Symbol.Anzahl.Klassen)),
             main = Title.Sample, xlab = x.Achse, ylab = y.Achse, cex.axis=fontsize.axis, cex.lab = fontsize.lab, cex.main=fontsize.main, cex = size.symbols)
        legend(x=Position.Legende.x,y=Position.Legende.y,legend=Inhalt.Legende, cex=fontsize.legend, pt.cex = fontsize.legendpt, y.intersp = 0.7, yjust = 0.8, bty = "n", text.width = 2,
               col=Col.Legende, pch = Symbole.Legende, title = Titel.Legende)
        
      }
    }
    
    
    dev.off()
  }
}