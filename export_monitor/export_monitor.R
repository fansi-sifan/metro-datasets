# Get Raw Data and save to 'source' folder
# Author: David Whyman
# Date: Wed Jun 19 14:55:00 2019

library(tidyverse)
library(skimr)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "V:/Export Monitor/2018/Deliverables/Deliverables/Metros Data/Metros by Total, NAICS 2 3.xlsx"
folder_name <- "export_monitor"
file_name <- "export_monitor_cbsa"

# metadata
dt_title <- "Export Monitor, 2017, all MSAs"
dt_src <- "https://www.brookings.edu/research/export-monitor-2018/"
dt_contact <- "Sifan Liu"
df_notes <- ""

# FUNCTION load
df <- readxl::read_xlsx(source_dir,sheet = "Total") %>% 
  filter(Year == 2017) 

df <- df %>%
  select(year = "Year",
         cbsa_code = "CBSA FIPS (2013)",
         cbsa_2013_name = "CBSA Name (2013)",
         cbsa_exports_nominal = "Nominal Exports ( mil.), by All-Industries (CBSA)",
         cbsa_exports_real = "Real Exports (mil.), by All-Industries (CBSA)",
         cbsa_pct_exports_gdp = "Export Share of GDP (%), by All-Industries (CBSA)"
         ) %>%
  expss::apply_labels(year = "Year",
                      cbsa_code = "CBSA FIPS (2013)",
                      cbsa_2013_name = "CBSA Name (2013)",
                      cbsa_exports_nominal = "Nominal Exports ( mil.), by All-Industries (CBSA)",
                      cbsa_exports_real = "Real Exports (mil.), by All-Industries (CBSA)",
                      cbsa_pct_exports_gdp = "Export Share of GDP (%), by All-Industries (CBSA)"
  )

df_labels <- create_labels(df)

# FUNCTION save output
save_output(df = df, labels = df_labels,
            folder = folder_name, file = file_name, 
            title = dt_title, contact = dt_contact, source = dt_src)


# COUNTY LEVEL   -------------
source_dir <- "V:/Export Monitor/2018/Deliverables/Deliverables/Counties Data/Counties by Total, NAICS 2.xlsx"
file_name <- "export_monitor_county"


# load data
df <- readxl::read_xlsx(source_dir,sheet = "Total") %>% 
  filter(Year == 2017) %>%
  mutate(stco_code = str_pad(as.character(`(County)`), 5, "left", "0"))

# set new column names
df <- df %>%
  select(
    year = Year,
    stco_code,
    co_name = "County Name (BEA)",
    st_code = "State FIPS",
    st_name = "State Name",
    st_abbr = "State Code",
    county_exports_nominal = "Nominal Exports ( mil.), by All-Industries (County)",
    county_exports_real = "Real Exports (mil.), by All-Industries (County)",
    county_pct_exports_gdp = "Export Share of GDP (%), by All-Industries (County)"
  )%>%
  expss::apply_labels(year = "Year",
                      stco_code = "FIPS code",
                      co_name = "County Name (BEA)",
                      st_code = "State FIPS",
                      st_name = "State Name",
                      st_abbr = "State Code",
                      county_exports_nominal = "Nominal Exports ( mil.), by All-Industries (County)",
                      county_exports_real = "Real Exports (mil.), by All-Industries (County)",
                      county_pct_exports_gdp = "Export Share of GDP (%), by All-Industries (County)"
  )
  
df_labels <- create_labels(df)

# FUNCTION save output
save_output(df = df, labels = df_labels,
            folder = folder_name, file = file_name, 
            title = dt_title, contact = dt_contact, source = dt_src)


