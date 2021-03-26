#********************************************
# Tema:  Continuacion: Introducciòn a R 
# Autor: Jair Villanueva PhD. 
# Fecha: Feb. 2021

#********************************************

# Càlculos Básicos ---------------------

save.image("IntroR_parte2")  # Guardar el script 

4^2            # Exponente

5^(1/2)        # Raiz Cuadrada

2^3 + 4 * 1/2 # Operaciones + complejas 

# Miscelanea de funciones Matematicas -----

x <- 10     # aignacion de un valor a un objeto

abs(x)      # valor absoluto
sqrt(x)     # raiz 
exp(x)      # Transformacion exponencial
log(x)      # logaritmos 
cos(x)      # funciones trigonometricas


# Nota: No se almacena ningun valor en la memoria

## Asignar objetos ------------------------

x <- 8    # se crea un objeto llamado X que contiene un nùmero (8)

print(x)  # devuelve el valor almacenado en el objeto

y <- (3 + 4)

# Calculos entre variables  ------------------

z <- x + y  # Suma 
z <- x * y  # Multiplicaciòón
print (z)   # devuelve el resultado y lo almacena 

# Nota para asignar los nombre de las variables debes considerar: 
# * Debes comenzar con una letra 
# * Puede contener caracteres alfanumerico "_", "."
# * R es sensitivo

