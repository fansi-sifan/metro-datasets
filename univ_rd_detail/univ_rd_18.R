library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "source/NSF_univ_18.csv"
folder_name <- "univ_rd_detail"
file_name <- "univ_rd_18"

# metadata
dt_title <- "NSF by field"
dt_src <- "https://ncsesdata.nsf.gov/ids/fss"
dt_contact <- "Sifan"
df_notes <- ""

# FUNCTION load
df <- read_csv(source_dir) %>%
  mutate(total_rd = federal + non_federal)%>%
  filter(!is.na(univ_abb))%>%
  select(contains("code"), everything(), -X, -X1)

df <- df %>% apply_labels(
  total_rd = "Total R&D expenditure, thousands, current dollars"
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
