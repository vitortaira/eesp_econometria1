### Econometria I - EESP 2020 ###

# Esse curso cobre dados em cross-section.

### Problemas ###

## P1 ##

basecon1filtrada = basecon1[,c(8,9,71:74)]
basecon1filtrada

install.packages("dplyr")
library(dplyr)

c1e1 = filter(basecon1filtrada, MARRIED == 1, EDUC1 == 1)
c1e2 = filter(basecon1filtrada, MARRIED == 1, EDUC2 == 1)
c1e3 = filter(basecon1filtrada, MARRIED == 1, EDUC3 == 1)
c1e4 = filter(basecon1filtrada, MARRIED == 1, EDUC4 == 1)

c0e1 = filter(basecon1filtrada, MARRIED == 0, EDUC1 == 1)
c0e2 = filter(basecon1filtrada, MARRIED == 0, EDUC2 == 1)
c0e3 = filter(basecon1filtrada, MARRIED == 0, EDUC3 == 1)
c0e4 = filter(basecon1filtrada, MARRIED == 0, EDUC4 == 1)

media_c1e1 = c(colMeans(c1e1))
media_c1e2 = c(colMeans(c1e2))
media_c1e3 = c(colMeans(c1e2))
media_c1e4 = c(colMeans(c1e3))

media_c0e1 = c(colMeans(c0e1))
media_c0e2 = c(colMeans(c0e2))
media_c0e3 = c(colMeans(c0e3))
media_c0e4 = c(colMeans(c0e4))

tabela = rbind(media_c1e1, media_c1e2, media_c1e3, media_c1e4, media_c0e1, media_c0e2, media_c0e3, media_c0e4)
tabela

## P3 ##

summary(lm(basecon1$LWKLYWGE ~ basecon1$EDUC))
cor(basecon1$LWKLYWGE, basecon1$EDUC)

## P8 ##

lm(Basecon1_Econometria_I$LWKLYWGE ~ Basecon1_Econometria_I$EDUC + Basecon1_Econometria_I$AGE)
summary(lm(Basecon1_Econometria_I$LWKLYWGE ~ Basecon1_Econometria_I$EDUC + Basecon1_Econometria_I$AGE))
lm(Basecon1_Econometria_I$LWKLYWGE ~ Basecon1_Econometria_I$EDUC)
summary(lm(Basecon1_Econometria_I$LWKLYWGE ~ Basecon1_Econometria_I$EDUC))
lm(Basecon1_Econometria_I$AGE ~ Basecon1_Econometria_I$EDUC)
summary(lm(Basecon1_Econometria_I$AGE ~ Basecon1_Econometria_I$EDUC))

## P14 ##

library(car)
LOGSAL <- basecon1$LWKLYWGE
EDUCACAO <- basecon1$EDUC
IDADE <- basecon1$AGE
IDADE2 <- (basecon1$AGE)^2
RACA <- basecon1$RACE
reg14 <- lm(LOGSAL ~ EDUCACAO + IDADE + RACA)
summary(reg14)
#ADICIONANDO A VARI?VEL EXPLICATIVA IDADE^2 ###
reg141 <- lm(LOGSAL ~ EDUCACAO + IDADE + RACA + IDADE2)
summary(reg141)
#PRIMEIRO TESTE: Beta2 = Beta3 = Beta4 = 0 ###
H0_1 <- c("EDUCACAO", "IDADE", "RACA")
linearHypothesis(reg14, H0_1)
R2_reg14 <- summary(reg14)$r.squared
F_1 <- (1063630/3)*R2_reg14/(1-R2_reg14)
print(F_1)
#Valor cr?tico para n?vel de signific?ncia alfa = 0.05 usando uma distribui??o F(k-1, n-k) ###
qf(1-0.05, 4-1, 1063634-4)
#SEGUNDO TESTE: 2*Beta3 = Beta4 ###
H0_2 <- c("2*IDADE = RACA")
linearHypothesis(reg14, H0_2)

## P15 ##

REGIAO1 <- basecon1$ENOCENT
REGIAO2 <- basecon1$ESOCENT
REGIAO3 <- basecon1$MIDATL
REGIAO4 <- basecon1$MT
REGIAO5 <- basecon1$NEWENG
REGIAO6 <- basecon1$SOATL
REGIAO7 <- basecon1$WNOCENT
REGIAO8 <- basecon1$WSOCENT
MARRIED <- basecon1$MARRIED
# Tomando REGIAO1 como refer?ncia:
reg15_regiao <- lm(LOGSAL ~ EDUCACAO + IDADE + RACA + REGIAO2 + REGIAO3 + REGIAO4 + REGIAO5 + REGIAO6 + REGIAO7 + REGIAO8)
summary(reg15_regiao)
# Como a base de dados especifica que MARRIED = 1 para homens casados, temos como refer?ncia homens solteiros.
reg15_civil <- lm(LOGSAL ~ EDUCACAO + IDADE + RACA + MARRIED)
summary(reg15_civil)
# Alterando o modelo para que os retornos salariais da educa??o variem de acordo com o estado civil.
reg15_civil_interacao <- lm(LOGSAL ~ MARRIED*(EDUCACAO + IDADE + RACA))
summary(reg15_civil_interacao)

## P22 ##

EXP <- basecon1_old$AGE - basecon1_old$AGE_ENTR
reg22.1 <- lm(basecon1_old$LWKLYWGE ~ basecon1_old$EDUC + EXP + basecon1_old$AGE + basecon1_old$AGEQ + basecon1_old$MARRIED)
reg22.2 <- lm(basecon1_old$LWKLYWGE ~ basecon1_old$EDUC + EXP + basecon1_old$AGE + basecon1_old$AGEQ + basecon1_old$MARRIED + basecon1_old$SAT)
summary(reg22.1)
summary(reg22.2)

