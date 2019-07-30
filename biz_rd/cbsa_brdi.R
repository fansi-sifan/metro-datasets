library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "source/BRDI_15.csv"
folder_name <- "biz_rd"
file_name <- "cbsa_biz_rd"

# metadata
dt_title <- "Domestic R&D performed by companies, Millions USD"
dt_src <- "https://www.nsf.gov/statistics/2019/nsf19322/"
dt_contact <- "Sifan Liu"
df_notes <- "Data downloaded from NSF InfoBriefs, using 2015 Business R&D and Innovation Survey"

# FUNCTION load
df <- read_csv(source_dir)

# labels
df <- df %>%
  select(cbsa_code, cbsa_name, biz_rd = total)%>% 
  apply_labels(
 cbsa_name = "metro names",
 cbsa_code = "CBSA code",
 total = "Total Domestic R&D paid by companies, millions USD")

df_labels <- create_labels(df)


# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
          labels = df_labels, folder = folder_name, file = file_name,
          title = dt_title, contact = dt_contact, source = dt_src, note = df_notes
)
