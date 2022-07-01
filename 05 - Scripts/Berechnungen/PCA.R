
#PCA

Summary <- NULL
names <- NULL
for(j in 1:Total.Samples)
{
  if(Ierror==0)
  {
    Sample<- get(Samples[j]) 
    start <- (match("PSEM_CLASS",names(Sample))+1)
    end   <- (match("Part_org",names(Sample))-1)
    
    Ierror <- tryCatch(
      {
        pca <- prcomp(Sample[,start:end], center = PCAcenter, scale. = PCAscale) 
        
        Ierror <- 0
      }
      ,
      error=function(cond)
      {
        #message("Test")
        closeSweetAlert(session)
        if(isTRUE(grepl("cannot rescale",cond)))
        {
          sendSweetAlert(session, title=paste("PCA: Skalierung von Nullspalten nicht möglich. Zusammensetzungsnormierung oder Skalierung deaktivieren.",sep=""), type="error",width=1500)
        }else{
          sendSweetAlert(session, title=paste("Bitte Rohdaten überprüfen. PCA nicht möglich.",sep=""), type="error",width=1500)
        }
        return(1)
      },
      warning=function(cond)
      {
        #message("Test")
        closeSweetAlert(session)
        if(isTRUE(grepl("cannot rescale",cond)))
        {
          sendSweetAlert(session, title=paste("PCA: Skalierung von Nullspalten nicht möglich. Zusammensetzungsnormierung oder Skalierung deaktivieren.",sep=""), type="error",width=1500)
        }else{
          sendSweetAlert(session, title=paste("Bitte Rohdaten überprüfen. PCA nicht möglich.",sep=""), type="error",width=1500)
        }
        return(1)
      })
    
    
    
    
    number_elements <- ((end-start)+1)
    
    
    if(Ierror==0)
    {
      
      ###generate correlation matrix 
      
      #add PCs to original sample
      Sample <- cbind(Sample,pca$x[,1:number_elements])
      
      #get column numbers
      startPC <- match("PC1",names(Sample))
      endPC <- startPC + (number_elements-1)
      
      #correlation 
      suppressWarnings( cor_matrix <- cor(Sample[,start:end], Sample[,startPC:endPC]))
      
      
      ##caluclate percentage of variation 
      pca.var <- pca$sdev^2
      pca.var.per <- round(pca.var/sum(pca.var)*100,10)
      pca.var.per.cum <- NULL
      for(i in 1:length(pca.var.per))
      {
        pca.var.per.cum[i] <- sum(pca.var.per[1:i])
      }
      results <- rbind(pca.var.per,pca.var.per.cum,pca$rotation)
      names <- rownames(results)
      names[1] <- "Proportion of Variance"
      names[2] <- "Cumulative Proportion"
      rownames(results) <- names
      Ierror <- safewrite.csv(results, filename = paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/PCA/Loadings/",get(Title.Sample.all[j]),"_loading_vectors_",Version,".csv",sep=""))
      if(Ierror==0)
      {
        Ierror <- safewrite.csv(cor_matrix, filename = paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/PCA/Correlation/",get(Title.Sample.all[j]),"_correlation_matrix_",Version,".csv",sep=""))
      }
      
      
      
      Summary <- rbind(Summary,pca.var.per)
    }
    
    
  }
  
  
}
if(Ierror==0)
{
  rownames(Summary) <- used.Samples
  colnames(Summary) <- c(paste("PC",1:number_elements,sep=""))
  Ierror <- safewrite.csv(Summary, filename = paste("01 - Projekte/",Projekt,"/",Charge,"/Ergebnisse/",Version,"/PCA/Loadings/","Proportion of Variation_all_samples_",Version,".csv",sep=""))
}