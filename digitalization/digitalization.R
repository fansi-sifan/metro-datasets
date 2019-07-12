# Get Raw Data and save to 'source' folder
# Author: David Whyman
# Date: Wed Jun 19 14:55:00 2019
# SET UP ==============================================
library(tidyverse)
library(skimr)
source("R/save_output.R")

source_dir <- "source/metro_all_updated.csv"
folder_name <- "digitalization"
file_name <- "digitalization"

# metadata
dt_title <- "Average digitalization score, 2002 and 2016"
dt_src <- "https://www.brookings.edu/research/digitalization-and-the-american-workforce/"
dt_contact <- "Sifan Liu"
df_notes <- ""

# FUNCTION load
df <- read_csv(source_dir)
assign(file_name,df)


# Digitalization ---------------------------------------------------

#data up to 2016 exists (read source data)
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
         cbsa_pct_low_16 = low16)

df_labels <- data.frame(c("variable","label"))

# FUNCTION save output
skimr::skim_with(numeric = list(hist = NULL), integer = list(hist = NULL))

save_output(df = df, labels = df_labels,
            folder = folder_name, file = file_name, 
            title = dt_title, contact = dt_contact, source = dt_src)


