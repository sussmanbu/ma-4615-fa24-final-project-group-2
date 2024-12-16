library(tidyverse)
library(readr)
library(ggplot2)
library(broom)

full_data <- readRDS("dataset/cleaned_dataset_full.rds")


full_model =  model <- glm(is_arrested ~ driver_race + stop_date + driver_gender + district, 
                           data = full_data, family = binomial)

tidy(full_model)
