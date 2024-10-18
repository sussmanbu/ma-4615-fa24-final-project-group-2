# This file is purely as an example.
# Note, you may end up creating more than one cleaned data set and saving that
# to separate files in order to work on different aspects of your project

# Load packages
library(tidyverse)
library(dplyr)

<<<<<<< HEAD
traffic_data <- read_csv(here::here("dataset", "Traffic stops in Rhode Island.csv"))
traffic_data |>
  head(10)

## CLEAN the data
traffic_data_clean <- traffic_data |>
  filter(!is.na(driver_gender)|!is.na(driver_race))|>
  select(2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15)

#   pivot_longer(2:5, names_to = "group", values_to = "refusal_rate")
# 
# write_rds(loan_data_clean, file = here::here("dataset", "loan_refusal_clean.rds"))
=======

# Load data
traffic_data <- read_csv(here::here("dataset", "Traffic stops in Rhode Island.csv"))


# Clean data
traffic_data_cleaned <- traffic_data %>%
  filter(!is.na(driver_race) & 
           !is.na(driver_gender) & 
           !is.na(violation_raw) & 
           !is.na(violation) & 
           !is.na(search_conducted) & 
           !is.na(stop_outcome) & 
           !is.na(stop_duration) & 
           !is.na(drugs_related_stop)) %>%
  select(-state, -county_name)


# Save cleaned data as an .rds file
# How to call data later: cleaned_data <- read_rds(here::here("dataset", "cleaned_dataset.rds"))
saveRDS(traffic_data_cleaned, here::here("dataset", "cleaned_dataset.rds"))
>>>>>>> c502fd79f5e39096cf41af295f464e9114794784
