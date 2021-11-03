# Exploratory data Analysis (EDA)
# Dataviz

# Packages  ................................
pkgs <- c("ggplot2", "unvotes", "DT","dplyr", "tidyr", "caret","xtable","data.table",
          "lubridate","klaR","randomForest","qwraps2","corrplot", "nnet","DT","rio",
          "tidyverse", "psych", "MASS", "ggplot2", "kernlab", "knitr")
# Install packages .........................
sapply(pkgs, require, character.only = T) 

## Save & Load ............................
save.image(file="feature.RData")
load      (file="feature.RData")  

# Libraries  ..............................
library(ggplot2); library(Hmisc);library(pastecs) 
library(unvotes); library(pastecs)
library(tidyverse); library(psych) 
library(lubridate); library(summarytools)
library(DT)

## Importar data .............................
setwd("C: \Desktop\DATA-SCIENCE\3- SLIDES-2020\DATA")
df <- read.table(file = "cancer.csv", header = TRUE)

# Tambien: 
wbcd <- read.csv("../input/cancer.csv", header=T, stringsAsFactors=F)

## Save & Load ............................
save.image(file="cancerDetection.RData")
load      (file="cancerDetection.RData") 

# Explorer data 
names(cancer)
dim(cancer)                    # Vector (569 x 33)
str(cancer)  
View(cancer)                   # Ver en un tabla los datos, hay un NA en la ultima columna (X33)
cancer <- cancer[,1:32]        # Eliminar el ultima columna
cancer2 <-as.data.frame(cancer)# convertir a dataframe 

# Datos faltantes 
data.frame(colSums(is.na(cancer))) # Total Count NA's  No hay data faltantes

# Revisar outcome
str(cancer$diagnosis)         #

# Removemos la  variable id 
cancer <- cancer[,-1]
cancer$diagnosis <- factor(ifelse(cancer$diagnosis=="B","Benign","Malignant"))  # to factor outcome diagnostic

# Inspeccionamos la data
str(cancer)
summary(cancer)              #resumen estadisticos de las variables
knitr::kable(head(cancer))   # resumir en tabla

# Correlation between each variables
library(PerformanceAnalytics)
chart.Correlation(cancer[,c(3:11)],histogram=TRUE, col="grey10", pch=1, main="Cancer Mean")

#  
library(psych)
pairs.panels(cancer[,c(12:21)], method="pearson",
             hist.col = "#1fbbfa", density=TRUE, ellipses=TRUE, show.points = TRUE,
             pch=1, lm=TRUE, cex.cor=1, smoother=F, stars = T, main="Cancer SE")

library(ggplot2)
library(GGally)
ggpairs(cancer[,c(22:31)],)+ theme_bw()+
  labs(title="Cancer Worst")+
  theme(plot.title=element_text(face='bold',color='black',hjust=0.5,size=13))


# Encontrar relacion entre las variables y el outcome
ggpairs(cancer[,c(2:11,1)], aes(color=diagnosis, alpha=0.75), lower=list(continuous="smooth"))+ theme_bw()+
  labs(title="Cancer Mean")+
  theme(plot.title=element_text(face='bold',color='black',hjust=0.5,size=12))


# Eliminar las variables que no tienen fuerte asociacion con el outcome ............
# Correlation Matrix     
correlationMatrix <- cor(cancer[,3:31])                              # Select only numerical Variables
hcorrelated       <- findCorrelation(correlationMatrix, cutoff=0.6)  # Threshold >0.6, Find Features that are highly corrected 
print(hcorrelated)                                                   # print indexes of highly correlated attributes
highly_cor_var    <- colnames(cancer[hcorrelated])                   # displaying highly correlated variables
data.frame(highly_cor_var)

# Removing the highly correlated variables .........................................
cancer_no_hcor <- cancer[,-hcorrelated]
str(cancer_no_hcor)
cancer_nc <- cancer_no_hcor       # este data set no tiene las variables correlacionadas
names(cancer_nc)

cancer3 <- cbind(cancer_nc, cancer[,1])
str(cancer3)
str(cancer)


