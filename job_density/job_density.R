library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
# cbsa -------------------

source_dir <- "source/job_density/lodes_jobdensity_94cbsa2018.xlsx"
folder_name <- "job_density"
file_name <- "cbsa_jobdensity"

# metadata
dt_title <- "Job density"
dt_src <- "https://www.brookings.edu/research/where-jobs-are-concentrating-why-it-matters-to-cities-and-regions/"
dt_contact <- "Joanne Kim"


# FUNCTION load
df <- readxl::read_xlsx(source_dir)%>%
  mutate(cbsa_code = as.character(cbsa))%>%
  gather(year, cbsa_jobdensity,year2004:year2015)%>%
  mutate(year = as.integer(gsub("year","",year)))%>%
  select(cbsa_code, cbsa_name = cbsaname, 
         naics2_code = naics, naics2_name = sector,
         everything(),-cbsa, -measure) 

df <- df %>% apply_labels(
  cbsa_jobdensity = "Weighted (perceived) actual job density, jobs per sq mile"
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

# cbsa expected ------------
source_dir <- "source/job_density/BMPP-Bass-Center-metro-area-job-density-data-20190618.xlsx"
file_name <- "cbsa_job_density_expected"

df <- readxl::read_xlsx(source_dir)%>%
  mutate(cbsa_code = as.character(cbsa)) %>%
  select(cbsa_code, cbsa_name = cbsaname, everything())

df <- df %>% apply_labels(
  density2004 = "Weighted (perceived) actual job density, jobs per sq mile",
  measure = "actual/expected"
)
df_labels <- create_labels(df)

# SAVE OUTPUT
# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
          labels = df_labels, folder = folder_name, file = file_name,
          title = "", contact = "", source = "", note = "", apd = T # add to cbsa meta
)


  
# county -------------------
source_dir <- "source/job_density/lodes_jobdensity_county_94cbsa2018.xlsx"
file_name <- "co_jobdensity"

df <- readxl::read_xlsx(source_dir)%>%
  mutate(cbsa_code = as.character(cbsa))%>%
  gather(year, county_jobdensity,year2004:year2015)%>%
  mutate(year = as.integer(gsub("year","",year)))%>%
  select(cbsa_code, cbsa_name = cbsaname, 
         stco_code = cntyfips, stco_name = county, 
         naics2_code = naics, naics2_name = sector,
         everything(),-cbsa, -measure) 

df <- df %>% apply_labels(
  county_jobdensity = "Weighted (perceived) actual job density, jobs per sq mile",
  type = "UC(Urban COre);ES(Emerging Suburban);MS(Mature Suburban)"
)
df_labels <- create_labels(df)

# SAVE OUTPUT
# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
          labels = df_labels, folder = folder_name, file = file_name,
          title = "", contact = "", source = "", note = "", apd = T # add to cbsa meta
)
