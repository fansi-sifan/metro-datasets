# Get Raw Data and save to 'source' folder
# Author: David Whyman
# Date: Fri June 21 10:00:12 2019
# SET UP ==============================================
pkgs <- c("tidyverse", "reshape2", "writexl", "httr","skimr","sjlabelled") #sjlabelled for column labels

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
  mutate(cbsa_code = as.character(cbsacode)) %>%
  select(-cbsacode) %>%
  janitor::clean_names()


county_univRD <- NSF_univRD %>%
  group_by(county) %>%
  summarise(
    rd_total = sum(Deflated.Total.R.D.Expenditures.in.All.Fields.Sum.),
    rd_total_biz = sum(as.numeric(as.character(Deflated.Business.Financed.R.D.Expenditures.Sum.)))
  ) %>%
  mutate(stco_code = str_pad(as.character(county), 5, "left", "0")) %>%
  select(-county)


labels<-c("total R&D spending",
          "total deflated business financed R&D spending",
          "FIPS code")

set_label(cbsa_univRD)<-labels
set_label(county_univRD)<-labels

#correspondance between labels and variable names
county_univRD_key <- get_label(county_univRD) %>%
  data.frame() %>%
  rename_at(vars(1), funs(paste0('labels'))) %>%
  mutate(names = colnames(county_univRD)) 


cbsa_univRD_key <- get_label(cbsa_univRD) %>%
  data.frame() %>%
  rename_at(vars(1), funs(paste0('labels'))) %>%
  mutate(names = colnames(cbsa_univRD)) 

#create directory
dir.create("univ_rd")
save(cbsa_univRD,file = "univ_rd/univ_rd_cbsa.rda")
save(county_univRD,file = "univ_rd/univ_rd_county.rda")


# sink metadata into .md
sink("univ_rd/README.md")
cbsa_univRD_key %>% kable()
county_univRD_key %>% kable()
skim_with(numeric = list(hist = NULL))
skim(cbsa_univRD) %>% kable()
skim(county_univRD) %>% kable()
sink()


#txt file with metadata
sink("univ_rd/univ_rd.txt")
cbsa_univRD_key
county_univRD
skim(cbsa_univRD)
skim(county_univRD)
sink()

#write csv
write_csv(cbsa_univRD,"univ_rd/univ_rd_cbsa.csv")
write_csv(county_univRD,"univ_rd/univ_rd_county.csv")

