
# SET UP =========================
library(tidycensus)
library(tidyverse)

source("R/clean_acs.R")
source("R/acs_var.R")

key <- Sys.getenv("CENSUS_API_KEY")

# save data to acs folder

library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
folder_name <- "acs5_2017"
file_name <- "cbsa_acs_raw"

# metadata
dt_title <- "Selected statistics from 2017 5 year ACS summary tables"
dt_src <- "https://api.census.gov/data/2017/acs/acs5.html"
dt_contact <- "Sifan Liu"
df_notes <- "Statistics calculated from ACS summary tables"

# FUNCTION load
geo <- "metropolitan statistical area/micropolitan statistical area"
vars <- objects()
var = mget(vars[grep("codes",vars)])

df <- map_dfc(var, function(x)clean_acs(geography = geo, variables = x, key = key, short = FALSE, cache = T))%>%
  select(cbsa_code, cbsa_name, contains("S",ignore.case = F),contains("B",ignore.case = F))

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
df <- df %>% calculate_acs()
save_datasets(df, folder = folder_name, file = file_name)

# county ----------------------------
file_name <- "co_acs_raw"
geo <- "county"

df <- map_dfc(var, function(x)clean_acs(geography = geo, variables = x, key = key, short = FALSE, cache = T))%>%
  select(stco_code, stco_name, contains("S",ignore.case = F),contains("B",ignore.case = F))

save_datasets(df, folder = folder_name, file = file_name)

# CALCULATE -------------------
file_name <- "co_acs"
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
yr <- 2017 # ACS year
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

