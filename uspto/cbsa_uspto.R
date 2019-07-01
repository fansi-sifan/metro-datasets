# Get Raw Data and save to 'source' folder
# Author: Eleanor Noble
# Date: 6/19/2019
# SET UP ==============================================
pkgs <- c("tidyverse", "reshape2", "writexl", "httr","skimr", "janitor", "stringr", "sjlabelled", "expss")

check <- sapply(pkgs, require, warn.conflicts = TRUE, character.only = TRUE)
if (any(!check)) {
  pkgs.missing <- pkgs[!check]
  install.packages(pkgs.missing)
  check <- sapply(pkgs.missing, require, warn.conflicts = TRUE, character.only = TRUE)
}

# TRANSFORM ============================================
# uspto CBSA---------------------------------------------------
cbsa_uspto <- read.csv("V:/Sifan/Birmingham/County Cluster/source/USPTO_msa.csv") %>% janitor::clean_names() %>%
  mutate(cbsa_code = substr(as.character(id_code), 2, 6)) %>%
  filter(id_code != "") %>%
  filter(geo_type != "ALL AREAS")%>%
  mutate(cbsa_type = as.character(geo_type), 
         cbsa_name = as.character(us_regional_title))%>%
  select(-geo_type,
         -us_regional_title,
         -id_code,
         -total)

#gathering into long instead of wide data
cbsa_uspto<-gather(cbsa_uspto,"year","patents_issued",x2000:x2015)
cbsa_uspto<-cbsa_uspto%>%
  mutate(year=as.numeric(substring(year, 2)),
         patents_issued = as.numeric(patents_issued))%>%
  apply_labels(cbsa_code= "cbsa geoid",
               cbsa_type="cbsa type: metro, mico, non, undetermined",
               cbsa_name="cbsa names",
               year = "year patent was issued",
               patents_issued = "total patents issued")

#correspondance between labels and variable names
cbsa_uspto_key <- get_label(cbsa_uspto) %>%
  data.frame() %>%
  mutate(names = colnames(cbsa_uspto)) %>%
  rename("label" = ".")

# uspto County---------------------------------------------------
co_uspto <- read.csv("V:/Sifan/Birmingham/County Cluster/source/USPTO_county.csv") %>% janitor::clean_names() %>%
  mutate(stco_code = str_pad(as.character(fips_code), 5, "left", "0"))%>%
  filter(mail_code!="ALL")%>%
  mutate(co_name = as.character(regional_area_component))%>%
  select(-fips_code,
         -mail_code,
         -total,
         -state_or_territory,
         -regional_area_component)

#gathering into long instead of wide data
co_uspto<-gather(co_uspto,"year","patents_issued",x2000:x2015)
co_uspto<-co_uspto%>%
  mutate(year=as.numeric(substring(year, 2)),
         patents_issued = as.numeric(patents_issued))%>%
  apply_labels(stco_code= "county code",
               co_name="county names",
               year = "year patent was issued",
               patents_issued = "total patents issued")

#correspondance between labels and variable names
co_uspto_key <- get_label(co_uspto) %>%
  data.frame() %>%
  mutate(names = colnames(co_uspto)) %>%
  rename("label" = ".")


# save output
dir.create("uspto")

#metadata-------------------------------------------

# create README 
sink("uspto/README.md")
kable(cbsa_uspto_key)
skim(cbsa_uspto)%>% kable()
kable(co_uspto_key)
skim(co_uspto)%>% kable()
sink()

#check output
skim_with_defaults()
skim(cbsa_uspto)

save(co_uspto,file = "uspto/co_uspto.rda")

# check output 
skim_with_defaults()
skim(co_uspto)

save(co_uspto,file = "uspto/co_uspto.rda")

# generate metadata cbsa 
sink("uspto/cbsa_uspto.txt")
skim_with(numeric = list(hist = NULL))
skim(cbsa_uspto)
sink()

# generate metadata county
sink("uspto/co_uspto.txt")
skim_with(numeric = list(hist = NULL))
skim(co_uspto)
sink()


# write csvs to github
write.csv(cbsa_uspto, "uspto/cbsa_uspto.csv")
write.csv(co_uspto, "uspto/co_uspto.csv")
