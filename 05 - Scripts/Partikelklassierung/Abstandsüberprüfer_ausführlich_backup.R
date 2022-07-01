#Abstandsüberprüfer
Aussortiert <- 0  #Resest der aussortierten Partikel

count <- 1 #Variable, die angibt, an welche Stelle die Zeilennummer des aussortierten Partikels in Vektor "Aussortiert" geschrieben werden soll 
marker <- 0 #Variable zum Erkennen einer Aussortierung
if(is.na(Test.Abstand[1,1]))
{} else {
  if(length(Test.Abstand$PART)>2)
  {
    for(val in 1:(length(Test.Abstand$PART)-1)){
      a <- val 
      b <- val +1
      if((length(Test.Abstand$PART)-val) >=11) #überprüft, ob überhaupt noch genügend Partikel in der Liste übrig sind 
      {
        for(h in 0:10) #es wird nicht nur ein Abgleich mit dem nächsten Partikel, sondern mit den nächsten h Partikeln durchgeführt 
        {
          if(abs(Test.Abstand$X_ABS[a]-Test.Abstand$X_ABS[b+h]) <= min.Abstand & abs(Test.Abstand$Y_ABS[a]-Test.Abstand$Y_ABS[b+h]) <= min.Abstand) #Abstandsüberprüfung
          {
            Aussortiert[count] <- a #Speicherung der aussortierten Partikelnummern in einem Verktor
            marker <- 1 #wird aktiviert, wenn ein Partikle aussortiert wurde 
          }
        }
        if(marker==1)
        {
          count <- count +1 #Variable wird um 1 erhöht, nächstes Partikel wird an nächste Stelle geschrieben
          marker <- 0 #reset des Markers
        }
      }
      if((length(Test.Abstand$PART)-val) <11)
      {
        for(h in 0:(length(Test.Abstand$PART)-val-1)) #es wird nicht nur ein Abgleich mit dem nächsten Partikel, sondern mit den noch restlichen übrigen Partikeln durchgeführt
        {
          if(abs(Test.Abstand$X_ABS[a]-Test.Abstand$X_ABS[b+h]) < min.Abstand & abs(Test.Abstand$Y_ABS[a]-Test.Abstand$Y_ABS[b+h]) < min.Abstand) #Abstandsüberprüfung
          {
            Aussortiert[count] <- a #Speicherung der aussortierten Partikelnummern in einem Verktor
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
    suppressWarnings(if(Aussortiert[1]!=0)
    {
      for(val in Aussortiert)
      {
        a <- val;
        b <- val+1; 
        Test.Abstand$AREA[b] <- Test.Abstand$AREA[a]+Test.Abstand$AREA[b] #Addieren der Fläche der aussortierten Partikel auf Partikel b 
      } ;
      #Part.Aussortiert <- c(1:Aussortiert)
      Test.Abstand <- Test.Abstand[-Aussortiert,] #Entfernung der aussortierten Partikle aus Dataframe der untersuchten Daten 
      
    })
  }}
