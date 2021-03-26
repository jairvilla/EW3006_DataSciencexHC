# Tema Identificar y eliminar características altamente correlacionadas
# Autor: Jair Villanueva 
# Fecha: Marzo, 2021
#................................


# cargar las librerias 
library(mlbench)
library(caret)

# Cargar los datos
data(PimaIndiansDiabetes)
dim(PimaIndiansDiabetes)

# calcular la matriz de correlación
correlationMatrix <- cor(PimaIndiansDiabetes[,1:8])
correlationMatrix

# encontrar variables que están altamente corregidos (idealmente >0.75)
cutoff <- 0.4
highlyCorrelated <- findCorrelation(correlationMatrix, cutoff=cutoff)
highlyCorrelated

# crear un nuevo conjunto de datos sin  las variables altamente  correlacionadas
dataset <- PimaIndiansDiabetes[,-highlyCorrelated]
dim(dataset)
names(dataset)
str(dataset)
