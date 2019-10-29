# by race
# B01001A white non-hispanic
# B01001B black
# B01001D asian
# B01001I latino

library(tidyverse)
library(tidycensus)
library(skimr)
library(expss)
source("R/save_output.R")
source("census/millenials.R")

# SET UP ====================================
folder_name <- "millenials diversity"
file_name <- "cbsa_agegroup_race"

# metadata
dt_title <- "Race by age group, msa"
dt_src <- "ACS 2017 5-year"
dt_contact <- "Sifan"
df_notes <- "Racial diversity of future workforce"

# FUNCTION load
df <- map_dfr(race_table, function(x)get_acs("metropolitan statistical area/micropolitan statistical area", key = Sys.getenv("CENSUS_API_KEY"),
                                             table = x))%>%
  clean_race_age() %>%
  ungroup()%>%
  select(cbsa_code = GEOID, everything(),-table) # make sure unique identifier is the left most column

df_labels <- as.data.frame(names(df))
# SAVE OUTPUT
# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
labels = df_labels, 
folder = folder_name, file = file_name,
title = dt_title, contact = dt_contact, source = dt_src, note = df_notes
)



