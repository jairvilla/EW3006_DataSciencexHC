
# Introducción a R. 


# Ayuda en R
help ("lm")
?lm
help.search("lm")

# Revisar el directorio de trabajo
getwd()

# cambiar el directorio de trabajo

setwd("/Users/jvill/Desktop/EJEMPLOS")  # Modificar según tu configuración del pc 

# Revisar elementos del directorio
dir()
list.files()

# Revisar lista de objetos que estan en el entorno de variables 
ls()

# Quitar los objetos del entorno de variables
rm(n1)            # eliminar un solo elemento
rm(list = ls())   # crear una lista que contienen todos los objetos del entorno, 
                  # y se eliman todos los objetos. 


# Definir un objeto 
a <- 3              # asignar un número
b <- "prueba"       # asignar un caracter
v <- c(3, 2, 4, 5)  # asignar un vector, no olvide la letra c (concadenar)
x <- c("perro", "gato","pez")

# Imprimir un objeto en la consola de R 
print(x)
x

# Determinar el tipo de objeto 
typeof(x)


# Guardar un Script en la carpeta de trabajo 
save.image("intro_R")

# Cargar un script (son archivos .R)
load("intro_R")  # Carga el script y los objetos almacenados en la memoria

 
