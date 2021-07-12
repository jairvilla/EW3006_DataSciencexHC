# Ejemplo: Spam usando K- fold 

# # Librarias ----
library(caret); library(kernlab)

# Data ----
data(spam)
str(spam)
names(spam)
summary(spam)
dim(spam)
# Validación Cruzada ----
set.seed(12345)
folds <- createFolds(y=spam$type, 
                     k= 10, 
                     list = TRUE, 
                     returnTrain = TRUE)
sapply(folds, length)

folds[[1]][1:10]


# Resampling ----
set.seed(1234)
folds <- createResample(y=spam$type, times=10, 
                        list = TRUE)
sapply(folds, length)

folds[[1]][1:10]


