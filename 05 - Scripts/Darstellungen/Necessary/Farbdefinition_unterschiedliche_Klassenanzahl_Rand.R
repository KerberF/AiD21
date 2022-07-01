Col.Rand.Anzahl.Klassen.1 <- expression(ifelse(Sample$Class ==Klasse.1,eval(Farbe.Rand.1),
                                             eval(Farbe.rest)))


Col.Rand.Anzahl.Klassen.2 <- expression(ifelse(Sample$Class ==Klasse.1,eval(Farbe.Rand.1),
                                      ifelse(Sample$Class==Klasse.2,eval(Farbe.Rand.2),
                                                    eval(Farbe.rest))))


Col.Rand.Anzahl.Klassen.3 <- expression(ifelse(Sample$Class ==Klasse.1,eval(Farbe.Rand.1),
                                      ifelse(Sample$Class==Klasse.2,eval(Farbe.Rand.2),
                                             ifelse(Sample$Class==Klasse.3,eval(Farbe.Rand.3),
                                                           eval(Farbe.rest)))))




Col.Rand.Anzahl.Klassen.4 <- expression(ifelse(Sample$Class ==Klasse.1,eval(Farbe.Rand.1),
                                      ifelse(Sample$Class==Klasse.2,eval(Farbe.Rand.2),
                                             ifelse(Sample$Class==Klasse.3,eval(Farbe.Rand.3),
                                                    ifelse(Sample$Class==Klasse.4,eval(Farbe.Rand.4),
                                                                  eval(Farbe.rest))))))

Col.Rand.Anzahl.Klassen.5 <- expression(ifelse(Sample$Class ==Klasse.1,eval(Farbe.Rand.1),
                                      ifelse(Sample$Class==Klasse.2,eval(Farbe.Rand.2),
                                             ifelse(Sample$Class==Klasse.3,eval(Farbe.Rand.3),
                                                    ifelse(Sample$Class==Klasse.4,eval(Farbe.Rand.4),
                                                           ifelse(Sample$Class==Klasse.5,eval(Farbe.Rand.5),
                                                                         eval(Farbe.rest)))))))


Col.Rand.Anzahl.Klassen.6 <- expression(ifelse(Sample$Class ==Klasse.1,eval(Farbe.Rand.1),
                                      ifelse(Sample$Class==Klasse.2,eval(Farbe.Rand.2),
                                             ifelse(Sample$Class==Klasse.3,eval(Farbe.Rand.3),
                                                    ifelse(Sample$Class==Klasse.4,eval(Farbe.Rand.4),
                                                           ifelse(Sample$Class==Klasse.5,eval(Farbe.Rand.5),
                                                                  ifelse(Sample$Class==Klasse.6,eval(Farbe.Rand.6),
                                                                                eval(Farbe.rest))))))))

Col.Rand.Anzahl.Klassen.7 <- expression(ifelse(Sample$Class ==Klasse.1,eval(Farbe.Rand.1),
                                      ifelse(Sample$Class==Klasse.2,eval(Farbe.Rand.2),
                                             ifelse(Sample$Class==Klasse.3,eval(Farbe.Rand.3),
                                                    ifelse(Sample$Class==Klasse.4,eval(Farbe.Rand.4),
                                                           ifelse(Sample$Class==Klasse.5,eval(Farbe.Rand.5),
                                                                  ifelse(Sample$Class==Klasse.6,eval(Farbe.Rand.6),
                                                                         ifelse(Sample$Class==Klasse.7,eval(Farbe.Rand.7),
                                                                                       eval(Farbe.rest)))))))))


Col.Rand.Anzahl.Klassen.8 <- expression(ifelse(Sample$Class ==Klasse.1,eval(Farbe.Rand.1),
                                      ifelse(Sample$Class==Klasse.2,eval(Farbe.Rand.2),
                                             ifelse(Sample$Class==Klasse.3,eval(Farbe.Rand.3),
                                                    ifelse(Sample$Class==Klasse.4,eval(Farbe.Rand.4),
                                                           ifelse(Sample$Class==Klasse.5,eval(Farbe.Rand.5),
                                                                  ifelse(Sample$Class==Klasse.6,eval(Farbe.Rand.6),
                                                                         ifelse(Sample$Class==Klasse.7,eval(Farbe.Rand.7),
                                                                                ifelse(Sample$Class==Klasse.8,eval(Farbe.Rand.8),
                                                                                              eval(Farbe.rest))))))))))




Col.Rand.Anzahl.Klassen.9 <- expression(ifelse(Sample$Class ==Klasse.1,eval(Farbe.Rand.1),
                                      ifelse(Sample$Class==Klasse.2,eval(Farbe.Rand.2),
                                             ifelse(Sample$Class==Klasse.3,eval(Farbe.Rand.3),
                                                    ifelse(Sample$Class==Klasse.4,eval(Farbe.Rand.4),
                                                           ifelse(Sample$Class==Klasse.5,eval(Farbe.Rand.5),
                                                                  ifelse(Sample$Class==Klasse.6,eval(Farbe.Rand.6),
                                                                         ifelse(Sample$Class==Klasse.7,eval(Farbe.Rand.7),
                                                                                ifelse(Sample$Class==Klasse.8,eval(Farbe.Rand.8),
                                                                                       ifelse(Sample$Class==Klasse.9,eval(Farbe.Rand.9),
                                                                                                     eval(Farbe.rest)))))))))))




Col.Rand.Anzahl.Klassen.10 <- expression(ifelse(Sample$Class ==Klasse.1,eval(Farbe.Rand.1),
                                       ifelse(Sample$Class==Klasse.2,eval(Farbe.Rand.2),
                                              ifelse(Sample$Class==Klasse.3,eval(Farbe.Rand.3),
                                                     ifelse(Sample$Class==Klasse.4,eval(Farbe.Rand.4),
                                                            ifelse(Sample$Class==Klasse.5,eval(Farbe.Rand.5),
                                                                   ifelse(Sample$Class==Klasse.6,eval(Farbe.Rand.6),
                                                                          ifelse(Sample$Class==Klasse.7,eval(Farbe.Rand.7),
                                                                                 ifelse(Sample$Class==Klasse.8,eval(Farbe.Rand.8),
                                                                                        ifelse(Sample$Class==Klasse.9,eval(Farbe.Rand.9),
                                                                                               ifelse(Sample$Class==Klasse.10,eval(Farbe.Rand.10),
                                                                                                      eval(Farbe.rest))))))))))))
