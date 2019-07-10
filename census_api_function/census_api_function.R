# function for pulling clean acs data: clean_acs
# Author: David Whyman
# Date: Wed Jul 03 11:30:00 2019
# SET UP ==============================================

pkgs <- c("tidyverse", "tidycensus","skimr")

check <-
  sapply(pkgs,
         require,
         warn.conflicts = TRUE,
         character.only = TRUE)

if (any(!check)) {
  pkgs.missing <- pkgs[!check]
  install.packages(pkgs.missing)
  check <-
    sapply(pkgs.missing,
           require,
           warn.conflicts = TRUE,
           character.only = TRUE)
}

census_api_key("e5ae735f65e6b93f5c2f9bc16bea67b72fa202da")

# FUNCTION: CLEAN_ACS ==============================================

# unlike tidycensus's get_acs, clean_acs assigns meaningful variable names

# first argument = geography
# second argument = variable codes
# third argument = endyear of survey (yyyy)
# fourth argument = number of years survey spans (either 1, 3, or 5)



clean_acs <- function(geography, variables, year, span) {
  
  geogr <- geography
  vari <- variables
  ye <- year
  spann <- span
  
  geogr_name <- paste0(enquo(geogr),"_name")
  varkey <- c("0")
  x <- c("0")
  
  # load libraries
  library(tidycensus)  
  library(tidyverse)  
  
  
  # pull data with get acs
  x <- get_acs(
    geography = geogr,
    variables = vari,
    cache_table = TRUE,
    year = ye,
    survey = paste0("acs", enquo(spann))[2]
  )
  
  # load descriptive labels for subject tables OR detailed tables
  suppressWarnings(
    if (str_detect(variables, "S")) {
      varkey <-
        load_variables(year, paste0("acs", enquo(span), "/subject")[2], cache = TRUE)
    } else {
      varkey <-
        load_variables(year, paste0("acs", enquo(span))[2], cache = TRUE)
    }
  )
  
  # clean pulled data and rename columns to descriptive labels 
  final <- varkey %>%
    filter(name %in% x$variable) %>%
    left_join(x, by = c("name" = "variable")) %>%
    select(-concept) %>%
    gather(key = "measure", value = "values", estimate, moe) %>%
    mutate(label = tolower(str_replace_all(label, "[[:punct:]]", " "))) %>%
    mutate(label = str_remove(label, "estimate")) %>%
    mutate(label = str_replace_all(label, " ", "_")) %>%
    unite(label, label, measure, sep = "_") %>%
    unite(label, name, label, sep = "_") %>%
    spread(key = label, value = values) %>%
    rename("geoid" = GEOID,
           geography_name = "NAME") %>%
    select_if(~sum(!is.na(.)) > 0)
  
  
  return(final)
  
}

# VARIABLE CODES =================================================

#variable codes for poverty rate by race (manual lookup & test)
pov_race_codes<-c("S1701_C03_013",
                  "S1701_C03_014",
                  "S1701_C03_015", 
                  "S1701_C03_016", 
                  "S1701_C03_017",
                  "S1701_C03_018", 
                  "S1701_C03_019", 
                  "S1701_C03_020",
                  "S1701_C03_021")

#variable codes for educational attainment by race (manual lookup & test)
ed_race_codes<-c("S1501_C02_028",
                 "S1501_C02_029",
                 "S1501_C02_030", 
                 "S1501_C02_031",
                 "S1501_C02_032", 
                 "S1501_C02_033", 
                 "S1501_C02_034", 
                 "S1501_C02_035", 
                 "S1501_C02_036", 
                 "S1501_C02_037", 
                 "S1501_C02_038", 
                 "S1501_C02_039", 
                 "S1501_C02_040", 
                 "S1501_C02_041", 
                 "S1501_C02_042", 
                 "S1501_C02_043", 
                 "S1501_C02_044", 
                 "S1501_C02_045", 
                 "S1501_C02_046", 
                 "S1501_C02_047", 
                 "S1501_C02_048",
                 "S1501_C02_049", 
                 "S1501_C02_050", 
                 "S1501_C02_051", 
                 "S1501_C02_052", 
                 "S1501_C02_053", 
                 "S1501_C02_054") 


# for a less hard-coded way to find variable codes...(double)
pov_race_codes_soft<-load_variables(2017,"acs1/subject", cache = "TRUE") %>%
  filter(grepl("S1701_C03", name)) %>%
  filter(grepl("HISPANIC", label) | grepl("Hispanic", label))

#pov_race_codes_soft$name == pov_race_codes


ed_race_codes_soft<-load_variables(2017,"acs1/subject", cache = "TRUE") %>%
  filter(grepl("S1501_C02", name)) %>%
  filter(grepl("alone", label) | grepl("Hispanic", label))

#ed_race_codes_soft$name == ed_race_codes #difference caused by empty columns ending in 49,40,51




# RUN =================================================

county_pov1 <- clean_acs("county", pov_race_codes, 2017, 1)
county_pov5 <- clean_acs("county", pov_race_codes, 2017, 5)
county_edu1 <- clean_acs("county", ed_race_codes, 2017, 1)
county_edu5 <- clean_acs("county", ed_race_codes, 2017, 5)


