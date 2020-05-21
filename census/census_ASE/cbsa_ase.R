library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "source/ASE_2016_00CSA02_with_ann.csv"
folder_name <- "ASE"
file_name <- "cbsa_ase"

# metadata
dt_title <- "Annual survey of entrepreneurs"
dt_src <- "https://www.census.gov/programs-surveys/ase.html"
dt_contact <- "Sifan"
df_notes <- "to be replaced by Annual Business Survey in Spring 2020"

# FUNCTION load
df <- read_csv(source_dir) %>%
  rename(cbsa_code = GEO.id2, cbsa_name = `GEO.display-label`,
         naics2_code = NAICS.id, naics2_name = `NAICS.display-label`) %>%
  select(contains("code"), everything()) %>%
  slice(2:n()) %>%
  mutate_at(c("FIRMPDEMP","RCPPDEMP", "EMP", "PAYANN"), as.numeric)


df <- df %>% apply_labels(
FIRMPDEMP = "Number of firms with paid employees",
RCPPDEMP = "Receipts of firms with paid employees ($1,000)",
EMP = "Number of paid employees for pay period including March 12",
PAYANN = "Annual Payroll ($1,000)"
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
