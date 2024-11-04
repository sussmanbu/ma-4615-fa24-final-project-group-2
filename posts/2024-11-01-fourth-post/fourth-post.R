#dummy code all categorical variables

traffic_reg <- traffic_data_cleaned %>%
  rename(gender = driver_gender) %>%
  mutate(
    gender = recode(as.factor(gender), "M" = 0, "F" = 1),
    stop_date = as.POSIXct(paste(stop_date, stop_time), format = "%Y-%m-%d %H:%M:%S")
  ) %>%
  select(-stop_time) %>%
  mutate(
    driver_race = recode(as.factor(driver_race), 
                         "White" = 0,
                         "Black" = 1,
                         "Asian" = 2,
                         "Hispanic" = 3,
                         "Other" = 4),
    violation = recode(as.factor(violation),
                       "Equipment" = 0,
                       "Speeding" = 1,
                       "Moving violation" = 2,
                       "Registration/plates" = 3,
                       "Seat belt" = 4,
                       "Other" = 5)
  ) %>%
  select(-violation_raw) %>%
  mutate(
    search_conducted = recode(as.factor(search_conducted),
                              "FALSE" = 0,
                              "TRUE" = 1),
    search_type = case_when(
      grepl("Probable Cause", search_type, ignore.case = TRUE) ~ "Probable Cause",
      grepl("Incident to Arrest", search_type, ignore.case = TRUE) ~ "Incident to Arrest",
      grepl("Protective Frisk", search_type, ignore.case = TRUE) ~ "Protective Frisk",
      grepl("Reasonable Suspicion", search_type, ignore.case = TRUE) ~ "Reasonable Suspicion",
      grepl("Inventory", search_type, ignore.case = TRUE) ~ "Inventory",
      is.na(search_type) ~ NA_character_,
      TRUE ~ "Other"
    ),
    search_type = recode(as.factor(search_type),
                         "Probable Cause" = 1,
                         "Incident to Arrest" = 2,
                         "Protective Frisk" = 3,
                         "Reasonable Suspicion" = 4,
                         "Inventory" = 5,
                         .default = 0),  
    stop_outcome = recode(as.factor(stop_outcome),
                          "Citation" = 1,
                          "Arrest Driver" = 2,
                          "Warning" = 3,
                          "No Action" = 4,
                          "Arrest Passenger" = 5,
                          "N/D" = 0),
    is_arrested = recode(as.factor(is_arrested),
                         "FALSE" = 0,
                         "TRUE" = 1),
    stop_duration = recode(as.factor(stop_duration),
                           "0-15 Min" = 0,
                           "16-30 Min" = 1,
                           "30+ Min" = 2),
    drugs_related_stop = recode(as.factor(drugs_related_stop),
                                "FALSE" = 0,
                                "TRUE" = 1),
    district = recode(as.factor(district),
                      "Zone X4" = 0,
                      "Zone K3" = 1,
                      "Zone X1" = 2,
                      "Zone X3" = 3,
                      "Zone K1" = 4,
                      "Zone K2" = 5))

