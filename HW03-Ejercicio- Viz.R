# Curso: Ciencias de Datos
# Objetivos: Realiar diferentes gráficas del dataset: "diabetes.csv"

#1: import data
diabetes <- read_csv("data/diabetes.csv")
diabetes <- as.data.frame(diabetes)

names(diabetes)

# #2: distribution glucose and pressure variables
ggplot(data = diabetes, aes(x = glucose)) +
  geom_histogram()

ggplot(data = diabetes, aes(x = pressure)) +
  geom_histogram()

#......................................
# Un histograma representa una distribución de frecuencias que se utiliza (o debe)
# para representar la frecuencia de las variables cuantitativas continuas.
# Aquí no es la altura, sino el área de la barra lo que es proporcional a la
# frecuencia de ese intervalo,y está en relación con la probabilidad con la
# que cada intervalo puede presentarse
#......................................

#3: distribution of pregnant variable
ggplot(data = diabetes, aes(x = pregnant)) +
  geom_bar()

# #  el diagrama de barras sirve para representar las variables 
# cualitativas ordinales. En el eje horizontal se representan las 
# diferentes categorías y sobre él se levantan unas columnas o 
# barras cuya altura es proporcional a la frecuencia de cada categoría. 
# Tambien para variables cuantivas discretas

#3: distribution of  variable
ggplot(data = diabetes, aes(x = diabetes)) +
  geom_bar()

#4: scatter plot for glucose vs insuline 
ggplot(data = diabetes, aes(x = glucose, y =insulin )) +
  geom_point()
