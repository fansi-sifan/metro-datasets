# Get Raw Data and save to 'source' folder
# Author: Eleanor Noble
# Date: 6/19/2019
# SET UP ==============================================
pkgs <- c("tidyverse", "reshape2", "writexl", "httr","skimr", "janitor", "sjlabelled")

check <- sapply(pkgs, require, warn.conflicts = TRUE, character.only = TRUE)
if (any(!check)) {
  pkgs.missing <- pkgs[!check]
  install.packages(pkgs.missing)
  check <- sapply(pkgs.missing, require, warn.conflicts = TRUE, character.only = TRUE)
}

# TRANSFORM ============================================
# inc5000 ---------------------------------------------------
cbsa_i5hgc <- read.csv("V:/Sifan/Birmingham/County Cluster/source/I5HGC_density.csv") %>%
  mutate(CBSA_CODE = as.character(CBSA)) %>%
  janitor::clean_names()%>%
  mutate(cbsa_name = as.character(name), 
         cbsa_size = as.character(size_category))%>%
  select(-cbsa,
         -name,
         -size_category)

# check output
skim_with_defaults()
skim(cbsa_i5hgc)

# save output
dir.create("inc5000")

save(cbsa_i5hgc,file = "inc5000/cbsa_i5hgc.rda")

# generate metadata 
sink("inc5000/cbsa_i5hgc.txt")
skim_with(numeric = list(hist = NULL))
skim(cbsa_i5hgc)
sink()

# create README cbsa
sink("inc5000/README.md")
skim(cbsa_i5hgc)%>% kable()
sink()

# write csv to github
write.csv(cbsa_i5hgc, "inc5000/cbsa_i5hgc.csv")
