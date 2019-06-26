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
# Patent Complexity ---------------------------------------------------
cbsa_patent_complexity <- read.csv("V:/Sifan/Birmingham/County Cluster/source/Complexity_msa.csv") %>% 
  janitor::clean_names() %>%
  mutate(cbsa_code= as.character(cbsa), cbsa_name = as.character(cma_cbsa_name))

cbsa_patent_complexity$cbsa <-NULL
cbsa_patent_complexity$cma_cbsa_name <- NULL

#rename patent variable
names(cbsa_patent_complexity)[names(cbsa_patent_complexity) == 'complex'] <- 'patent_complexity'

#labels for metadata
labels<-c("patent complexity score","cbsa code","cbsa name")

set_label(cbsa_patent_complexity)<-labels

#correspondance between labels and variable names
cbsa_patent_complexity_key <- get_label(cbsa_patent_complexity) %>%
  data.frame() %>%
  rename_at(vars(1), funs(paste0('labels'))) %>%
  mutate(names = colnames(cbsa_patent_complexity))

# check output
skim_with_defaults()
skim(cbsa_patent_complexity)

# save output
dir.create("patent_complexity")

save(cbsa_patent_complexity,file = "patent_complexity/cbsa_patent_complexity.rda")

# generate metadata county
sink("patent_complexity/cbsa_patent_complexity.txt")
cbsa_patent_complexity_key
skim_with(numeric = list(hist = NULL))
skim(cbsa_patent_complexity)
sink()

# create README cbsa
sink("patent_complexity/README.md")
kable(cbsa_patent_complexity_key)
skim(cbsa_patent_complexity)%>% kable()
sink()

# write csv to github
write.csv(cbsa_patent_complexity, "patent_complexity/cbsa_patent_complexity.csv")