## P25 ##

library(AER)
library(stargazer)
reg25 <- lm(basecon1$LWKLYWGE ~ basecon1$EDUC + basecon1$AGE + basecon1$MARRIED) 
summary(reg25)
#Caso em que m=k
#2SLS manualmente (erros padr?o errados)
estagio1 <- lm(basecon1$EDUC ~ basecon1$QOB + basecon1$AGE + basecon1$MARRIED)
educfitada <- fitted(estagio1)
estagio2 <- lm(basecon1$LWKLYWGE ~ educfitada + basecon1$AGE + basecon1$MARRIED)
#2SLS autom?tico
reg25_2SLS <- ivreg(basecon1$LWKLYWGE ~ basecon1$EDUC + basecon1$AGE + basecon1$MARRIED | basecon1$QOB + basecon1$AGE + basecon1$MARRIED, data = basecon1)
#Tabela comparativa
stargazer(estagio1, estagio2, reg25_2SLS, type = "text", keep.stat = c("n", "rsq"))
#Testando exogeneidade do regressor
educresid <- resid(estagio1)
reg25.1 <- lm(basecon1$LWKLYWGE ~ basecon1$EDUC + basecon1$AGE + basecon1$MARRIED + educresid)
#Note que todos os coeficientes, exceto o associado a educresid, s?o iguais aos obtidos por 2SLS.
coeftest(reg25.1)
#Se o coeficiente associado a educresid for estatisticamente diferente de zero, ent?o EDUC ? end?gena.
# Caso em que m>k
#Testando exogeneidade do instrumento
reg25.2 <- ivreg(basecon1$LWKLYWGE ~ basecon1$EDUC + basecon1$AGE + basecon1$MARRIED | basecon1$QOB + basecon1$YOB + basecon1$AGE + basecon1$MARRIED)
logsalresid <- resid(reg25.2)
reg25.3 <- lm(logsalresid ~ basecon1$QOB + basecon1$YOB + basecon1$AGE + basecon1$MARRIED)
LM <- nobs(reg25.3)*summary(reg25.3)$r.squared
critico <- qchisq(.95, df = 1)
LM > critico
#Se verdadeiro, ent?o pelo menos algum dos instrumentos n?o ? ex?geno.

## P25 alterado ##

library(AER)
library(stargazer)
reg25 <- lm(basecon1$LWKLYWGE ~ basecon1$EDUC + basecon1$AGE + basecon1$MARRIED) 
summary(reg25)
#Caso em que m=k 
#2SLS manualmente (erros padr?o errados)
estagio1 <- lm(basecon1$EDUC ~ as.factor(basecon1$QOB) + basecon1$AGE + basecon1$MARRIED)
educfitada <- fitted(estagio1)
estagio2 <- lm(basecon1$LWKLYWGE ~ educfitada + basecon1$AGE + basecon1$MARRIED)
#2SLS autom?tico
reg25_2SLS <- ivreg(basecon1$LWKLYWGE ~ basecon1$EDUC + basecon1$AGE + basecon1$MARRIED | as.factor(basecon1$QOB) + as.factor(basecon1$QOB)*basecon1$YOB + basecon1$YOB + basecon1$AGE + basecon1$MARRIED, data = basecon1)
resid1 <- resid(reg25_2SLS)
reg25.3 <- lm(basecon1$LWKLYWGE ~ basecon1$EDUC + basecon1$AGE + basecon1$MARRIED + resid1)
#Tabela comparativa
stargazer(estagio1, estagio2, reg25_2SLS, type = "text", keep.stat = c("n", "rsq"))
#Testando exogeneidade do regressor (Teste de Hausman)
educresid <- resid(estagio1)
reg25.1 <- lm(basecon1$LWKLYWGE ~ basecon1$EDUC + basecon1$AGE + basecon1$MARRIED + educresid)
#Note que todos os coeficientes, exceto o associado a educresid, s?o iguais aos obtidos por 2SLS.
coeftest(reg25.1)
#Se o coeficiente associado a educresid for estatisticamente diferente de zero, ent?o EDUC ? end?gena.
#Caso em que m>k
#Testando exogeneidade do instrumento (Teste de Sargan)
reg25.2 <- ivreg(basecon1$LWKLYWGE ~ basecon1$EDUC + basecon1$AGE + basecon1$MARRIED | as.factor(basecon1$QOB) + basecon1$YOB + basecon1$AGE + basecon1$MARRIED)
logsalresid <- resid(reg25.2)
reg25.3 <- lm(logsalresid ~ as.factor(basecon1$QOB) + basecon1$YOB + basecon1$AGE + basecon1$MARRIED)
LM <- nobs(reg25.3)*summary(reg25.3)$r.squared
critico <- qchisq(.95, df = 1)
LM > critico
#Se verdadeiro, ent?o pelo menos algum dos instrumentos n?o ? ex?geno.

## P26 ##

library(stargazer)
library(systemfit)
library(haven)
T26 <- read_dta("EESP/3? Semestre/Econometria I/2020/T26.dta")

