# code_review exercise 
rm(list = ls())
setwd("/cloud/project")
library(dplyr)
library(lubridate)
library(zoo)
source("/cloud/project/ispor_setup/basic_setup.R")

# Step 1: Obtain data
source("/cloud/project/ispor_setup/basic_setup.R")

# Step 2: Clean some values
ConvertToNA <- function(value) {
  ifelse(value == "", NA, value)
}

# Step 2B: convert all date variables to date stored objects since data is in format day-Mon-Year; need to specify 
# non-standard format to R
ConvertToDate <- function(value) {
  as.Date(value, format = "%d-%b-%Y")
}

# Step 2C: convert age to a numeric varibale 
# Step 2E: convert misspelled "unknown" to "unknown"
demographics.df <- demographics.df %>%
  dplyr::mutate(age = as.character(age)) %>%
  dplyr::mutate(gender = ifelse(is.na(gender), "unknown", gender))

# Step 2F: remap clients.df column "external_practice_id" to "internal_practice_id" 
#         since the column values match exactly
names(clients.df)[2] <- "internal_practice_id"

# Step 2G: deal with any duplicate patients in patients table
duplicate.patients <- patients.df %>% 
  dplyr::group_by(patient_id) %>% dplyr::count() %>% dplyr::arrange(desc(n)) %>% 
  dplyr::filter(n > 1) %>% 
  dplyr::select(patient_id)

# remove duplicate patients
dd.patients.df <- patients.df %>% 
  dplyr::group_by(patient_id) %>% 
  dplyr::sample_n(1) %>% 
  ungroup()

# Step 2H: deal with any duplicate patients in demographics table
d.demographics <- demographics.df %>% 
  dplyr::group_by(patient_id) %>% 
  count() %>% dplyr::arrange(desc(n)) %>% 
  dplyr::filter(n > 1) %>% 
  dplyr::select(patient_id)

# remove duplicate patients
demographics.df2 <- demographics.df %>% 
  group_by(patient_id) %>% 
  arrange(race) %>% 
  top_n(1) %>%
  ungroup()

ApplyTransformation <- function(named_tbl_df) {
  named_tbl_df <- named_tbl_df %>%
    mutate_each(funs(ConvertToNA)) %>%
    mutate_each(funs(ConvertToDate), matches("date"))
  return(named_tbl_df)
}

# loop to apply all transformation to all environment objects ending in .df
for (df in ls(pattern = ".df")) {
  assign(df, ApplyTransformation(get(df)))
}


# Step 3: create one wide dataframe joining all objects together to make it easier to analyze data
combined.df <- dd.patients.df %>%
  left_join(clients.df) %>%
  left_join(d.demographics) %>%
  left_join(admins.df) %>%
  full_join(orders.df) # it's possible orders/admins are not linked so want to include any non-matched orders

