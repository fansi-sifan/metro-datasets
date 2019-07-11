
# SET UP ===================
library(tidycensus)
library(tidyverse)

source("R/clean_api.R")
source("R/acs_var.R")

# Get data ================
key <- Sys.getenv("CENSUS_API_KEY")

# update data fields HERE ----
geo <- "county"
yr <- 2017
span <- 5
var <- earnings_edu_codes

# use clean_acs to get data
df <- clean_acs(geo, var, yr,span,key)


