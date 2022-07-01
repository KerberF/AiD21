##Entfernung des Fe und O Gehaltes, Normierung der restlichen Anteile 




for(j in 1:Total.Samples)
{
  if(Ierror==0)
  {
    updateProgressBar(session, id="Progress.Partikelklassierung", title = "Partikelklassierung läuft: Zusammensetzungsnormierung", value = (50+j*Schrittweite)) 
    Sample.norm<- get(Samples[j]) 
    Ierror <-  safewrite.csv(Sample.norm, file =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Klassierung/all/",get(Title.Sample.all[j]),"_",Version,"_all_Particles_unnormiert.csv",sep=""))
    if(Ierror==0)
    {
      for(i in 1:length(Sample.norm$PART))
      {
        Particle.totalcontent <- 0
        for(e in Elements) #Aufsummieren aller Gehalte mit Ausnahme von Fe und O, falls sich diese Ausnahmen ändern muss der Vektor Elements angepasst werden und die 0-Setzung die weiter unten erfolgt
        {
          Particle.totalcontent <- Particle.totalcontent+Sample.norm[i,e]
        }
        
        if(Particle.totalcontent>0)
        {
          for(e in Elements) #Normierung der Gehalte auf 100% 
          {
            Sample.norm[i,e] <- Sample.norm[i,e]/Particle.totalcontent*100
          }
        }
        for(l in Elements.0)
        {
          Sample.norm[i,l] <- 0 #Setzen des Wertes von Fe auf 0
        }
        #Sample.norm[i,"Cr"] <- 0 #Setzen des Wertes von O auf 0 
        #Sample.norm[i,"C"] <- 0 #Setzen des Wertes von C auf 0 
      }
      name <- Samples.norm[j]
      assign(name, Sample.norm)
      
      if(Normierung.vorher==TRUE)
      {
        safewrite.csv(Sample.norm, file =paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Messwerte normiert/",get(Title.Sample.all[j]),"_",Version,"_normiert.csv",sep=""))
      }
      
    }
  }
}

