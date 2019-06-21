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
msa_patentCOMP <- read.csv("V:/Sifan/Birmingham/County Cluster/source/Complexity_msa.csv") %>% 
  janitor::clean_names() %>%
  mutate(msa= as.character(cbsa), msa_name = as.character(cma_cbsa_name))

msa_patentCOMP$cbsa <-NULL
msa_patentCOMP$cma_cbsa_name <- NULL

# check output
skim_with_defaults()
skim(msa_patentCOMP)

# save output
dir.create("patent_complexity")

save(county_USPTO,file = "patent_complexity/msa_patentCOMP.rda")

# generate metadata county
sink("patent_complexity/msa_patentCOMP.txt")
skim_with(numeric = list(hist = NULL))
skim(msa_patentCOMP)
sink()

# create README msa
sink("patent_complexity/msa_patentCOMP.md")
skim(msa_patentCOMP)%>% kable()
sink()

# write csv to github
write.csv(msa_patentCOMP, "patent_complexity/msa_patentCOMP.csv")
