#*****************************************
# Tema: Tipos de datos y estructuras
# Autor: Jair Villanueva 
# Fecha: Feb., 2021
# ***************************************

## Tipos de datos en R ---------

typeof(20)     # double 

typeof(TRUE)   # Lógico

typeof(3L)     # integer 

typeof("jair") # caracter

typeof(NA)     # faltante

typeof(Inf)    # infinitos

N <- 1/0
typeof(N)

# Algunos ejemplos ---------

a <- 3 

# Numerico
print(a)
a
typeof(a)

name <- "Stark"

# Caracter
print(name)
typeof(name)

electro <- TRUE

# Logico
print(holiday)
typeof(holiday)

distancia <- 1 + 4i

# Complex
print(distance)
typeof(distance)

#  creacion de Vectores  ----- 

vec_0 <- 1:5              # vector de numeros ordenados  
print(vec_0)

vec_1 <- c(1, 2, 3, 4)    # creación de un Vector númerico 
vec_1
typeof(vec_1) 

vec_2 <- c("a", "b", "c") # creación de un Vector caracter 
typeof(vec_2)

seq(1, 10)                # secuencias

a <- seq(1, 10, by = 2)   # secuencias con un orden 
a

seq(from = 1, to = 5 )   # secuencia de 1 a 5

# Combinar vectores 

mixed_vec <- c(vec_1,vec_2 ) # los caracteres son mas permisivo que lo numeros
print(mixed_vec)
typeof(mixed_vec)

# Coersion ------
# Obliga a vector que sea de una clase definida por el usuario

vec_num <- as.numeric(mixed_vec)
vec_num


a <- "a"
x <- 8
b <- "9"

a + x   # Esta suma no se puede 
b + x

as.numeric(b) + x         # asignar as.numerico al vector a 

# Indexacion de los vectores ------

# Indexar por posición 

z <- 6:10
print(z)

z[4]      # extraer el valor de vector con una posicion específica 

z[c(2,4)]

# Indexación negativa 

z[-1]
z[-c(1,5)]

# Indexacion por nombre
names(z)      #
names(z) <- c("primero", "segundo", "tercero", "cuarto", "quinto")

z["segundo"]

named <- c(a = 1, b = 2, c = 3, d = 4, e = 5) # Otra forma de nombrar los vectores

# Modificacion de vectores

z[1] <- NA 
z


# Creaciòn de listas

ing <- list(4000, "pedro", TRUE)
ing

# Nombrar los elementos de una lista 

ing <- list(salario = 1000, 
            nombre =  "pedro", 
            trabaja = TRUE )
ing

names(ing)

ing <- list(salario = 1000, 
            nombre =  "pedro", 
            trabaja = TRUE, 
            info = c("tel", "dir"))
ing

# Indexar lista por nombre o posiciòn 

names(ing)
ing["salario"]
ing[3]
ing[[3]]

ing$salario

# Modificar una lista 

ing$salario <- 5000
ing

# dataframe  -------
f1 <- data.frame(c1 = c(1, 3),
                 c2 = c(2, 4), 
                 c3 = c("a", "b"))
f1

# Indexación 

f1$c1  # muestra los valores que estan en la columna c2

f1[1, 3]
f1[,2]
f1[, "c2"]

save.image("IntroBasicR")
