library(here)  # here()
library(dplyr) # various
library(readr) # read_csv()
library(purrr) # mapchr()
library(tidyr)



# Generate all of the column names, since there is an extra header. If the head
#   is eliminated, then we have duplicate column names for the years.

YEARS_OF_DATA <- c(2019, 2017, 2015)

COLUMN_GROUPS <- c("_Exist_BC", "_Exist_CC", "_Method", "Program_Type", 
                   "_Coverage", "_Exist_HPV")


# There is likely a better way to do this (i.e. purrr), but this works for a
#   two variable solution for now, and gives the correct ordering.
# Combine the groups years and groupings into a string so it can become a col
#   name.

grouped_colnames <- expand.grid(YEARS_OF_DATA, COLUMN_GROUPS) %>%
    mutate(final_col_name = paste0(Var1, Var2)) %>%
    pull(final_col_name)



# Load in data.

data <- read_csv(here("data.csv"), skip = 1)
colnames(data) <- c("Country", grouped_colnames)
