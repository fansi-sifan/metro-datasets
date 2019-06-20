# Get Raw Data and save to 'source' folder
# Author: David Whyman
# Date: Wed Jun 19 14:55:00 2019
# SET UP ==============================================
pkgs <- c("tidyverse", "reshape2", "writexl", "httr","skimr")

check <- sapply(pkgs, require, warn.conflicts = TRUE, character.only = TRUE)
if (any(!check)) {
  pkgs.missing <- pkgs[!check]
  install.packages(pkgs.missing)
  check <- sapply(pkgs.missing, require, warn.conflicts = TRUE, character.only = TRUE)
}



# Digitalization ---------------------------------------------------

#data up to 2016 exists (read source data)
cbsa_digital <- read.csv("source/metro_all_updated.csv") %>%
  mutate(cbsa = as.character(`AREA`)) %>%
  janitor::clean_names()


#create directory
dir.create("digitalization")
save(cbsa_digital,file = "digitalization/digitalization.rda")


# sink metadata into .md
sink("digitalization/digitalization.md")
skim(cbsa_digital) %>% kable()
sink()


#txt file with metadata
sink("digitalization/digitalization.txt") 
skim(cbsa_digital)
sink()

#write csv
write_csv(cbsa_digital,"digitalization/digitalization.csv")

