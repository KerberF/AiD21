#Classes

Class1 <- "Al2O3"
Condition.Class1 <- expression(Al > 20 & O > 20 & Si < 2 &  Ti < 2& (Mg+Si+Ca+Ti) < 10 & Mn < 2  )
teest <- paste("expression(Al > 20 & O > 20 & Si < 2 &  Ti < 2& (Mg+Si+Ca+Ti) < 10 & Mn < 2  )")
eval(Condition.Class1)

Class2 <- "Ti-N"
Condition.Class2 <- expression(Ti>10 & N>5)

Class3 <- "MnO-Al2O3"
Condition.Class3 <- expression(Al > 10 & Mn > 2 &(Mg+Si+Ca+Ti)<10  & Si < 2)

Class4 <- "Mn-Si-highAl"
Condition.Class4 <- expression(Mn > 2  & Si > 2 & Al > 15)

Class5 <- "Mn-Si-lowAl"
Condition.Class5 <- expression(Mn > 2  & Si > 2 & Al < 15 & Al >=1)

Class6 <- "Mn-Si-Ti"
Condition.Class6 <- expression(Mn > 2 & Si > 2 & Al < 1 & Ti > 2)

Class7 <- "SiO2"
Condition.Class7 <- expression(Si/O>=0.4 & Si/O<6.2 & Al<3 & Mg<3 & Ca<3 & K<3 & Mn<3 & S<10)

Class8 <- "MnO-MnS"
Condition.Class8 <- expression(Mn>8 & (Mn/S)>=1 & (Al+Si+Ti+Cr)<(Mn+S))

Class9 <-"CaO-CaS"
Condition.Class9 <- expression(Ca > 5 & (Ca/S) > 2)

Class10 <- "MgO"
Condition.Class10 <- expression(Mg > 10 & O > 10 & Al < 3 & Mn < 3 & Si < 3)

Class11 <- "andere"
Condition.Class11 <- expression(Fe < 100)

test <- c("Mg > 10 & O > 10 & Al < 3 & Mn < 3 & Si < 3")
Condition.Class10 <- test
Condition.Class10
Data  <-subset(Sample.cut, eval(parse(text=get(Condition.Classes[k])))) #parse macht aus einem String eine (expression(String)-Konstruktion ohne Quotes)

parse(text=get(Condition.Classes[k]))

as.name("Mg > 10 & O > 10 & Al < 3 & Mn < 3 & Si < 3")
as.numeric(test[1])
cat("expression(Mg > 10 & O > 10 & Al < 3 & Mn < 3 & Si < 3)")
eval(parse(text = "x"))
paste(test[1])
eval(test[1])
eval("test")
Condition.Class10 <- expression(noquote(test[1]))
Condition.Class10 <- noquote(test[1])
Condition.Class10
#Class2 <- "Cr-Mn"
#old Conditions# 
#Condition.Class2 <- expression((Cr/Fe) > 0.5 & ((Cr-40)/Fe) > -0.33 & ((Mn-40.5)/Fe) < -0.55 & Si < 5 & ((Mn-63.33)/Cr) > -1.67 & ((Mn-58.75)/Cr) < -0.75  )
#Condition.Class2 <- expression((Cr-4.5)/Fe >= 0.2604 & (Si-0.1475)/Fe < 0.0085 & (Mn-1.63)/Fe >= 0.0943)

#Class3 <- "Si-Mn"
#Condition.Class3 <- expression(((Mn-40.5)/Fe) > -0.55 & ((Mn/Si)>3.2) & ((Mn/Si)<9.1))
#Condition.Class3 <- expression((Si-0.1475)/Fe >= 0.0085 & (Cr-4.5)/Fe < 0.2604 & (Mn-1.63)/Fe >= 0.0943)

#Class4 <- "Si-Cr-Mn"
#Condition.Class4 <- expression((Cr-4.5)/Fe >= 0.2604 & (Si-0.1475)/Fe >= 0.0085 & (Mn-1.63)/Fe >= 0.0943)

#Class5 <- "SiO2"
#Condition.Class5 <- expression(Si/O > 0.4 & Si/O < 6.2 & Al < 3 & Mg < 3 & Ca < 3 & K< 3 & Mn < 5 & S < 10)

#Class6 <- "FeO"
#Condition.Class6 <- expression(Fe > 60 & O > 1 & (Si+Al+Mn+Mg+Ca+Na)<10)

#Class7 <- "Kratzer"
#Condition.Class7 <- expression(Fe > 90)




#Hinweise zu Trennzeichen:
#-Excel exportiert CSV-Datei standardmäßig mit dem Trennzeichen ";" und dem Dezimalzeichen "," --> Region Deutschland 
#-in den USA wird als Dezimalzeichen "." verwendet, als Trennzeichen ";"
#-ASPEX generiert CSV nach USA-Richtlinien ebenso wie R, wenn die Funktion write.csv genutzt wird, write.csv2 generiert CSV-Datei nach Deutsch-Richtilinien

#


####Vorklassierung




PreClass1 <- "Kratzer"
Condition.PreClass1 <- expression(Fe > 90 | (Fe+C)>90 & (Si+Al+Mn+Mg+Ca+Na+Ti)<3)

PreClass2 <- "Schmutz"
Condition.PreClass2 <- expression(C > 10 | Na > 5)

PreClass3 <- "FeO"
Condition.PreClass3 <- expression(Fe > 60 & O > 1 & (Si+Al+Mn+Mg+Ca+Na+Ti)<3)

