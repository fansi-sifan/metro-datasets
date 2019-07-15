library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "source/AUTM.csv"
folder_name <- "autm"
file_name <- "autm"

# metadata
dt_title <- "University licensing activity and income"
dt_src <- "The Statistics Access for Technology Transfer (STATT) Database, 2017"
dt_contact <- "Sifan Liu"
df_notes <- ""

# FUNCTION load
df <- read_csv(source_dir)

# data available up to 2017
df <- df %>%
  group_by(FIPS) %>%
  # summarise_if(is.numeric, sum, na.rm = TRUE) %>%
  summarise(
    tot_lic = sum(Lic.Iss, na.rm = TRUE) + sum(Opt.Iss, na.rm = TRUE),
    lg_lic = sum(Tot.Lic.Lg.Co, na.rm = TRUE),
    sm_lic = sum(Tot.Lic.Sm.Co, na.rm = TRUE),
    st_lic = sum(Tot.Lic.St.Ups, na.rm = TRUE),
    inc_lic = sum(Gross.Lic.Inc, na.rm = TRUE),
    tot_IP = sum(Inv.Dis.Rec, na.rm = TRUE),
    tot_st = sum(St.Ups.Formed, na.rm = TRUE),
    instate_st = sum(St.Ups.in.Home.St, na.rm = TRUE)
  ) %>%
  mutate(stco_code = str_pad(as.character(FIPS), 5, "left", "0")) %>%
  select(-FIPS)

# labels =========
# set variable labels
df <- df %>% apply_labels (
  tot_lic = "total license and option issues",
  lg_lic = "total licenses, large companies",
  sm_lic = "total licenses, small companies",
  st_lic = "total licenses, start-ups",
  inc_lic = "gross license income",
  tot_IP = "total investment disclosures received",
  tot_st = "total start ups formed",
  instate_st = "start ups in home state",
  stco_code = "county FIPS code"
)

df_labels <- create_labels(df)


df <- df %>%
  select(stco_code, everything())

# FUNCTION save output
save_datasets(df, folder = folder_name, file = file_name)
save_meta(df,
  labels = df_labels, folder = folder_name, file = file_name,
  title = dt_title, contact = dt_contact, source = dt_src
)
