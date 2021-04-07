# Curso: Ciencias de datos para sector salud
# Autor: Prof. Jair Villanueva
# Tema: Visualizacion de datos parte 1

# Libreria y paquetes 
if(!require(tidyverse)) install.packages("tidyverse")
library(tidyverse)
library(ggplot2)

# Data
?mpg
data(mpg)
str(mpg)
names(mpg)
View(mpg)

# Más info. de la data 
# Q1: Cómo obtener más información o ayuda para trabajar con el dataset ? 
?mpg
glimpse(mpg)
summary(mpg)


# Utilizaremos ggplot
# estructura: 
# ggplot(data, aes(x = var1, y = var2) + 
# geom_xxx )

str(mpg)
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point()

# Usamos geoms para graficar nuestro datos

# Gráficas de una sola variable -----

## histogram
ggplot(data = mpg, aes(x = hwy)) +
  geom_histogram()

?mpg
mpg$class

## bar chart
ggplot(data = mpg, aes(x = class)) +
  geom_bar()

## Poligrama de frecuencia
ggplot(data = mpg, aes(x = hwy)) +
  geom_freqpoly()


## Densidad 
ggplot(data = mpg, aes(x = hwy)) +
  geom_density()


# Gráficas de dos variables -----

## scatter plot
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point()

## box plot
ggplot(data = mpg, aes(x = class, y = hwy)) +
  geom_boxplot()

## violin plot
ggplot(data = mpg, aes(x = class, y = hwy)) +
  geom_violin()


ggplot(data = mpg, aes(x = class)) +
  geom_bar()

names(diabetes)
summary(diabetes)
colSums(is.na(diabetes))

diabetes$diabetes

# Non-mapping aesthetics
ggplot(data = diabetes, aes(x =glucose, y =insulin))+
  geom_point(color = "red", size = 2, shape = 10, alpha =.8)

ggplot(diabetes, aes(x=age, y=pressure, color=diabetes)) + 
  geom_point(size=2)

ggplot(diabetes, aes(x=diabetes)) + 
  geom_bar()
str(diabetes)

ggplot(diabetes, aes(x=as.factor(diabetes), fill=as.factor(diabetes) )) + 
  geom_bar( ) +
  scale_fill_hue(c = 40) +
  theme(legend.position="none")


ggplot(data = diabetes, aes(x = glucose, y = insulin)) +
  geom_point(color = "blue")

# Mapping aesthetics
ggplot(data = diabetes, aes(x = glucose, y = insulin, color = diabetes)) +
  geom_point()

ggplot(data = diabetes, aes(x = glucose, y = insulin, color = diabetes)) +
  geom_point()


# facets for small multiples
# Las funciones de faceta proporcionan una forma sencilla de crear pequeños múltiplos
# facet_wrap: se utiliza principalmente para crear pequeños múltiplos basados en una 
# sola variable

ggplot(diabetes, aes(x = age, y = pressure )) +
  geom_point() +
  facet_wrap(~ diabetes, nrow = 2)

?facet_wrap 
# revisar otros argumentos para el control de salidas

# ejemplo: 
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_grid(drv ~ cyl)


ggplot(diabetes, aes(x = pregnant)) +
  geom_bar() +
  facet_wrap(~ diabetes)

names(diabetes)

# Adicionar títulos en la gráfica

# Añadir titulos
ggplot(data = diabetes, aes(x = diabetes, y = pressure)) +
  geom_boxplot() +
  ggtitle("Diabetes vs Presión arterial”,
          subtitle = “Dataset: Diabetes.cvs")

# Ajuste de escala 
ggplot(data = txhousing, aes(x = volume, y = median)) +
  geom_point() 

ggplot(data = txhousing, aes(x = volume, y = median)) +
  geom_point(alpha = .25) +
  scale_x_log10()

ggplot(data = txhousing, aes(x = volume, y = median)) +
  geom_point(alpha = .25) +
  scale_x_log10()

glimpse(diabetes)

# Axis titles and labels
ggplot(data = txhousing, aes(x = volume, y = median)) +
  geom_point(alpha = .25)  +
  scale_y_continuous(name = "Median Sales Price") +
  scale_x_log10(name = "Total Sales Volume")

# Putting it all together
ggplot(data = txhousing, aes(x = volume, y = median)) +
  geom_point(alpha = .25) +
  scale_y_continuous(name = "Median Sales Price", labels = scales::dollar) +
  scale_x_log10(name = "Total Sales Volume", labels = scales::comma) +
  ggtitle("Texas Housing Sales",
          subtitle = "Sales data from 2000-2010 provided by the TAMU real estate center")

# Overplotting
ggplot(data = txhousing, aes(x = volume, y = median)) +
  geom_point(alpha = .25)  +
  scale_x_log10() +
  geom_smooth()

ggplot(data = txhousing, aes(x = volume, y = median)) +
  geom_point(alpha = .25)  +
  scale_x_log10() +
  geom_smooth(method = "lm")

# Linea de ajuste
ggplot(data = txhousing, aes(x = volume, y = median)) +
  geom_point(alpha = .25)  +
  scale_x_log10() +
  geom_smooth(method = "lm") +
  facet_wrap(~ month)

