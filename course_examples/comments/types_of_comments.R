# Types of Comments


## Debt Comments :( ---- 
rcc_filtered <- enhanced_rcc %>%
  filter(line_1_name == "Sunitinib monotherapy")
# TODO: compare results with combination therapy 

## Backup Comments :( ... but a little more angry and sad ---- 
first_line <- enhanced_rcc %>%
  filter(line_1_name == "Sunitinib monotherapy") 

# first_line <- enhanced_rcc %>%
#   filter(line_1_name == "Nivolumab monotherapy") 

## Guide Comments :| ---- 
# remove ineligible ECOG performance status scores
step2 <- step1 %>%
  left_join(ecog_index, by = 'patientid') %>%
  filter(is.na(ecogvalue) | ecogvalue < 2)

## Teacher Comments :) ---- 
MatchInWindow <- function(sub_list, window) {
  # This function finds the best match between 
  # entries in x and y by date 
  # It does this in 4 stages:
  # 1) Find all possible matches within window. 
  #    This implicitly finds a bipartite graph, in      
  #    which there are edges between all elements of 
  #    x and all elements of y that are within
  #    the window of time from each other.
  # 2) Identify isolated single vertices (elements        
  #    with no possible matches)
  # 3) Identity isolated vertex pairs (vertices 
  #    of degree 1 with a shared edge)
  # 4) Among the remaining connected graph, finds 
  #    matching that minimizes overall
  #    difference in dates between 
  #    matched elements. Equivalently maximizes
  #    the gain of 1/(difference in dates).
  ...
  
  
## Why Comments --
CalculateClinicalProgression <- function(...) {
  # Clinician - confirmed progression date:
  # First clinician - confirmed progression event occurring after the advanced diagnosis date is determined by taking
  # the earliest source evidence date (scan date, pathology date, or clinician note date) associated with the
  # progression event.  We examine this because in melanoma we have a larger gap between advanced diagnosis date and
  # first line therapy start (due to the fact that many patients have surgery first).
  ...
}  
