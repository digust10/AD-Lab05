library(plyr)
library("ggplot2")
dados <- read.csv("train.csv")
homens = subset(dados,Sex == "male")


#idade
k = (cut(homens$Age,9,labels=c("0-10","11-20","21-30","31-40","41-50","51-60","61-70","71-80","81-90")))
#idade numero de passageiros + classe
certo = aggregate(homens$Survived ~ Pclass + k, data = homens, length)
names(certo)[names(certo)=="homens$Survived"] <- "taxa"

table(certo)

qplot(x=k, y=taxa, fill=Pclass,
      data=certo, geom="bar", stat="identity",
      position="dodge")

#idade taxa de sobrevivencia idade + classe
certo = aggregate(homens$Survived ~ Pclass + k, data = homens, mean)
#idade+familia
certo = aggregate(homens$Survived ~ SibSp + k, data = homens, mean)
names(certo)[names(certo)=="homens$Survived"] <- "taxa"
qplot(x=k, y=taxa, fill=SibSp,
      data=certo, geom="bar", stat="identity",
      position="dodge")
#idade+parentes
certo = aggregate(homens$Survived ~ Parch + k, data = homens, mean)
names(certo)[names(certo)=="homens$Survived"] <- "taxa"
qplot(x=k, y=taxa, fill=Parch,
      data=certo, geom="bar", stat="identity",
      position="dodge")
#