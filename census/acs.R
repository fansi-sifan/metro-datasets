
# SET UP =========================
library(tidycensus)
library(tidyverse)

source("census/clean_acs.R")
source("census/acs_var.R")

key <- Sys.getenv("CENSUS_API_KEY")

# save data to acs folder

library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
folder_name <- "acs5_2018"
file_name <- "cbsa_acs_raw"

# metadata
dt_title <- "Selected statistics from 2018 5 year ACS summary tables"
dt_src <- "https://api.census.gov/data/2018/acs/acs5.html"
dt_contact <- "Sifan Liu"
df_notes <- "Statistics calculated from ACS summary tables"

# FUNCTION load
geo <- "metropolitan statistical area/micropolitan statistical area"
vars <- objects()
var = mget(vars[grep("codes",vars)])
years <- 2018

raw <- map_dfc(var, function(x)clean_acs(geography = geo, variables = x, year = years, key = key, short = FALSE, cache = T))

df <- raw %>%
  select(cbsa_code, cbsa_name, dplyr::contains("S",ignore.case = F),dplyr::contains("B",ignore.case = F), dplyr::contains("C", ignore.case = F))

df_labels = create_labels(df)

# SAVE OUTPUT
# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
labels = df_labels, folder = folder_name, file = file_name,
title = dt_title, contact = dt_contact, source = dt_src, note = df_notes
)

# CALCULATE -------------------
file_name <- "cbsa_acs"

# load("acs5_2017/cbsa_acs_raw.rda")
# df <- cbsa_acs_raw

df <- df %>% calculate_acs()
save_datasets(df, folder = folder_name, file = file_name)

# county ----------------------------
file_name <- "co_acs_raw"
geo <- "county"

raw <- map_dfc(var, function(x)clean_acs(geography = geo, variables = x, year = years, key = key, short = FALSE, cache = T))

df <- raw %>%
  select(stco_code, stco_name,dplyr::contains("S",ignore.case = F),dplyr::contains("B",ignore.case = F))

save_datasets(df, folder = folder_name, file = file_name)

# CALCULATE -------------------
file_name <- "co_acs"

# load("acs5_2017//co_acs_raw.rda")
# df <- co_acs_raw

df <- df %>% calculate_acs()
save_datasets(df, folder = folder_name, file = file_name)


######### CUSTOMIZE ########################
########## update data fields HERE #########
############################################

# Change geography ----------
geo <- "county" # "state", "county", "tract", "metropolitan statistical area/micropolitan statistical area"

# look up other variables ------
# tmp <- load_variables(yr,paste0("acs",span),cache = TRUE)
# view(tmp)
# var <- 'S2301_C01_001'

# Optional --------------
# set variables to NULL and use table to get a whole table
# tabl <- "S1701" #if pulling entire table, set variables to NULL

# set year and span -------------
yr <- 2018 # ACS year
# span <- 5 # 1-year or 5-year

# set boundary, instead of pulling data for all counties ---
# st  ="AL"
# co = "Jefferson"
# co_acs <- clean_acs(state = st, county = co, 
#                       geography = geo, variables = NULL, 
#                       year = yr, span = span,
#                       key = key, table = tabl)


# Alternative functions to get data =======================

# use base get_acs to get data ---------------
# df <- get_acs(geography = geo, variables = var, 
#               year = yr,
#               key = key, 
#               output = "wide")
# 

# quick visualization
# df %>%
#   ggplot(aes(fill = B20004_001E)) + 
#   geom_sf(color = NA) + 
#   coord_sf() + 
#   scale_fill_viridis_c(option = "magma") 

# use clean_acs to get data with descriptive labels -------
# df <- clean_acs(state = st, county = co, 
#               geography = geo, variables = var, 
#               year = yr, span = span,
#               key = key)

# set variables to NULL and use table to get a whole table -----
# df <- clean_acs(state = st, county = co, 
#                 geography = geo, variables = NULL, 
#                 year = yr, span = span,
#                 key = key, table = tabl)

# shorten names with argument short = TRUE -----
# df <- clean_acs(state = st, county = co, 
#                 geography = geo, variables = var, 
#                 year = yr, span = span,
#                 key = key, short = TRUE)

zip_acs <- get_acs(geography = "zcta",
                   variables = c(pop_race_codes,pov_race_codes),
                   output = "wide",
                   geometry = T,
                   key = key)

zip_acs_cleaned <- zip_acs %>% 
  calculate_pop_race() %>% 
  calculate_pov_race() %>% 
  select(GEOID, contains("pop"), contains("pct"))

save(zip_acs,file = "census/zip_acs.rda")
save(zip_acs_cleaned,file = "census/zip_acs_cleaned.rda")
