library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
source_dir <- ""
folder_name <- ""
file_name <- ""

# metadata
dt_title <- ""
dt_src <- ""
dt_contact <- ""
df_notes <- ""

# FUNCTION load
df <- read_csv(source_dir)

# labels
df <- df %>%
  select()%>% 
  apply_labels()

df_labels <- create_labels(df)


# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
rmarkdown::render("R/codebook_template.Rmd", output_dir = folder_name, output_file = "README")

#[depreciated] meta file
# save_meta(df,
#           labels = df_labels, folder = folder_name, file = file_name,
#           title = dt_title, contact = dt_contact, source = dt_src, note = df_notes
# )
