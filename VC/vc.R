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
# VC ---------------------------------------------------
cbsa_VC <- read.csv("V:/Sifan/Birmingham/County Cluster/source/VC.csv") %>%
  filter(round == "Total VC" & measure == "Capital Invested ($ M) per 1M Residents") %>%
  mutate(cbsa_code = as.character(cbsa13)) %>%
  janitor::clean_names()

# changing variable names, classes, getting rid of unnecessary variables
cbsa_VC$x <- NULL
cbsa_VC$cbsa13 <-NULL
cbsa_VC$country<-NULL
cbsa_VC$measure <- NULL

colnames(cbsa_VC)[which(names(cbsa_VC) == "msa")] <- "cbsa_name"
colnames(cbsa_VC)[which(names(cbsa_VC) == "value")] <- "capital_invested_(in_millions)_per_1M_residents"

cbsa_VC$cbsa_name<-as.character(cbsa_VC$cbsa_name)

# check output
skim_with_defaults()
skim(cbsa_VC)

# save output
dir.create("VC")

save(cbsa_VC,file = "VC/cbsa_VC.rda")

# generate metadata county
sink("VC/cbsa_VC.txt")

skim_with(numeric = list(hist = NULL))
skim(cbsa_VC)
sink()

# create README cbsa
sink("VC/cbsa_VC.md")
skim(cbsa_VC)%>% kable()
sink()

# write csv to github
write.csv(cbsa_VC, "VC/cbsa_VC.csv")

