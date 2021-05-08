#****************************************************
# Modelo de regresion Logistica
# Data: PimaIndiansDiabetes2
# Tarea: Clasificacion de paciente con/sin diabetes
# ***************************************************

# Paquetes

install.packages("MASS")
install.packages("mlbench")

# cargamos las librerias 
library(MASS)
library(mlbench)
??MASS          # Info. paquete

# data
data("PimaIndiansDiabetes2")
diabetes <- PimaIndiansDiabetes2
?PimaIndiansDiabetes2

# descripcion de los datos
head(diabetes, 6)
str(diabetes)

# estadisticas del data set 
summary(diabetes)

# Omitir datos faltantes 

diabetes <- na.omit(diabetes)
dim(diabetes)
dim(data1)

# Modelo de RLogistic
model <- glm(diabetes ~.,family = binomial, data=data1 ) # si queremos utilizar todas las varaibles 

model3 <- glm(diabetes ~ glucose + pedigree + mass,family = binomial, data=data1 )

# Info. Modelo
model$fitted.values

summary(model)
summary(model2)
summary(model3)

library(dplyr)

prueba <- data1 %>%
  sample_n(20, replace = FALSE)
dim(prueba)

prueba1 <- prueba %>%
  select(-"diabetes")
dim(prueba1)
head(prueba1,5)

?predict

# predicion 
pred1 <- predict(model, newdata = prueba1, type = "response")
pred2 <- ifelse(pred1 > 0.5, "pos", "neg")
pred2

mean(pred2==prueba$diabetes)
