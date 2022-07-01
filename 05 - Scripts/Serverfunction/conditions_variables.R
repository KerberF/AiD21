#Conditions for input variables 

iv_Bezeichnung <- InputValidator$new()
iv_Bezeichnung$add_rule("Charge",sv_required(message = "Eingabe wird benötigt."))
iv_Bezeichnung$add_rule("Version",sv_required(message = "Eingabe wird benötigt."))
iv_Bezeichnung$add_rule("Projekt",sv_required(message = "Eingabe wird benötigt."))
iv_Bezeichnung$enable()

iv_Partikelklassierung <- InputValidator$new()
#Abstandsüberprüfer
iv_Partikelklassierung$add_rule("min.Abstand",sv_required(message = "Eingabe wird benötigt."))
iv_Partikelklassierung$add_rule("min.Abstand",sv_gt(0, message_fmt = "Wert muss größer als 0 sein."))


#Clusterprüfung
iv_Partikelklassierung$add_rule("Anzahl.Spalten",sv_required(message = "Eingabe wird benötigt."))
iv_Partikelklassierung$add_rule("Anzahl.Spalten",sv_gt(0, message_fmt = "Wert muss größer als 0 sein."))
iv_Partikelklassierung$add_rule("Anzahl.Spalten",sv_integer(message = "Eine ganze Zahl wird benötigt."))
iv_Partikelklassierung$add_rule("Anzahl.Reihen",sv_required(message = "Eingabe wird benötigt."))
iv_Partikelklassierung$add_rule("Anzahl.Reihen",sv_gt(0, message_fmt = "Wert muss größer als 0 sein."))
iv_Partikelklassierung$add_rule("Anzahl.Reihen",sv_integer(message = "Eine ganze Zahl wird benötigt."))
iv_Partikelklassierung$add_rule("Referenzfläche",sv_required(message = "Eingabe wird benötigt."))
iv_Partikelklassierung$add_rule("Referenzfläche",sv_gt(0,message = "Wert muss größer als 0 sein."))
iv_Partikelklassierung$enable()



#Zusammensetzungsnormierung
iv_addElement <- InputValidator$new()
iv_addElement$add_rule("Elements.to.add",sv_required(message = "Eingabe wird benötigt."))
iv_addElement$add_rule("Elements.to.add",sv_gt(0, message_fmt = "Wert muss größer als 0 sein."))
iv_addElement$add_rule("Elements.to.add",sv_integer(message = "Eine ganze Zahl wird benötigt."))
iv_addElement$enable()

iv_addElement0 <- InputValidator$new()
iv_addElement0$add_rule("Elements.to.add0",sv_required(message = "Eingabe wird benötigt."))
iv_addElement0$add_rule("Elements.to.add0",sv_gt(0, message_fmt = "Wert muss größer als 0 sein."))
iv_addElement0$add_rule("Elements.to.add0",sv_integer(message = "Eine ganze Zahl wird benötigt."))
iv_addElement0$enable()

#PGV
iv_PGV <- InputValidator$new()
iv_PGV$add_rule("Total.Größenklassen",sv_required(message = "Eingabe wird benötigt."))
iv_PGV$add_rule("Total.Größenklassen",sv_gt(2, message_fmt = "Wert muss größer als 1 sein."))
iv_PGV$add_rule("Total.Größenklassen",sv_integer(message = "Eine ganze Zahl wird benötigt."))
iv_PGV$add_rule("Referenzfläche",sv_required(message = "Eingabe wird benötigt."))
iv_PGV$add_rule("Referenzfläche",sv_gt(0,message = "Wert muss größer als 0 sein."))
iv_PGV$enable()

#Darstellungen

iv_AnzahlKlassen <- InputValidator$new()
iv_AnzahlKlassen$add_rule("Darstellungen.Klassen.Anzahl",sv_required(message = "Eingabe wird benötigt."))
iv_AnzahlKlassen$add_rule("Darstellungen.Klassen.Anzahl",sv_gt(0, message_fmt = "Wert muss größer als 0 sein."))
iv_AnzahlKlassen$add_rule("Darstellungen.Klassen.Anzahl",sv_integer(message = "Eine ganze Zahl wird benötigt."))
iv_AnzahlKlassen$enable()

