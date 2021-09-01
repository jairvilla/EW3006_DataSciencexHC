#*****************************************
# Tema: Tipos de datos y estructuras
# Autor: Jair Villanueva 
# Fecha: Feb., 2021
# ***************************************

# Tipos de datos en R ---------

k <- c(2,3,4,5,6,7)       # Crear un vector con data numericos

typeof(k)     # double    # identificamos el tipo de dato que tenemos

typeof(TRUE)   # Lógico

typeof(3L)     # integer 

typeof("jair") # caracter

typeof(NA)     # faltante

typeof(Inf)    # infinito

N <- 1/0

typeof(N)

# Algunos ejemplos ---------
# Numerico
a <-3     # Asignar un 3 a un objeto 
print(a)  # Regresa el valor del objeto
a
typeof(a)

# String 
name <- "Stark"
print(name)
typeof(name)

# Logico
log <- TRUE
print(log)
typeof(log)

# complejos 
r  <- 1 + 4i
y  <- 3 + 6i 
suma <- r + y
div <- r / y

print(div)
typeof(div)

#  Creación de Vectores  ----- 

vec1 <- 11:20        # Secuencia de numeros 
vec2 <- c("a","b")  # vector que contiene caracteres
vec3 <- c(1, 2, 3, 4)    # creación de un Vector númerico 

vec4 <- seq(1,10)          # secuencias con un numeros 1- 10 

vec5 <- seq(1, 10, by = 2)   # secuencias con un orden 

vec6 <- seq(from = 1, to = 20 )   # secuencia de 1 a 5

# Combinar vectores 
mixed_vec <- c(vec1,vec2 ) # Nota: los caracteres son mas permisivo que lo numeros
print(mixed_vec)

mix2 <- cbind(vec1,vec4)   # Organizar vectores creados en dos columnas 
mix3 <- rbind(vec1, vec4)  # Organizar vectores en dos filas 

colnames(mix3) <- c("A", "B", "C","D","E","F","G", "H","I", "J")  # Asignar nombres a columnas
mix3

# Coersion ------
# Obliga a vector que sea de una clase definida por el usuario
vec_num <- as.numeric(mixed_vec)
vec_num

a <- "a"
x <- 8
b <- "9"
a + x               # Esta suma no se puede realizas
b + x

as.numeric(b) + x   # asignar as.numerico al vector a 

# Indexacion de los vectores ------
# Indexar por posición 
z <- (6:10)
z[15] <- 7
z

l <- z[3]      # seleccionar un valor en una posicion específica 
z <- z[c(2,4)] # seleccionar dos valores en posiciones esp.
z
# Indexación negativa 

z[-1]           # eliminar dato que esta en la posicion 1
z <- z[-c(6:14)] # eliminar por rangos de un vector


# Indexacion por nombre
z <- c(12,23,344,9,55)
names(z) <- c("age", "peso", "nombre", "cuarto", "quinto")

z["nombre"]  # buscar los datos que estan en la variable

x <- c(a = 1, b = 2, c = 3, d = 4, e = 5) # Otra forma de nombrar los vectores
x

# Modificacion de vectores  ---- 
z[1] <- NA  # Asignar un NA al vector Z  
z

# Creación de listas ----

ing <- list(4000, "pedro", TRUE)
ing <- list (aa = 1, bb = 2, cc = 3) 
ing$aa

# anadir un dato a la lista
ing$ee <- 4
ing
# Nombrar los elementos de una lista 

ing <- list(salario = 1000,
            nombre =  "pedro", 
            trabaja = TRUE )

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

# Creacion de una Matrix 
data <- c(1,2,3,4,5,6)
encabezado <- list(NULL, c("a","b","c")) 

m <- matrix(data,nrow =2, ncol=3, byrow = T, dimnames = encabezado)

m <- matrix(data,nrow =2, ncol=3, byrow = T)

# Indexaciòn 
m[2,c(1,3)]
m[,1]

# Creación de un dataframe  -------

años <- c(1890, 1892, 1976, 2009)
puntaje <- c(1, 2, 3.4, 45) 

m <- data.frame(años,puntaje)
m
x <-m$años
x <-m[,1]

df1 <- data.frame( c1 = c(1, 3,4),
                   c2 = c(2, 4, 5), 
                   c3 = c("a", "b", "c"))
y <- df1$c3

l <- df1[,c(2,3)] 
l <- df1[2:3,] 

# Indexación 

f1$c1  # muestra los valores que estan en la columna c2
f1[1, 3]
f1[,2]
f1[, "c2"]

save.image("IntroBasicR")
