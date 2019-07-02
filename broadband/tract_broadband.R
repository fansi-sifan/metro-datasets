# Get Raw Data and save to 'source' folder
# Author: Eleanor Noble
# Date: 6/19/2019
# SET UP ==============================================
pkgs <- c("tidyverse", "reshape2", "writexl", "httr","skimr", "janitor","stringr", "sjlabelled", "expss")

check <- sapply(pkgs, require, warn.conflicts = TRUE, character.only = TRUE)
if (any(!check)) {
  pkgs.missing <- pkgs[!check]
  install.packages(pkgs.missing)
  check <- sapply(pkgs.missing, require, warn.conflicts = TRUE, character.only = TRUE)
}

# TRANSFORM ============================================
# broadband ---------------------------------------------------
tract_broadband <- readxl::read_xlsx("V:/Infrastructure/2 Long Form Projects/Broadband/Final Layout/Masterfile_Final.xlsx")%>%
  janitor::clean_names()%>%
  mutate(stcotract_code = as.character(str_sub(tract,-6,-1)))%>%
  select(-v1,
         -tract,
         -tractonly_fips,
         -state,
         -county,
         -statename, 
         -countyname, 
         -cbsa,
         -metro,
         -stplfips,
         -place,
         -geotype)%>%
  apply_labels(atl3 = "at least 3 Mbps",
               atl10 = "at least 10 Mbps",
               atl25 = "at least 10 Mbps",
               above1g = "at least 1 Gbps",
               stcotract_code = "tract geoid")

#correspondance between labels and variable names
tract_broadband_key <- get_label(tract_broadband) %>%
  data.frame() %>%
  mutate(names = colnames(tract_broadband)) %>%
  rename("label" = ".")

  
# check output
skim_with_defaults()
skim(tract_broadband)

# save output
dir.create("broadband")

save(tract_broadband,file = "broadband/tract_broadband.rda")

# generate metadata county
sink("broadband/tract_broadband.txt")
tract_broadband_key
skim_with(numeric = list(hist = NULL))
skim(tract_broadband)
sink()

# create README msa
sink("broadband/README.md")
kable(tract_broadband_key)
skim(tract_broadband)%>% kable()
sink()

# write csv to github
write.csv(tract_broadband, "broadband/tract_broadband.csv")
