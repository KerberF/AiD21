#Test.Abstand <- read.csv2("test_abs.csv")
#Test.Abstand <- read.csv2("Test_neu.csv")

#min.Abstand <- 0.02
#safewrite.csv(Test.Abstand,"test_abs.csv")
#mist[[1]] <- Test.Abstand[1,]
#mist[[2]] <- Test.Abstand[2,]
#for(i in 1:length(Test.Abstand$PART))
#{
#  mist[[i]] <- Test.Abstand[i,]
#}
#write.csv2(Test.Abstand, file = "Al2O32.csv")
if(length(Test.Abstand$PART)>1)
{

cluster <- NULL
Clusternumber <- rep(0, length(Test.Abstand$PART))

Test.Abstand <- data.frame(Test.Abstand,Clusternumber)
for(entry in 1:length(Test.Abstand$PART))
{

  punktx <- Test.Abstand$X_ABS[entry]
  punkty <- Test.Abstand$Y_ABS[entry]
  #Test.Abstand2 <- Test.Abstand[(i-50:i+50),]
  unten <- entry-20
  if(unten<=0)
  {
    unten <- 1
  }
  oben <- entry+20
  if(oben >length(Test.Abstand$PART))
  {
    oben <- length(Test.Abstand$PART)
  }
  
  zu_vergleichen <- subset(Test.Abstand[unten:oben,c("PART","X_ABS","Y_ABS","Clusternumber")], sqrt((Y_ABS-punkty)^2+(X_ABS-punktx)^2)<=min.Abstand)
#assign cluster number:
  if(length(zu_vergleichen$PART)>1)
  {
    if(Test.Abstand$Clusternumber[entry]!=0)
    {
      clusternum <- Test.Abstand$Clusternumber[entry]
    }else{
      clusternum <- Test.Abstand$PART[entry]
    }

 for(entry2 in 1:length(zu_vergleichen$PART))
 {
   if(zu_vergleichen$Clusternumber[entry2]==0)
   {
     pos_org <- which(Test.Abstand$PART== zu_vergleichen$PART[entry2])
     Test.Abstand$Clusternumber[pos_org] <- clusternum
   }else{
    if(zu_vergleichen$Clusternumber[entry2]!=clusternum&zu_vergleichen$Clusternumber[entry2]!=0)
     {
       number <- zu_vergleichen$Clusternumber[entry2]
       
       for(l in unten:oben)
       {
         if(Test.Abstand$Clusternumber[l]==number)
         {
          
         Test.Abstand$Clusternumber[l] <- clusternum
     }
     
     }
   }
   }}
  }
   
}
#keep largest entry, delete all other 
Aussortiert <- NULL

Test.Abstand_cluster <- subset(Test.Abstand, Clusternumber!=0)
cluster <- unique(Test.Abstand_cluster$Clusternumber)
if(length(cluster)>0)
{
for(current_cluster in cluster)
{
zu_vergleichen <- subset(Test.Abstand_cluster,Clusternumber==current_cluster) 
pos <- which(Test.Abstand$PART== zu_vergleichen$PART[which.max(zu_vergleichen$AREA)])
Test.Abstand[pos,"AREA"] <-sum(zu_vergleichen$AREA)

Aussortiert <- c(Aussortiert,zu_vergleichen[-which.max(zu_vergleichen$AREA),"PART"])
}
Aussortiert_trans <- NULL
for(to_remove in 1:length(Aussortiert))
{
  Aussortiert_trans[to_remove] <- which(Test.Abstand$PART==Aussortiert[to_remove])
}

Test.Abstand <- Test.Abstand[-Aussortiert_trans,]
}
remove <- which(colnames(Test.Abstand)=="Clusternumber" )
Test.Abstand <- Test.Abstand[,-remove]
}