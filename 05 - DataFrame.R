#*****************************************
# Tema: Estuctura: DataFrame
# Autor: Jair Villanueva 
# Fecha: Feb., 2021
# ***************************************

# Creación de dataframe 
library(dplyr)

df <- data.frame(col1 = 1:4, 
                 col2 = c("Esto", "es", "un text", NA), 
                 col3 = c(TRUE, FALSE, TRUE, NA ), 
                 col4 = c(2.5, 4.2, pi, 3))
print(df)
str(df)          # ver estructura de dataframe
mean(df$col1)

summary(df)
glimpse(df)
?summary
mean(df$col4)

typeof(df$col1)
dim(df)

# otra forma de crear data.frame
v1 <- 1:3
v2 <-c("this", "is", "text")
v3 <- c(TRUE, FALSE, TRUE)
temp <- c(36, 37, 36)
prom <- mean (v1)

df2 <- data.frame(col1 = v1, col2 = v2, col3 = v3, temp = temp) # convertir vectores a un dataframe usando data.frame


l <- list(item1 = 1:3, item2 = c("Esto", "es", "un texto"), item3 = c(2.5, 4.2, 5.1)) # Lista
l
l <- as.data.frame(l)                           # convertir una lista  a un dataframe usando data.frame



m1 <- matrix(1:12, nrow = 4, ncol = 3)
str(m1)

m1 <- as.data.frame(m1)                          # convertir una matrix a un dataframe usando as.data.frame

df
# Agregar una nueva columna
v4 <- c("A", "B", "C", "D")
v5 <- c(1,2,3,4,5)
df
df <- cbind(df, v4)

df <- rbind(df,v5)

# otra forma
add_df <- data.frame(col1 = 4, col2 = "R", col3 = FALSE, col4 = 1.1,
                    stringsAsFactors = FALSE)

add_df

df3 <- rbind(df, add_df)
df3
str(df3)

# Agregar nombres 
dim(df)
names(df)
rownames(df) <- c("pedro", "juan", "elisa","andrea","andres")
colnames(df) <- c("col_1", "col_2", "col_3", "col_4", "col_5")
attributes(df)

# seleccionar un subconjunto de elementos
df[c("row2", "row3"), ]
df[1:2, c(1, 3)]
v <- c(1, 2, 4)
df[ , v]

