library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "source/shiftshare.csv"
folder_name <- "shiftshare"
file_name <- "cbsa_shiftshare"

# metadata
dt_title <- "Shiftshare analysis using EMSI data"
dt_src <- "V:/Performance/Project files/Metro Monitor/2018v/Output/Shift Share/Monitor Shiftshare Cumulative (2-digit NAICS).csv"
dt_contact <- "Isha"
df_notes <- ""

# FUNCTION load
df <- read_csv(source_dir,col_types = cols(cbsa2013_fips = col_character())) %>%
  filter(year == 2016) %>%
  select(cbsa_code = cbsa2013_fips, cbsa_name = cbsa2013_name, naics2_code = naics2, naics2_name = industryname_naics2, everything())%>%
  apply_labels(
         indicator = "Aggregate wage, Employment, GDP",
         "lsshare2006" = "local shift 2006",
         "imshare2006" = "industry mix 2006",
         "nsshare2006" = "national share 2006",
         "lsshare2011" = "local shift 2011",
         "imshare2011" = "industry mix 2011",
         "nsshare2011" = "national share 2011",
         "lsshare2015" = "local shift 2015",
         "imshare2015" = "industry mix 2015",
         "nsshare2015" = "national share 2015"
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


