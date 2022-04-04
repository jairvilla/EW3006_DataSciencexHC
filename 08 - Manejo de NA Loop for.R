# Loop For for handling NAs

library(dplyr)                                                             

set.seed(10)                                                               
df <- data.frame(a = sample(c(NA, 1:3)    , replace = TRUE, 10),           
                 b = sample(c(NA, 101:103), replace = TRUE, 10),                            
                 c = sample(c(NA, 201:203), replace = TRUE, 10))                            

df %>% 
  mutate_all(~ifelse(is.na(.x), mean(.x, na.rm = TRUE), .x)) 

# Alternativa 2
colSums(is.na(df))

df[] <- lapply(df, function(x) { 
  x[is.na(x)] <- mean(x, na.rm = TRUE)
  x
})
df

