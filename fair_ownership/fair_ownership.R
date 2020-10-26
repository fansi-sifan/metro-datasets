library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "source/ownership fair share.xlsx"
folder_name <- "fair_ownership"
file_name <- "cbsa_ownership"

# metadata
dt_title <- "business ownership fair share ratio"
dt_src <- "https://www.brookings.edu/research/businesses-owned-by-women-and-minorities-have-grown-will-covid-19-undo-that/"
dt_contact <- "Sifan Liu"
df_notes <- "State and metro level business ownership fair share ratio (% of business ownership/% adult population)"

# FUNCTION load
df <- readxl::read_xlsx(source_dir, sheet = "metro_ratio", skip = 3)

# labels
df <- df %>%
  rename(cbsa_code = GEOID) %>% 
  mutate(across(-contains("cbsa"), as.numeric))

df_labels <- ""


# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
          labels = df_labels, folder = folder_name, file = file_name,
          title = dt_title, contact = dt_contact, source = dt_src, note = df_notes
)

file_name <- "state_ownership"
df <- readxl::read_xlsx(source_dir, sheet = "state_ratio", skip = 3)

# labelsb
df <- df %>%
  rename(st_code = GEOID, st_name = NAME) %>% 
  mutate(across(-contains("st_"), as.numeric))

df_labels <- ""


# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
          labels = df_labels, folder = folder_name, file = file_name,
          title = dt_title, contact = dt_contact, source = dt_src, note = df_notes
)
