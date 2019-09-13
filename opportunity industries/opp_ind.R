library(tidyverse)
library(skimr)
library(expss)
library(reshape2)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "source/opp_ind.csv"
folder_name <- "opportunity industries"
file_name <- "cbsa_oppind_race"

# metadata
dt_title <- "Opportunity industries"
dt_src <- "https://www.brookings.edu/research/opportunity-industries/"
dt_contact <- "Isha Shah"
dt_notes <- "Good jobs provide stable employment, middle-class wages and benefits
Promising jobs are entry-level positions from which most workers can reach a good job within 10 years
Other jobs do not provide decent pay, benefits, or pathways to good jobs "


# TRANSFORM ============================================
df <- read.csv(source_dir) %>%
  mutate(cbsa_code = as.character(cbsa_code_alt))


# SAVE OUTPUT
df <- df %>%
  select(cbsa_code, everything()) # make sure unique identifier is the left most column

# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
          labels = df_labels, folder = folder_name, file = file_name,
          title = dt_title, contact = dt_contact, source = dt_src, note = dt_notes
)


# summary ------
source_dir <- "source/goodjobs.csv"
file_name <- "cbsa_oppind"

# TRANSFORM ============================================
df <- read.csv(source_dir) %>%
  mutate(cbsa_code = as.character(cbsa_code_alt))


# SAVE OUTPUT
df <- df %>%
  select(cbsa_code, everything()) # make sure unique identifier is the left most column

# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
          labels = df_labels, folder = folder_name, file = file_name,
          title = dt_title, contact = dt_contact, source = dt_src, note = dt_notes
)