iv_Darstellungen <- InputValidator$new()
iv_Darstellungen$add_rule("Darstellungen.Klassen.Anzahl",sv_required(message = "Eingabe wird benötigt."))
iv_Darstellungen$add_rule("Darstellungen.Klassen.Anzahl",sv_gt(0, message_fmt = "Wert muss größer als 0 sein."))
iv_Darstellungen$add_rule("Darstellungen.Klassen.Anzahl",sv_integer(message = "Eine ganze Zahl wird benötigt."))

iv_Darstellungen$add_rule("figure.rows",sv_required(message = "Eingabe wird benötigt."))
iv_Darstellungen$add_rule("figure.rows",sv_gt(0, message_fmt = "Wert muss größer als 0 sein."))
iv_Darstellungen$add_rule("figure.rows",sv_integer(message = "Eine ganze Zahl wird benötigt."))

iv_Darstellungen$add_rule("figure.col",sv_required(message = "Eingabe wird benötigt."))
iv_Darstellungen$add_rule("figure.col",sv_gt(0, message_fmt = "Wert muss größer als 0 sein."))
iv_Darstellungen$add_rule("figure.col",sv_integer(message = "Eine ganze Zahl wird benötigt."))


iv_Darstellungen$enable()






#Datenbank
iv_Datenbank <- InputValidator$new()
iv_Datenbank$add_rule("Anzahl.Tabellen",sv_required(message = "Eingabe wird benötigt."))
iv_Datenbank$add_rule("Anzahl.Tabellen",sv_gt(0, message_fmt = "Wert muss größer als 0 sein."))
iv_Datenbank$add_rule("Anzahl.Tabellen",sv_integer(message = "Eine ganze Zahl wird benötigt."))
iv_Datenbank$add_rule("Anzahl.Tabellen",sv_between(1,5,message_fmt = "Bitte eine Zahl zwischen 1 und 5 eingeben."))
iv_Datenbank$enable()



#Rulefile-Editor
iv_RulefileEditor <- InputValidator$new()
iv_RulefileEditor$add_rule("AnzahlVorklassen",sv_required(message = "Eingabe wird benötigt."))
iv_RulefileEditor$add_rule("AnzahlVorklassen",sv_gte(0, message_fmt = "Wert muss größer oder gleich 0 sein."))
iv_RulefileEditor$add_rule("AnzahlVorklassen",sv_integer(message = "Eine ganze Zahl wird benötigt."))

iv_RulefileEditor$add_rule("AnzahlHauptklassen",sv_required(message = "Eingabe wird benötigt."))
iv_RulefileEditor$add_rule("AnzahlHauptklassen",sv_gte(0, message_fmt = "Wert muss größer oder gleich 0 sein."))
iv_RulefileEditor$add_rule("AnzahlHauptklassen",sv_integer(message = "Eine ganze Zahl wird benötigt."))
iv_RulefileEditor$enable()


#Titel Messdaten 

iv_Messdaten <- InputValidator$new()
iv_Messdaten$add_rule("displayed_titleSample1",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample2",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample3",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample4",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample5",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample6",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample7",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample8",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample9",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample10",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample11",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample12",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample13",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample14",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample15",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample16",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample17",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample18",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample19",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample20",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample21",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample22",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample23",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample24",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample25",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample26",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample27",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample28",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample29",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample30",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample31",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample32",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample33",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample34",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample35",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample36",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample37",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample38",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample39",sv_required(message = "Eingabe wird benötigt."))
iv_Messdaten$add_rule("displayed_titleSample40",sv_required(message = "Eingabe wird benötigt."))


iv_Messdaten$enable()