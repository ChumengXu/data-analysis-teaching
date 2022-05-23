# code_review exercise (updated file) 
library(dplyr)
library(purrr)

# The data required for this demo is hosted on an author's website
# basic_setup obtains the data for us and loads it into several data frame objects in our working environment:
# admins.df, clients.df, demographics.df, orders.df, patients.df 
source("/cloud/project/ispor_setup/basic_setup.R")

ApplyStringConversionFunctions <- function(named_df) {
  # Apply string conversion functions to a data frame converting "" to NA and casting columns containing the pattern
  #   "date" to a date object
  #
  # Args:
  #   @named_df: a data frame object containing columns to apply string conversion to
  
  # Returns: 
  #   The original data frame with converted values
  named_df %>%
    mutate_each(funs(FillEmptyStrings)) %>%
    mutate_each(funs(ConvertStringToDate), matches("date"))
}

FillEmptyStrings <- function(value) {
  # Convert empty string values to NA values
  #
  # Args:
  #   @value: a single element in a vector representing any value (including an empty string)
  
  # Returns: 
  #   The original value or NA in the case of an empty string
  ifelse(value == "", NA, value)
}

# Sample data contains non-traditional date value representations and as a result, requires explicit coercing
ConvertStringToDate <- function(value) {
  # Convert a character class object representing a date to a date class object
  #
  # Args:
  #   @value: a single element in a vector representing a date value stored as a character
  
  # Returns: 
  #   The original value represented as a date class object
  as.Date(value, format = "%d-%b-%Y")
}

clean.demographics.df <- demographics.df %>%
  mutate(age = as.character(age)) %>%
  mutate(gender = if_else(is.na(gender), "unknown", gender))

# the clients table calls the "internal_practice_id", "external_practice_id" despite their identical values
# to make joining easier, the column is explicitly renamed
clean.clients.df <- clients.df %>% 
  rename(internal_practice_id = external_practice_id)

# the patients table does not represent a unique patient set
unique.patient.set <- patients.df %>% 
  distinct()

# the demographics table does not represent a unique patient set
# some patients are duplicated with one row entry missing information and the other containing it
unique.clean.demographics_df <- clean.demographics.df %>% 
  group_by(patient_id) %>% 
  # arranging in desc order will put "" values below populated values
  arrange(desc(age)) %>% 
  mutate(row_number = row_number()) %>% 
  # the item corresponding to row 1 will contain the more complete entry for the patient
  filter(row_number == 1) %>% 
  ungroup() %>% 
  select(-row_number)

cleaned.df.list <- list(patients = unique.patient.set, 
                        clients = clean.clients.df, 
                        demographics = unique.clean.demographics_df, 
                        admins = admins.df,
                        orders = orders.df)

converted.clean.df.list <- cleaned.df.list %>% 
  map(ApplyStringConversionFunctions)

analysis.df <- converted.clean.df.list[["patients"]] %>%
  left_join(converted.clean.df.list[["admins"]]) %>%
  # it's possible orders/admins are not linked so want to include any non-matched orders
  full_join(converted.clean.df.list[["orders"]]) %>% 
  left_join(converted.clean.df.list[["clients"]]) %>%
  left_join(converted.clean.df.list[["demographics"]])
