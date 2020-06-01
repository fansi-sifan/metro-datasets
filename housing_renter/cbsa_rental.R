library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "source/metro rent-income Feb2020.xlsx"
folder_name <- "housing_renter"
file_name <- "cbsa_rental"

# metadata
dt_title <- "Rental housing affordability"
dt_src <- "Jenny, not published yet"
dt_contact <- "Jenny"
df_notes <- "Housing affordability measure by race"

# FUNCTION load
df <- readxl::read_excel(source_dir) %>%
  mutate(cbsa_code = str_pad(msa, 5, "left", "0")) %>%
  select(cbsa_code, cbsa_name = msaname, everything()) # make sure unique identifier is the left most column

# SAVE OUTPUT
# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
labels = '', folder = folder_name, file = file_name,
title = dt_title, contact = dt_contact, source = dt_src, note = df_notes
)
