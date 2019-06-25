# Get Raw Data and save to 'source' folder
# Author: David Whyman
# Date: Wed Jun 19 14:55:00 2019
# SET UP ==============================================
pkgs <- c("tidyverse", "reshape2", "writexl", "httr","skimr","sjlabelled") #sjlabelled for column labels

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
  select(-c(2,13:16))

#use old column names as labels (use View() to see labels)
set_label(cbsa_export)<-colnames(cbsa_export)


#set new column names
colnames(cbsa_export)<-c(
  "year",
  "cbsa_code",
  "cbsa_2013_name",
  "cbsa_2013_short_name",
  "st_abbr",
  "st_code",
  "st_name",
  "is_top100",
  "is_top100_label",
  "is_metro",
  "is_metro_label",
  "cbsa_exports_nominal",
  "cbsa_exports_real",
  "cbsa_pct_exports_gdp",
  "cbsa_export_jobs_direct",
  "cbsa_export_jobs_direct_intensity",
  "cbsa_export_jobs_total",
  "cbsa_export_jobs_total_intensity",
  "cbsa_2003_2014_pct_export_growth",
  "cbsa_2008_2017_pct_export_growth",
  "cbsa_2014_2017_pct_export_growth",
  "cbsa_2003_2017_pct_export_growth",
  "cbsa_pct_export_growth",
  "cbsa_gdp_nominal",
  "cbsa_gdp_real",
  "cbsa_2003_2014_pct_gdp_growth",
  "cbsa_2008_2017_pct_gdp_growth",
  "cbsa_2003_2017_pct_gdp_growth",
  "cbsa_2014_2017_pct_gdp_growth",
  "cbsa_pct_gdp_growth",
  "cbsa_jobs")

#correspondance between old names (labels) and new names
cbsa_export_key <- get_label(cbsa_export) %>%
  data.frame() %>%
  rename_at(vars(1), funs(paste0('labels'))) %>%
  mutate(names = colnames(cbsa_export)) 

# COUNTY LEVEL  

#load data
county_export <- readxl::read_xlsx("V:/Export Monitor/2018/Deliverables/Deliverables/Counties Data/Counties by Total, NAICS 2.xlsx", sheet = "Total") %>%
  filter(Year == 2017) %>%
  mutate(stcofips_code = str_pad(as.character(`(County)`), 5, "left", "0")) %>%
  select(-c(2,3,5,6,7,15,16,17,18))


#use old column names as labels (use View() to see labels)
set_label(county_export)<-colnames(county_export)

#set new column names
colnames(county_export)<-c("year",
                           "co_name", 
                           "is_top100",
                           "is_top100_label",
                           "is_metro",
                           "is_metro_label",
                           "st_code",
                           "st_name",
                           "st_abbr",
                           "county_exports_nominal",
                           "county_exports_real",
                           "county_pct_exports_gdp",
                           "county_export_jobs_direct",
                           "county_export_jobs_direct_intensity",
                           "county_export_jobs_total",
                           "county_export_jobs_total_intensity",
                           "county_2003_2014_pct_export_growth",
                           "county_2008_2017_pct_export_growth",
                           "county_2014_2017_pct_export_growth",
                           "county_2003_2017_pct_export_growth",
                           "county_pct_export_growth",
                           "county_gdp_nominal",
                           "county_gdp_real",
                           "county_2003_2014_pct_gdp_growth",
                           "county_2008_2017_pct_gdp_growth",
                           "county_2003_2017_pct_gdp_growth",
                           "county_2014_2017_pct_gdp_growth",
                           "county_pct_gdp_growth",
                           "county_jobs",
                           "stco_code"
)

#correspondance between old names (labels) and new names
county_export_key <- get_label(county_export) %>%
  data.frame() %>%
  rename_at(vars(1), funs(paste0('labels'))) %>%
  mutate(names = colnames(county_export)) 



#create directory
dir.create("export_monitor")
save(cbsa_export,file = "export_monitor/cbsa_export_monitor.rda")
save(county_export,file = "export_monitor/county_export_monitor.rda")

skim_with(integer = list(hist = NULL), numeric = list(hist = NULL))

# sink metadata into .md
sink("export_monitor/README.md")
county_export_key %>% kable()
cbsa_export_key %>% kable()
skim(county_export) %>% kable()
skim(cbsa_export) %>% kable()
sink()


#txt file with metadata
sink("export_monitor/export_monitor.txt") 
county_export_key
cbsa_export_key
skim(county_export) %>% kable()
skim(cbsa_export) %>% kable()
sink()

#write csv
write_csv(county_export,"export_monitor/county_export_monitor.csv")
write_csv(cbsa_export,"export_monitor/cbsa_export_monitor.csv")

# cbsa_naics4_export <- read.csv("V:/Export Monitor/2018/Deliverables/Deliverables/Metros Data/Metros  by NAICS 4.csv") %>%
#   filter(gm == msa_FIPS) %>%
#   filter(year == 2017)
# 
# county_naics4_export <- read.csv("V:/Export Monitor/2018/Deliverables/Deliverables/Counties Data/Counties by NAICS 4.csv") %>%
#   filter(gc == as.integer(county_FIPS)) %>%
#   filter(year == 2017)
