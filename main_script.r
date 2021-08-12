library(here)  # here()
library(dplyr) # various
library(readr) # read_csv()


# Load in data.

data <- read_csv(here("data.csv"), skip = 1)
