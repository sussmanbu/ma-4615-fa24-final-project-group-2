# This script tries to answer some of our questions about race disparity through proportion testing
library(tidyverse)
library(readr)
library(ggplot2)
library(broom)

traffic_data = readRDS("dataset/cleaned_dataset.rds")

# Q1: is there a significant difference between the proportions
# of whites who are arrested for speeding
# and blacks who are arrested for speeding

ps = traffic_data|>
  filter(driver_race == 'White' | driver_race == 'Black')|>
  filter(violation == 'Speeding')|>
  group_by(driver_race)|>
  summarize(p = mean(is_arrested == T),
            n = n())

p1 = ps$p[1] # proportion of blacks arrested for speeding
p2 = ps$p[2] # proportion of whites arrested for speeding

n1 = ps$n[1] # number of blacks in the sample
n2 = ps$n[2] # number of whites in the sample

zcrit = qnorm(.05, lower.tail = F)
SE = zcrit * sqrt(p1*(1-p1)/n1 + p2*(1-p2)/2)
CI = c((p1 - p2) - SE, (p1 - p2) + SE)
CI
# There is not a statistically significant difference

