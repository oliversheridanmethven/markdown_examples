AEMO<-read.csv("AEMOPriceDataSimple.csv")
SydTemp<-read.csv("SydTemp.csv")
minTemp<-SydTemp$Minimum.temperature..Degree.C.
maxTemp<-SydTemp$Maximum.temperature..Degree.C.
maxTemp<-maxTemp[SydTemp$Year==2013]
minTemp<-minTemp[SydTemp$Year==2013]
maxTemp<-maxTemp[!is.na(maxTemp)]
minTemp<-minTemp[!is.na(minTemp)]
Date<-as.Date(AEMO$Date, '%d/%m/%y')