# Author: Jair Villanueva
# Manejo de DPLYR package
# dplyr is based on the concepts of functions as verbs that manipulate data frames.

# Lo que podemos hacer con dplyr
# 1. mutate() adds new variables that are functions of existing variables
# 2. select() picks variables based on their names.
# 3. filter() picks cases based on their values.
# 4. summarise() reduces multiple values down to a single summary.
# 5. arrange() changes the ordering of the rows. 
# 6. otros

# Instalar package 
install.packages("dplyr")
install.packages("tidyverse")

if(!require(devtools)) install.packages("devtools")
if(!require(ggpubr)) install.packages("ggpubr")
if(!require(ggplot2)) install.packages("ggplot2")

# Library 
library(dplyr);

# data 
data(iris)
glimpse(iris)
summary(iris)


# Filter ----
iris %>%
  filter(Species == "setosa", Sepal.Width >= 3.0)

# Seleccionar ----

iris$Species <- as.factor(iris$Species)

iris %>%
  dplyr::select(Petal.Width, Petal.Length)%>%
  ggscatter( x = "Petal.Width", y = "Petal.Length",
            add = "reg.line",                                 # Add regression line
            conf.int = TRUE,                                  # Add confidence interval
            add.params = list(color = "blue",
                              fill = "lightgray")
    ) +
  stat_cor(method = "pearson", label.x = 2, label.y = 8) 

# Problema con select
# El problema se debe básicamente a que el paquete MASS incorpora una función select() 
# que por el orden de carga "enmascara" el select() de dplyr/tidyverse. 


# Eliminar una variable

iris %>%
  dplyr::select(-Species)  # exclude variables

iris %>%
  dplyr::select(2:3)    # rango de variables 

# slice  ----
iris %>%
  slice(2:3)    # extraer filas seleccionada


# Group- by  + summarize ----
 iris %>%
  group_by(Species)%>%
  summarise(Promedio = mean(Petal.Length))  # Reducir las variable a valores 
print(y)
 

# mutate ---

iris %>%
  mutate(Bonificacion = (Sepal.Width*0.5)) %>%   # crear una nueva variable y la añade  al df 
  dplyr::select(Sepal.Width, Species, Bonificacion)

  
iris  %>%
  mutate( species_code = case_when(
    Species == "virginica" ~ "Primera flor",
    Species == "setosa" ~ "segunda flor",
    Species == "versicolor" ~ "tercera flor",
  ))

ncbikecrash %>%
  mutate(driver_alcohol_drugs_simplified = case_when(
    driver_alcohol_drugs == "Missing" ~ NA_character_,
    str_detect(driver_alcohol_drugs, "Yes") ~ "Yes",
    TRUE   ~ driver_alcohol_drugs
  ))

# count ----

iris %>%
  count(Species, Sepal.Width)

# seleccionar elementos random ----
iris_n5 <- iris %>%
     sample_n(20, replace = FALSE)
dim(iris_n5)
iris_n5

iris_n5 <- iris %>%
  sample_frac(0.2, replace = FALSE)
dim(iris_n5)
iris_n5
