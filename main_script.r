library(here)  # here()
library(dplyr) # various
library(readr) # read_csv()
library(purrr) # mapchr()



# Generate all of the column names, since there is an extra header. If the head
#   is eliminated, then we have duplicate column names for the years.

YEARS_OF_DATA <- c(2019, 2017, 2015)

COLUMN_GROUPS <- c("_Exist_BC", "_Exist_CC", "_Method", "Program_Type", 
                   "_Coverage", "_Exist_HPV")



# Load in data.

data <- read_csv(here("data.csv"), skip = 1)
colnames(data) <- c("Country",
                    paste0(YEARS_OF_DATA, )
