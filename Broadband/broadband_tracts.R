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
# Broadband ---------------------------------------------------
tract_broadband <- readxl::read_xlsx("V:/Infrastructure/2 Long Form Projects/Broadband/Final Layout/Masterfile_Final.xlsx")

# check output
skim_with_defaults()
skim(tract_broadband)

# save output
dir.create("Broadband")

save(county_USPTO,file = "Broadband/tract_broadband.rda")

# generate metadata county
sink("Broadband/tract_broadband.txt")
skim_with(numeric = list(hist = NULL))
skim(tract_broadband)
sink()

# create README msa
sink("Broadband/tract_broadband.md")
skim(tract_broadband)%>% kable()
sink()

# write csv to github
write.csv(tract_broadband, "Broadband/tract_broadband.csv")