library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "co_school_scores.rda" # use "helper.R" file to check the actual data processing. 
folder_name <- "school proficiency"
file_name <- "co_school_proficiency"

# metadata
dt_title <- "Share of students achieved a passing grade in state MATH and RLA assessment (grade 4-8)"
dt_src <- "EDFacts"
dt_contact <- "Sifan"
df_notes <- "State assessments are designed by each state to measure the content the state has 
determined appropriate for that grade and subject. As a result, both the content on the tests and 
achievement standards students must meet to be considered “proficient” vary widely across states. 
Specific proficiency rates for schools in different states should not be considered comparable. "

# FUNCTION load
load(source_dir)

df <- co_school_scores %>%
select(stco_code, everything()) # make sure unique identifier is the left most column

df <- df %>% apply_labels(
  ALL_pass = "Share of students achieved a passing grade",
  MBL_pass = "Share of Black students achieved a passing grade",
  MWH_pass = "Share of white students achieved a passing grade",
  MHI_pass = "Share of Hispanic students achieved a passing grade",
  MAS_pass = "Share of Asian students achieved a passing grade",
  MAM_pass = "Share of American Indian/Alaska Native students achieved a passing grade"
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
