# Loading necessary libraries 
library(tidyverse)
library(readr)
library(ggplot2)
library(broom)

traffic_data <- readRDS("dataset/cleaned_dataset.rds")

# View the structure of the dataset
print(str(traffic_data))

# Display summary statistics
print(summary(traffic_data))


# Initial exploratory data analysis 
# Visualize the distribution of a key variable (e.g., 'race')
ggplot(traffic_data, aes(x = driver_race, fill = driver_race)) +
  geom_bar() +
  labs(title = "Distribution of Driver Race", x = "Driver Race", y = "Count")+
  scale_fill_viridis_d(option = "D")

# Visualize the proportion of traffic stops by driver race
ggplot(traffic_data, aes(x = driver_race, fill = stop_outcome)) +
  geom_bar(position = "fill") +
  labs(title = "Proportion of Traffic Stops by Driver Race", x = "Driver Race", y = "Proportion")+
  scale_fill_viridis_d(option = "D")

# Visualize the frequency of traffic stops over time
ggplot(traffic_data, aes(x = as.Date(stop_date))) +
  geom_histogram(binwidth = 30, fill = "steelblue", color = "black") +
  labs(title = "Traffic Stops Over Time", x = "Date", y = "Number of Stops")+
  theme_minimal()

# Visualize the relationship between violation type and driver race
ggplot(traffic_data, aes(x = violation, fill = driver_race)) +
  geom_bar(position = "dodge") +
  labs(title = "Violation Types by Driver Race", x = "Violation", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_color_viridis_d()


# Data Visualizations to answer questions from blog post 2 
# Q1: Does race impact the duration of stop and the extent of search?

# Visualize the distribution of stop duration by driver race
ggplot(traffic_data, aes(x = driver_race, fill = stop_duration)) +
  geom_bar(position = "fill") +
  labs(title = "Stop Duration by Driver Race", x = "Driver Race", y = "Proportion") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_viridis_d(option = "D")

# Visualize the proportion of searches conducted by driver race
ggplot(traffic_data, aes(x = driver_race, fill = search_conducted)) +
  geom_bar(position = "fill") +
  labs(title = "Search Conducted by Driver Race", x = "Driver Race", y = "Proportion") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_viridis_d(option = "D")

#Q2: What is the most common reason for stops?
ggplot(traffic_data, aes(x = violation, fill = violation)) +
  geom_bar() +
  labs(title = "Most Common Reason for Stops", x = "Violation", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  scale_fill_viridis_d(option = "D")

#Q3: Does the proportion of drug-related stops to total stops vary significantly between races?
ggplot(traffic_data, aes(x = driver_race, fill = drugs_related_stop)) +
  geom_bar(position = "fill") +
  labs(title = "Proportion of Drug-Related Stops by Race", x = "Driver Race", y = "Proportion") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_viridis_d(option = "D")

#Q4: Is there a correlation between race and stop outcome = arrest?
ggplot(traffic_data, aes(x = driver_race, fill = stop_outcome)) +
  geom_bar(position = "fill") +
  labs(title = "Proportion of Arrests by Driver Race", x = "Driver Race", y = "Proportion") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_viridis_d(option = "D")

#Q5: What is the distribution of stops in districts in terms of race?
ggplot(traffic_data, aes(x = district, fill = driver_race)) +
  geom_bar(position = "fill") +
  labs(title = "Distribution of Stops by District and Driver Race", x = "District", y = "Proportion") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) + 
  scale_fill_viridis_d(option = "D")

#Q6: Controlling for stop date, gender, and district, what’s the correlation between race and arrest?
# Fit a logistic regression model controlling for stop date, gender, and district
model <- glm(is_arrested ~ driver_race + stop_date + driver_gender + district, 
             data = traffic_data, family = binomial)

# Summarize the model results
summary(model)

# Display the coefficients as a tidy table
tidy(model)




