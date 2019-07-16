library(tidyverse)
library(skimr)
library(expss)
library(sjlabelled)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "source/oic.csv"
folder_name <- "oic"
file_name <- "oic"

# metadata -----------
dt_title <- "Economic Trajectory of Old Industrial Cities"
dt_src <- "Brookings Institution analysis of American Community Survey, Census, and Moody's data"
dt_contact <- "Sifan Liu"
df_notes <- ""


# read datasets
df <- read_csv(source_dir)
df_labels <- read_csv("source/oic_labels.csv", skip = 1) #existing appendix with variable labels
set_label(df)<-df_labels$Description

df <- df %>% rename(stco_code = stcofips)


# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
          labels = df_labels, folder = folder_name, file = file_name,
          title = dt_title, contact = dt_contact, source = dt_src, notes = df_notes
)














