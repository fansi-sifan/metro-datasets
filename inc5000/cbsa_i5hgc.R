library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "V:/Sifan/Birmingham/County Cluster/source/I5HGC_density.csv"
folder_name <- "inc5000"
file_name <- "cbsa_i5hgc"

# metadata
dt_title <- "High growth firms by metros, 2011-2017"
dt_src <- "https://www.brookings.edu/research/high-growth-firms-and-cities-in-the-us-an-analysis-of-the-inc-5000/"
dt_contact <- "Ian hathaway"
df_notes <- "High growth firms refer to firms made the Inc.5000 list"

# FUNCTION load
df <- read_csv(source_dir)%>%
  janitor::clean_names()%>%
  mutate(cbsa_code = as.character(cbsa))%>%
  select(-cbsa,
         cbsa_name = name,
         -size_category)
df <- df %>%
  select(cbsa_code, everything()) # make sure unique identifier is the left most column

# Labels
df <- df %>% 
  apply_labels(
    i5hgc_density = "High-growth Inc.5000 companies per 1 million residents"
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

