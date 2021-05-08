
# Modelo de regresion Lineal
install.packages("modeldata")

pkgs <- c("dplyr", "tidyr", "broom"," caret", "lubridate","ROCR","broom", 
          "klaR","randomForest","corrplot", "nnet","DT","rio","pROC","tidyverse","pscl",
          "psych", "MASS", "ggplot2", "kernlab", "knitr", "gmodels","compareGroups", 
          "ggpubr","pROC", "glmnet","ROCR", "modeldata") 

sapply(pkgs, require, character.only = T)

# package 
install.packages("modeldata")

# Cargamos los datos
library(modeldata)
library(tidyverse)
library(ggplot2)
library(dplyr)

# Cargamos los datos

data(crickets)      # Cargamos los datos
??crickets          # Informacion del dataset
dim(crickets)
head(crickets, 10)
str(crickets)
names(crickets)
summary(crickets)
glimpse(crickets)

# gglot 
# plot Rate Vs Temperatura
crickets %>% 
  ggplot( aes(x = rate, y = temp))+
  geom_point() +
  geom_smooth(method=lm , color="darkblue", se=FALSE) +
  labs(title = "Tasa de chirridos de grillos Vs Temperatura",
       x = "Chirridos por seg.", y = "Temperatura")

# Correlacion entre las varibles x(rate) e y(temp) 
cor(crickets$temp, crickets$rate)

# La correlación es una medida estadística que sugiere el nivel de dependencia lineal entre dos variables
# Su valor está entre -1 y +1
# Por encima de 0 es una correlación positiva, es decir, X es directamente proporcional a Y.
# Por debajo de 0 es correlación negativa, es decir, X es inversamente proporcional a Y.
# El valor 0 sugiere una relación débil.


# Modelo de regresión lineal
cmodel <- lm(temp ~ rate, data = crickets)
cmodel
summary(cmodel)

confint(cmodel)  # intervalo de confianza 95%

# predición de nuevas variables 

new_data <- data.frame(rate = c(5, 10, 30, 43, 53, 65, 100, 250, 287,300)) # rate con nuevos datos 
prediccion <- predict(cmodel, newdata = new_data)
prediccion <- round(data.frame(prediccion),1)
prediccion

# Validación tomando 10 valores aleatorios(rate) del dataset 
validation <- crickets %>% 
  sample_n(10, replace = FALSE)

rate_val <- validation %>%
  select(rate)

temp_real <- validation %>%
  select(temp) 

# prediccion datos (rate) nuevos
pred2 <- predict(cmodel, newdata = rate_val)

resultados <- data.frame(temp_real, predm = round(pred2,1))
resultados

# Estimacion del Error 
res<- resultados %>% 
      mutate(error = temp - predm)
res

# comparar datos de validacion
pred3 <- data.frame(predmol = round(pred2,1), rate_real=rate_val)

ggplot() +
  geom_point(aes(x = validation$rate, y = validation$temp),
             colour = 'blue') +
  geom_line(aes(x = crickets$rate, y = predict(cmodel, newdata = rate_val)),
            colour = 'red') +
  ggtitle('X vs Y (Test set)') +
  xlab('X') +
  ylab('Y')






