
# function for standarizing ----

standarize <- function(x) {
  num   <- x - mean(x)
  denom <- sd(x)
  return (num/denom)
}

# to apply function -----

newData  <- as.data.frame(lapply(nameFile, standarize)) 
summary(newData2)
head(newData2, 10)


# Select data 
data3 <- nameFile[,55:58]

# Density plot
par(mfrow=c(2, 4))
colnames <- dimnames(data3)[[2]]

for (i in 1:10) {
  d <- density(data3[, i])
  plot(d, type = "n", main = colnames[i])
  polygon(d, col = "cadetblue3", border = "gray")
}


