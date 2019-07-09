library(tidyverse)
library(skimr)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "source/BRDI_15.csv"
folder_name <- "brdi_15"
file_name <- "cbsa_brdi"

# metadata
dt_title <- "Domestic R&D performed by companies, Millions USD"
dt_src <- "Business R&D and Innovation Survey, 2015"
dt_contact <- "Sifan Liu"
df_notes <- ""

# FUNCTION load
df <- read_csv(source_dir)
assign(file_name,df)

# labels
labels <- c(
 cbsa_name <- "metro names",
 cbsa_code <- "CBSA code",
 total <- "Total Domestic R&D paid by companies, millions USD",
 total_paidbycompany <-"Paid for by the company",
 total_paidbyothers <- "Paid for by others"
)

df_labels <- labels %>%
  data.frame() %>%
  mutate(names = colnames(df)) %>%
  rename("label" = ".")

# FUNCTION save output
skimr::skim_with(numeric = list(hist = NULL), integer = list(hist = NULL))

save_output(df = df, labels = df_labels,
            folder = folder_name, file = file_name, 
            title = dt_title, contact = dt_contact, source = dt_src)

