library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "V:/Infrastructure/2 Long Form Projects/Broadband/Final Layout/Masterfile_Final.xlsx"
folder_name <- "broadband"
file_name <- "tract_broadband"

# metadata
dt_title <- "Digitial Distress: mapping broadband availability and subscription"
dt_src <- "https://www.brookings.edu/wp-content/uploads/2017/09/broadbandreport_september2017.pdf"
dt_contact <- "Adie tomer, Elizabeth Kneeboth, Ranjitha Shivaram"
df_notes <- ""

# FUNCTION load
df <- readxl::read_xlsx(source_dir)%>%
  janitor::clean_names() %>%
  mutate(stcotract_code = as.character(str_sub(tract, -6, -1))) %>%
  select(
    -v1,
    -tract,
    -tractonly_fips,
    -state,
    -county,
    -statename,
    -countyname,
    -cbsa,
    -metro,
    -stplfips,
    -place,
    -geotype
  )

df <- df %>% apply_labels(
  atl3 = "at least 3 Mbps",
  atl10 = "at least 10 Mbps",
  atl25 = "at least 10 Mbps",
  above1g = "at least 1 Gbps",
  stcotract_code = "tract geoid"
)
df_labels <- create_labels(df)

# SAVE OUTPUT
df <- df %>%
select(stcotract_code, everything()) # make sure unique identifier is the left most column
# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
labels = df_labels, folder = folder_name, file = file_name,
title = dt_title, contact = dt_contact, source = dt_src
)

