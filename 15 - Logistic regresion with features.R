#****************************************************
# Modelo de regresion Logistica
# Data: PimaIndiansDiabetes2
# Tarea: Clasificacion de paciente con/sin diabetes
# ***************************************************

# Paquetes
if(!require(pROC)) install.packages("pROC")
install.packages("MASS")
install.packages("mlbench")
install.packages("caret")

# cargamos las librerias.......
library(MASS); library(dplyr); library(caret)
library(mlbench); library(tidyverse)  
library(modelr); library(broom); library(pROC)  
# Info. paquete

# data ........................
data("PimaIndiansDiabetes2")
diabetes <- PimaIndiansDiabetes2
?PimaIndiansDiabetes2

# descripción de los datos .....
head(diabetes, 6)
str(diabetes)
dim(diabetes)
# estadisticas del data set 
summary(diabetes)

# Omitir datos faltantes 

diabetes <- na.omit(diabetes)
dim(diabetes)
str(diabetes)
# trabajar con las variables que tienen datos completos 
df <- diabetes[complete.cases(diabetes), ]
# summary(df)
# dim(df)
??glm 
# Modelo de RLogistic
model1 <- glm(diabetes ~.,family = binomial, data=diabetes) # si queremos utilizar todas las varaibles 

# Revisar el modelo
summary(model1)

model2 <- glm(diabetes ~ glucose + pedigree +
                mass ,family = binomial, data = diabetes)
summary(model2)

model3 <- glm(diabetes ~ glucose + pedigree +
                mass + age ,family = binomial, data = diabetes)
summary(model3)

# Info. Modelo
model1$fitted.values
model1$coefficients

# Validacion de modelo
# observaciones nuevas, que debe predecir el modelo
prueba <- diabetes %>%
  sample_n(50, replace = FALSE)
dim(prueba)
names(prueba)
head(prueba,5)
prueba1 <- prueba %>%
  select(-"diabetes")
dim(prueba1)
head(prueba1,5)

# predicion 
pred1 <- predict(model1, newdata = prueba1, type = "response")
pred2 <- ifelse(pred1 > 0.5, "pos", "neg")
pred2 <- as.factor(pred2)

mean(pred2==prueba$diabetes)
resultado <- data.frame(prediccion = pred2, actual=prueba$diabetes)
resultado

confusionMatrix(pred2, reference = prueba$diabetes, positive = "pos")
??confusionMatrix

# Modelo de regresion usando el package caret  ......

# Implementación de un modelo de Regresion logística
library(caret)    # Usaremos funciones del paquete caret
set.seed(12345)   # garantizar usar los mismos datos

#  Paso1: Partición del dataset: Training y testing  ----  
inTrain <- createDataPartition(y=diabetes$diabetes,
                               p=0.70, list=FALSE)
training <- diabetes[inTrain,]   # 70% de los datos para el entrenamiento
testing  <- diabetes[-inTrain,]  # 30% de los datos para la validación 

# dimesion de los subsets 
dim(diabetes)
dim(training)
dim(testing)
glimpse(training)
??glimpse

# Paso 2: Seleccionar el modelo

set.seed(1234)
modelFit <- train(diabetes ~.,data=training, method="glm")
summary(modelFit)

modelFit$method
modelFit$results  # resultados con los datos de entrenamiento


# Paso 3: Ajuste del Modelo
modelFit$finalModel

# Paso 4: Predicción de los nuevos datos
head(testing2, 6)
testing2 <- testing %>%
  select(-diabetes)

prediccion <- predict(modelFit,newdata=testing2)
typeof(prediccion)
prediccion <- as.factor(prediccion) 
prediccion
resultados <- data.frame(real=testing$diabetes, modelo=prediccion)
resultados
dim(testing)
# Paso 5: Evaluación (Métricas) 
confusionMatrix(prediccion,testing$diabetes, positive = "pos")

92/117
# Paso 6: Curva Roc 
install.packages("pROC")
library(pROC)

# Curva Roc
library(pROC)
plot.roc(test$Outcome, predictionglm,
         main="Curva ROC del Model", percent=TRUE,
         ci=TRUE, of="thresholds", # compute  the threshold of prediction 
         thresholds="best", # select the (best) threshold
         print.thres="best", 
         print.auc=TRUE,ci.auc=TRUE) # a

