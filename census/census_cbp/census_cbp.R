library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
folder_name <- "census/census_cbp"
file_name <- "cbp_cbsa_naics_emp"

# metadata
dt_title <- "Employment by industry from County Business Pattern, 2018"
dt_src <- "https://www.census.gov/data/datasets/2018/econ/cbp/2018-cbp.html"
dt_contact <- "Sifan Liu"
df_notes <- "2-, 3-, 4- and 6-digit NAICS code"

# FUNCTION load
library(censusapi)
cbp_year <- "2018"
vars <- c("GEO_ID","NAICS2017", "NAICS2017_LABEL","EMP", "ESTAB")

cbp_year <- "2014"
vars <- c("GEO_ID","NAICS2012", "NAICS2012_TTL","EMP", "ESTAB")

geo <- "metropolitan statistical area/micropolitan statistical area"

df <- getCensus(
  name = "cbp",
  vintage = cbp_year,
  vars = vars,
  region = geo,
  key = Sys.getenv("CENSUS_API_KEY")
) 

# labels
df <- df %>%
  mutate(naics_level = str_length(NAICS2017),
         across(EMP:ESTAB, as.numeric)) %>% 
  select(cbsa_code = metropolitan_statistical_area_micropolitan_statistical_area, 
         naics_code = NAICS2017, 
         naics_level, EMP, ESTAB) 

# datasets
save_datasets(df, folder = folder_name, file = file_name)
df_labels <- tribble(~var, ~label,
                     "EMP", "employment",
                     "ESTAB", "establishment")
# meta file
save_meta(df,
          labels = df_labels, folder = folder_name, file = file_name,
          title = dt_title, contact = dt_contact, source = dt_src, note = df_notes
)
