library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "source/OutOfWork_county.csv"
folder_name <- "out_of_work"
file_name <- "co_oow"

# metadata
dt_title <- "Out of work population by group"
dt_src <- "https://www.brookings.edu/research/meet-the-out-of-work/"
dt_contact <- "Martha Ross"
df_notes <- "130 large cities and counties across the United States, note that LA, Seattle, Chicago, Detroit, etc. are treated separately from their counties"

# FUNCTION load
df <- read_csv(source_dir) %>%
  mutate(stco_code = str_pad(fips, 5, "left", "0")) %>%
  janitor::clean_names() %>%
  select(stco_code, everything(),-cbsacode, -fips) %>%
  apply_labels(jurisdiction = "cities and counties",
               stco_code = "counties and its core cities might be sharing the same fips code")

df_labels <- create_labels(df)

# SAVE OUTPUT
# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
labels = df_labels, folder = folder_name, file = file_name,
title = dt_title, contact = dt_contact, source = dt_src, note = df_notes
)




# check output
skim_with_defaults()
skim(stco_oow)

# save output
dir.create("out_of_work")

save(stco_oow,file = "out_of_work/stco_oow.rda")

# generate metadata county
sink("out_of_work/stco_oow.txt")
skim_with(numeric = list(hist = NULL))
skim(stco_oow)
sink()

# create README county
sink("out_of_work/README.md")
skim(stco_oow)%>% kable()
sink()


# write csv to github
write.csv(stco_oow, "out_of_work/stco_oow.csv")
