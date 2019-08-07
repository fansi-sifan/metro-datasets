library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "V:/Global Profiles/Data/REGPAT/Analysis Files/_g4.xlsx"
folder_name <- "oecd_patent"
file_name <- "cbsa_regpat"

# metadata
dt_title <- "OECD patents, 2008 - 2012, metro"
dt_src <- "http://www.oecd.org/sti/inno/intellectual-property-statistics-and-analysis.htm"
dt_contact <- "Sifan"
df_notes <- ""

# FUNCTION load
df <- readxl::read_xlsx(source_dir, sheet = "i0") %>%
  filter(`Year Range` == "2008-2012") %>%
  filter(Country == "United States") %>%
  janitor::clean_names() %>%
  select(
    year_range,
    cbsa_name = "micro_region",
    cbsa_code = "micro_regions",
    st_name = "core_macro_region",
    cbsa_patents_invented = "number_of_patents_invented_total_micro_regions",
    cbsa_inventors_per_patent = "number_of_inventors_per_patent_total_micro_regions",
    cbsa_patent_applications = "number_of_patent_applications_total_micro_regions",
    cbsa_applicants_per_patent = "number_of_applicants_per_patent_total_micro_regions"
  )

df <- df %>% apply_labels(
  cbsa_patents_invented = "number_of_patents_invented_total_micro_regions",
  cbsa_inventors_per_patent = "number_of_inventors_per_patent_total_micro_regions",
  cbsa_patent_applications = "number_of_patent_applications_total_micro_regions",
  cbsa_applicants_per_patent = "number_of_applicants_per_patent_total_micro_regions"
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
title = dt_title, contact = dt_contact, source = dt_src, note = df_notes
)
