# Tema: Manipulacion de datos
# Prof: Jair Villanueva 
# date: 09/20 
# Objetivo: Cargar data desde un archivo .CSV en un directorio local
# -----------------------------------------
#Nota: 
# CSV significa Valores Separados por Comas. Un archivo CSV se utiliza para almacenar datos. 
# Es un archivo de texto sin formato con extensión .csv.
# En este tipo de archivos los valores se establecen por ',' (coma) o ';' (semi-colon)
# -----------------------------------------

install.packages("readr")  # Necesitamos instalar paquete readr. 
library(readr)             # Cargar paquete readr

# Nota: algunas funciones de "readr" para  tener en cuenta 
# read_csv(): para leer archivos con coma (“,”) como separador
# read_csv2(): para leer archivos con punto y coma (“;”) como separador
# read_tsv(): para leer archivos con tabulador (“\t”) como separador
# read_delim(,sep =’|’): para leer archivos con separador distintos como puede ser el símbolo ‘|’


# Método 1: ------------------------

file.choose()             # Buscar la ruta del archivo de csv, y selecciona donde estan tus datos. Te aparecera esto
#   [1] "C:\\Users\\jvill\\Desktop\\DATA-SCIENCE\\Projects_Course\\EDA_Project\\data\\drug200.csv"

filename <- "BreastCancer.csv"               # asignamos un string(variable texto) con el nombre que queremos
cancer   <- read.csv(filename, header=TRUE)  # Carga el archivo CSV desde un directorio local
head(cancer)                                 # Muestra las primeros cinco observaciones


# Método 2:-------------------------

getwd()                                      # Da la ruta en el que working directory se encuentra 
setwd("C:/Users/jvill/Desktop/DATA-SCIENCE/1-202101Course/2021_CourseDS/data") # Asigna la ruta a una variable que crearemos "dataset"
filename <- "BreastCancer.csv"                    # define el filename
dataset <- read.csv(filename, header=TRUE)  # asigna los datos a una variable llamada dataset y lee los datos
head(dataset)
str(dataset)

#**********************************************************************

## Tema: Cargar data desde un archivo del excel data desde una página web 
# Prof: Jair Villanueva 
# Date:07/20
#.............................................

# Packages requeridos 

install.packages("xlsx")   # Instalar paquetes 
library(xlsx)              # Carga la library xlsx
# --------------------------------

# Método 1 -----------------------
getwd()
cancer2 <- read.xlsx("C:/Users/jvill/Desktop/DATA-SCIENCE/1-202101Course/2021_CourseDS/data/cancer2.xlsx", sheetIndex = 1, header = TRUE) 
head(cancer2)


# Método 2 --------------------------------------

# Para leer el archivo de esa ubicación el código R será
cancer_breast <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer/breast-cancer.data")
names(cancer_breast)     # Da los nombres de las columnas, nota que en este caso no hay o no son los adecuados los nombre de las columnas 
View(cancer_breast)      # Ver los datos
str(cancer_breast)       # Muestra la estructura de un objeto en R
dim(cancer_breast)       # Dimensiones de un objeto



carEva   <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/car/car.data")   # data sin nombre
namescar <- read.csv ("https://archive.ics.uci.edu/ml/machine-learning-databases/car/car.names")  # Nombres del dataframe
names(namescar)
dim(carEva)
# Asignar manualmente  los nombres a las columnas de mis datos (ver atribute information dataset)
# Para el caso del dataset breast-cancer.data, 
# Los nombres de las columnas son: class, age, menopause,tumor-size, inv-node, inv-nodes, node-caps,deg-malig,breast,breast-quad,irradiat 
names(cancer_breast) = c("class","age","menopause","tumor-size","inv-node",
                         "node-caps","deg-malig","breast","breast-quad","irradiat")
str(cancer_breast)                                                      

#************************************************
# Intentalo Caso 2 asignar nombres a CarEva
# Class Values: unacc

# Attributes:
# buying: vhigh, high, med, low.
# maint: vhigh, high, med, low.
# doors: 2, 3, 4, 5 more.
# persons: 2, 4, more.
# lug_boot: small, med, big.
# safety: low, med, high.
# **********************************************