#OLS
reg26.1 <- lm(T26$lannearn ~ T26$exper + T26$age + T26$married + T26$tenure + T26$educ + T26$nrtheast + T26$nrthcen + T26$south + T26$male + T26$white + T26$union + T26$tenuresq + T26$expersq)
reg26.2 <- lm(T26$vacdays ~ T26$exper + T26$age + T26$married + T26$tenure + T26$educ + T26$nrtheast + T26$nrthcen + T26$south + T26$male + T26$white + T26$union + T26$tenuresq + T26$expersq)
reg26.3 <- lm(T26$sicklve ~ T26$age + T26$depends + T26$married + T26$educ + T26$male + T26$union + T26$office)
# 28 ~ 3 + 4 + 5 + 6 + 7 + 8 + 9 + 10 + 11 + 12 + 13 + 14 + 15 + 35 + 36
reg26.4 <- lm(T26$insur ~ T26$exper + T26$age + T26$depends + T26$married + T26$tenure + T26$educ + T26$nrtheast + T26$nrthcen + T26$south + T26$male + T26$white + T26$union + T26$office + T26$tenuresq + T26$expersq)
# 29 ~ 3 + 4 + 5 + 6 + 7 + 8 + 9 + 10 + 11 + 12 + 13 + 14 + 15 + 35 + 36 
reg26.5 <- lm(T26$pension ~ T26$exper + T26$age + T26$depends + T26$married + T26$tenure + T26$educ + T26$nrtheast + T26$nrthcen + T26$south + T26$male + T26$white + T26$union + T26$office + T26$tenuresq + T26$expersq)

#systemfit
eq.lannearn <- T26$lannearn ~ T26$exper + T26$age + T26$married + T26$tenure + T26$educ + T26$nrtheast + T26$nrthcen + T26$south + T26$male + T26$white + T26$union + T26$tenuresq + T26$expersq
eq.vacdays <- T26$vacdays ~ T26$exper + T26$age + T26$married + T26$tenure + T26$educ + T26$nrtheast + T26$nrthcen + T26$south + T26$male + T26$white + T26$union + T26$tenuresq + T26$expersq
eq.sicklve <- T26$sicklve ~ T26$age + T26$depends + T26$married + T26$educ + T26$male + T26$union + T26$office
eq.insur <- T26$insur ~ T26$exper + T26$age + T26$depends + T26$married + T26$tenure + T26$educ + T26$nrtheast + T26$nrthcen + T26$south + T26$male + T26$white + T26$union + T26$office + T26$tenuresq + T26$expersq
eq.pension <- T26$pension ~ T26$exper + T26$age + T26$depends + T26$married + T26$tenure + T26$educ + T26$nrtheast + T26$nrthcen + T26$south + T26$male + T26$white + T26$union + T26$office + T26$tenuresq + T26$expersq

eq.sistema <- list(eq.lannearn, eq.vacdays, eq.sicklve, eq.insur, eq.pension)
SUR26 <- systemfit(eq.sistema, method = "SUR")
summary(SUR26)

#Tabela das 5 regress?es por OLS
stargazer(reg26.1, reg26.2, reg26.3, reg26.4, reg26.5, type = "text", keep.stat = c("n", "rsq"))

## P28 ##

library(haven)
T28 <- read_dta("EESP/3? Semestre/Econometria I/2020/T28.DTA")

eq.h <- T28$hours ~ T28$lwage + T28$educ + T28$age + T28$kidslt6 + T28$kidsge6 + T28$nwifeinc
eq.s <- T28$lwage ~ T28$hours + T28$educ + T28$exper + T28$expersq
eq.sistema <- list(eq.h, eq.s)
instrum <- ~ T28$educ + T28$age + T28$kidslt6 + T28$kidsge6 + T28$nwifeinc + T28$exper + T28$expersq 

#OLS
eq.h.ols <- lm(eq.h)
eq.s.ols <- lm(eq.s)
library(stargazer)
stargazer(eq.h.ols, eq.s.ols, type = "text", keep.stat = c("n", "rsq"))

#2SLS
summary(systemfit(eq.sistema, inst = instrum, data = T28, method = "2SLS"))

#3SLS
summary(systemfit(eq.sistema, inst = instrum, data = T28, method = "3SLS"))

## P32 ##

library(haven)
T28 <- read_dta("EESP/3? Semestre/Econometria I/2020/T28.DTA")

eq.h <- T28$hours ~ T28$lwage + T28$educ + T28$age + T28$kidslt6 + T28$kidsge6 + T28$nwifeinc
eq.s <- T28$lwage ~ T28$hours + T28$educ + T28$exper + T28$expersq
eq.sistema <- list(eq.h, eq.s)
instrum <- ~ T28$educ + T28$age + T28$kidslt6 + T28$kidsge6 + T28$nwifeinc + T28$exper + T28$expersq 

#OLS
eq.h.ols <- lm(eq.h)
eq.s.ols <- lm(eq.s)
library(stargazer)
stargazer(eq.h.ols, eq.s.ols, type = "text", keep.stat = c("n", "rsq"))

#2SLS
library(systemfit)
summary(systemfit(eq.sistema, inst = instrum, data = T28, method = "2SLS"))

#3SLS
summary(systemfit(eq.sistema, inst = instrum, data = T28, method = "3SLS"))

#OLS
ols.trab <- lm(T28$inlf ~ T28$educ + T28$age + T28$kidslt6 + T28$kidsge6 + T28$nwifeinc + T28$exper + T28$expersq)
summary(ols.trab) #assumindo homocedasticidade
coeftest(ols.trab, vcov = hccm ) #erro padr?o robusto

x.teste <- list(nwifeinc = c(1000,0), educ = c(3,20), exper = c(0,30), expersq = c(0,900), 
                age = c(18,40), kidslt6 = c(3,0), kidsge6 = c(2,0))
