library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "source/access.csv"
folder_name <- "access across america"
file_name <- "cbsa_job_access"

# metadata
dt_title <- "Job accessibility by auto and transit, 2017"
dt_src <- "http://access.umn.edu/research/america/index.html"
dt_contact <- "Sifan Liu"
df_notes <- "Access Across America project. Block level data available from the project website"

# FUNCTION load
df <- read_csv(source_dir) %>%
select(cbsa_code, everything()) # make sure unique identifier is the left most column

df <- df %>% apply_labels(
  "auto_10" = "Number of jobs accessible by auto in 10 minutes",
  "transit_10" = "Number of jobs accessible by transit in 10 minutes",
  "ratio_10" = "auto_10/transit_10"

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
