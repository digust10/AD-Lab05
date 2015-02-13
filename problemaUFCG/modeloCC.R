dados <- read.csv("dadostreino.csv", header = TRUE, sep = ";")
#CC
dados = subset(dados,CURSO == "14102100")
#dados = data.frame(dados$CODIGO, dados$COD_EVASAO,dados$SITUACAO,dados$MEDIA)


library("C50")
set.seed(12345)
dados <- dados[order(runif(1536)), ]
#fac_evasao <- factor(dados$dados.COD_EVASAO)
fac_evasao <- factor(dados$COD_EVASAO)
eva_model <- C5.0(dados[,-2], fac_evasao)
summary(eva_model)

teste <- read.csv("dadosteste.csv", header = TRUE, sep = ";")

p <- predict( eva_model, teste, type="class" )
c = data.frame(teste$MATRICULA,p)
write.csv(file="Diego_Ernesto_CC.csv", x=c)