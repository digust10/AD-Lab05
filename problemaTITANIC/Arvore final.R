#Usando a solucao vista em sala

library("gmodels")
library("C50")

dados <- read.csv("train.csv")


#verificando dados
str(dados)
table(dados$Sex)

#retirando as mulheres
homens = subset(dados,Sex == "male")

#adcionando levels
levels(homens$Cabin)[1] = "missing"
levels(homens$Embarked)[1] = "missing"

#verificando dados
table(homens$Pclass)
summary(homens$Pclass)
classe = homens$Pclass

table(homens$SibSp)
summary(homens$SibSp)
familia = homens$SibSp

table(homens$Parch)
summary(homens$Parch)
parente = homens$Parch

table(homens$Fare)
summary(homens$Fare)
tarifa = homens$Fare

table(homens$Survived)
sobreviveu = homens$Survived

idade = homens$Age

novo = data.frame(idade,tarifa,parente,familia,classe,sobreviveu)

set.seed(12345)
novo <- novo[order(runif(577)), ]
#homens_x=homens_x[,-1]

summary(homens_r$Pclass)
summary(homens_r$Fare)

fac_sobreviveu <- factor(sobreviveu)
surv_model <- C5.0(novo[,-6], fac_sobreviveu)
surv_model
summary(surv_model)
C5imp(surv_model)

# USando o tutorial de R 
library(rpart)
fit <- rpart(sobreviveu ~ idade + tarifa + parente + familia + classe, data=novo, method="class")
plot(fit)
text(fit)

library(rattle)
library(rpart.plot)
library(RColorBrewer)
fancyRpartPlot(fit)

#previsao
teste <- read.csv("test.csv")
homens_teste = subset(teste,Sex == "male")
Prediction <- predict(fit, homens_teste, type = "class")
submit <- data.frame(PassengerId = homens_teste$PassengerId, Survived = Prediction)
write.csv(submit, file = "myfirstdtree.csv", row.names = FALSE)