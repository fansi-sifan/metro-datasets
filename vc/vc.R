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
  filter(round == "Total VC" ) %>%
  filter(measure == "Capital Invested ($ M) per 1M Residents") %>%
  filter(period == "2015-17") %>%
  mutate(cbsa_code = as.character(cbsa13)) %>%
  janitor::clean_names()%>%
  mutate(cbsa_name = as.character(msa),
         rank = as.numeric(rank))%>%
  select(cbsa_code, cbsa_name,
         year_range = period,
         vc_per_m_pop = value)%>%
  apply_labels(year_range = "time period of investment",
               vc_per_m_pop = "capital invested (in_millions) per 1M residents", 
               cbsa_code = "cbsa code", 
               cbsa_name = "cbsa name")

df_labels <- create_labels(df)

# SAVE OUTPUT
df <- df %>%
select(cbsa_code, everything()) # make sure unique identifier is the left most column
# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
labels = df_labels, folder = folder_name, file = file_name,
title = dt_title, contact = dt_contact, source = dt_src, note = df_notes)

