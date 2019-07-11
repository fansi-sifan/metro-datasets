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


# FUNCTION: CLEAN_ACS ==============================================

# unlike tidycensus's get_acs, clean_acs assigns meaningful variable names

# first argument = geography
# second argument = variable codes
# third argument = endyear of survey (yyyy)
# fourth argument = number of years survey spans (either 1, 3, or 5)

key <- Sys.getenv("CENSUS_API_KEY")

clean_acs <- function(geography, variables, year, span, key) {
  
  geogr_name <- paste0(enquo(geography),"_name")

  # pull data with get acs
  df <- get_acs(
    geography = geography,
    variables = variables,
    cache_table = TRUE,
    year = year,
    key = key,
    survey = paste0("acs", span)
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
  output <- varkey %>%
    filter(name %in% df$variable) %>%
    left_join(df, by = c("name" = "variable")) %>%
    select(-concept) %>%
    gather(key = "measure", value = "values", estimate, moe) %>%
    mutate(label = tolower(str_replace_all(label, "[[:punct:]]", " "))) %>%
    mutate(label = str_remove(label, "estimate")) %>%
    mutate(label = str_replace_all(label, " ", "_")) %>%
    unite(label, label, measure, sep = "_") %>%
    unite(label, name, label, sep = "_") %>%
    spread(key = label, value = values) %>%
    rename(stco_code = GEOID,
           stco_name = NAME) %>%
    select_if(~sum(!is.na(.)) > 0)
  
  
  return(output)
  
}

# VARIABLE CODES =================================================

#variable codes for poverty rate by race (manual lookup & test)
pov_race_codes<-purrr::map_chr(seq(13,21),function(x)paste0("S1701_C03_0",x)) 

#variable codes for educational attainment by race (manual lookup & test)
ed_race_codes<-purrr::map_chr(seq(28,54),function(x)paste0("S1501_C02_0",x))


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


