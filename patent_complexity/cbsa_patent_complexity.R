library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "V:/Sifan/Birmingham/County Cluster/source/Complexity_msa.csv"
folder_name <- "patent_complexity"
file_name <- "cbsa_patentcomplex"

# metadata
dt_title <- "Patent complexity score"
dt_src <- "https://www.media.mit.edu/publications/the-geography-of-complex-knowledge/"
dt_contact <- "Sifan Liu"
df_notes <- ""

# FUNCTION load
df <- read_csv(source_dir) %>% 
  janitor::clean_names() %>%
  mutate(cbsa_code = as.character(cbsa), 
         cbsa_name = as.character(cma_cbsa_name),
         patent_complexity = complex) %>%
  select(-cbsa, 
         -cma_cbsa_name, 
         -complex)


# SAVE OUTPUT
df <- df %>%
  select(cbsa_code, everything()) # make sure unique identifier is the left most column

df <- df %>% apply_labels(
patent_complexity = "patent complexity score (0-1)"
)
df_labels <- create_labels(df)

# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
labels = df_labels, folder = folder_name, file = file_name,
title = dt_title, contact = dt_contact, source = dt_src, note = df_notes
)


