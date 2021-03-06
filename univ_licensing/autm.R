library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")
load("../metro.data/data/county_cbsa_st.rda")

# SET UP ====================================
source_dir <- "source/AUTM.csv"
folder_name <- "univ_licensing"
file_name <- "co_univ_licensing"

# metadata -----------
dt_title <- "University licensing activity and income"
dt_src <- "https://autm.net/surveys-and-tools/databases/statt"
dt_contact <- "Sifan Liu"
df_notes <- "The Statistics Access for Technology Transfer (STATT) Database, 2017"

# read datasets
df <- read_csv(source_dir) %>%
  filter(!is.na(add))

# TRANSFORM =================================

# Data ---------------------------
# data available up to 2017
df <- df %>%
  group_by(FIPS,YEAR) %>%
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
  ) %>% ungroup()%>%
  mutate(stco_code = str_pad(as.character(FIPS), 5, "left", "0")) %>%
  left_join(county_cbsa_st[c("stco_code", "co_name")], by = "stco_code")%>%
  select(stco_code, co_name, year = YEAR, everything(),-FIPS) %>% 

  # apply labels
  apply_labels (
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

# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
  labels = df_labels, folder = folder_name, file = file_name,
  title = dt_title, contact = dt_contact, source = dt_src, note = df_notes
)

# cbsa
file_name <- "cbsa_univ_licensing"

df <- df %>%
  left_join(county_cbsa_st[c("stco_code","cbsa_code","cbsa_name")], by = "stco_code")%>%
  group_by(cbsa_code,cbsa_name,year)%>%
  summarise_if(is.numeric, sum)

save_datasets(df, folder = folder_name, file = file_name)
