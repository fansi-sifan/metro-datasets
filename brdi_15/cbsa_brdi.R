library(tidyverse)
library(skimr)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "source/BRDI_15.csv"
folder_name <- "brdi_15"
file_name <- "cbsa_brdi"

# metadata
dt_title <- "Domestic R&D performed by companies, Millions USD"
dt_src <- "Business R&D and Innovation Survey, 2015"
dt_contact <- "Sifan Liu"
df_notes <- ""

# FUNCTION load
df <- read_csv(source_dir)

# FUNCTION save output
save_output(df,folder_name, file_name, dt_title, dt_contact, dt_src)

