# Get Raw Data and save to 'source' folder
# Author: Sifan Liu
# Date: Fri Aug 03 14:00:12 2018
# SET UP ==============================================
pkgs <- c("tidyverse", "reshape2","skimr","janitor")

check <- sapply(pkgs, require, warn.conflicts = TRUE, character.only = TRUE)
if (any(!check)) {
  pkgs.missing <- pkgs[!check]
  install.packages(pkgs.missing)
  check <- sapply(pkgs.missing, require, warn.conflicts = TRUE, character.only = TRUE)
}

# TRANSFORM ============================================
# REGPAT ---------------------------------------------------

#data exists up to 2012

cbsa_regpat <- readxl::read_xlsx("V:/Global Profiles/Data/REGPAT/Analysis Files/_g4.xlsx", sheet = "i0") %>%
  filter(`Year Range` == "2008-2012") %>%
  janitor::clean_names() %>%
  select(
year_range,                                         
cbsa_name = "micro_regions",                                      
cbsa_fips = "micro_region",                                  
st_name = "core_macro_region",                               
country_name = "country",
cbsa_patents_invented = "number_of_patents_invented_total_micro_regions",     
cbsa_inventors_per_patent = "number_of_inventors_per_patent_total_micro_regions" , 
cbsa_patent_applications = "number_of_patent_applications_total_micro_regions",  
cbsa_applicants_per_patent = "number_of_applicants_per_patent_total_micro_regions"
)

#create directory
dir.create("regpat")
save(cbsa_regpat,file = "regpat/regpat.rda")

skim_with(numeric = list(hist = NULL))

# sink metadata into .md
sink("regpat/README.md")
skim(cbsa_regpat) %>% kable()
sink()


#txt file with metadata
sink("regpat/regpat.txt") 
skim(cbsa_regpat)
sink()

#write csv
write_csv(cbsa_regpat,"regpat/regpat.csv")

