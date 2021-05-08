#*****************************************
# Tema: Manejo de datos faltantes
# Autor: Jair Villanueva 
# Fecha: Marzo, 2021
# ***************************************
getwd()

# Crear vector con datos faltantes

x <- c(1:4, NA, 6:7, NA)  # Vector con NA
x
is.na(x)                  # identificar los valores perdidos

# Crear dataframe con datos faltantes
df <- data.frame(col1 = c(1:3, NA),
                 col2 = c("this", NA,"is", "text"), 
                 col3 = c(TRUE, FALSE, TRUE, TRUE), 
                 col4 = c(2.5, 4.2, 3.2, NA))
df
is.na(df)                
str(df)

mean(df$col1)

# identificar la ubicacion y el numero de NA 

which(is.na(df))    # localizar NA 
sum(is.na(df))      # Contar NA 
colSums(is.na(df))  # calcular el total de valores
is.na(df$col2)      # Identificar los NA en una columna epecifica


# Imputacion de datos a NA's

x <- c(1:4, NA, 6:7, NA)
x
typeof(x)

mean(x)               # Promedio de los valores del vector (error)
summary(x)

mean(x, na.rm=TRUE)  # Excluye los NA del promedio 
x[is.na(x)]<- mean(x, na.rm = TRUE) # Imputacion de valores usando la media
x
mean(x)

?round
x <-round(x,0)
x
summary(x)
mean(x)

# Opcion 2: omitir los datos faltantes
x <- c(1:4, NA, 6:7, NA, NA, NA)
x
mean(na.omit(x))

PROME <- (1+2+3+4+6+7)/6
PROME
# Datos faltantes en data.frame
df <- data.frame(col1 = c(1:3, NA),
                 col2 = c("Esto", NA,"es", "texto "), 
                 col3 = c(TRUE, FALSE, TRUE, TRUE), 
                 col4 = c(2.5, 4.2, 3.2, NA),
                 stringsAsFactors = FALSE)

colSums(is.na(df))
na.omit(df)        # Omitir valores


# Funcion complete.cases 
df
colSums(is.na(df))
complete.cases(df)        # detecta las filas que tienen los valores completos
df2 <- df[complete.cases(df), ]  # crea un subset con caso completos
df2
df[!complete.cases(df), ] # con ! obtiene los caso incompletos   


# revisar NA y missing values

numberOfNA = length(which(is.na(dataset)==T))
if(numberOfNA > 0) {
  cat('Number of missing values found: ', numberOfNA)
  cat('\nRemoving missing values...')
  trainingSet = dataset[complete.cases(dataset), ]
}



