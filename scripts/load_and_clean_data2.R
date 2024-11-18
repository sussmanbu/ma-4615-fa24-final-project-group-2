# Load packages
library(tidyverse)
library(dplyr)
library(tidyr)

# Load data
ri_traffic_data_clean <- readRDS(here::here("dataset", "cleaned_dataset.rds"))
sf_traffic_data <- readRDS(here::here("dataset", "sf_raw_dataset.rds"))

# variables in RI data
# stop_date, stop_time, driver_gender, driver_race, violation_raw, violation
# search_conducted, search_type, stop_outcome, is_arrested, stop_duration
# drugs_related_stop, district

ri_traffic_data_clean = ri_traffic_data_clean|>
  mutate(state = "Rhode Island",
         driver_race = tolower(driver_race),
         stop_outcome = tolower(stop_outcome))|>
  select(!violation_raw)

# omitted columns are already in the dataset correctly labeled
sf_traffic_data_clean = sf_traffic_data|>
  filter(!is.na(subject_sex) | 
         !is.na(subject_race))|>
  mutate(state = "California",
         stop_date = date,
         stop_time = as.character(time),
         driver_gender = if_else(subject_sex == 'male', 'M', 'F'),
         driver_race = if_else(subject_race == 'asian/pacific islander', 'asian', subject_race),
         violation = if_else(startsWith(reason_for_stop, "Moving Violation"), "Moving violation", "Other"),
         search_type = if_else(T, NA, NA),
         stop_outcome = outcome, # differing values
         is_arrested = arrest_made,
         stop_duration = if_else(T, NA, NA), # not included,
         drugs_related_stop = if_else(T, NA, NA), # not included,
         )|>
  select(stop_date, 
         stop_time, 
         driver_gender, 
         driver_race, 
         violation,
         search_conducted,
         search_type, 
         stop_outcome,
         is_arrested,
         stop_duration,
         drugs_related_stop,
         district,
         state)
        
full_traffic_data_clean = full_join(ri_traffic_data_clean, sf_traffic_data_clean)

saveRDS(full_traffic_data_clean, here::here("dataset", "cleaned_dataset_full.rds"))
