# Get Raw Data and save to 'source' folder
# Author: David Whyman
# Date: Wed Jun 19 14:55:00 2019
# SET UP ==============================================
pkgs <- c("tidyverse", "reshape2", "writexl", "httr","skimr")

check <- sapply(pkgs, require, warn.conflicts = TRUE, character.only = TRUE)
if (any(!check)) {
  pkgs.missing <- pkgs[!check]
  install.packages(pkgs.missing)
  check <- sapply(pkgs.missing, require, warn.conflicts = TRUE, character.only = TRUE)
}



# Export Monitor---------------------------------------------------

#data up to 2017 exists

cbsa_export <- readxl::read_xlsx("V:/Export Monitor/2018/Deliverables/Deliverables/Metros Data/Metros by Total, NAICS 2 3.xlsx", sheet = "Total") %>%
  filter(Year == 2017) %>%
  mutate(cbsa = as.character(`(CBSA)`)) %>%
  janitor::clean_names()


county_export <- readxl::read_xlsx("V:/Export Monitor/2018/Deliverables/Deliverables/Counties Data/Counties by Total, NAICS 2.xlsx", sheet = "Total") %>%
  filter(Year == 2017) %>%
  mutate(FIPS = str_pad(as.character(`(County)`), 5, "left", "0")) %>%
  janitor::clean_names()

#create directory
dir.create("export_monitor")
save(cbsa_export,file = "export_monitor/export_monitor_cbsa.rda")
save(county_export,file = "export_monitor/export_monitor_county.rda")


# sink metadata into .md
sink("export_monitor/export_monitor.md")
skim(county_export) %>% kable()
skim(cbsa_export) %>% kable()
sink()


#txt file with metadata
sink("export_monitor/export_monitor.txt") 
skim(county_export)
skim(cbsa_export)
sink()

#write csv
write_csv(county_export,"export_monitor/export_monitor_county.csv")
write_csv(cbsa_export,"export_monitor/export_monitor_cbsa.csv")

# cbsa_naics4_export <- read.csv("V:/Export Monitor/2018/Deliverables/Deliverables/Metros Data/Metros  by NAICS 4.csv") %>%
#   filter(gm == msa_FIPS) %>%
#   filter(year == 2017)
# 
# county_naics4_export <- read.csv("V:/Export Monitor/2018/Deliverables/Deliverables/Counties Data/Counties by NAICS 4.csv") %>%
#   filter(gc == as.integer(county_FIPS)) %>%
#   filter(year == 2017)


