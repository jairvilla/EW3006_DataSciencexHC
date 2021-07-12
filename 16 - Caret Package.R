
# Librarias ----
library(AppliedPredictiveModeling); library(caret); library(kernlab)

# Data ----
data(spam); data(AlzheimerDisease)
dim(AlzheimerDisease)

# Descripción de la data ----
str(spam)
names(spam)
summary(spam)

# Partición de los datos (Data splitting) ----
# Usamos el paquete Caret 

alldata  <- createDataPartition(y = spam$type,
                               p = 0.75, list = FALSE)

training <- spam[alldata,]  # data para entrenar el modelo
dim(training)

testing  <- spam[-alldata,] # data para evaluar el modelo 
dim(testing)
table(testing$type)         # outcome balanceados

# Modelo GLM implementado ---- 
set.seed(1234)
modelFit <- train(type ~., data = training, method = "glm")

# Modelo final  ----
modelFit$finalModel

# Evaluamos el modelo (testing) ----

prediccion <-predict(modelFit, newdata=testing)
prediccion
table(prediccion)

# Métricas ---- 
# Qué tan bien predice el modelo?
 
confusionMatrix(prediccion, testing$type)




  