# Split training data y test data ................................................. 
set.seed(899)   # Valores aleatorios
inTrain <- createDataPartition(y=cancer$diagnosis, p = 0.70, list =FALSE)  # Split 70% y 30%
train   <- cancer[inTrain,]
test    <- cancer[-inTrain,]
x_train <- subset(train,select = -c(diagnosis))    # only predictors from train 
x_test  <- subset(test,select  = -c(diagnosis))    # only predictors from test
y_train <- subset(train,select = c(diagnosis))     # outcome from train data 
y_test  <- subset(test, select = c(diagnosis))     # outcome from test data
control <- trainControl(method = 'repeatedcv',number = 10,repeats = 3) # control




str(train)
# Model RANDOM FOREST 
library(randomForest);library(e1071) 
# Building Models...............................
# Logistic Model -----------------------------------
set.seed(1156)
logFit <- train(diagnosis ~.,
                data = train,
                method = 'glm',
                preProc = c("center", "scale"),
                trControl = control)
#....................................................
#  KNN ----
set.seed(445)
knnFit <- train(diagnosis~.,
                data = train,
                method = "knn",
                preProc = c("center", "scale"),
                tuneGrid = data.frame(.k = 1:10),
                trControl = control)

#  SVM ..........................................
set.seed(523)
svmFit <- train(diagnosis~.,
                data = train,
                method = 'svmLinear',
                preProc = c('center','scale'),
                tuneLength = 7,
                trControl = control)

# Bayes Naives .................................
set.seed(456)
nbFit  <- train(diagnosis~ .,
                data=train,
                method="nb",
                preProc = c('center','scale'),
                trControl=control)

# Random forest -----
set.seed(123)
rfFit <- train(diagnosis~., data = train, 
               method = "rf",
               preProc = c('center','scale'),
               trControl = control,
               skip = TRUE)


library(caret)
# Validacion de los modelos 
#  Model 1: Prediction with LogisticR ----
predictionglm <- predict(logFit, newdata = x_test, type="prob")  # Probabilidad de que sea 1(no cumple)
predglm01     <- ifelse(predictionglm > 0.5,"Malignant" ,"Benign")
predglm01     <- as.factor(predglm01)
length(predglm01)
cancer$diagnosis
dim(cancer)
# AUC and CI   .................................. 
print(aucglm   <- auc(test$diagnosis,predictionglm))
print(ciaucglm <- ci.auc(test$diagnosis, predictionglm))
rocglm          <-roc(test$diagnosis,predictionglm)$auc

# Compute error  ................................
confusionmatrix  <- table(predglm01, 
                          test[,which(names(test) == "diagnosis")])
## Missclasification --
misclassificationglm <- (confusionmatrix[2, 1] + confusionmatrix[1, 2]) / 
  (confusionmatrix[1, 1] + confusionmatrix[1, 2] + confusionmatrix[2, 1] + confusionmatrix[2, 2])

misclassificationglm

# Matrix confusion   ....................................
print(cm.glm <- confusionMatrix(data=predglm01,reference = test$diagnosis)) 

# Threshold and AUC ......................................
plot.roc(test$class, predictionglm,
         main="Comparison of AUC GLM_FULL MODEL ", percent=TRUE,
         ci=TRUE, of="thresholds", # compute  the threshold of prediction 
         thresholds="best", # select the (best) threshold
         print.thres="best", 
         print.auc=TRUE,ci.auc=TRUE) # a

## Calculate optimal threshold with Youden's index  .......
rocglm  <- roc(test$class, predictionglm)
print(bestglm <- coords(rocglm, "b", ret = "threshold", best.method = "youden"))

# Threshold Adj. fit Model ...............................
predglm01  <- ifelse( predictionglm > bestglm, 1, 0)
predglm01  <- as.factor(predglm01)

# Matrix Confusion  .....................................
sink(file="glm_prediction21")
print(cm.glm01 <- confusionMatrix(data=predglm01, reference = test$class, positive = "1")) 
sink()

# Compute error .........................................
confusionmatrix  <- table(predglm01,test[,which(names(test) == "class")]) 

# Missclasification  ....................................
misclassificationglm01 <- (confusionmatrix[2, 1] + confusionmatrix[1, 2]) / 
  (confusionmatrix[1, 1] + confusionmatrix[1, 2] + confusionmatrix[2, 1] + confusionmatrix[2, 2])
misclassificationglm01

