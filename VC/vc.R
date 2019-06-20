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
city_VC <- read.csv("V:/Sifan/Birmingham/County Cluster/source/VC.csv") %>%
  filter(round == "Total VC" & measure == "Capital Invested ($ M) per 1M Residents") %>%
  mutate(geoid = as.character(cbsa13)) %>%
  janitor::clean_names()

city_VC$x <- NULL
city_VC$cbsa13 <-NULL
colnames(city_VC)[which(names(city_VC) == "msa")] <- "city"

# check output
skim_with_defaults()
skim(city_VC)

# save output
dir.create("VC")

save(county_USPTO,file = "VC/city_VC.rda")

# generate metadata county
sink("VC/city_VC.txt")

skim_with(numeric = list(hist = NULL))
skim(city_VC)
sink()

# create README city
sink("VC/city_VC.md")
skim(city_VC)%>% kable()
sink()

# write csv to github
write.csv(city_VC, "VC/city_VC.csv")

