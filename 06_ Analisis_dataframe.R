

# Curso: Ciencias de datos para sector salud
# Autor Prof. Jair Villanueva
# Objetivo: Comprender los datos usando estadística descriptiva 

# Instalar package
install.packages("tidyverse")
install.packages("fivethirtyeight")
install.packages("ggplot2")
# Librerias 

library(tidyverse)
library(fivethirtyeight)
library(ggplot2)

# Cargar la Data

data("college_recent_grads")
college_grad_students

# Analisis estadisticos 
dim(cancer)
str(cancer)
summary(cancer)
names(cancer)
mean(cancer$Cell.size)



glimpse(college_recent_grads)  # Resumir los datos en forma general
summary(college_recent_grads)

names(college_recent_grads)   # Nombres de las columnas

# 1 ¿Qué carrera tiene la tasa de desempleo más baja?

pr1 <- college_recent_grads %>%      # Lo ordena de menor a mayor
   arrange(unemployment_rate)


# Obtener solo algunas variables utiles (rank,major, unemployment_rate )
college_recent_grads %>%
  arrange(unemployment_rate) %>%
  select(rank, major, unemployment_rate)

res1 <- college_recent_grads$unemployment_rate
res1


#  Redondear los valores

pr1 <- college_recent_grads %>%
         arrange(unemployment_rate) %>%
         select(rank, major, unemployment_rate) %>%
         mutate(unemployment_rate = round(unemployment_rate, digits = 4)) # Modificar le nombre 


# pr2 ¿Qué carrera tiene el mayor porcentaje de mujeres?

pr2 <- college_recent_grads %>%
         arrange(desc(unemployment_rate)) %>%   # desc indica que queremos unemployment en forma descendiente 
         select(rank, major, unemployment_rate)

pr2 <- college_recent_grads %>%
         arrange(desc(sharewomen)) %>%   # desc indica que queremos unemployment en forma descendiente 
         select(rank, major, sharewomen)

head(pr2, 3)   # Muestra las tres primeras observaciones 

# pr3 Cómo se comparan las distribuciones del ingreso medio en las categorías principales?

ggplot(data = college_recent_grads, mapping = aes(x = median)) +   # ancho de las barras bin = 1000
  geom_histogram(binwidth = 1000,
                 fill = "#69b3a2",
                 color = "#e9ecef") 

ggplot(data = college_recent_grads, mapping = aes(x = median)) +   # ancho de las barras bin = 1000
  geom_histogram( binwidth=5000, fill="#69b3a2", color="#e9ecef") 

# Estadistica Basica 

college_recent_grads %>%
  summarise(min = min(median), max = max(median),
            mean = mean(median), med = median(median),
            sd = sd(median), 
            q1 = quantile(median, probs = 0.25),
            q3 = quantile(median, probs = 0.75))

ggplot(data = college_recent_grads, mapping = aes(x = median)) +
  geom_histogram() +
  facet_wrap( ~ major_category, ncol = 4)

