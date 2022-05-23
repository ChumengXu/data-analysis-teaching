# How can we turn this into a flexible function?

# visit_date_df %>%
#   group_by(patientid) %>%
#   summarise(visit = n())

# IN SQL FOR THOSE UNFAMILIAR WITH dplyr 
# SELECT 
#   patientid,
#   COUNT (visitid) as count_visit
# FROM visit_date_df
# GROUP BY patientid

# Load in some sample data to make things real
source("./ispor_setup/basic_setup.R")

###################################
# SCROLL DOWN FOR A SAMPLE ANSWER #
###################################














GroupSum <- function(my_df, group_col) {
  dplyr::as_data_frame(my_df) %>%
    dplyr::group_by_(group_col) %>%
    dplyr::summarise(count = dplyr::n())
}

GroupSum(demographics.df, "patient_id")
GroupSum(admins.df, "drug_name")