predict(ols.trab, x.teste)

#Probit
probit.trab <- glm(T28$inlf ~ T28$educ + T28$age + T28$kidslt6 + T28$kidsge6 + T28$nwifeinc + T28$exper + T28$expersq,
                   family = binomial(link = probit), data = T28)
summary(probit.trab)
logLik(probit.trab)

#Logit
logit.trab <- glm(T28$inlf ~ T28$educ + T28$age + T28$kidslt6 + T28$kidsge6 + T28$nwifeinc + T28$exper + T28$expersq,
                  family = binomial(link = logit), data = T28)
summary(logit.trab)
logLik(logit.trab)

stargazer(ols.trab, probit.trab, logit.trab, type = "text", keep.stat = c("n", "rsq"))

#Likelihood Ratio Test
library(lmtest)
lrtest(probit.trab)
lrtest(logit.trab)
library(car)
linearHypothesis(probit.trab, hypothesis.matrix = c("T28$educ = 2*T28$kidslt6"))
qchisq(1-0.05, df = 1)

#Lagrange Multiplier Test
resid.probit <- resid(probit.trab)
reg.aux <- lm(resid.probit ~ )
LM.probit <- nobs(reg.aux)*summary(reg.aux)$r.squared
LM.probit > qchisq(1-0.05, df = 1)

#Wald Test
waldtest(probit.trab, vcov = hccm, test = "Chisq")
qchisq(1-0.05, df = 1)

## P33 ##

library(haven)
basecon1 <- read_dta("~/EESP/3? Semestre/Econometria I/basecon1/basecon1.dta")

ols <- lm(LWKLYWGE ~ AGE + EDUC + RACE, data = basecon1)
mle <- glm(LWKLYWGE ~ AGE + EDUC + RACE, data = basecon1)

library(stargazer)
stargazer(ols, mle, type = "text", keep.stat = c("n", "rsq"))

#Likelihood Ratio Test
library(lmtest)
lrtest(mle)
library(car)
linearHypothesis(mle, c('2*EDUC = AGE'))
qchisq(1-0.05, df = 1)


#Lagrange Multiplier Test
reg.aux <- lm(resid() ~ )
LM.probit <- nobs(reg.aux)*summary(reg.aux)$r.squared
qchisq(1-0.05, df = 1)

#Wald Test
waldtest(mle)
waldtest(mle, vcov = hccm, test = "Chisq") #erro padr?o robusto
qchisq(1-0.05, df = 1)

## HETEROCEDASTICIDADE ##

library(haven)
T28 <- read_dta("EESP/3? Semestre/Econometria I/2020/T28.DTA")
T28.completa <- na.omit(T28)

regteste <- lm(T28.completa$hours ~ T28.completa$lwage + T28.completa$educ + T28.completa$age)

b.int <- summary(regteste)$coefficient[1]
b.lwage <- summary(regteste)$coefficient[2]
b.educ <- summary(regteste)$coefficient[3]
b.age <- summary(regteste)$coefficient[4]

lwage.med <- mean(T28.completa$lwage)
educ.med <- mean(T28$educ)
age.med <- mean(T28$age)

library(lmtest)
# TESTE DE BREUSCH-PAGAN LM-TEST
significancia <- 0.05
critico <- qchisq(1-significancia, df = regteste$rank-1) #Essa defini??o de df assume que todos os regressores explicam a vari?ncia.
estatistica <- bptest(regteste)$static
if("estatistica">"critico") {
  print("Como a estat??stica de teste ?? maior que o valor cr??tico, rejeitamos a H0 de homocedasticidade dos erros")
} else {print("Como a estat??stica de teste ?? menor que o valor cr??tico, n??o rejeitamos a H0 de homocedasticidade dos erros")}

# GR??FICO RES??DUOS X VALORES PREDITOS
plot(x=regteste$fitted.values, y=regteste$residuals, main="RES??DUOS X VALORES PREDITOS", xlab="VALORES PREDITOS", ylab="RES??DUOS")
abline(0,0, col="blue")

# GR??FICO Y X REGRESSOR
plot(x=T28$lwage, y=T28$hours, main="Y X X", xlab="X", ylab="Y")
abline(b.int+b.educ*educ.med+b.age*age.med, b.lwage,col="red")

### TRABALHO ###

### VG ###

# importing data from Stata
install.packages("foreign")
library(foreign)
library(haven)
setwd("~/Desktop/Bibliografia 3o Semestre/Econometria Biblio")
tut1 <- read_dta("basecon1.dta")
library(plyr)

install.packages("dplyr")
library(dplyr)

summary(tut1) # info relevantes
ncol(tut1) # variaveis

# para colocar na tabela
married <- factor(tut1$MARRIED, labels =c ("NO", "YES"))
table(married)
prop.table(table(married))

# histogramas
hist(tut1$LWKLYWGE, freq = F)
plot(density(tut1$LWKLYWGE))
hist(tut1$EDUC, freq = F)
mean(tut1$MARRIED)
pie(table(married))
boxplot(tut1$EDUC, horizontal = TRUE)
ecdf(tut1$LWKLYWGE)

# media e variancia condicional
married <- group_by(tut1, MARRIED)
cond_mar_sal <- summarise(married, 
                          sal_mean = mean(LWKLYWGE),
                          sal_median = median(LWKLYWGE),
                          sal_var = var(LWKLYWGE),
                          n= n())

