##Darstellung zweier Variablen mit dritter Variable als Helligkeitgradient

#Voreinstellungen
Minimum <- 0
Total.Plots <- Total.Samples
Inhalt.Legende <- c("min","medium","max")
if(language=="deutsch")
{
  x.Achse <- paste(plot.x,"-Gehalt in Ma.-%",sep = "")
  y.Achse <- paste(plot.y,"-Gehalt in Ma.-%",sep = "")
  
  
  
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
  y.Achse <- paste(plot.y,"-content in wt%",sep = "")
  
  
  
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



if(plot.z=="kein Helligkeitsverlauf")
{
  plot.z <- "PART"
  Maximum <- 1
  kein.z <- TRUE
}else
{
  kein.z <- FALSE
}




if(language=="deutsch")
{
  
  
  Titel.Legende <- paste(plot.z," in Ma.-%",sep="") #muss angepasst werden, falls in z keine Gehalt dargestellt wird 
  
  if(plot.z=="DAVE")
  {
    Titel.Legende <- paste(plot.z," in µm",sep = "")
  }
  if(plot.z=="AREA")
  {
    Titel.Legende <- paste("Partikelfläche in µm²",sep = "")
  }
  if(plot.z=="Dequi")
  {
    Titel.Legende <- paste("Äquivalentdurchmesser in µm",sep = "")
  }
}


if(language=="englisch")
{
  
  
  Titel.Legende <- paste(plot.z," in wt%",sep="") #muss angepasst werden, falls in z keine Gehalt dargestellt wird 
  
  if(plot.z=="DAVE")
  {
    Titel.Legende <- paste(plot.z," in µm",sep = "")
  }
  if(plot.z=="AREA")
  {
    Titel.Legende <- paste("Particle area in µm²",sep = "")
  }
  if(plot.z=="Dequi")
  {
    Titel.Legende <- paste("Equivalent diameter in µm",sep = "")
  }
}

if(Darstellungen.Rohdaten==FALSE)#sonst werden die bereits eingelesenen Daten verwendet
{
  if(Daten.Normiert==FALSE)
  {
    for(i in 1:Total.Samples)
    {
      if(Ierror==0)
      {
        SampleNr <- Samples[i]
        Ierror <- tryCatch(
          {
            Datensatz <- read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[i]),"_",Version,"_all_Particles_unnormiert.csv",sep=""), header=TRUE, dec=",", sep=";",fileEncoding = "ISO-8859-1")
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
        if(Ierror==0)
        {
          assign(SampleNr, Datensatz)
        }
      }
    }
  }
  if(Daten.Normiert==TRUE)
  {
    for(i in 1:Total.Samples)
    {
      if(Ierror==0)
      {
        SampleNr <- Samples[i]
        Ierror <- tryCatch(
          {
            Datensatz <- read.table(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Messwerte normiert/",get(Title.Sample.all[i]),"_",Version,"_normiert.csv",sep=""), header=TRUE, dec=",", sep=";",fileEncoding = "ISO-8859-1")
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
        if(Ierror==0)
        {
          assign(SampleNr, Datensatz)
        }
      }
      
    }
  }
}


if(Ierror==0)
{
  #medium <- ((Maximum+Minimum)/2)
  
  a <- 0
  b <- 0
  Ierror <- tryCatch(
    {
      if(Darstellungsvariante=="Rohdaten")
      {
        pdf(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Darstellungen/gesamt/",plot.x,"_vs_",plot.y,"_vs_",plot.z,"_Sample_1-",Total.Plots,"_",Version,"_Rohdaten.pdf",sep=""),width= 8.27, height = 11.69)
      }else{
        if(Darstellungsvariante=="Hauptklassen normiert")
        {
          pdf(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Darstellungen/gesamt/",plot.x,"_vs_",plot.y,"_vs_",plot.z,"_Sample_1-",Total.Plots,"_",Version,"_Hauptklassen_normiert.pdf",sep=""),width= 8.27, height = 11.69)
        }else{
          if(Darstellungsvariante=="Hauptklassen unnormiert")
          {
            pdf(paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Darstellungen/gesamt/",plot.x,"_vs_",plot.y,"_vs_",plot.z,"_Sample_1-",Total.Plots,"_",Version,"_Hauptklassen_unnormiert.pdf",sep=""),width= 8.27, height = 11.69)
          }
        }}
      
      
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
    par(mfrow=c(figure.rows,figure.col),mar=c(5,5,4,2))
    Schrittweite <- 90/Total.Plots
    for(j in 1:Total.Plots)
    {
      updateProgressBar(session, id= "progress.Darstellungen", title = "Darstellungen erzeugen...",  value = 10+(j*Schrittweite))
      Sample<- get(Samples[j]) 
      
      #max <- round(max(Sample[,plot.z]),1) #generiert Daten für Legende, Achtung max wurde in Maximum geändert, min in Minimum, wegen überschneidung der Variablen in anderen Funktionen
      #medium <- round(((max(Sample[,plot.z])+min(Sample[,plot.z]))*0.5),1) #generiert Daten für Legende
      #min <- round(min(Sample[,plot.z]),1) #generiert Daten für Legende
      Inhalt.Legende <- c(Minimum,Maximum) #erzeugt Legendeninahlt
      Messfläche <- get(Messfläche.all[j])
      Title.Sample <- get(displayed.Title.Sample.all[j])
      #dum <- (Sample[,plot.z] - (min(Sample[,plot.z])-5)) / (max(Sample[,plot.z]) - (min(Sample[,plot.z])-5))
      #dum <- (Sample[,plot.z] - (min)) / (max - (min))
      dum7 <- (ifelse(((Sample[,plot.z]/Maximum)+0.2)<=1,((Sample[,plot.z]/Maximum))+0.2,1))
      plot(x=Sample[,plot.x], y=Sample[,plot.y], xlim = Skalierung.x, ylim = Skalierung.y, col=rgb(1-dum7,1-dum7,1-dum7),pch=16, main = Title.Sample, xlab = x.Achse, ylab = y.Achse, cex.axis=fontsize.axis, cex.lab = fontsize.lab, cex.main=fontsize.main, cex = size.symbols)
      if(kein.z==FALSE){
        legend(x=Position.Legende.x,y=Position.Legende.y,legend=Inhalt.Legende, cex=fontsize.legend, pt.cex = fontsize.legendpt, y.intersp = 0.7, yjust = 0.8, bty = "n", text.width = 2,col=c(rgb(1-min(dum7),1-min(dum7),1-min(dum7)),rgb(1-max(dum7),1-max(dum7),1-max(dum7))), pch = c(16,16), title = Titel.Legende)}else{}
      #par(new=TRUE)
      #plot(x=c(0,50), y=c(0,27.47), type="l",xlim = Skalierung.x, ylim = Skalierung.y, col="blue", main = Title.Sample, xlab = x.Achse, ylab = y.Achse)
      #par(new=TRUE)
      #plot(x=c(0,50), y=c(0,27.47), type="l",xlim = Skalierung.x, ylim = Skalierung.y, col="blue", main = Title.Sample, xlab = x.Achse, ylab = y.Achse)
      
      
      
      
    }
    
    
    
    dev.off()
    
  }
}
