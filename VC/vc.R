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
# vc ---------------------------------------------------
cbsa_vc <- read.csv("V:/Sifan/Birmingham/County Cluster/source/VC.csv") %>%
  filter(round == "Total VC" & measure == "Capital Invested ($ M) per 1M Residents") %>%
  mutate(cbsa_code = as.character(cbsa13)) %>%
  janitor::clean_names()

# changing variable names, classes, getting rid of unnecessary variables
cbsa_vc$x <- NULL
cbsa_vc$cbsa13 <-NULL
cbsa_vc$country<-NULL
cbsa_vc$measure <- NULL

colnames(cbsa_vc)[which(names(cbsa_vc) == "msa")] <- "cbsa_name"

cbsa_vc$cbsa_name<-as.character(cbsa_vc$cbsa_name)
cbsa_vc$rank<-as.numeric(cbsa_vc$rank)

#labels for metadata
labels<-c("cbsa name","time period of investment","total venture capital","
capital invested (in_millions) per 1M residents","latitude","longitude","cbsa ranking ","cbsa code")

set_label(cbsa_vc)<-labels

#correspondance between labels and variable names
cbsa_vc_key <- get_label(cbsa_vc) %>%
  data.frame() %>%
  rename_at(vars(1), funs(paste0('labels'))) %>%
  mutate(names = colnames(cbsa_vc))

# check output
skim_with_defaults()
skim(cbsa_vc)

# save output
dir.create("vc")

save(cbsa_vc,file = "vc/cbsa_vc.rda")

# generate metadata county
sink("vc/cbsa_vc.txt")
cbsa_vc_key
skim_with(numeric = list(hist = NULL))
skim(cbsa_vc)
sink()

# create README cbsa
sink("vc/README.md")
kable(cbsa_vc_key)
skim(cbsa_vc)%>% kable()
sink()

# write csv to github
write.csv(cbsa_vc, "vc/cbsa_vc.csv")

