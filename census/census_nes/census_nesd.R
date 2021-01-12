library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "source/nesd/nesd_estimates_2017_Table1.xlsx"
folder_name <- "census/census_nes/"
file_name <- "census_nesd"

# metadata
dt_title <- "Demographic Data on Nonemployer businesses, 2017"
dt_src <- "https://www.census.gov/programs-surveys/abs/data/nesd.html"
dt_contact <- "Sifan Liu"
df_notes <- ""

# FUNCTION load
df <- readxl::read_excel(source_dir, skip = 2)

df <- metro.data::cbsa_18 %>% 
  select(cbsa_code, cbsa_name, cbsa_size) %>% 
  inner_join(df %>% 
              mutate(cbsa_name = str_sub(`Geographic Area Name`, 1, -12)), 
            by = "cbsa_name") 

df_labels <- list(count(df, `Meaning of Sex Code`), 
                  count(df, `Meaning of Race Code`), 
                  count(df, `Meaning of Ethnicity Code`))

# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
          labels = df_labels, folder = folder_name, file = file_name,
          title = dt_title, contact = dt_contact, source = dt_src, note = df_notes
)