educ1 <- group_by(tut1, EDUC1)
cond_fund1_sal <- summarise(educ1,
                            sal_mean = mean(LWKLYWGE),
                            sal_median = median(LWKLYWGE),
                            sal_var = var(LWKLYWGE),
                            n= n())

cond_fund1_mar <- summarise(educ1,
                            sal_mean = mean(MARRIED),
                            sal_median = median(MARRIED),
                            sal_var = var(MARRIED),
                            n= n())

educ2 <- group_by(tut1, EDUC2)
cond_fund2_sal <- summarise(educ2,
                            sal_mean = mean(LWKLYWGE),
                            sal_median = median(LWKLYWGE),
                            sal_var = var(LWKLYWGE),
                            n= n())

cond_fund2_mar <- summarise(educ2,
                            sal_mean = mean(MARRIED),
                            sal_median = median(MARRIED),
                            sal_var = var(MARRIED),
                            n= n())

educ3 <- group_by(tut1, EDUC3)
cond_med_sal <- summarise(educ3,
                          sal_mean = mean(LWKLYWGE),
                          sal_median = median(LWKLYWGE),
                          sal_var = var(LWKLYWGE),
                          n= n())

cond_med_mar <- summarise(educ3,
                          sal_mean = mean(MARRIED),
                          sal_median = median(MARRIED),
                          sal_var = var(MARRIED),
                          n= n())

educ4 <- group_by(tut1, EDUC4)
cond_sup_sal <- summarise(educ4,
                          sal_mean = mean(LWKLYWGE),
                          sal_median = median(LWKLYWGE),
                          sal_var = var(LWKLYWGE),
                          n= n())

cond_sup_mar <- summarise(educ4,
                          sal_mean = mean(MARRIED),
                          sal_median = median(MARRIED),
                          sal_var = var(MARRIED),
                          n= n())

marriededuc <- group_by(tut1, MARRIED)
cond_mar_educ <- summarise(marriededuc, 
                           sal_mean = mean(EDUC),
                           sal_median = median(EDUC),
                           sal_var = var(EDUC),
                           n= n())

race <- group_by(tut1, RACE)
cond_rac_sal <- summarise(race,
                          sal_mean = mean(LWKLYWGE),
                          sal_median = median(LWKLYWGE),
                          sal_var = var(LWKLYWGE),
                          n= n())

# tabela de conting??ncia
attach(tut1)
mytable1 <- table(MARRIED, EDUC1) # A will be rows, B will be columns 
mytable1 # print table 
chisq.test(mytable1) # testar independencia

mytable2 <- table(MARRIED, EDUC2) # A will be rows, B will be columns 
mytable2 # print table 
chisq.test(mytable2) # testar independencia

mytable3 <- table(MARRIED, EDUC3) # A will be rows, B will be columns 
mytable3 # print table 
chisq.test(mytable3) # testar independencia

mytable4 <- table(MARRIED, EDUC4) # A will be rows, B will be columns 
mytable4 # print table 
chisq.test(mytable4) # testar independencia

mytabletest <- table(MARRIED, EDUC1, EDUC2, EDUC3, EDUC4)
ftable(mytabletest)

sum(tut1$MARRIED)
sum(tut1$EDUC1)
count(tut1, EDUC1>0)

library(ggplot2)
# graficos
ggplot(data=tut1, aes(x=EDUC, y=LWKLYWGE, colour=MARRIED))+ geom_point()

basecon2 <- tut1 %>% filter(MARRIED>0) # so casados
ggplot(data=basecon2, aes(x=EDUC, y=LWKLYWGE))+ geom_point()

basecon3 <- tut1 %>% filter(MARRIED== 0) # so solteiros
ggplot(data=basecon3, aes(x=EDUC, y=LWKLYWGE))+ geom_point()

plot1 <- ggplot(tut1[tut1$EDUC1 == 1,], aes(x = LWKLYWGE)) + geom_histogram(aes(fill = I("red")), color = "Black") +geom_vline(xintercept = mean(tut1[tut1$EDUC1 == 1, "LWKLYWGE"]), color = "Blue")+xlim(c(0,10))

# cov e corr
cov(tut1[,c(3,14,15)]) #covariancia anos de estudo, log do salario e casado
cor(tut1[,c(3,14,15)]) #correla????o anos de estudo, log do salario e casado

# criar uma vari??vel juntando os grupos educacionais - 1, 2, 3 e 4 e depois fazer um cross table 

install.packages("stats")
library(stats)

# normalidade
library(nortest)
normalidade <-function(x)
{
  t1<- ks.test(x, "pnorm")
  t2<-lillie.test(x)
  t3<-cmv.test(x)
  t5<-sf.test(x)
  t6<-ad.test(x)
  t7<-pearson.test(x)
  
  testes<-c(t1$method, t2$method, t3$method, t5$method, t6$method, t7$method)
  valorp<-c(t1$p.value, t2$p.value, t3$p.value, t5$p.value, t6$p.value, t7$p.value)
  
  resultados<-cbind(valorp)
  rownames(resultados) <-testes
  print(resultados, digits=4)
}

qqnorm(tut1$LWKLYWGE, main="", xlab="quantis teoricos N(0,1)", pch=2) qqline(tut1$LWKLYWGE, lty=1, col="blue")

