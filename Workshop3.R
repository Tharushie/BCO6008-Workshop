library()
library(tidymodels)
library(skimr)
library(janitor)

muffin_cupcake_data_original<-read_csv("https://raw.githubusercontent.com/adashofdata/muffin-cupcake/master/recipes_muffins_cupcakes.csv")

muffin_cupcake_data_original%>%skim()

#clean variable names

muffin_cupcake_data<-muffin_cupcake_data_original%>%
  clean_names()

#Splitting the clean data set to training and testing - internal structure

muffin_cupcake_split<-initial_split(muffin_cupcake_data)
muffin_cupcake_split

#Save training and testing data sets separately

muffin_cupcake_training<-training(muffin_cupcake_split)
muffin_cupcake_testing<-testing(muffin_cupcake_split)

#Create a recipe
muffin_recipe<-recipe(type~flour+milk+sugar+egg, data = muffin_cupcake_training)  
muffin_recipe

muffin_recipe_steps<-muffin_recipe%>%
  step_meanimpute(all_numeric())%>%
  step_center(all_numeric())%>%
  step_scale(all_numeric())

muffin_recipe_steps

#Prep the recipe
prepped_recipe<-prep(muffin_recipe_steps, training = muffin_cupcake_training)
prepped_recipe

#Baking the recipe
muffin_train_preprocessed<-bake(prepped_recipe, muffin_cupcake_training)
muffin_train_preprocessed

muffin_testing_preprocessed<-bake(prepped_recipe, muffin_cupcake_testing)
muffin_testing_preprocessed
  