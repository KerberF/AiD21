#Abstandsüberprüfer


Aussortiert <- 0  #Resest der aussortierten Partikel
count <- 1
if(is.na(Test.Abstand[1,1]))
{} else {
  if(length(Test.Abstand$PART)>2)
  {
    for(val in 1:(length(Test.Abstand$PART)-1)){
      a <- val 
      b <- val +1
      if(abs(Test.Abstand$X_ABS[a]-Test.Abstand$X_ABS[b]) < min.Abstand & abs(Test.Abstand$Y_ABS[a]-Test.Abstand$Y_ABS[b]) < min.Abstand) #Abstandsüberprüfung
      {
        Aussortiert[count] <- a #Speicherung der aussortierten Partikelnummern in einem Verktor
        count <- count +1
      }
    }
    
    suppressWarnings(if(Aussortiert[1]!=0)
    {

      for(val in Aussortiert)
      {
        a <- val;
        b <- val+1; 
        Test.Abstand$AREA[b] <- Test.Abstand$AREA[a]+Test.Abstand$AREA[b] #Addieren der Fläche der aussortierten Partikel auf Partikel b 
      } ;
      Part.Aussortiert <- c(1:Aussortiert)
      Test.Abstand <- Test.Abstand[-Aussortiert,] #Entfernung der aussortierten Partikle aus Dataframe der untersuchten Daten 
      
    })
  }}

