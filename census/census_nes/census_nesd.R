library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "source/nesd/nesd_estimates_2017_Table1.xlsx"
folder_name <- "census/census_nes/"
file_name <- "cbsa_nesd"

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

# legal form

# SET UP ====================================
source_dir <- "source/nesd/nesd_estimates_2017_Table3.xlsx"
folder_name <- "census/census_nes/"
file_name <- "cbsa_nes_inc"

# FUNCTION load
df <- readxl::read_excel(source_dir, skip = 2)

df <- df %>% 
  filter(!is.na(`Meaning of Legal Form of Organization Code`)) %>% 
  # filter(`2017 NAICS Code` == "00", `Meaning of Ethnicity Code` == "Total", 
  #        `Meaning of Race Code` == "Total", `Meaning of Race Code` == "Total", 
  #        `Meaning of Sex Code` == "Total", `Meaning of Veteran Code` == "Total") %>% 
  mutate(firms = as.numeric(str_remove_all( `Number of Nonemployer Firms`, ",")), 
         cbsa_name = str_sub(`Geographic Area Name`, 1, -12)) %>% 
  inner_join(metro.data::cbsa_18 %>% 
               select(cbsa_code, cbsa_name, cbsa_size), 
             by = "cbsa_name")

df_labels <- list(count(df, type))

# datasets
save_datasets(df, folder = folder_name, file = file_name)


