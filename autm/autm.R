# Get Raw Data and save to 'source' folder
# Author: Sifan Liu
# Date: Fri Aug 03 14:00:12 2018
# SET UP ==============================================
pkgs <- c("tidyverse", "reshape2", "writexl", "httr","skimr")

check <- sapply(pkgs, require, warn.conflicts = TRUE, character.only = TRUE)
if (any(!check)) {
  pkgs.missing <- pkgs[!check]
  install.packages(pkgs.missing)
  check <- sapply(pkgs.missing, require, warn.conflicts = TRUE, character.only = TRUE)
}

# TRANSFORM ============================================
# AUTM ---------------------------------------------------

# data available up to 2017

AUTM <- read.csv("source/AUTM.csv")

county_AUTM <- AUTM %>%
  group_by(FIPS) %>%
  # summarise_if(is.numeric, sum, na.rm = TRUE) %>%
  summarise(
    tot_lic = sum(Lic.Iss, na.rm = TRUE) + sum(Opt.Iss, na.rm = TRUE),
    lg_lic = sum(Tot.Lic.Lg.Co, na.rm = TRUE),
    sm_lic = sum(Tot.Lic.Sm.Co, na.rm = TRUE),
    st_lic = sum(Tot.Lic.St.Ups, na.rm = TRUE),
    inc_lic = sum(Gross.Lic.Inc, na.rm = TRUE),
    tot_IP = sum(Inv.Dis.Rec, na.rm = TRUE),
    tot_st = sum(St.Ups.Formed, na.rm = TRUE),
    instate_st = sum(St.Ups.in.Home.St, na.rm = TRUE)
  ) %>%
  mutate(FIPS = str_pad(as.character(FIPS), 5, "left", "0"))

#create directory
dir.create("autm")
save(AUTM,file = "autm/autm.rda")


# sink metadata into .md
sink("autm/autm.md")
skim(AUTM) %>% kable()
sink()


#txt file with metadata
sink("autm/autm.txt") 
skim(AUTM)
sink()

#write csv
write_csv(AUTM,"autm/autm.csv")







