library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "source/broadband_by_metro.csv"
folder_name <- "broadband_2020"
file_name <- "tract_broadband"

# metadata
dt_title <- "broadband adoption rates by tract"
dt_src <- "https://www.brookings.edu/blog/the-avenue/2020/02/05/neighborhood-broadband-data-makes-it-clear-we-need-an-agenda-to-fight-digital-poverty/"
dt_contact <- "Adie Tomer"
df_notes <- "Source: Brookings analysis of ACS 2018 5-year estimates. \nNote: 
Tracts in digital poverty are tracts where at least half the neighborhood’s households do not have a wireline subscription and at least half do not have a wireless subscription"

# FUNCTION load
df <- read_csv(source_dir)

# labels
df <- df %>%
  mutate(stco_code = str_pad(county, 5, "left", "0"),
         stcotr_code = str_pad(GEOID, 11, "left", "0"),
         cbsa_code = as.character(cbsacode)) %>% 
  select(contains("_code"), 
         cbsa_name = cbsatitle,
         cbsa_type = metropolitanmicropolitanstatis, 
         everything())

df_labels <- tibble::tribble(
  ~name, ~label,
  "totalhh", "Total households",
  "with_broadband", "Number of households with broadband", 
  "broadband_pct", "Share of households with broadband"
)


# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
          labels = df_labels, folder = folder_name, file = file_name,
          title = dt_title, contact = dt_contact, source = dt_src, note = df_notes
)


file_name <- "cbsa_broadband"
# FUNCTION load
df <- readxl::read_xlsx("source/another.xlsx")

# labels
df <- df %>%
  mutate(cbsa_code = as.character(cbsa_2013)) %>% 
  select(cbsa_code, cbsa_name, 
         totalhh = tt, 
         dig_pov = anothermeas) %>% 
  mutate(pct_digital_poverty = dig_pov/count)

df_labels <- tibble::tribble(
  ~name, ~label,
  "totalhh", "Total households",
  "with_broadband", "Number of households with broadband", 
  "dig_pov", "Share of tracts in digital poverty"
)


# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
          labels = df_labels, folder = folder_name, file = file_name,
          title = dt_title, contact = dt_contact, source = dt_src, note = df_notes
)
