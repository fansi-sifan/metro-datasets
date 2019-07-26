library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "source/USPTO_msa.csv"
folder_name <- "uspto"
file_name <- "cbsa_uspto"

# metadata
dt_title <- "Utility patent grants, 2000 - 2015, by MSA"
dt_src <- "https://www.uspto.gov/web/offices/ac/ido/oeip/taf/cls_cbsa/allcbsa_gd.htm"
dt_contact <- "Sifan Liu"
df_notes <- "Patenting in technology classes, breakout by origin"

# FUNCTION load
df <- read_csv(source_dir) %>% 
  janitor::clean_names() %>%
  mutate(cbsa_code = substr(as.character(id_code), 2, 6)) %>%
  filter(id_code != "") %>%
  filter(geo_type != "ALL AREAS")%>%
  mutate(cbsa_name = as.character(u_s_regional_title))%>%
  select(-geo_type,
         -u_s_regional_title,
         -id_code,
         -total)%>%
  select(cbsa_code, everything()) # make sure unique identifier is the left most column

df <- df %>% 
  gather("year","patents_issued",x2000:x2015)%>%
  mutate(year = as.numeric(substring(year, 2)),
         patents_issued = as.numeric(patents_issued))%>%
  apply_labels(cbsa_code= "cbsa geoid",
               cbsa_name="cbsa names",
               year = "year patent was issued",
               patents_issued = "total patents issued")

df_labels <- create_labels(df)

# SAVE OUTPUT
# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
labels = df_labels, folder = folder_name, file = file_name,
title = dt_title, contact = dt_contact, source = dt_src, note = df_notes
)



# uspto County---------------------------------------------------
source_dir <- "source/USPTO_county.csv"
file_name <- "co_uspto"

# metadata
dt_title <- "Utility patent grants, 2000 - 2015, by county"

# FUNCTION load
df <- read_csv(source_dir) %>% 
  janitor::clean_names() %>%
  mutate(stco_code = str_pad(as.character(fips_code), 5, "left", "0"))%>%
  filter(mail_code!="ALL")%>%
  mutate(co_name = as.character(regional_area_component))%>%
  select(-fips_code,
         -mail_code,
         -total,
         -state_or_territory,
         -regional_area_component) %>%
select(stco_code, everything()) # make sure unique identifier is the left most column

df <- df %>% 
  gather("year","patents_issued",x2000:x2015)%>%
  mutate(year=as.numeric(substring(year, 2)),
         patents_issued = as.numeric(patents_issued))%>%
  apply_labels(stco_code= "county code",
               co_name="county names",
               year = "year patent was issued",
               patents_issued = "total patents issued")

df_labels <- create_labels(df)

# SAVE OUTPUT
# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
labels = df_labels, folder = folder_name, file = file_name,
title = dt_title, contact = dt_contact, source = dt_src, note = df_notes, apd = T, skip = T
)

