# Get Raw Data and save to 'source' folder
# Author: Eleanor Noble
# Date: 6/19/2019
# SET UP ==============================================
pkgs <- c("tidyverse", "reshape2", "writexl", "expss", "httr","skimr", "janitor", "sjlabelled", "expss")

check <- sapply(pkgs, require, warn.conflicts = TRUE, character.only = TRUE)
if (any(!check)) {
  pkgs.missing <- pkgs[!check]
  install.packages(pkgs.missing)
  check <- sapply(pkgs.missing, require, warn.conflicts = TRUE, character.only = TRUE)
}

# TRANSFORM ============================================
# Patent Complexity ---------------------------------------------------
cbsa_patent_complexity <- read.csv("V:/Sifan/Birmingham/County Cluster/source/Complexity_msa.csv") %>% 
  janitor::clean_names() %>%
  mutate(cbsa_code = as.character(cbsa), 
         cbsa_name = as.character(cma_cbsa_name),
         patent_complexity = complex) %>%
  select(-cbsa, 
         -cma_cbsa_name, 
         -complex)%>%
  apply_labels(cbsa_code = "cbsa code",
  cbsa_name = "cbsa name",
  patent_complexity = "patent complexity score")

# check output
skim_with_defaults()
skim(cbsa_patent_complexity)

# save output
dir.create("patent_complexity")
save(cbsa_patent_complexity,file = "patent_complexity/cbsa_patent_complexity.rda")

# generate metadata county
sink("patent_complexity/cbsa_patent_complexity.txt")
skim_with(numeric = list(hist = NULL))
skim(cbsa_patent_complexity)
sink()

# create README cbsa
sink("patent_complexity/README.md")
skim(cbsa_patent_complexity)%>% kable()
sink()

# write csv to github
write.csv(cbsa_patent_complexity, "patent_complexity/cbsa_patent_complexity.csv")
