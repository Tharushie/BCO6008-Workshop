install.packages("Tidymodels")
install.packages("MASS")
install.packages("ISLR")

library(tidymodels)
library(MASS)
library(ISLR)

set.seed(123)

#1 - Specify the model: type/mode/engine
lm_spec<-linear_reg()%>%
  set_mode("regression")%>%
  set_engine("lm")

data(Boston)

#*usually you do the recipe before next step (split to training testing etc.)

#2 - Take model specification from step 1and apply to the data = use 'fit()' and put formula y~x
lm_fit<-lm_spec%>%
  fit(data=Boston, medv~lstat)

lm_fit

lm_fit%>%pluck("fit") %>% 
  summary()

tidy(lm_fit)

#3 - Use the fitted model from step 2 to predict new y's in new data
predict(lm_fit, new_data = Boston)

# examining new predicted values 
final_model<-augment(lm_fit, new_data = Boston) %>%
  select(medv, .pred)




