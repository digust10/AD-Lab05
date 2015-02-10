library("gmodels")
library("C50")

dados <- read.csv("train.csv")
str(dados)
table(dados$Sex)
homens = subset(dados,Sex == "male")
levels(homens$Cabin)[1] = "missing"
levels(homens$Embarked)[1] = "missing"
# table(homens$Sex)
table(homens$Pclass)
summary(homens$Pclass)
table(homens$SibSp)
summary(homens$SibSp)
table(homens$Parch)
summary(homens$Parch)
table(homens$Fare)
summary(homens$Fare)

table(homens$Survived)

set.seed(12345)
homens_r <- homens[order(runif(1000)), ]
summary(homens_r$Pclass)
summary(homens_r$Fare)

homens_r$Survived <- factor(homens_r$Survived)
surv_model <- C5.0(homens_r[,-2], homens_r$Survived)
surv_model
summary(surv_model)


#lapply(abc_train[ names(abc_train) != "Result"] , table)
#lapply(homens_r[] , table)

teste <- read.csv("test.csv")
homens_teste = subset(teste,Sex == "male")
levels(homens_teste$Cabin)[1] = "missing"
levels(homens_teste$Embarked)[1] = "missing"
surv_pred <- predict(surv_model, homens_teste)
surv_pred
#library(gmodels)
#CrossTable(homens_teste$Survived, surv_pred, prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE)