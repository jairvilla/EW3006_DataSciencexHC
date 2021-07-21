# ***********************************
# Logistic Model for feature selection diabetes dataset
# Dataset from: https://www.kaggle.com/uciml/pima-indians-diabetes-database/download
# Prof: Jair Villanueva, Phd
# Course: Machine learning for HC
#*************************************

# Importing Libraries
library(readr); library(caret) 
library(ggplot2); library(mlbench)

# Import Dataset ----
# url      <- "https://www.kaggle.com/uciml/pima-indians-diabetes-database/download"
# diabetes <- read.csv(url)

data(PimaIndiansDiabetes)
diabetes <-PimaIndiansDiabetes

# Solo seleccionando variables mas significativas segun boruta: Glucose, BMI, Age, Pregnancies
names(diabetes)
diabetes2 <- diabetes[,c("glucose", "insulin","pedigree","pressure", "diabetes")]
head(diabetes2, 6)
str(diabetes2)

# Split training data y test data ................................................. 

set.seed(123)   # Valores aleatorios
inTrain <- createDataPartition(y=diabetes2$diabetes, p = 0.70, list =FALSE)  # Split 70% y 30%
train   <- diabetes2[inTrain,]
test    <- diabetes2[-inTrain,]
x_train <- subset(train, select=-c(diabetes)) # only predictors from train
x_test  <- subset(test, select= -c(diabetes)) # only predictors from test
y_train <- subset(train, select= c(diabetes)) # diabetes from train data
y_test  <- subset(test, select=  c(diabetes)) # diabetes from test data

# Control para el cross- validation 
control <- trainControl(method = 'repeatedcv',number = 10,repeats = 3)

# Logistic Model -----------------------------------
set.seed(1156)
glmfit <- train(diabetes ~.,
                data = train,
                method = 'glm',
                preProc = c("center", "scale"),
                trControl = control)

# Paso 6: Validar el Modelo ............................
#  Model 1: Prediction with LogisticR ----
predictionglm <- predict(glmfit, newdata = x_test, type="prob")[,2]  # Probabilidad de que sea 1(no cumple)
predglm01     <- ifelse(predictionglm > 0.5,1,0)
predglm01     <- as.factor(predglm01)
dim()

# Convert Outcome in 1 and 0 values
y_test2 <- factor(ifelse(y_test == "pos",1,0))

# Metrics: ConfusionMatrix ---- 
confusionMatrix (data = predglm01, reference =  y_test2)

# Curva Roc
library(pROC)
plot.roc(y_test2, predictionglm,
         main="Curva ROC del Model", percent=TRUE,
         ci=TRUE, of="thresholds", # compute  the threshold of prediction 
         thresholds="best", # select the (best) threshold
         print.thres="best", 
         print.auc=TRUE,ci.auc=TRUE) # a
