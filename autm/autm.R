# Get Raw Data and save to 'source' folder
# Author: Sifan Liu
# Date: Fri Aug 03 14:00:12 2018
# SET UP ==============================================
pkgs <- c("tidyverse", "reshape2", "writexl", "httr", "skimr", "sjlabelled") # sjlabelled for column labels

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

county_autm <- AUTM %>%
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
  mutate(stco_code = str_pad(as.character(FIPS), 5, "left", "0")) %>%
  select(-FIPS)

# set variable labels
labels <- c(
  "total license and option issues",
  "total licenses, large companies",
  "total licenses, small companoes",
  "total licenses, start-ups",
  "gross license income",
  "total investment disclosures received",
  "total start ups formed",
  "start ups in home state",
  "county FIPS code"
)

set_label(county_autm) <- labels

# correspondance between labels and variable names
county_autm_key <- get_label(county_autm) %>%
  data.frame() %>%
  rename_at(vars(1), funs(paste0("labels"))) %>%
  mutate(names = colnames(county_autm))


# create directory
dir.create("autm")
save(county_autm, file = "autm/autm.rda")


# sink metadata into .md
sink("autm/README.md")
county_autm_key %>% kable()
skim_with(integer = list(hist = NULL), numeric = list(hist = NULL))
skim(county_autm) %>% kable()
sink()


# txt file with metadata
sink("autm/autm.txt")
county_autm_key
skim(county_autm)
sink()

# write csv
write_csv(county_autm, "autm/autm.csv")
