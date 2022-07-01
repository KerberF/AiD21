#Abstandsüberprüfer
#Test.Abstand <- read.csv2("test.csv", header = TRUE)
#min.Abstand <- 0.02
#Aussortiert <- 0  #Resest der aussortierten Partikel
particle_remove <- NULL 
cluster_number <- NULL
Aussortiert  <- data.frame() #clusternumber is always the first inclusion detected of the cluster 

a <- 2
count <- 1 #Variable, die angibt, an welche Stelle die Zeilennummer des aussortierten Partikels in Vektor "Aussortiert" geschrieben werden soll 
marker <- 0 #Variable zum Erkennen einer Aussortierung
if(is.na(Test.Abstand[1,1]))
{} else {
  if(length(Test.Abstand$PART)>2)
  {
    for(val in 1:(length(Test.Abstand$PART)-1)){
      a <- val 
      b <- val +1
      current_Clusternumber <- a 
      if((length(Test.Abstand$PART)-val) >=11) #überprüft, ob überhaupt noch genügend Partikel in der Liste übrig sind 
      {
        for(h in 0:10) #es wird nicht nur ein Abgleich mit dem nächsten Partikel, sondern mit den nächsten h Partikeln durchgeführt 
        {
          if(abs(Test.Abstand$X_ABS[a]-Test.Abstand$X_ABS[b+h]) <= min.Abstand & abs(Test.Abstand$Y_ABS[a]-Test.Abstand$Y_ABS[b+h]) <= min.Abstand) #Abstandsüberprüfung
          {
            if(!a %in% Aussortiert[,1])  
            {      
              Aussortiert[count,1] <- a #Speicherung der aussortierten Partikelnummern in einem Vektor
              Aussortiert[count,2] <- a #Speicherung der Clusternummer, always the first inclusion of the cluster
              count <- count+1
            }
            z <- b+h
            if(!z %in% Aussortiert[,1])
            {
              Aussortiert[count,1] <- z
              Aussortiert[count,1] <- a ##Speicherung der Clusternummer
            }else {
              excluded <-  which(current_Clusternumber == Aussortiert[,1])
              current_Clusternumber <- Aussortiert[which(z== Aussortiert[,1]),2]
              for (i in excluded)
              {
                Aussortiert[i,2] <- current_Clusternumber
              }
              
            }
            
            #Aussortiert[count,2] <- (b+h) #Speicherung der Partikelnummern des zugehörigen doppelten Partikels in einem Vektor
            marker <- 1 #wird aktiviert, wenn ein Partikel aussortiert wurde 
            
            Test.Abstand$AREA[b+h] <- Test.Abstand$AREA[a]+Test.Abstand$AREA[b+h] #Addieren der Fläche der aussortierten Partikel auf Partikel b 
            Test.Abstand$AREA[a] <- 0
          }
          if(marker==1)
          {
            count <- count +1 #Variable wird um 1 erhöht, nächstes Partikel wird an nächste Stelle geschrieben
            marker <- 0 #reset des Markers
          }  
        }
      }
      Test <- NULL
      for(i in 1:500)
      {
        abs[i] <-  Test.Abstand$X_ABS[i]-Test.Abstand$X_ABS[i+1] 
      }  
      abs
      Test <- which(abs,0.05)
      Test
      if((length(Test.Abstand$PART)-val) <11)
      {
        for(h in 0:(length(Test.Abstand$PART)-val-1)) #es wird nicht nur ein Abgleich mit dem nächsten Partikel, sondern mit den noch restlichen übrigen Partikeln durchgeführt
        {
          if(abs(Test.Abstand$X_ABS[a]-Test.Abstand$X_ABS[b+h]) < min.Abstand & abs(Test.Abstand$Y_ABS[a]-Test.Abstand$Y_ABS[b+h]) < min.Abstand) #Abstandsüberprüfung
          {
            Aussortiert[count,1] <- a #Speicherung der aussortierten Partikelnummern in einem Vektor
            Aussortiert[count,2] <- (b+h) #Speicherung der Partikelnummern des zugehörigen doppelten Partikels in einem Vektor
            marker <- 1 #wird aktiviert, wenn ein Partikle aussortiert wurde 
          }
          
        }
        if(marker==1)
        {
          count <- count +1 #Variable wird um 1 erhöht, nächstes Partikel wird an nächste Stelle geschrieben
          marker <- 0 #reset des Markers
        } 
        
        
        
        
      }
      
    }
    #Unterdrücken von Warnmeldung, dass in Aussortiert mehr als ein Element ist. 
    suppressWarnings(if(Aussortiert>0)
    {
      for(val in Aussortiert)
      {
        a <-  val;
        b <-  val+1; 
        Test.Abstand$AREA[b] <- Test.Abstand$AREA[a]+Test.Abstand$AREA[b] #Addieren der Fläche der aussortierten Partikel auf Partikel b 
      } ;
      #Part.Aussortiert <- c(1:Aussortiert)
      Test.Abstand <- Test.Abstand[-Aussortiert[,1],] #Entfernung der aussortierten Partikle aus Dataframe der untersuchten Daten 
      
    })
  }}
