library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "V:/Sifan/Birmingham/County Cluster/source/VC.csv"
folder_name <- "vc"
file_name <- "cbsa_vc"

# metadata
dt_title <- "VC investment per 1M residents, 2015-2017"
dt_src <- "http://startupsusa.org/global-startup-cities/"
dt_contact <- "Ian Hathaway"
df_notes <- ""

# FUNCTION load
df <- read_csv(source_dir)

df <- df %>%
  select(-rank,-X1)%>%
  filter(period == "2015-17") %>%
  mutate(cbsa_code = as.character(cbsa13)) %>%
  janitor::clean_names()%>%
  mutate(cbsa_name = as.character(msa))%>%
  unite(var,round, measure)%>%
  spread(var, value)%>%
  apply_labels(year_range = "time period of investment",
               cbsa_code = "cbsa code", 
               cbsa_name = "cbsa name")


# SAVE OUTPUT
df <- df %>%
select(cbsa_code, everything(),-msa, -country, -latitude, -longitude,-cbsa13) # make sure unique identifier is the left most column

df_labels <- create_labels(df)

# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
labels = df_labels, folder = folder_name, file = file_name,
title = dt_title, contact = dt_contact, source = dt_src, note = df_notes)

