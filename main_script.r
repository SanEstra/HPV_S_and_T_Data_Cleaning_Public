library(here)  # here()
library(dplyr) # various
library(readr) # read_csv()
library(tidyr)



# Generate all of the column names, since there is an extra header. If the head
#   is eliminated, then we have duplicate column names for the years.

YEARS_OF_DATA <- c(2019, 2017, 2015)

COLUMN_GROUPS <- c("Exist_BC", "Exist_CC", "Method", "Program_Type", 
                   "Coverage", "Exist_HPV")



# There is likely a better way to do this (i.e. purrr), but this works for a
#   two variable solution for now, and gives the correct ordering.
# Combine the groups years and groupings into a string so it can become a col
#   name.

grouped_colnames <- expand.grid(YEARS_OF_DATA, COLUMN_GROUPS) %>%
    mutate(final_col_name = paste0(Var1, Var2)) %>%
    pull(final_col_name)


# Load in data.

data <- read_csv(here("data.csv"), skip = 1)

# Wide to long with multiple headers
# First we loop through the years present, selecting for all columns that start
#   with that year. Rename the columns to what they actually represent, then
#   stack those datasets on each other.

data <- map_dfr(YEARS_OF_DATA,
           ~{
               # Look to see if there is a single pipeline that can be used.
               tmp_df <- select(data, starts_with(as.character(.x)))
               colnames(tmp_df) <- COLUMN_GROUPS

               # Add lost data back 
               tmp_df %>%
                   mutate(Year = .x,
                          Country = pull(data, Country)) %>%
                   relocate(Country, Year)
           }) %>%
    arrange(Country, Year)

