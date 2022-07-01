##Positionsnormierer 


for(j in 1:Total.Samples)
{
  
  Sample<- get(Samples[j]) 
  Positionx <- Sample$X_ABS
  Positiony <- Sample$Y_ABS
  minx <- min(Positionx)
  miny <- min(Positiony)
  for(i in 1:length(Sample$PART))
  {
  Positionx[i] <- (Positionx[i]-minx) 
  Positiony[i] <- (Positiony[i]-miny) 
  }      
  Sample$X_ABS <- Positionx
  Sample$Y_ABS <- Positiony
  
  name <- Samples[j]
  assign(name, Sample)
  
}  










 

