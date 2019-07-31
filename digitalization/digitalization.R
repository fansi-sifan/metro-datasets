library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ==============================================

source_dir <- "source/metro_all_updated.csv"
folder_name <- "digitalization"
file_name <- "cbsa_digitalization"

# metadata
dt_title <- "Average digitalization score, 2002 and 2016"
dt_src <- "https://www.brookings.edu/research/digitalization-and-the-american-workforce/"
dt_contact <- "Sifan Liu"
df_notes <- ""

# FUNCTION load
df <- read_csv(source_dir)

df <- df %>%
  janitor::clean_names() %>%
  select(cbsa_code = area,
         cbsa_name = geography,
         cbsa_score_02 = score02,
         cbsa_score_16 = score16,
         cbsa_pct_high_02 = high02,
         cbsa_pct_medium_02 = medium02,
         cbsa_pct_low_02 = low02,
         cbsa_pct_high_16 = high16,
         cbsa_pct_medium_16 = medium16,
         cbsa_pct_low_16 = low16)%>%
  apply_labels(
    cbsa_score_02 = "Mean digital score, 2002",
    cbsa_score_16 = "Mean digital score, 2016",
    cbsa_pct_high_02 = "Share of jobs that are high digital, 2002", 
    cbsa_pct_high_16 = "Share of jobs that are high digital, 2016",
    cbsa_pct_medium_02 = "Share of jobs that are medium digital, 2002", 
    cbsa_pct_medium_16 = "Share of jobs that are medium digital, 2016", 
    cbsa_pct_low_02 = "Share of jobs that are low digital, 2002", 
    cbsa_pct_low_16 = "Share of jobs that are low digital, 2016"
  )

df_labels <- create_labels(df)


# SAVE OUTPUT
df <- df %>%
select(cbsa_code, everything()) # make sure unique identifier is the left most column
# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
labels = df_labels, folder = folder_name, file = file_name,
title = dt_title, contact = dt_contact, source = dt_src
)

