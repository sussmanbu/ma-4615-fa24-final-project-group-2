# This file is purely as an example.
# Note, you may end up creating more than one cleaned data set and saving that
# to separate files in order to work on different aspects of your project

# Load packages
library(tidyverse)
library(dplyr)

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
