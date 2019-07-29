# pipeline to create master datasets
source("R/pip.R")

# Data for which places =============================
find_cbsa_counties("Birmingham")
find_cbsa_counties("grand rapids")
find_cbsa_counties("denver")

places <- purrr::map_df(c("Birmingham", "grand rapids-kentwood", "denver"), find_cbsa_counties)

# Download ACS summary data ===================================

# SET UP -------------------------
library(tidycensus)
library(tidyverse)
library(sjlabelled)

source("R/clean_acs.R")
source("R/acs_var.R")

key <- Sys.getenv("CENSUS_API_KEY")

# update data fields HERE ------

geo <- "county" # "state", "county", "tract", "metropolitan statistical area/micropolitan statistical area"
yr <- 2017 # ACS year
span <- 5 # 1-year or 5-year
var <- c(pov_race_codes,ed_race_codes) # or search for variables below

# look up other variables 
# tmp <- load_variables(yr,paste0("acs",span),cache = TRUE)
# view(tmp)
# var <- 'S2301_C01_001'

# Get data -------------
co_acs <- clean_acs(geography = geo, variables = var, 
                    year = yr, span = span,
                    key = key, short = FALSE)
get_label(co_acs)

var <- drive_codes
geo <- "metropolitan statistical area/micropolitan statistical area"
cbsa_acs <- clean_acs(geography = geo, variables = var, 
                      year = yr, span = span,
                      key = key, short = FALSE)

calculate_race <-  function(df) {
  df %>%
    mutate(ba_above_wh = S1501_C01_030_estimate/S1501_C01_028_estimate,
           ba_above_bk = S1501_C01_036_estimate/S1501_C01_034_estimate,
           pct_belowpoverty_wh = S1701_C03_013_estimate,
           pct_belowpoverty_bk = S1701_C03_014_estimate) %>%
    select(-contains("estimate"),-contains("moe"))
  }
  
co_race <- calculate_race(co_acs)

cbsa_commute <- cbsa_acs %>%
  mutate(drivealone = S0802_C02_001_estimate/S0802_C01_001_estimate)%>%
  select(-contains("estimate"),-contains("moe"))


# Optional --------------
# set variables to NULL and use table to get a whole table
tabl <- "S1701" #if pulling entire table, set variables to NULL

# set boundary, instead of pulling data for all counties
# st  ="AL"
# county = "Jefferson"
# co_acs <- clean_acs(state = st, county = co, 
#                       geography = geo, variables = NULL, 
#                       year = yr, span = span,
#                       key = key, table = tabl)


# Get all data ====================================

# supply datasets of interests -----------
list_county_all <- list(co_uspto, county_univ_rd, export_monitor_county, co_race)
list_cbsa_all <- list(cbsa_uspto, cbsa_i5hgc, cbsa_metromonitor, cbsa_patentcomplex,cbsa_commute)

# merge all datasets and keep the latest year only
cbsa_df <- merge_cbsa(lapply(list_cbsa_all, keep_latest)) 
county_df <- merge_county(lapply(list_county_all, keep_latest)) 

# find cbsa data --------------
cbsa_df %>%
  filter(cbsa_code %in% places$cbsa_code)

# find county data
county_df %>%
  filter(stco_code %in% places$stco_code)
