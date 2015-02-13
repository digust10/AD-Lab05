dados <- read.csv("dadostreino.csv", header = TRUE, sep = ";")
#Mecanica
dados = subset(dados,CURSO == "11124100")
#dados = data.frame(dados$CODIGO, dados$COD_EVASAO,dados$SITUACAO,dados$MEDIA)

library("C50")
set.seed(12345)
dados <- dados[order(runif(1536)), ]
#fac_evasao <- factor(dados$dados.COD_EVASAO)
fac_evasao <- factor(dados$COD_EVASAO)
eva_model <- C5.0(dados[,-2], fac_evasao)

teste <- read.csv("dadosteste.csv", header = TRUE, sep = ";")

p <- predict( eva_model, teste, type="class" )
c = data.frame(teste$MATRICULA,p)
write.csv(file="Diego_Ernesto_EM.csv", x=c)