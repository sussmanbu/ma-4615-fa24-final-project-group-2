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

<<<<<<< HEAD
=======

# Change stop_time to numeric
traffic_data_cleaned$stop_time <- as.numeric(traffic_data_cleaned$stop_time)


# Function to convert sec to time of day
secs_to_time_of_day <- function(seconds) {
  hours <- (seconds %/% 3600) %% 24
  minutes <- (seconds %/% 60) %% 60
  secs <- seconds %% 60
  sprintf("%02d:%02d:%02d", hours, minutes, secs)
}


# Apply conversion function
traffic_data_cleaned$stop_time <- sapply(traffic_data_cleaned$stop_time, secs_to_time_of_day)


>>>>>>> e8cf1013b6b690a44163853572176ce1d63b2c88
# Save cleaned data as an .rds file
# How to call data later: cleaned_data <- read_rds(here::here("dataset", "cleaned_dataset.rds"))
saveRDS(traffic_data_cleaned, here::here("dataset", "cleaned_dataset.rds"))
