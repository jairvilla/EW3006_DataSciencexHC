# Modelo de regresion logiticas
# Objetivo, realizar un modelo de clasificación de spam 
# Autor: Prof. Jair Villanueva 


# Packages requeridos
install.packages("caret")
install.packages("kernlab")
install.packages("e1071")

# Cargamos las Librarias
library(caret); library(kernlab);library(e1071) 

# Cargar el dataset
data(spam)
names(spam)   # Outcome = type 
str(spam)
dim(spam)
colSums(is.na(spam))
summary(spam)

# Implementación de un modelo de Regresion logística

set.seed(12345)   # garantizar usar los mismos datos

# Usaremos funciones del paquete caret
#  Paso1: Partición del dataset: Training y testing  ----  

inTrain <- createDataPartition(y=spam$type,
                               p=0.70, list=FALSE)
training <- spam[inTrain,]   # 70% de los datos para el entrenamiento
testing  <- spam[-inTrain,]  # 30% de los datos para la validación 

dim(spam)
dim(training)
dim(testing)
glimpse(training)
# Paso 2: Seleccionar el modelo

names(spam)
set.seed(1234)
modelFit <- train(type ~.,data=training, method="glm")

modelFit$method
modelFit$results  # resultados con los datos de entrenamiento


# Paso 3: Ajuste del Modelo
modelFit$finalModel
names(spam)

# Paso 4: Predicción de los nuevos datos
prediccion <- predict(modelFit,newdata=testing)
prediccion
table(prediccion)

# Paso 5: Evaluación (Métricas) 
confusionMatrix(prediccion,testing$type)



