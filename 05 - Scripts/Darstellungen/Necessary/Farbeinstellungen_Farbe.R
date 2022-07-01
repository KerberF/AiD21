#Farbeinstellungen Farbe
#in Farbe mit gleichen Symbolen
Farbe.eins <- expression(rgb(255,((1-dum)*255),((1-dum)*255),max=255)) #rot
Farbe.zwei <- expression(rgb(255,255,((1-dum)*255),max=255)) #gelb
Farbe.drei <- expression(rgb(((1-dum)*255),(((1-dum)*127)+128),255,max=255)) #hellblau
Farbe.vier <- expression(rgb((((1-dum)*127)+128),((1-dum)*255),255,max=255)) #lila
Farbe.fünf <- expression(rgb(255,((1-dum)*255),255,max=255)) #pink
Farbe.sechs <- expression(rgb(((1-dum)*255),255,255,max=255))#türkies
Farbe.sieben <- expression(rgb(((1-dum)*255),((1-dum)*255),255,max=255)) #blau
Farbe.acht <- expression(rgb(255,(((1-dum)*121)+134),((1-dum)*255),max=255)) #orange
Farbe.neun <- expression(rgb(((1-dum)*255),255,((1-dum)*255),max=255)) #grün
Farbe.zehn <- expression(rgb((((1-dum)*127)+128),255,((1-dum)*255),max=255)) #hellgrün


Farbe.rest <- expression(rgb(0,255,0,max=255,alpha=0))

Farbe.Legende.1 <- expression(rgb(255,0,0,max=255))
Farbe.Legende.2 <- expression(rgb(255,255,0,max=255))
Farbe.Legende.3<- expression(rgb(0,128,255,max=255))
Farbe.Legende.4 <- expression(rgb(128,0,255,max=255))
Farbe.Legende.5 <- expression(rgb(255,0,255,max=255))
Farbe.Legende.6 <- expression(rgb(0,255,255,max=255))
Farbe.Legende.7 <- expression(rgb(0,0,255,max=255))
Farbe.Legende.8 <- expression(rgb(255,134,255,max=255))
Farbe.Legende.9 <- expression(rgb(0,255,0,max=255))
Farbe.Legende.10 <- expression(rgb(128,255,0,max=255))

Farbe.Verlauf.low <- expression(rgb(0,0,0,max=255,alpha=50))
Farbe.Verlauf.high <- expression(rgb(0,0,0,max=255,alpha = 255))

if(Symbole.Füllung==TRUE)
{
  Symbol.1 <- 21;
  Symbol.2 <- 22;
  Symbol.3 <- 23;
  Symbol.4 <- 24;
  Symbol.5 <- 25;
  Symbol.6 <- 21;
  Symbol.7 <- 22; 
  Symbol.8 <- 23; 
  Symbol.9 <- 24;
  Symbol.10 <- 25;
  Symbol.rest <- 21
  Symbol.Verlauf.low  <- 21
  Symbol.Verlauf.high <- 21
  
}
if(Symbole.Füllung==FALSE)
{
  Symbol.1 <- 16;
  Symbol.2 <- 16;
  Symbol.3 <- 16;
  Symbol.4 <- 16;
  Symbol.5 <- 16;
  Symbol.6 <- 16;
  Symbol.7 <- 16; 
  Symbol.8 <- 16; 
  Symbol.9 <- 16;
  Symbol.10 <- 16;
  Symbol.rest <- 16
  Symbol.Verlauf.low  <- 16
  Symbol.Verlauf.high <- 16
  
}


Farbe.Rand.1 <- expression(rgb(0,0,0,max=255))
Farbe.Rand.2 <- expression(rgb(0,0,0,max=255))
Farbe.Rand.3 <- expression(rgb(0,0,0,max=255))
Farbe.Rand.4 <- expression(rgb(0,0,0,max=255))
Farbe.Rand.5 <- expression(rgb(0,0,0,max=255))
Farbe.Rand.6 <- expression(rgb(0,0,0,max=255))
Farbe.Rand.7 <- expression(rgb(0,0,0,max=255))
Farbe.Rand.8 <- expression(rgb(0,0,0,max=255))
Farbe.Rand.9 <- expression(rgb(0,0,0,max=255))
Farbe.Rand.10<- expression(rgb(0,0,0,max=255))