envelope<-function(x)
{ n<-length(x)
qqnorm(x,main="",xlab="quantis te??ricos N(0,1)", pch=20)
qqline(x, lty=2, col="red")
nsim<-100
conf<-0.95
dadossim<-matrix(rnorm(n*nsim, mean= mean(x), sd=sd(x)), nrow= n)
dadossim<-apply(dadossim,2, sort)
infsup<-apply(dadossim,1, quantile, probs= c((1-conf) / 2, (1+conf) / 2))
xbsim<-rowMeans(dadossim)
faixay<-range(x, dadossim)
qq0<- qqnorm(x, main="", xlab="quantis te??ricos N(0,1)", pch=20, ylim=faixay)
eixox<- sort(qq0$x)
lines(eixox, xbsim)
lines(eixox, infsup[1,])
lines(eixox, infsup[2,])
}

# estimador dos minimos quadrados
teste<-lsfit(tut1$EDUC, tut1$LWKLYWGE) 
ls.print(teste)

testecivil <- lsfit(tut1$MARRIED, tut1$LWKLYWGE)
ls.print(testecivil)

install.packages("hydroGOF")
library(hydroGOF)
mse(tut1$MARRIED, tut1$LWKLYWGE) # mean squared error


# regressao

linear <- lm(LWKLYWGE ~ MARRIED, data= tut1)
print(linear)
summary(linear)

cor.test(tut1$EDUC, tut1$LWKLYWGE)
linear2 <- lm(LWKLYWGE ~ EDUC, data = tut1)
print(linear2)
summary(linear2)


# determine residual degrees of freedom
linear2$df.residual

# calculando na mao

cov1 <- cov(tut1$LWKLYWGE, tut1$EDUC)
var1 <- var(tut1$EDUC)
mean1 <- mean(tut1$EDUC)
mean2 <- mean(tut1$LWKLYWGE)

b_chapeu <- cov1/var1
alfa_chapeu <- mean2 -b_chapeu*mean1

b_hat <- coef(linear2) 
y_hat <- round(b_hat["(Intercept)"] +b_hat["EDUC"]*EDUC,5) 
e_hat <- LWKLYWGE - y_hat
# o mesmo pode ser feito por: 
y_hat2 <- round(fitted(linear2), 5)
e_hat2 <- resid(linear2)

# apenas parametros: 
log_sal <- tut1$LWKLYWGE
educ <- tut1$EDUC
tut1_final <- cbind(log_sal, educ, y_hat2, e_hat2) [1:15,]

# confirmando as propriedades
mean(e_hat2) # m??dia do erro chapeu - residuo -  eh 0
cor(educ , e_hat2) # covariancia entre a variavel explicativa e o erro chapeu - residuo-  eh 0

# calculando o teste de hipoteses na mao
SST <- sum(e_hat2*e_hat2)
n <- 1063634
s2 <- round(SST/(n-2), 5)  
s <- round(sqrt(s2),5) 
x_xbarra<- (sum(educ*educ - 2*educ*mean(educ) + mean(educ)*mean(educ))) 
sb <- s/sqrt(x_xbarra) # desv pad de b
summary(linear2)$coefficients
tb <- 0.08143/sb # t-valor
pb <- 2*pt(411.0406, df = linear2$df.residual) # nao entendi
lim_sup <- 0.08143 + 1.96*sb
lim_inf <- 0.08143 - 1.96*sb
int_conf <- cbind(lim_inf, lim_sup) # intervalo de confianca
confint(linear2)

# plotando normalmente entre [-6,6]
t <- seq(-6, 6, 0.01)

plot(x = t, 
     y = dnorm(t, 0, 1), 
     type = "l", 
     col = "steelblue", 
     lwd = 2, 
     yaxs = "i", 
     axes = F, 
     ylab = "", 
     main = expression("Calculating the p-value of a Two-sided Test when" ~ t^act ~ "=411"), 
     cex.lab = 0.7,
     cex.main = 1)

tact <- 411

axis(1, at = c(0, -1.96, 1.96, -tact, tact), cex.axis = 0.7)


# regiao critica sombreada
polygon(x = c(-6, seq(-6, -1.96, 0.01), -1.96),
        y = c(0, dnorm(seq(-6, -1.96, 0.01)), 0), 
        col = 'orange')

polygon(x = c(1.96, seq(1.96, 6, 0.01), 6),
        y = c(0, dnorm(seq(1.96, 6, 0.01)), 0), 
        col = 'orange')

# flechinhas e o t critico, e os respectivos p-valores
arrows(-3.5, 0.2, -2.5, 0.02, length = 0.1)
arrows(3.5, 0.2, 2.5, 0.02, length = 0.1)

text(-3.5, 0.22, 
     labels = expression("0.025"~"="~over(alpha, 2)),
     cex = 0.7)
text(3.5, 0.22, 
     labels = expression("0.025"~"="~over(alpha, 2)),
     cex = 0.7)

text(-5, 0.18, 
     labels = expression(paste("-|",t[act],"|")), 
     cex = 0.7)
text(5, 0.18, 
     labels = expression(paste("|",t[act],"|")), 
     cex = 0.7)

# colocar a barrinha vermelha 
rug(c(-1.96, 1.96), ticksize  = 0.145, lwd = 2, col = "darkred")
rug(c(-tact, tact), ticksize  = -0.0451, lwd = 2, col = "darkgreen")

# Goodness of Fit
# calculando o R2 em 3 diferentes maneiras
R2_1 <- round(var(y_hat2)/var(log_sal), 5)
R2_2 <- round(1-var(e_hat2)/var(log_sal), 5)
R2_3 <- round(cor(log_sal, y_hat2)*cor(log_sal, y_hat2), 5)

# grafico de dispers??o
library(ggplot2)
dispersao <- ggplot(tut1, aes(x=EDUC, y= LWKLYWGE)) + 
  geom_point() + geom_smooth(method = "lm") + 
  labs(y= "log do salario", x= "anos de educacao")

