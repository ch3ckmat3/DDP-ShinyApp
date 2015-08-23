# global code/variables

#load dataset
ds <- read.csv("Airports.csv")

#rename columns
names(ds)[3]<-"y2012"
names(ds)[4]<-"y2013"
names(ds)[5]<-"PercentChange"
