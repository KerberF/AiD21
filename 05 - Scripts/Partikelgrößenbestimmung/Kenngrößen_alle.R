#  Klassen.Grenzen <- paste("Grenze.",1:11,sep="")
#  Grenze.1 <- 0
#  Grenze.2 <- 1
#  Grenze.3 <- 3
#  Grenze.4 <- 5
#  Grenze.5 <- 10
#  Grenze.6 <- 20
#  Grenze.7 <- 30
#  Grenze.8 <- 50
#  Grenze.9 <- 80
#  Grenze.10 <- 130
#  Grenze.11 <- 200



##Berechnung d10, d50, d90 
#test <- read.csv2("test4.csv")
#test <- test[,-1]
Partikelgröße_nach_Klassen <- Summary.Partikelgröße.all.norm

#Partikelgröße_nach_Klassen <- test
Summary_d50 <- NULL
Summary_d10 <- NULL
Summary_d90 <- NULL
Summary_Kenngrößen <- data.frame(Summary_d10, Summary_d50, Summary_d90)
Summenfunktion <- Partikelgröße_nach_Klassen
dim <- dim(Partikelgröße_nach_Klassen)
if(dim[1]>0&dim[2]>0)
{
  for(i in 1:dim[1])
  {
    sumall <- 0
    for(j in 1:dim[2])
    {
      sumall <- sumall+Partikelgröße_nach_Klassen[i,j]
    }
    if(sumall>10)
    {
      for(j in 1:dim[2])
      {
        sum <- 0
        for(k in 1:j)
        {
          sum <-  sum+Partikelgröße_nach_Klassen[i,k]
        }
        Summenfunktion[i,j] <- sum/sumall
        
      } 
      ###d10  
      min1 <- 0
      min2 <- 0
      minSummenfunktion <- 0
      for(j in 1:dim[2])
      {
        if(Summenfunktion[i,j]>=minSummenfunktion && Summenfunktion[i,j]<=0.1)
        {
          minSummenfunktion <- Summenfunktion[i,j]
          min1 <- j
        }    
      }
      stopper <- 0
      for(j in 1:dim[2])
      {
        if(Summenfunktion[i,j]>0.1&& stopper==0)
        {
          min2 <- j
          stopper <- 1
        }    
      }
      
      
      if(min1==0)
      {
        m <- (get(Klassen.Grenzen[min2+1])-get(Klassen.Grenzen[min1+1]))/(Summenfunktion[i,min2]-0)
      }else{
        m <- (get(Klassen.Grenzen[min1+1])-get(Klassen.Grenzen[min2+1]))/(Summenfunktion[i,min1]-Summenfunktion[i,min2])
      }  #m <- 1
      
      
      n <- (get(Klassen.Grenzen[min2+1]) - (m*(Summenfunktion[i,min2])))
      d10 <- m*0.1+n
      d10 <- round(d10, digits = 3)
      if(d10<0)
      {
        d10 <- "nicht bestimmbar"
      }
      Summary_Kenngrößen[i,1] <- d10
      
      
      ###d50  
      min1 <- 0
      min2 <- 0
      minSummenfunktion <- 0
      for(j in 1:dim[2])
      {
        if(Summenfunktion[i,j]>=minSummenfunktion && Summenfunktion[i,j]<=0.5)
        {
          minSummenfunktion <- Summenfunktion[i,j]
          min1 <- j
        }    
      }
      stopper <- 0
      for(j in 1:dim[2])
      {
        if(Summenfunktion[i,j]>0.5&& stopper==0)
        {
          min2 <- j
          stopper <- 1
        }    
      }
      
      
      if(min1==0)
      {
        m <- (get(Klassen.Grenzen[min2+1])-get(Klassen.Grenzen[min1+1]))/(Summenfunktion[i,min2]-0)
      }else{
        m <- (get(Klassen.Grenzen[min1+1])-get(Klassen.Grenzen[min2+1]))/(Summenfunktion[i,min1]-Summenfunktion[i,min2])
      }  #m <- 1
      
      n <- (get(Klassen.Grenzen[min2+1]) - (m*(Summenfunktion[i,min2])))
      d50 <- m*0.5+n
      d50 <- round(d50, digits = 3)
      if(d50<0)
      {
        d50 <- "nicht bestimmbar"
      }
      Summary_Kenngrößen[i,2] <- d50
      
      ###d90  
      min1 <- 0
      min2 <- 0
      minSummenfunktion <- 0
      for(j in 1:dim[2])
      {
        if(Summenfunktion[i,j]>=minSummenfunktion && Summenfunktion[i,j]<=0.9)
        {
          minSummenfunktion <- Summenfunktion[i,j]
          min1 <- j
        }    
      }
      stopper <- 0
      for(j in 1:dim[2])
      {
        if(Summenfunktion[i,j]>0.9&& stopper==0)
        {
          min2 <- j
          stopper <- 1
        }    
      }
      if(min2<Total.Größenklassen)
      {
        if(min1==0)
        {
          m <- (get(Klassen.Grenzen[min2+1])-get(Klassen.Grenzen[min1+1]))/(Summenfunktion[i,min2]-0)
        }else{
          m <- (get(Klassen.Grenzen[min1+1])-get(Klassen.Grenzen[min2+1]))/(Summenfunktion[i,min1]-Summenfunktion[i,min2])
        }  #m <- 1
        
        n <- (get(Klassen.Grenzen[min2+1]) - (m*(Summenfunktion[i,min2])))
        d90 <- m*0.9+n
        d90 <- round(d90, digits = 3)
        if(d90<0)
        {
          d90 <- "nicht bestimmbar"
        }
        Summary_Kenngrößen[i,3] <- d90
      }else{
        Summary_Kenngrößen[i,3] <- paste(">",get(Klassen.Grenzen[Total.Größenklassen]),sep="")
      } 
      
      
    }else{
      Summary_Kenngrößen[i,1] <-0
      Summary_Kenngrößen[i,2] <-0
      Summary_Kenngrößen[i,3] <-0
    }
    
  }
}

for(i in 1:dim[1])
{
  Summary_Kenngrößen[i,1] <- sub(".",",", as.character(Summary_Kenngrößen[i,1]), fixed = TRUE)
  Summary_Kenngrößen[i,2] <- sub(".",",", as.character(Summary_Kenngrößen[i,2]), fixed = TRUE)
  Summary_Kenngrößen[i,3] <- sub(".",",", as.character(Summary_Kenngrößen[i,3]), fixed = TRUE)
}


names <- c("x10 in µm²", "x50 in µm²", "x90 in µm²")
colnames(Summary_Kenngrößen) <- names
rownames(Summary_Kenngrößen) <- used.Samples
Ierror <- safewrite.csv(Summary_Kenngrößen, filename = paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Partikelgröße/Kenngrößen_alle_Partikel.csv",sep=""),rownames = TRUE)

