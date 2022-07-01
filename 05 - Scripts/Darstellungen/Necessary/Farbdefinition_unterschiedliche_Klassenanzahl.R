Col.Anzahl.Klassen.1 <- expression(ifelse(Sample$Class ==Klasse.1,eval(Farbe.eins),
                                             eval(Farbe.rest)))


Col.Anzahl.Klassen.2 <- expression(ifelse(Sample$Class ==Klasse.1,eval(Farbe.eins),
                                      ifelse(Sample$Class==Klasse.2,eval(Farbe.zwei),
                                                    eval(Farbe.rest))))


Col.Anzahl.Klassen.3 <- expression(ifelse(Sample$Class ==Klasse.1,eval(Farbe.eins),
                                      ifelse(Sample$Class==Klasse.2,eval(Farbe.zwei),
                                             ifelse(Sample$Class==Klasse.3,eval(Farbe.drei),
                                                           eval(Farbe.rest)))))




Col.Anzahl.Klassen.4 <- expression(ifelse(Sample$Class ==Klasse.1,eval(Farbe.eins),
                                      ifelse(Sample$Class==Klasse.2,eval(Farbe.zwei),
                                             ifelse(Sample$Class==Klasse.3,eval(Farbe.drei),
                                                    ifelse(Sample$Class==Klasse.4,eval(Farbe.vier),
                                                                  eval(Farbe.rest))))))

Col.Anzahl.Klassen.5 <- expression(ifelse(Sample$Class ==Klasse.1,eval(Farbe.eins),
                                      ifelse(Sample$Class==Klasse.2,eval(Farbe.zwei),
                                             ifelse(Sample$Class==Klasse.3,eval(Farbe.drei),
                                                    ifelse(Sample$Class==Klasse.4,eval(Farbe.vier),
                                                           ifelse(Sample$Class==Klasse.5,eval(Farbe.fünf),
                                                                         eval(Farbe.rest)))))))


Col.Anzahl.Klassen.6 <- expression(ifelse(Sample$Class ==Klasse.1,eval(Farbe.eins),
                                      ifelse(Sample$Class==Klasse.2,eval(Farbe.zwei),
                                             ifelse(Sample$Class==Klasse.3,eval(Farbe.drei),
                                                    ifelse(Sample$Class==Klasse.4,eval(Farbe.vier),
                                                           ifelse(Sample$Class==Klasse.5,eval(Farbe.fünf),
                                                                  ifelse(Sample$Class==Klasse.6,eval(Farbe.sechs),
                                                                                eval(Farbe.rest))))))))

Col.Anzahl.Klassen.7 <- expression(ifelse(Sample$Class ==Klasse.1,eval(Farbe.eins),
                                      ifelse(Sample$Class==Klasse.2,eval(Farbe.zwei),
                                             ifelse(Sample$Class==Klasse.3,eval(Farbe.drei),
                                                    ifelse(Sample$Class==Klasse.4,eval(Farbe.vier),
                                                           ifelse(Sample$Class==Klasse.5,eval(Farbe.fünf),
                                                                  ifelse(Sample$Class==Klasse.6,eval(Farbe.sechs),
                                                                         ifelse(Sample$Class==Klasse.7,eval(Farbe.sieben),
                                                                                       eval(Farbe.rest)))))))))


Col.Anzahl.Klassen.8 <- expression(ifelse(Sample$Class ==Klasse.1,eval(Farbe.eins),
                                      ifelse(Sample$Class==Klasse.2,eval(Farbe.zwei),
                                             ifelse(Sample$Class==Klasse.3,eval(Farbe.drei),
                                                    ifelse(Sample$Class==Klasse.4,eval(Farbe.vier),
                                                           ifelse(Sample$Class==Klasse.5,eval(Farbe.fünf),
                                                                  ifelse(Sample$Class==Klasse.6,eval(Farbe.sechs),
                                                                         ifelse(Sample$Class==Klasse.7,eval(Farbe.sieben),
                                                                                ifelse(Sample$Class==Klasse.8,eval(Farbe.acht),
                                                                                              eval(Farbe.rest))))))))))




Col.Anzahl.Klassen.9 <- expression(ifelse(Sample$Class ==Klasse.1,eval(Farbe.eins),
                                      ifelse(Sample$Class==Klasse.2,eval(Farbe.zwei),
                                             ifelse(Sample$Class==Klasse.3,eval(Farbe.drei),
                                                    ifelse(Sample$Class==Klasse.4,eval(Farbe.vier),
                                                           ifelse(Sample$Class==Klasse.5,eval(Farbe.fünf),
                                                                  ifelse(Sample$Class==Klasse.6,eval(Farbe.sechs),
                                                                         ifelse(Sample$Class==Klasse.7,eval(Farbe.sieben),
                                                                                ifelse(Sample$Class==Klasse.8,eval(Farbe.acht),
                                                                                       ifelse(Sample$Class==Klasse.9,eval(Farbe.neun),
                                                                                                     eval(Farbe.rest)))))))))))




Col.Anzahl.Klassen.10 <- expression(ifelse(Sample$Class ==Klasse.1,eval(Farbe.eins),
                                       ifelse(Sample$Class==Klasse.2,eval(Farbe.zwei),
                                              ifelse(Sample$Class==Klasse.3,eval(Farbe.drei),
                                                     ifelse(Sample$Class==Klasse.4,eval(Farbe.vier),
                                                            ifelse(Sample$Class==Klasse.5,eval(Farbe.fünf),
                                                                   ifelse(Sample$Class==Klasse.6,eval(Farbe.sechs),
                                                                          ifelse(Sample$Class==Klasse.7,eval(Farbe.sieben),
                                                                                 ifelse(Sample$Class==Klasse.8,eval(Farbe.acht),
                                                                                        ifelse(Sample$Class==Klasse.9,eval(Farbe.neun),
                                                                                               ifelse(Sample$Class==Klasse.10,eval(Farbe.zehn),
                                                                                                      eval(Farbe.rest))))))))))))
