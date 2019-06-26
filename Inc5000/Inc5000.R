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
# Inc5000 ---------------------------------------------------
cbsa_I5HGC <- read.csv("V:/Sifan/Birmingham/County Cluster/source/I5HGC_density.csv") %>%
  mutate(CBSA_CODE = as.character(CBSA)) %>%
  janitor::clean_names()


cbsa_I5HGC$cbsa<-NULL
cbsa_I5HGC$cbsa_name<-as.character(cbsa_I5HGC$cbsa_name)
names(cbsa_I5HGC)[names(cbsa_I5HGC) == 'name'] <- 'cbsa_name'

# check output
skim_with_defaults()
skim(cbsa_I5HGC)

# save output
dir.create("Inc5000")

save(cbsa_I5HGC,file = "Inc5000/cbsa_I5HGC.rda")

# generate metadata county
sink("Inc5000/cbsa_I5HGC.txt")
skim_with(numeric = list(hist = NULL))
skim(cbsa_I5HGC)
sink()

# create README cbsa
sink("Inc5000/cbsa_I5HGC.md")
skim(cbsa_I5HGC)%>% kable()
sink()

# write csv to github
write.csv(cbsa_I5HGC, "Inc5000/cbsa_I5HGC.csv")
