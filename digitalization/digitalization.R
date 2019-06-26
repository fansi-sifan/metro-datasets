# Get Raw Data and save to 'source' folder
# Author: David Whyman
# Date: Wed Jun 19 14:55:00 2019
# SET UP ==============================================
pkgs <- c("tidyverse", "janitor","skimr")

check <- sapply(pkgs, require, warn.conflicts = TRUE, character.only = TRUE)
if (any(!check)) {
  pkgs.missing <- pkgs[!check]
  install.packages(pkgs.missing)
  check <- sapply(pkgs.missing, require, warn.conflicts = TRUE, character.only = TRUE)
}

# Digitalization ---------------------------------------------------

#data up to 2016 exists (read source data)
cbsa_digital <- read.csv("source/metro_all_updated.csv") %>%
  janitor::clean_names() %>%
  select(cbsa_code = area,
         cbsa_name = geography,
         cbsa_score_02 = score02,
         cbsa_score_16 = score16,
         cbsa_pct_high_02 = high02,
         cbsa_pct_medium_02 = medium02,
         cbsa_pct_low_02 = low02,
         cbsa_pct_high_16 = high16,
         cbsa_pct_medium_16 = medium16,
         cbsa_pct_low_16 = low16)

#create directory
dir.create("digitalization")
save(cbsa_digital,file = "digitalization/digitalization.rda")

skim_with(integer = list(hist = NULL), numeric = list(hist = NULL))

# sink metadata into .md
sink("digitalization/README.md")
skim(cbsa_digital) %>% kable()
sink()


#txt file with metadata
sink("digitalization/digitalization.txt") 
skim(cbsa_digital)
sink()

#write csv
write_csv(cbsa_digital,"digitalization/digitalization.csv")

