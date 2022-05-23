# Writing your first Function 
## Step 1: Start with the problem ---- 
# e.g., want the numeric difference between two dates

NumericDateDiff <- function(date_1, date_2) {
  # Computes the difference between two dates and converts the  
  # difftime object to a numeric representation of the interval 
  ...
  ...
  
}

## Step 2: Create working snippet of code ---- 
diff_time <- difftime("2013-01-01", "2012-01-01")
as.numeric(diff_time)

## Step 3: Rewrite using temporary variables ----
date_1 <- "2013-01-01"
date_2 <- "2012-01-01"

diff_time <- difftime(date_1, date_2)
as.numeric(diff_time)

## Step 4: Translate it into a proper function ----
NumericDateDiff <- function(date_1, date_2) {
  # Computes the difference between two dates and converts 
  # the difftime object to a numeric representation of the 
  # interval 
  #
  # Args:
  #   @date_1: The later of the two dates
  #   @date_2: The earlier of the two dates
  #
  # Returns: a single value representing the numeric difference
  # in time between date_1 and date_2
  diff_time <- difftime(date_1, date_2, units = "days")
  as.numeric(diff_time)
}

NumericDateDiff("2013-01-01", "2012-01-01")

## Step 5: [Optional] Add default arguments ----
NumericDateDiff <- function(date_1, date_2, time_units = "days") {
  # Computes the difference between two dates and converts 
  # the difftime object to a numeric representation of the interval 
  #
  # Args:
  #   @date_1: The later of the two dates
  #   @date_2: The earlier of the two dates
  #   @time_units: unit of measure for calculating date difference 
  #   (defaults to days - options include secs, mins, hours, weeks)
  #
  # Returns: a single value representing the numeric difference
  # in time between date_1 and date_2
  diff_time <- difftime(date_1, date_2, units = time_units)
  as.numeric(diff_time)
}

NumericDateDiff("2013-01-01", "2012-01-01")

NumericDateDiff("2013-01-01", "2012-01-01", "weeks")

## Step 6: [Optional] Add optional arguments ----
NumericDateDiff <- function(date_1, date_2, cutoff_date = NULL) {
  # Computes the difference between two dates and converts the difftime    
  # object to a numeric representation of the interval 
  #
  # Args:
  #   @date_1: The later of the two dates
  #   @date_2: The earlier of the two dates
  #   @cutoff_date: if specified, information documented after this 
  #   date is excluded
  #  
  # Returns: a single value representing the numeric difference in time  
  # between date_1 and date_2.  In cases where the cutoff_date date  
  # precedes date_1, the difference will be between the cutoff date and
  # date_2
  
  if (!is.null(cutoff_date)) {
    date_1 <- min(date_1, cutoff_date)
  } else {
    date_1 <- date_1
  }
  diff_time <- difftime(date_1, date_2, units = "days")
  as.numeric(diff_time)
}

NumericDateDiff("2013-01-01", "2012-01-01")

NumericDateDiff("2013-01-01", "2012-01-01", "2012-6-01")

