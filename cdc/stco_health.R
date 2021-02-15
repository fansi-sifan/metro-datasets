library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "https://chronicdata.cdc.gov/resource/swc5-untb.csv?"
folder_name <- "cdc"
file_name <- "stco_health"

# metadata
dt_title <- "PLACES: Local data for better health"
dt_src <- "https://www.cdc.gov/500cities/"
dt_contact <- "Sifan"
df_notes <- "CDC provides estimate at tract level for all counties since 2018; data available for 500 cities from 2015 - 2018"

# FUNCTION load
# 2020 release of 2018 data, county
cdc2020 <- read.socrata(paste0(source_dir, "MeasureId=PHLTH"), token)

df <- cdc2020 %>% 
  mutate(stco_code = str_pad(locationid, 5, "left", "0")) %>% 
  select(year, stco_code, data_value_type, data_value, totalpopulation) %>% 
  pivot_wider(names_from = "data_value_type", values_from = "data_value")
  
df_labels <- "Physical health not good > 14 days"
# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
rmarkdown::render("R/codebook_template.Rmd", output_dir = folder_name, output_file = "README")
