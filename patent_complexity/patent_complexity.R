# Get Raw Data and save to 'source' folder
# Author: Eleanor Noble
# Date: 6/19/2019
# SET UP ==============================================
pkgs <- c("tidyverse", "reshape2", "writexl", "httr","skimr", "janitor")

check <- sapply(pkgs, require, warn.conflicts = TRUE, character.only = TRUE)
if (any(!check)) {
  pkgs.missing <- pkgs[!check]
  install.packages(pkgs.missing)
  check <- sapply(pkgs.missing, require, warn.conflicts = TRUE, character.only = TRUE)
}

# TRANSFORM ============================================
# Patent Complexity ---------------------------------------------------
cbsa_patentCOMP <- read.csv("V:/Sifan/Birmingham/County Cluster/source/Complexity_msa.csv") %>% 
  janitor::clean_names() %>%
  mutate(cbsa = as.character(cbsa))

# check output
skim_with_defaults()
skim(cbsa_patentCOMP)

# save output
dir.create("patent_complexity")

save(county_USPTO,file = "patent_complexity/cbsa_patentCOMP.rda")

# generate metadata county
sink("patent_complexity/cbsa_patentCOMP.txt")
skim_with(numeric = list(hist = NULL))
skim(county_USPTO)
sink()

# create README cbsa
sink("patent_complexity/cbsa_patentCOMP.md")
skim(cbsa_USPTO)%>% kable()
sink()

# write csv to github
write.csv(cbsa_patentCOMP, "patent_complexity/cbsa_patentCOMP.csv")
