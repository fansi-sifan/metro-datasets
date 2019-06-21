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
# USPTO ---------------------------------------------------
cbsa_USPTO <- read.csv("V:/Sifan/Birmingham/County Cluster/source/USPTO_msa.csv") %>% janitor::clean_names() %>%
  mutate(cbsa = substr(as.character(id_code), 2, 6)) %>%
  filter(id_code != "") %>%
  filter(geo_type != "ALL AREAS")

county_USPTO <- read.csv("V:/Sifan/Birmingham/County Cluster/source/USPTO_county.csv") %>% janitor::clean_names() %>%
  mutate(FIPS = str_pad(as.character(fips_code), 5, "left", "0"))%>%
  filter(mail_code!="ALL")

county_USPTO$fips_code <- NULL
  
# check output
skim_with_defaults()
skim(cbsa_USPTO)
skim(county_USPTO)

# save output
dir.create("USPTO")

save(county_USPTO,file = "USPTO/county_USPTO.rda")
save(cbsa_USPTO,file = "USPTO/cbsa_USPTO.rda")

# generate metadata county
sink("USPTO/county_USPTO.txt")
skim_with(numeric = list(hist = NULL))
skim(county_USPTO)
sink()

# generate metadata county
sink("USPTO/cbsa_USPTO.txt")
skim_with(numeric = list(hist = NULL))
skim(cbsa_USPTO)
sink()

# create README cbsa
sink("USPTO/cbsa_USPTO.md")
skim(cbsa_USPTO)%>% kable()
sink()

# create README county
sink("USPTO/county_USPTO.md")
skim(county_USPTO)%>% kable()
sink()

# write csv to github
write.csv(county_USPTO, "USPTO/county_USPTO.csv")
write.csv(cbsa_USPTO, "USPTO/cbsa_USPTO.csv")
