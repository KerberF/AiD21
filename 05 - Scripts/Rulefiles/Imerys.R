#Klassemanager
#Rulefile nach Steffen 


Class1 <- "Al2O3"
Condition.Class1 <- expression(Al > 2 & O > 5 & Mn < 1 & S < 1 &  Ca < 1  )

Class2 <- "Al2O3-CaO"
Condition.Class2 <- expression(Al > 2 & O > 5 & Mn< 1 & S < 1 & Ca < 15)

Class3 <- "Al2O3-Ca-MnS"
Condition.Class3 <- expression(Al > 2 & O > 5 & Mn < 10 & S < 10 & Ca < 15 )

Class4 <- "SiO2"
Condition.Class4 <- expression(Si/O>=0.4 & Si/O<6.2 & Al<3 & Mg<3 & Ca<3 & K<3 & Mn<3 & S<10)

Class5 <- "MnO-MnS"
Condition.Class5 <- expression(Mn>8 & (Mn/S)>=1 & (Al+Si+Ti+Cr)<(Mn+S))

Class6 <-"CaO-CaS"
Condition.Class6 <- expression(Ca > 5 & (Ca/S) > 2)

Class7 <- "Kratzer"
Condition.Class7 <- expression(Fe > 90 | (Fe+C)>90 & (Si+Al+Mn+Mg+Ca+Na+Ti)<3)

Class8 <- "Schmutz"
Condition.Class8 <- expression(C > 10 | Na > 5)

Class9 <- "FeO"
Condition.Class9 <- expression(Fe > 60 & O > 4 & (Si+Al+Mn+Mg+Ca+Na+Ti)<3)

Class10 <- "andere"
Condition.Class10 <- expression(Fe < 100)



