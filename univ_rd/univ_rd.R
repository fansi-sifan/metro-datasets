library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "source/NSF_univ.csv"
folder_name <- "univ_rd"
file_name <- "cbsa_univ_rd"

# metadata
dt_title <- "Higher education R&D survey "
dt_src <- "https://ncsesdata.nsf.gov/ids/?utm_source=WebCaspar&utm_medium=WebCaspar&utm_campaign=WebCaspar"
dt_contact <- "Sifan"
df_notes <- ""

# FUNCTION load
df <- read_csv(source_dir) %>%
  group_by(cbsacode) %>%
  summarise(
    rd_total = sum(Deflated.Total.R.D.Expenditures.in.All.Fields.Sum.),
    rd_total_biz = sum(as.numeric(as.character(Deflated.Business.Financed.R.D.Expenditures.Sum.)))
  ) %>%
  mutate(cbsa_code = as.character(cbsacode)) %>%
  select(cbsa_code, everything(),-cbsacode) 

df <- df %>% apply_labels(
  rd_total = "total R&D spending",
  rd_total_biz = "total deflated business financed R&D spending"
)
df_labels <- create_labels(df)

# SAVE OUTPUT
# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
labels = df_labels, folder = folder_name, file = file_name,
title = dt_title, contact = dt_contact, source = dt_src
)

# county -------------------------------
file_name <- "county_univ_rd"

df <- read_csv(source_dir)  %>%
  group_by(county) %>%
  summarise(
    rd_total = sum(Deflated.Total.R.D.Expenditures.in.All.Fields.Sum.),
    rd_total_biz = sum(as.numeric(as.character(Deflated.Business.Financed.R.D.Expenditures.Sum.)))
  ) %>%
  mutate(stco_code = str_pad(as.character(county), 5, "left", "0")) %>%
  select(stco_code, everything(), -county)

save_datasets(df, folder = folder_name, file = file_name)

save_meta(df,
          labels = df_labels, folder = folder_name, file = file_name,
          title = dt_title, contact = dt_contact, source = dt_src, apd = T
)