# Linear Model Estimation Using Ordinary Least Squares
install.packages("rms")
library(rms)
minimoquadrado<-ols(LWKLYWGE ~ EDUC, data= tut1)

# quebrando algumas hip??teses - heterocedasticidade e exogeneidade
library(ggplot2)
residuos <- linear2$residuals
ggplot(data = tut1, aes(y = residuos, x = educ)) + geom_point() +geom_abline(linear2) + theme_classic()
plot( x = educ, y = residuos)
abline(linear2)

par(mfrow=c(1,1)) # init 4 charts in 1 panel
plot(linear2)
lmtest::bptest(linear2)  # Breusch-Pagan test
car::ncvTest(linear2 )  # Breusch-Pagan test

# exercicio 9 da lista
parametros <- vector()
m = 17000

for (i in 1:m) { 
  X_9 <- runif(n = m, min = 0, max = 10) # criando uma distribuicao uniforme
  U_9 <- rnorm(n = m, mean = 0, sd=5) # criando uma distribuicao normal pro erro
  Y_9 <- 1 + 2*X_9 + U_9 # criando Y (real)
  reg_9 <- lm(Y_9~X_9) # regressao
  parametros[i] <- coef(reg_9)[2]
}
df_parametros <- data.frame(Estimado = parametros, Amostra = 1:m)
df_parametros %>% 
  ggplot(aes(x = Amostra, y = Estimado)) +
  geom_line()
summary(reg_9)


mean(X_9)
sd(X_9)
mean(U_9)
sd(U_9)
u_hat_9 <- resid(reg_9) # residuos da regressao
sum(u_hat_9) # verificando a propriedade da soma do residuo ser 0
sum(X_9*u_hat_9) # verificando se a soma da multiplicacao entre x e residuo eh 0 
sum(U_9)
sum(U_9*X_9)


# exercicio 10 da lista
exc_10 <- read_dta("consumer.dta")
idoso <- ifelse(exc_10$AGE>=60, 1, 0)
exc_10_idoso <- cbind(exc_10, idoso)
exc_10_idoso$idoso <- as.numeric(exc_10_idoso$idoso)
sum(idoso, na.rm = T)/502
mean(exc_10$INCOME, na.rm = T)

reg_10 <- lm(INCOME ~ FAMSIZE, data = exc_10)
library(tseries)


# regressao multipla
linear_mult <- lm( LWKLYWGE ~ EDUC + AGE, data = tut1)
linear_mult2 <- lm( LWKLYWGE ~ EDUC + + AGE + AGE_ENTR, data = tut1)
linear_aux <- lm(AGE ~ AGE_ENTR, data = tut1)
summary(linear_mult)
summary(linear_mult2)
summary(linear_aux)


# testando se o coef de linear_mult eh diferente de 0.06
teduc <- (linear_mult$coefficients['EDUC'] - 0.06)/0.0002024
Bj_plus <-  linear_mult$coefficients["EDUC"] + 1.96*0.0002024 
Bj_minus <- linear_mult$coefficients["EDUC"] - 1.96*0.0002024 
X <- cbind(1, tut1$EDUC, tut1$AGE)
colnames(X) <- c("CTE", "EDUC", "AGE")
Y <- tut1$LWKLYWGE
b_hat <- solve(t(X) %*% X) %*% t(X) %*% Y 
ic <- cbind(Bj_minus, Bj_plus)
colnames(ic) <- c("Lim_inf", "Lim_sup")

e_hat_mult<- resid(linear_mult)
t(var_mat) %*% e_hat_mult

beta_hat <- coef(linear_mult) # estimadores da reg normal multipla
delta_til <- coef(lm(AGE ~ EDUC, data = tut1)) # relacao entre regressores
beta_hat ["EDUC"] + beta_hat["AGE"]*delta_til["EDUC"] # variaveis omitidas (por delta tilde)
linear2 <- lm(LWKLYWGE ~ EDUC, data = tut1)
coef(linear2)
# variaveis binarias no modelo

linear_irrest <- lm(LWKLYWGE ~ AGE + AGEQ + EDUC + RACE, data = tut1)
table(tut1$REGION)
linear_irrest_regd <- lm(LWKLYWGE ~ AGE + AGEQ + EDUC + RACE + ESOCENT + MIDATL + MT + 
                           NEWENG + SOATL + WNOCENT + WSOCENT + EASTW, data = tut1)
summary(linear_irrest_regd)
library(AER)
linear_irrest_reg <- lm(LWKLYWGE ~ AGE + AGEQ + EDUC + RACE + REGION, data = tut1)
summary(linear_irrest_reg)

linear_married <- lm(LWKLYWGE ~ AGE + AGEQ + EDUC + RACE + MARRIED, data = tut1)
summary(linear_married)

linear_interact_married <- lm(LWKLYWGE ~ MARRIED*(AGE + AGEQ + EDUC + RACE), data = tut1)
summary(linear_interact_married)

library(vtable)
vtable(tut1, summ = c("mean(x)", "median(x)"))


x <- c(1 , 3 , 5, 7, 8, 9)
fix(x)



# teste F
linear_irrest <- lm(LWKLYWGE ~ AGE + AGEQ + EDUC + RACE, data = tut1)
R2_irrest <- summary(linear_irrest)$r.squared
summary(linear_irrest)
library(car) 
myH0 <- c("AGE", "AGEQ", "EDUC", "RACE") # minha hip nula
linearHypothesis(linear_irrest,myH0) # testeF automaticamente
my_race_educ <- c("EDUC", "RACE")
linearHypothesis(linear_irrest, my_race_educ)

