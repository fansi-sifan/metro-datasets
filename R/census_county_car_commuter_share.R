# Get Raw Data and save to 'source' folder
# Author: Eleanor Noble
# Date: 6/19/2019
# SET UP ==============================================
pkgs <- c("tidyverse", "reshape2", "writexl", "httr","skimr", "janitor", 
          "sjlabelled", "expss","tidycensus")

check <- sapply(pkgs, require, warn.conflicts = TRUE, character.only = TRUE)
if (any(!check)) {
  pkgs.missing <- pkgs[!check]
  install.packages(pkgs.missing)
  check <- sapply(pkgs.missing, require, warn.conflicts = TRUE, character.only = TRUE)
}
# API setup ============================================
census_api_key("08481c4dfc3883be489eadb48bc5e5a525083674", install = TRUE)
# First time, reload your environment so you can use the key without restarting R.
readRenviron("~/.Renviron")

# PULL API VARIABLE NAMES ACS 2017 5 year ============================================
variable_names_2017_acs5 <- load_variables(2017, "acs5/subject", cache = TRUE)%>%
  mutate(label = tolower( str_replace_all(label, "[[:punct:]]", " ")))

# PULL AND TRANSFORM ACS 2017 5 year ============================================
us_commuting_2017_acs5 <- get_acs(geography = "county", 
                                 table = "S0802", #figure out which table gives you the basic socio demographic info
                                 year = 2017,
                                 survey = "acs5",
                                 cache_table = TRUE)

#Look at the variable table and the census api data to determine variable codes
#total workers = S0802_C01_001
#drove to work = S0802_C02_001
#carpooled to work = S0802_C03_001

us_commuting_2017_acs5 <- us_commuting_2017_acs5%>%
  left_join(variable_names_2017_acs5, by=c("variable"="name")) %>%
  select(-concept) %>%
  filter(variable=="S0802_C01_001"|variable=="S0802_C02_001"|variable=="S0802_C03_001") %>%
  select(-variable) %>%
  mutate(label = ifelse(label=="estimate  total  workers 16 years and over",
                        "tot_workers_16_up",
                        gsub("estimate  car  truck  or van    ","",label)),
         label = gsub("  workers 16 years and over", "", label)) %>%
         #this cleans up the labels to either say race or total pop
  gather(variable, value, (estimate:moe)) %>%
  unite(temp, label, variable) %>%
  spread(temp, value) %>% #make the data wide again
  janitor::clean_names() %>%
  mutate(co_name = name, 
         stco_code = geoid) %>%
  select(-name,
         -geoid)

# PULL API VARIABLE NAMES ACS 2017 1 year ============================================
variable_names_2017_acs1 <- load_variables(2017, "acs1/subject", cache = TRUE)%>%
  mutate(label = tolower( str_replace_all(label, "[[:punct:]]", " ")))

# PULL AND TRANSFORM ACS 2017 1 year  ============================================
#using the api to pull the census data 
us_commuting_2017_acs1 <- get_acs(geography = "county", 
                                 table = "S0802", #figure out which table gives you the basic socio demographic info
                                 year = 2017,
                                 survey = "acs1",
                                 cache_table = TRUE)

#there are a lot of missing values and counties for the acs 1 year estimates
us_commuting_2017_acs1 <- us_commuting_2017_acs1_raw %>%
  left_join(variable_names_2017_acs5, by=c("variable"="name")) %>%
  select(-concept) %>%
  filter(variable=="S0802_C01_001"|variable=="S0802_C02_001"|variable=="S0802_C03_001") %>%
  select(-variable) %>%
  mutate(label = ifelse(label=="estimate  total  workers 16 years and over",
                        "tot_workers_16_up",
                        gsub("estimate  car  truck  or van    ","",label)),
         label = gsub("  workers 16 years and over", "", label)) %>%
  gather(variable, value, (estimate:moe)) %>%
  unite(temp, label, variable) %>%
  spread(temp, value) %>% #make the data wide again
  janitor::clean_names() %>%
  mutate(co_name = name, 
         stco_code = geoid) %>%
  select(-name,
         -geoid)
