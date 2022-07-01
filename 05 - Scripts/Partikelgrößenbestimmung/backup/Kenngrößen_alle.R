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
    if(sumall>0)
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
      findmin <- NULL
      class <- NULL
      findmin <- data.frame(findmin, class)
      for(j in 1:dim[2])
      {
        findmin[j,1] <- abs(0.1-Summenfunktion[i,j])
        findmin[j,2] <- j
      }
      
      min1 <- findmin[which.min(findmin$V1),]
      sub_1st_min <- findmin[-(which.min(findmin$V1)),]
      min2 <-  sub_1st_min[which.min(sub_1st_min$V1),]
      sub_2nd_min <- sub_1st_min[-(which.min(sub_1st_min$V1)),]
      
      
      if(min1$V2>1 & min2$V2>1)
      {
        m <- (((get(Klassen.Grenzen[min1$V2])+get(Klassen.Grenzen[min1$V2-1]))/2)-((get(Klassen.Grenzen[min2$V2])+get(Klassen.Grenzen[min2$V2-1]))/2))/(Summenfunktion[i,min1$V2]-Summenfunktion[i,min2$V2])
      }else{
        if(min1$V2==1)
        {
          m <- (((get(Klassen.Grenzen[min1$V2])+0)/2)-((get(Klassen.Grenzen[min2$V2])+get(Klassen.Grenzen[min2$V2-1]))/2))/(Summenfunktion[i,min1$V2]-Summenfunktion[i,min2$V2]) 
        }
        if(min2$V2==1)
        {
          m <- (((get(Klassen.Grenzen[min1$V2])+get(Klassen.Grenzen[min1$V2-1]))/2)-((get(Klassen.Grenzen[min2$V2])+0)/2))/(Summenfunktion[i,min1$V2]-Summenfunktion[i,min2$V2])
        }
        
        
        
      }
      
      if(m=="-Inf"|m=="-Inf")
      {
        mini <- 0
        mini[1] <- min1$V2
        mini[2] <- min2$V2
        Summary_Kenngrößen[i,1] <- min(mini)
      }else{
        n <- (min1$V2 - (m*min1$V1))
        d10 <- m*0.1+n
        if(d10<0)
        {
          d10 <- "nicht bestimmbar"
        }
        Summary_Kenngrößen[i,1] <- d10
      }
      
      ###d50  
      findmin <- NULL
      class <- NULL
      findmin <- data.frame(findmin, class)
      for(j in 1:dim[2])
      {
        findmin[j,1] <- abs(0.5-Summenfunktion[i,j])
        findmin[j,2] <- j
      }
      
      min1 <- findmin[which.min(findmin$V1),]
      sub_1st_min <- findmin[-(which.min(findmin$V1)),]
      min2 <-  sub_1st_min[which.min(sub_1st_min$V1),]
      sub_2nd_min <- sub_1st_min[-(which.min(sub_1st_min$V1)),]
      
      
      if(min1$V2>1 & min2$V2>1)
      {
        m <- (((get(Klassen.Grenzen[min1$V2])+get(Klassen.Grenzen[min1$V2-1]))/2)-((get(Klassen.Grenzen[min2$V2])+get(Klassen.Grenzen[min2$V2-1]))/2))/(Summenfunktion[i,min1$V2]-Summenfunktion[i,min2$V2])
      }else{
        if(min1$V2==1)
        {
          m <- (((get(Klassen.Grenzen[min1$V2])+0)/2)-((get(Klassen.Grenzen[min2$V2])+get(Klassen.Grenzen[min2$V2-1]))/2))/(Summenfunktion[i,min1$V2]-Summenfunktion[i,min2$V2]) 
        }
        if(min2$V2==1)
        {
          m <- (((get(Klassen.Grenzen[min1$V2])+get(Klassen.Grenzen[min1$V2-1]))/2)-((get(Klassen.Grenzen[min2$V2])+0)/2))/(Summenfunktion[i,min1$V2]-Summenfunktion[i,min2$V2])
        }
        
        
      }
      #m <- 1
      
      if(m=="-Inf"|m=="-Inf")
      {
        mini <- 0
        mini[1] <- min1$V2
        mini[2] <- min2$V2
        Summary_Kenngrößen[i,2] <- min(mini)
      }else{
        
        
        n <- (min1$V2 - (m*min1$V1))
        d50 <- m*0.5+n
        if(d50<0)
        {
          d50 <- "nicht bestimmbar"
        }
        Summary_Kenngrößen[i,2] <- d50
      }
      ###d90  
      findmin <- NULL
      class <- NULL
      findmin <- data.frame(findmin, class)
      for(j in 1:dim[2])
      {
        findmin[j,1] <- abs(0.9-Summenfunktion[i,j])
        findmin[j,2] <- j
      }
      
      min1 <- findmin[which.min(findmin$V1),]
      sub_1st_min <- findmin[-(which.min(findmin$V1)),]
      min2 <-  sub_1st_min[which.min(sub_1st_min$V1),]
      sub_2nd_min <- sub_1st_min[-(which.min(sub_1st_min$V1)),]
      
      
      if(min1$V2>1 & min2$V2>1)
      {
        m <- (((get(Klassen.Grenzen[min1$V2])+get(Klassen.Grenzen[min1$V2-1]))/2)-((get(Klassen.Grenzen[min2$V2])+get(Klassen.Grenzen[min2$V2-1]))/2))/(Summenfunktion[i,min1$V2]-Summenfunktion[i,min2$V2])
      }else{
        if(min1$V2==1)
        {
          m <- (((get(Klassen.Grenzen[min1$V2])+0)/2)-((get(Klassen.Grenzen[min2$V2])+get(Klassen.Grenzen[min2$V2-1]))/2))/(Summenfunktion[i,min1$V2]-Summenfunktion[i,min2$V2]) 
        }
        if(min2$V2==1)
        {
          m <- (((get(Klassen.Grenzen[min1$V2])+get(Klassen.Grenzen[min1$V2-1]))/2)-((get(Klassen.Grenzen[min2$V2])+0)/2))/(Summenfunktion[i,min1$V2]-Summenfunktion[i,min2$V2])
        }
        
        
        
      }
      #m <- 1
      if(m=="-Inf"|m=="-Inf")
      {
        mini <- 0
        mini[1] <- min1$V2
        mini[2] <- min2$V2
        Summary_Kenngrößen[i,3] <- min(mini)
      }else{
        n <- (min1$V2 - (m*min1$V1))
        d90 <- m*0.9+n
        if(d90<0)
        {
          d90 <- "nicht bestimmbar"
        }
        Summary_Kenngrößen[i,3] <- d90
      }
      
      
    }else{
      Summary_Kenngrößen[i,1] <-0
      Summary_Kenngrößen[i,2] <-0
      Summary_Kenngrößen[i,3] <-0
    }
    
  }
}

names <- c("x10 in \xB5m²", "x50 in \xB5m²", "x90 in \xB5m²")
colnames(Summary_Kenngrößen) <- names
rownames(Summary_Kenngrößen) <- used.Samples
safewrite.csv(Summary_Kenngrößen, filename = paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/Partikelgröße/Kenngrößen_alle_Partikel.csv",sep=""),rownames = TRUE)

