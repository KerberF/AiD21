##Darstellung zweier Variablen mit dritter Variable als Helligkeitgradient

#Voreinstellungen


Total.Plots <- Total.Samples
Skalierung.x <- c(0,60)
Skalierung.y <- c(0,40)
Position.Legende.x <- 0
Position.Legende.y <- 38
Inhalt.Legende <- c("min","medium","max")
plot.x <- "Al"
plot.y <- "Ca"
plot.z <- "Mg"
figure.rows <- 4 #Anzahl an Abbildungen pro Spalte 
figure.col <- 3
x.Achse <- paste(plot.x,"-Gehalt in At.-%",sep = "")
y.Achse <- paste(plot.y,"-Gehalt in At.-%",sep = "")
Titel.Legende <- paste(plot.z," in At.-%",sep="") #muss angepasst werden, falls in z keine Gehalt dargestellt wird 

library(ade4)
a <- 0
b <- 0
windows(width= 8.27, height = 11.69)

par(mfrow=c(figure.rows,figure.col))
j <- 7
for(j in 1:Total.Plots)
{
  Sample<- get(Samples[j]) 
  #max <- round(max(Sample[,plot.z]),1) #generiert Daten für Legende
  #medium <- round(((max(Sample[,plot.z])+min(Sample[,plot.z]))*0.5),1) #generiert Daten für Legende
  #min <- round(min(Sample[,plot.z]),1) #generiert Daten für Legende
  #Inhalt.Legende <- c(min,medium,max) #erzeugt Legendeninahlt
  #Messfläche <- get(Messfläche.all[j])
  Title.Sample <- get(Title.Sample.all[j])
  #dum <- (Sample[,plot.z] - (min(Sample[,plot.z])-5)) / (max(Sample[,plot.z]) - (min(Sample[,plot.z])-5))
  
  data.dreieck <- data.frame(Sample[,plot.x],Sample[,plot.y],Sample[,plot.z])
  colnames(data.dreieck)<- c(paste(plot.x),paste(plot.y,"\n",Title.Sample),paste(plot.z))
  triangle.plot(data.dreieck, clab=0, cpoi=1, addmean = FALSE, show=FALSE, min3 = c(0,0,0))
  
  #plot(x=Sample[,plot.x], y=Sample[,plot.y], xlim = Skalierung.x, ylim = Skalierung.y, col=rgb(1-dum,1-dum,1-dum),pch=16, main = Title.Sample, xlab = x.Achse, ylab = y.Achse)
  #legend(x=Position.Legende.x,y=Position.Legende.y,legend=Inhalt.Legende, cex=1.3, pt.cex = 1, y.intersp = 0.7, yjust = 0.8, bty = "n", text.width = 2,col=c(rgb(1-min(dum),1-min(dum),1-min(dum)),rgb(1-(max(dum)+min(dum))/2,1-(max(dum)+min(dum))/2,1-(max(dum)+min(dum))/2),rgb(1-max(dum),1-max(dum),1-max(dum))), pch = c(16,16,16), title = Titel.Legende)
  #par(new=TRUE)
  #plot(x=c(0,50), y=c(0,27.47), type="l",xlim = Skalierung.x, ylim = Skalierung.y, col="blue", main = Title.Sample, xlab = x.Achse, ylab = y.Achse)
  #par(new=TRUE)
  #plot(x=c(0,50), y=c(0,27.47), type="l",xlim = Skalierung.x, ylim = Skalierung.y, col="blue", main = Title.Sample, xlab = x.Achse, ylab = y.Achse)
  a <- a+1
  b <- b+1
  if(a==(figure.col*figure.rows))
  {
    
    savePlot(filename = paste("PDF-Reports/",Charge,"/",plot.x,"_vs_",plot.y,"_vs_",plot.z,"_Sample_",b-a+1,"-",b,"_Dreieck.pdf",sep = ""), type = "pdf");
    a <- 0
  }
}
if(a!=0)
{
  savePlot(filename = paste("PDF-Reports/",Charge,"/",plot.x,"_vs_",plot.y,"_vs_",plot.z,"_Sample_",b-a+1,"-",b,"_Dreieck.pdf",sep = ""), type = "pdf");
}