# teste2 
myH02 <- c("RACE = 2*AGE")
linearHypothesis(linear_irrest, myH02)

library(stargazer)
linear_age <- lm( LWKLYWGE ~ AGE, data = tut1)
linear_age_q <- lm(LWKLYWGE ~ AGE + AGEQ, data = tut1)
linear_age_q_educ <- lm(LWKLYWGE ~ AGE + AGEQ + EDUC, data = tut1)
linear_age_q_educ_race <- lm(LWKLYWGE ~ AGE + AGEQ + EDUC + RACE, data = tut1)

stargazer(list(linear_age,linear_age_q, linear_mult, linear_age_q_educ, linear_age_q_educ_race), style = "commadefault",
          type = "text", keep.stat = c("n", "rsq"))

# exercicio 4 da lista 2
# apenas um teste
I <- diag(n)
um <- matrix(1, nrow = 11, ncol = 1)
M1 <- I - um %*% solve(t(um) %*% um) %*% t(um)
M1 %*% M1
um %*% t(um)
# letra f
faculty <- read_dta("faculty_salary.dta")
sal_mean <- mean(faculty$sal)
female_mean <- mean(faculty$female)
saldemean <- round(faculty$sal - sal_mean,2)
femaledeman <- round(faculty$female - female_mean, 2)
faculty <- cbind(faculty, saldemean, femaledeman)
reg_cte <- lm(femaledeman ~ saldemean, data = faculty)
summary(reg_cte)

# exercicio 7 da lista 
install.packages("Hmisc") 
library(Hmisc) # para trocar os labels da variavel
label(faculty$saldemean) <- "Desvio dos salarios da media"
label(faculty$femaledeman) <- "Desvio da var de sexo com a media"
reg_7 <- lm(sal ~ female, data =faculty)
summary(reg_7)


# exercicio 7 da lista 2
faculty <- read_dta("faculty_salary.dta")
reg_gen <- lm(sal ~ female, data = faculty)
summary(reg_gen)
reg_int <- lm(sal ~ degree *(ydegree), data = faculty)
summary(reg_int)

reg_gen_log <- lm(log(sal) ~ female, data = faculty)
summary(reg_gen_log)

# SEM

basecon3 <- read_dta("basecon3.dta")
View(basecon3)
library(AER)
twostage_h <- ivreg(hours ~ lwage + educ + age + kidslt6 + kidsge6 + nwifeinc| educ + age + kidslt6 + kidsge6 + nwifeinc + exper + expersq, data = basecon3)
twostage_sal <- ivreg(lwage ~ hours + educ + exper + expersq | educ + exper + expersq + kidslt6 + kidsge6 + nwifeinc, data = basecon3)
summary(twostage_sal)
summary(twostage_h)

library(stargazer)
stargazer(twostage_h, twostage_sal, type = "text")


library(foreign)
library(systemfit)

eq_horas <- hours ~ lwage + educ + age + kidslt6 + kidsge6 + nwifeinc
eq_sal <- lwage ~ hours + educ + exper + expersq
eq_sistema <- list(eq_horas, eq_sal)
instrum <- ~ educ + age + kidslt6 + kidsge6 + nwifeinc + exper + expersq 
summary(systemfit(eq_sistema, inst = instrum, data = basecon3, method = "2SLS"))
summary(systemfit(eq_sistema, inst = instrum, data = basecon3, method = "3SLS"))


# Maxima Verossimilhan??a

# OLS 
library(car)
library(lmtest) 
prob_trab <- lm( inlf ~ nwifeinc + educ + exper + expersq + age + kidslt6 + kidsge6, data = basecon3)
summary(prob_trab) # assumindo homoc
coeftest(prob_trab, vcov = hccm ) # erro padrao robusto heteroc. e o teste t
# problemas com OLS: y fittado pode ser menor que 0 ou maior que 1: 

x_teste <- list(nwifeinc = c(100,0), educ = c(5,17), exper = c(0,30), expersq = c(0,900), 
                age = c(20,52), kidslt6 = c(2,0), kidsge6 = c(0,0))

predict(prob_trab, x_teste)


# Maxima vero. 
# probit 

probit_trab <- glm( inlf ~ nwifeinc + educ + exper + expersq + age + kidslt6 + kidsge6,
                    family = binomial(link = probit), data = basecon3)
summary(probit_trab)
logLik(probit_trab)

# logit
logit_trab <- glm( inlf ~ nwifeinc + educ + exper + expersq + age + kidslt6 + kidsge6,
                   family = binomial(link = logit), data = basecon3)
summary(logit_trab)
logLik(logit_trab)

stargazer(prob_trab, probit_trab, logit_trab, type = "text")

# Maxima Vero modelo antigo

basecon1 <- read_dta("basecon1.dta")
ols_completa <- lm(LWKLYWGE ~ AGE + AGEQ + EDUC + RACE, data = basecon1)
veroinv_completa <- glm(LWKLYWGE ~ AGE + AGEQ + EDUC + RACE, family = inverse.gaussian(link = "1/mu^2"),
                        data = basecon1)

vero_completa <- glm(LWKLYWGE ~ AGE + AGEQ + EDUC + RACE, family = gaussian(link = "identity"),
                     data = basecon1)
summary(probit_completa)
stargazer(ols_completa, vero_completa, type = "text")
library(car)
linearHypothesis(probit_completa, hypothesisMatrix = c('2*educ = exper'))

library(VGAM)
?wald.stat