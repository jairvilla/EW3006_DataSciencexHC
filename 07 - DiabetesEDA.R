#*****************************************
# Tema: Analisis estadistico Exploratorio (EDA) 
# Autor: Jair Villanueva 
# Fecha: Feb., 2021
# ***************************************

# Instalar packages
install.packages("corrplot")
install.packages("reshape2")

getwd()

# Librerias  ----

library(tidyverse); library(ggplot2);library(corrplot)
library(readr); library(dplyr); library(reshape2)  

# Cargar datos ----
getwd()
setwd("C:/Users/jvill/Desktop/DataScience-2021/data") # Asigna la ruta a una variable que crearemos "dataset"
filename <- "diabetes2.csv"                          # define el filename
diabetes <- read.csv(filename, header=TRUE)         # asigna los datos a una variable llamada dataset y lee los datos
tail(diabetes, 3)
str(diabetes)
glimpse(diabetes)

# Manejar el dataset como una tabla 
diabetes <- as_tibble(diabetes) 
diabetes

# Analisis de los datos 
dim(diabetes)
str(diabetes)
glimpse(diabetes)

names(diabetes)
sapply(diabetes, typeof)  # Tipos de datos

# Info. estadistica basica 
summary(diabetes)

# Modificar nombre de columnas 
names(diabetes)
colnames(diabetes)[7]<- "Pedigree"

# Revisar el outcome (salida)
table(diabetes$Outcome) 
 
# De forma gráfica
g <- ggplot(diabetes, aes(Outcome))+ 
     geom_bar(aes(group = Outcome,
                 color = Outcome)) +
    theme(legend.position = "none")
g

#  Analisis de dos variables en relacion con el target 
names(diabetes)

summary(diabetes$Pregnancies)

g <- ggplot(diabetes, aes(Pregnancies))
g + geom_bar(aes(group=Outcome)) +
    facet_wrap(~Outcome) +
    theme(legend.position = "none")

# Intenta lo mismo con las variables Glucose y Outcome
# BloodPressure y Outcome
# BMI and Outcome

# Age and Outcome
g <- ggplot(diabetes, aes(Age))
g + geom_bar(aes(group=Outcome)) + 
    facet_wrap(~Outcome) + 
    theme(legend.position = "none")

# Correlacion entre las variables 

num_vars <- unlist(lapply(diabetes, is.numeric))  
dia_nums <- diabetes[ , num_vars]

dia_corr <- cor(dia_nums)
corrplot(dia_corr, method="number")
corrplot(dia_corr, type="upper")

# Valor Faltantes e impuntacion de valores 
# Presion arterial? Los valores son correctos

prom_bp <- mean(diabetes$BloodPressure[diabetes$BloodPressure > 0])

diabetes$BloodPressure <- ifelse(diabetes$BloodPressure == 0,
                                 round(prom_bp, 0),
                                 diabetes$BloodPressure)
summary(diabetes)

# Los valores son correctos
mean_Glu <- mean(diabetes$Glucose[diabetes$Glucose > 0])

diabetes$Glucose <- ifelse(diabetes$Glucose == 0, 
                           round(mean_Glu, 0), diabetes$Glucose)
# SkinThickness
mean_SkT <- mean(diabetes$SkinThickness[diabetes$Glucose > 0])

diabetes$SkinThickness <- ifelse(diabetes$SkinThickness == 0, 
                                 round(mean_SkT,0), diabetes$Glucose)

# BMI
mean_BMI <- mean(diabetes$BMI [diabetes$BMI  > 0])
diabetes$BMI  <- ifelse(diabetes$BMI  == 0, 
                        round(mean_BMI ,0), diabetes$BMI )


summary(diabetes)
num_vars <- unlist(lapply(diabetes, is.numeric))  
dia_nums <- diabetes[ , num_vars]

dia_corr <- cor(dia_nums)
corrplot(dia_corr, method="number")

