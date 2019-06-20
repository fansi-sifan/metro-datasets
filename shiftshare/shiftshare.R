# Get Raw Data and save to 'source' folder
# Author: David Whyman
# Date: Wed Jun 19 15:39:00 2019
# SET UP ==============================================
pkgs <- c("tidyverse", "reshape2", "writexl", "httr","skimr")

check <- sapply(pkgs, require, warn.conflicts = TRUE, character.only = TRUE)
if (any(!check)) {
  pkgs.missing <- pkgs[!check]
  install.packages(pkgs.missing)
  check <- sapply(pkgs.missing, require, warn.conflicts = TRUE, character.only = TRUE)
}


# ShiftShare ---------------------------------------------------


#original location of source/shiftshare.csv is:
#V:\Performance\Project files\Metro Monitor\2018v/Output/Shift Share\Monitor Shiftshare Cumulative (2-digit NAICS).csv
#no 2019 version of this dataset found

cbsa_shiftshare <- read_csv("source/shiftshare.csv") %>%
 #filter(cbsa2013_fips == msa_FIPS) %>% (not sure what msa_FIPS refers to... object does not exist)
  filter(year == 2016) %>%
  janitor::clean_names() #variable names still not clear to me

#save output
dir.create("shiftshare")
save(cbsa_shiftshare,file = "shiftshare/shiftshare.rda")

#save metadata in readme
sink("shiftshare/shiftshare.md") 
skim(cbsa_shiftshare) %>%
  kable()
sink()

#txt file with metadata
sink("shiftshare/shiftshare.txt") 
skim(cbsa_shiftshare)
sink()

#write csv
write_csv(cbsa_shiftshare, "shiftshare/shiftshare.csv")






