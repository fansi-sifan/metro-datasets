# migration trends from ACS

library(tidyverse)
library(tidycensus)
library(skimr)
library(expss)
source("R/save_output.R")
source("census/acs_var.R")

# SET UP ====================================
folder_name <- "census_migration"
file_name <- "co_inflow"

# metadata
dt_title <- "county talent inflow trend 2006 - 2017"
dt_src <- "ACS"
dt_contact <- "Sifan"
df_notes <- "ACS migration tables"

# FUNCTION load
dgeo <- "county"
vars <- migration_edu_codes
yr = 2006:2017

df <- get_multiyr(yr)

df <- df %>%
  # filter(GEOID %in% c("08001", "08035", "08069", "08013", "08005", "08031", "08059", "08123", "08014")) %>%
  select(-tidyr::contains("pct"))%>%
  group_by(year, GEOID)%>%
  summarise_if(is.numeric, sum) %>%
  mutate(
    movein_edu_baplus = fromabroad_edu_baplus + fromdiffstate_edu_baplus,
    movein_total = fromabroad_total + fromdiffstate_total,
    pct_newcomer = movein_total / B07009_001E,
    newcomer_pct_edu_baplus = movein_edu_baplus / movein_total) %>%  
  select(-tidyr::contains("B07009")) 


df <- df %>% 
  ungroup()%>%
  rename(stco_code = GEOID)%>%
  apply_labels(
    "newcomer_pct_edu_baplus" = "percentage of people have BA and above among all those that moved in from outside of the state in the last year",
    "pct_newcomer" = "percentage of people moved in from outside of the state in the last year among all local residents ",
    "movein_total" = "number of people moved in from outside of the state in the last year",
    "movein_edu_baplus" = "number of people moved in from outside of the state in the last year, with BA and above"
)

df_labels <- create_labels(df)

# SAVE OUTPUT
# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
labels = df_labels, folder = folder_name, file = file_name,
title = dt_title, contact = dt_contact, source = dt_src, note = df_notes
)





