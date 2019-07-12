library(tidyverse)
library(skimr)
source("R/save_output.R")

# SET UP ====================================
# cbsa -------------------

source_dir <- "../../metro_data_warehouse/data_final/job_density/lodes_jobdensity_94cbsa2018.xlsx"
folder_name <- "job_density"
file_name <- "job_density_cbsa"

# metadata
dt_title <- ""
dt_src <- ""
dt_contact <- ""
df_notes <- ""
df_labels <- data.frame(c("var","lab"))

# FUNCTION load
df <- readxl::read_xlsx(source_dir)%>%
  mutate(cbsa_code = as.character(cbsa))

# FUNCTION save output
save_output(df = df, labels = df_labels,folder = folder_name, file = file_name, title = dt_title, contact = dt_contact, source = dt_src,apd = T)

# county -------------------
source_dir <- "../../metro_data_warehouse/data_final/job_density/lodes_jobdensity_county_94cbsa2018.xlsx"
file_name <- "job_density_county"

df <- readxl::read_xlsx(source_dir)%>%
  mutate(cbsa_code = as.character(cbsa))%>%
  rename(stco_code = cntyfips)


# FUNCTION save output
save_output(df = df, labels = df_labels,folder = folder_name, file = file_name, title = dt_title, contact = dt_contact, source = dt_src,apd = T)
