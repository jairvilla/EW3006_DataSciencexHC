# Curso: Ciencias de datos para sector salud
# Autor: Prof. Jair Villanueva
# Tema: Visualizacion de datos parte 1


# Librerias y paquetes que requerimos 
if(!require(tidyverse)) install.packages("tidyverse")
library(tidyverse)  # Manipulación de datos 
library(ggplot2)    # Visialización de los datos
library(readr)      # Importar dataset .csv
library(dplyr)

# Cargar el Dataset ----
# Cargar desde una pagina web 
heart.data <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/processed.cleveland.data",header=FALSE,sep=",",na.strings = '?')
names(heart.data) <- c( "age", "sex", "cp", "trestbps", "chol","fbs", "restecg",
                        "thalach","exang", "oldpeak","slope", "ca", "thal", "num")

# Cargar desde un directorio local 
heart <- read_delim("data/heart.csv", delim = ";", 
                    escape_double = FALSE, trim_ws = TRUE)

heart <-as.data.frame(heart)   # Convertir a data frame

# Obtener información de los datos
str(heart)
names(heart)
dim(heart)
head(heart, 5)


# Q1: Cómo obtener más información o ayuda para trabajar con el dataset ? 
# Analisis estadístico de las variables

heart$diag <- as.factor(heart$diag)
glimpse(heart)
summary(heart)

# Omitir NA del dataset 
hd <-heart[complete.cases(heart), ]
dim(hd)
str(hd)

# Como usar el paquete ggplot
# estructura ggplot: 
# data layers +  geom layer + stat layer =  grafico con ggplot2

# Ejemplo de layers con ggplot2
names(hd)
heart.data <- hd %>% 
  dplyr::filter(age >= 40)

# data layer           
p <- ggplot(data=heart.data, 
            aes(x = age, y= chol))
p
# data layer + geom layer 
p + geom_point() 
names(hd)
heart.data %>%
  ggplot(aes(x = age, y= chol)) +
  geom_point()+ 
  stat_smooth(method="lm", formula = y ~ x)+
  theme(legend.position="none",
        plot.title = element_text(size=11)) +
  ggtitle("Edad vs colesterol") +
  ylab("colesterol(mg/dl)")+
  xlab("Age") 

# Buscar + geom_
apropos("^geom_")
apropos("^theme_")
# data + stat layer
apropos("^stat_")

p +  geom_point()+
  stat_smooth(method="lm", formula = y ~ x)

# añadir más capas 

# Gráficas de una sola variable -----
names(heart)

# Box plot 
ggplot(hd, aes(x=as.factor(diag), y=age)) + 
  geom_boxplot(fill="LightSalmon", alpha=0.2) + 
  geom_jitter(color="#E0526C", size=0.4, alpha=0.9) +
  xlab("diagnosis")+
  ggtitle("Age vs Pres/Aus de la enfermedad")

# Leyenda en la gráficas
p + theme(
  legend.position="none",
  plot.title = element_text(size=11)) +
  ggtitle("Edad Vs presencia o ausencia de la enfermedad") +
  xlab("Enfermedad (ausencia o presencia)")

# Otra forma
hd %>%
  ggplot(aes(diag))+ 
  geom_bar(aes(fill=diag), position="dodge")+ 
  labs(title="Frecuencia de var. Diag",subtitle = "Fuente:Propia", x="Factores", y = "Frecuencia")+
  geom_text(aes(label=..count..),stat='count',position=position_dodge(0.9),vjust=-0.2)

## histogram (categoricas)
names(heart)
ggplot(data = heart, aes(x= sex)) +
  geom_histogram()

## bar chart
ggplot(data = mpg, aes(x = class)) +
  geom_bar()

## Poligrama de frecuencia
ggplot(data = heart, aes(x = age)) +
  geom_freqpoly()

## Densidad 
hd %>% 
  ggplot(aes(x = age)) +
  geom_density()

# Gráficas de dos variables -----

## scatter plot
names(hd)
head(hd, 3)
ggplot(data= hd, aes(x = age, y = oldpeak)) +
  geom_point()
par(hd)

install.packages("PerformanceAnalytics")
library("PerformanceAnalytics")

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

