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
#using the api to pull the census data 
us_employment_2017_acs5<-get_acs(geography = "county", 
                           table = "S2301", #figure out which table gives you the basic socio demographic info
                           year = 2017,
                           survey = "acs5",
                           cache_table = TRUE)

us_employment_2017_acs5 <- us_employment_2017_acs5 %>%
  left_join(variable_names_2017_acs5, by=c("variable"="name")) %>%
  select(-concept) %>%
  filter(str_detect(variable, "S2301_C01") #this filters to only include values in this relevant table
         &(str_detect(label, "race")|variable=="S2301_C01_001")) %>% #this narrows it down more to only include variables about race 
  #and the "S2301_C01_001" is the total population for each county
  select(-variable) %>%
  mutate(label = ifelse(str_detect(label, "race"), 
                        gsub(".*latino origin","",label),
                        "tot_pop"))  %>% #this cleans up the labels to either say race or total pop
  gather(variable, value, (estimate:moe)) %>%
  unite(temp, label, variable) %>%
  spread(temp, value) %>% #make the data wide again
  janitor::clean_names() %>%
  mutate(co_name = name, 
         stco_code = geoid) %>%
  select(stco_code, #only include the geo names, black, white, total pop 
         co_name,
         black_or_african_american_alone_estimate,
         black_or_african_american_alone_moe,
         white_alone_estimate,
         white_alone_moe,
         tot_pop_estimate,
         tot_pop_moe)

# PULL API VARIABLE NAMES ACS 2017 1 year ============================================
variable_names_2017_acs1 <- load_variables(2017, "acs1/subject", cache = TRUE)%>%
  mutate(label = tolower( str_replace_all(label, "[[:punct:]]", " ")))

# PULL AND TRANSFORM ACS 2017 1 year  ============================================
#using the api to pull the census data 
us_employment_2017_acs1<-get_acs(geography = "county", 
                                 table = "S2301", #figure out which table gives you the basic socio demographic info
                                 year = 2017,
                                 survey = "acs1",
                                 cache_table = TRUE)

#There are many NAs for the ACS one year estimates at the level of race
us_employment_2017_acs1 <- us_employment_2017_acs1 %>%
  left_join(variable_names_2017_acs1, by=c("variable"="name")) %>%
  select(-concept) %>%
  filter(str_detect(variable, "S2301_C01") #this filters to only include values in this relevant table
         &(str_detect(label, "race")|variable=="S2301_C01_001")) %>% #this narrows it down more to only include variables about race 
  #and the "S2301_C01_001" is the total population for each county
  select(-variable) %>%
  mutate(label = ifelse(str_detect(label, "race"), 
                        gsub(".*latino origin","",label),
                        "tot_pop"))  %>% #this cleans up the labels to either say race or total pop
  gather(variable, value, (estimate:moe)) %>%
  unite(temp, label, variable) %>%
  spread(temp, value) %>% #make the data wide again
  janitor::clean_names() %>%
  mutate(co_name = name, 
         stco_code = geoid) %>%
  select(stco_code, #only include the geo names, black, white, total pop 
         co_name,
         black_or_african_american_alone_estimate,
         black_or_african_american_alone_moe,
         white_alone_estimate,
         white_alone_moe,
         tot_pop_estimate,
         tot_pop_moe)
