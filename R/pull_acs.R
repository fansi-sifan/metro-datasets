
# SET UP =========================
library(tidycensus)
library(tidyverse)

source("R/clean_acs.R")
source("R/acs_var.R")

key <- Sys.getenv("CENSUS_API_KEY")

# update data fields HERE ========

geo <- "tract" # "state", "county", "tract", "metropolitan statistical area/micropolitan statistical area"
yr <- 2017 # ACS year
span <- 5 # 1-year or 5-year
var <- earnings_edu_codes # or search for variables below

# tmp <- load_variables(yr,paste0("acs",span),cache = TRUE)
# view(tmp)
# var <- 'S2301_C01_001'

# optional
st <- "AL"
co <- "073"
map <- TRUE # if needs corresponding geographic shapefiles

# Get data =======================

# use base get_acs to get data ---------------
df <- get_acs(state = st, county = co, 
                geography = geo, variables = var, 
                year = yr,
                key = key, 
                geometry = map)

# quick visualization
df %>%
  ggplot(aes(fill = estimate)) + 
  geom_sf(color = NA) + 
  coord_sf() + 
  scale_fill_viridis_c(option = "magma") 

# use clean_acs to get data with descriptive labels -------
df <- clean_acs(state = st, county = co, 
              geography = geo, variables = var, 
              year = yr,
              key = key)
