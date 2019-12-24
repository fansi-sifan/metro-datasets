# migration trends from ACS

library(tidyverse)
library(tidycensus)
library(skimr)
library(expss)
source("R/save_output.R")
source("census/acs_var.R")

# SET UP ====================================
folder_name <- "census_edu_res"
file_name <- "co_edu_res"

# metadata
dt_title <- "county education attainment by place of birth trend 2006 - 2017"
dt_src <- "ACS"
dt_contact <- "Sifan"
df_notes <- "ACS education tables"

# FUNCTION load
geo <- "county"
yr = 2009:2018
vars = edu_birth_codes

df <- get_multiyr(yr) 

df <- df %>%
  calculate_edu_birth() %>%
  select(stco_code = GEOID, stco_name = NAME, year, contains("all"), contains("ba"))
  
# add labels
df <- df %>% 
  apply_labels(
"pct_baplus_instate" = "Share of residents have a BA or above (born in state of residence)",
"pct_baplus_outstate" = "Share of residents have a BA or above (born in other states in US, or native but outside US)",
"pct_baplus_fb" = "Share of residents have a BA or above (foreign born)"

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


# msa -----------------------------------

file_name <- "cbsa_edu_res"
geo <- "metropolitan statistical area/micropolitan statistical area"

df <- get_multiyr(yr) 

df <- df %>%
  calculate_edu_birth() %>%
  select(cbsa_code = GEOID, cbsa_name = NAME, year, tidyr::contains("all"), tidyr::contains("ba"))

# add labels
df <- df %>% 
  apply_labels(
    "pct_baplus_instate" = "Share of residents have a BA or above (born in state of residence)",
    "pct_baplus_outstate" = "Share of residents have a BA or above (born in other states in US, or native but outside US)",
    "pct_baplus_fb" = "Share of residents have a BA or above (foreign born)"
    
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


