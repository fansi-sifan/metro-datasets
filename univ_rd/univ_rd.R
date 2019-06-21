# Get Raw Data and save to 'source' folder
# Author: David Whyman
# Date: Fri June 21 10:00:12 2019
# SET UP ==============================================
pkgs <- c("tidyverse", "reshape2", "writexl", "httr","skimr")

check <- sapply(pkgs, require, warn.conflicts = TRUE, character.only = TRUE)
if (any(!check)) {
  pkgs.missing <- pkgs[!check]
  install.packages(pkgs.missing)
  check <- sapply(pkgs.missing, require, warn.conflicts = TRUE, character.only = TRUE)
}

# TRANSFORM ============================================
# Univ R&D ---------------------------------------------------
NSF_univRD <- read.csv("source/NSF_univ.csv")

cbsa_univRD <- NSF_univRD %>%
  group_by(cbsacode) %>%
  summarise(
    rd_total = sum(Deflated.Total.R.D.Expenditures.in.All.Fields.Sum.),
    rd_total_biz = sum(as.numeric(as.character(Deflated.Business.Financed.R.D.Expenditures.Sum.)))
  ) %>%
  mutate(cbsa = as.character(cbsacode)) %>%
  janitor::clean_names()

county_univRD <- NSF_univRD %>%
  group_by(county) %>%
  summarise(
    rd_total = sum(Deflated.Total.R.D.Expenditures.in.All.Fields.Sum.),
    rd_total_biz = sum(as.numeric(as.character(Deflated.Business.Financed.R.D.Expenditures.Sum.)))
  ) %>%
  mutate(FIPS = str_pad(as.character(county), 5, "left", "0"))

#create directory
dir.create("univ_rd")
save(cbsa_univRD,file = "univ_rd/univ_rd_cbsa.rda")
save(county_univRD,file = "univ_rd/univ_rd_county.rda")


# sink metadata into .md
sink("univ_rd/univ_rd.md")
skim(cbsa_univRD)
skim(county_univRD)
sink()


#txt file with metadata
sink("univ_rd/univ_rd.txt") 
skim(cbsa_univRD)
skim(county_univRD)
sink()

#write csv
write_csv(cbsa_univRD,"univ_rd/univ_rd_cbsa.csv")
write_csv(county_univRD,"univ_rd/univ_rd_county.csv")
