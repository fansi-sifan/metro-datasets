# Get Raw Data and save to 'source' folder
# Author: Eleanor Noble
# Date: 6/19/2019
# SET UP ==============================================
pkgs <- c("tidyverse", "reshape2", "writexl", "httr","skimr", "janitor", "stringr")

check <- sapply(pkgs, require, warn.conflicts = TRUE, character.only = TRUE)
if (any(!check)) {
  pkgs.missing <- pkgs[!check]
  install.packages(pkgs.missing)
  check <- sapply(pkgs.missing, require, warn.conflicts = TRUE, character.only = TRUE)
}

# TRANSFORM ============================================
# USPTO CBSA---------------------------------------------------
cbsa_USPTO <- read.csv("V:/Sifan/Birmingham/County Cluster/source/USPTO_msa.csv") %>% janitor::clean_names() %>%
  mutate(cbsa_code = substr(as.character(id_code), 2, 6)) %>%
  filter(id_code != "") %>%
  filter(geo_type != "ALL AREAS")

#changing cbsa uspto names and classes
names(cbsa_USPTO)[names(cbsa_USPTO) == 'geo_type'] <- 'cbsa_type'
names(cbsa_USPTO)[names(cbsa_USPTO) == 'us_regional_title'] <- 'cbsa_name'
cbsa_USPTO$id_code<-NULL
cbsa_USPTO$total<-NULL

cbsa_USPTO$cbsa_type<-as.character(cbsa_USPTO$cbsa_type)
cbsa_USPTO$cbsa_name<-as.character(cbsa_USPTO$cbsa_name)

#gathering into long instead of wide data
cbsa_USPTO<-gather(cbsa_USPTO,"year","patents_issued",3:18)
cbsa_USPTO<-cbsa_USPTO%>%
  mutate(year=as.numeric(substring(year, 2)))

# USPTO County---------------------------------------------------
county_USPTO <- read.csv("V:/Sifan/Birmingham/County Cluster/source/USPTO_county.csv") %>% janitor::clean_names() %>%
  mutate(stco_code = str_pad(as.character(fips_code), 5, "left", "0"))%>%
  filter(mail_code!="ALL")

#changing county uspto names and classes and deleting unnecessary variables
county_USPTO$fips_code <- NULL
county_USPTO$mail_code <- NULL
county_USPTO$total <- NULL
names(county_USPTO)[names(county_USPTO) == 'state_or_territory'] <- 'st_name'
names(county_USPTO)[names(county_USPTO) == 'regional_area_component'] <- 'co_name'

county_USPTO$st_name<-as.character(county_USPTO$st_name)
county_USPTO$co_name<-as.character(county_USPTO$co_name)

#gathering into long instead of wide data
county_USPTO<-gather(county_USPTO,"year","patents_issued",3:18)
county_USPTO<-county_USPTO%>%
  mutate(year=as.numeric(substring(year, 2)))

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
