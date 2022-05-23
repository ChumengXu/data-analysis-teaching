# install some common packges (you won't need this if you are using Rstudio Cloud)
# install.packages(c("dplyr", "ggplot2", "knitr", "lubridate", "purrr", "zoo"))

# read in some data
temp <- tempfile()
download.file("http://www.blytheadamson.com/wp-content/uploads/2018/11/exercise_materials.zip", temp)

# load data objects
load(unz(temp, "flatiron_ispor_tables.RData"))

# remove temp file
unlink(temp)