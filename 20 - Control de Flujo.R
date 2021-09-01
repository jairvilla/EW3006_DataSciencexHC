# Control de flujo

# If-Then-Else ----

a <- 66  # Determinar si el numero es mayor o menor a un valor
if (a > 55) {
  print("a es mayor a  55")
} else {
  print("a es menor o igual 55")
  }

# For Loop ----
# Create a vector filled with random normal values
u1 <- rnorm(30)   # crea un vector con valores aleatoreos

# Initialize 
usq <- 0
for(i in 1:10) {
  # el i-th elemento  of u1 al cuadrado en la posicion i-th de usq
  usq[i] <- u1[i]*u1[i]
  print(usq[i])
}

print(i)

# While Loop 

a <- 8
while (a < 6) {
  print(a)
  a = a + 100
}
a
