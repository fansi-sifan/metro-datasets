# get ABS data
library(tidyverse)
library(censusapi)

us_abs_naics6 <- getCensus(name = "abscs",
                            vintage = 2017,
                            vars = c("GEO_ID","NAICS2017", "NAICS2017_LABEL",
                                     # "EMPSZFI","EMPSZFI_LABEL",
                                     "SEX", "SEX_LABEL","ETH_GROUP", "ETH_GROUP_LABEL","RACE_GROUP", "RACE_GROUP_LABEL",
                                     "FIRMPDEMP","RCPPDEMP", "EMP", "PAYANN"),
                            region = "us:*",
                            key = Sys.getenv("CENSUS_API_KEY"))

stco_abs_naics <- getCensus(name = "abscs",
          vintage = 2017,
          vars = c("GEO_ID","NAICS2017", "NAICS2017_LABEL","EMPSZFI","EMPSZFI_LABEL",
                   "SEX", "SEX_LABEL","ETH_GROUP", "ETH_GROUP_LABEL","RACE_GROUP", "RACE_GROUP_LABEL",
                   "FIRMPDEMP","RCPPDEMP", "EMP", "PAYANN"),
          region = "county:*",
          key = Sys.getenv("CENSUS_API_KEY"))

# stco_naics_ownership <- df %>% 
#   mutate(stco_code = str_sub(GEO_ID, -5,-1),
#          naics2_code = str_pad(NAICS2017,2,"left","0")) 

cbsa_abs_fsize_naics <- getCensus(name = "abscs",
                vintage = 2017,
                vars = c("GEO_ID","NAICS2017", "NAICS2017_LABEL","EMPSZFI","EMPSZFI_LABEL",
                         "SEX", "SEX_LABEL","ETH_GROUP", "ETH_GROUP_LABEL","RACE_GROUP", "RACE_GROUP_LABEL",
                         "FIRMPDEMP","RCPPDEMP", "EMP", "PAYANN"),
                region = "metropolitan statistical area/micropolitan statistical area:*",
                key = Sys.getenv("CENSUS_API_KEY"))


# cbsa_fsize_naics_ownership <- cbsa_fsize_ownership %>% 
#   mutate(cbsa_code = str_sub(GEO_ID, -5,-1),
#          naics2_code = str_pad(NAICS2017,2,"left","0")) 
save(us_abs_naics6, file = "census/census_abs/us_abs_naics6.rda")
save(stco_abs_naics, file = "census/census_abs/stco_naics_ownership.rda")
save(cbsa_abs_fsize_naics, file = "census/census_abs/cbsa_naics_ownership.rda")

abs_by_fsize <- function(df)df %>% 
  mutate(firm_size = case_when(
    EMPSZFI %in% c("612","620","630", "641", "642","651") ~ "1 - 250 employees",
    EMPSZFI == "001" ~ "All firms",
    EMPSZFI == "611" ~ "no employees",
    EMPSZFI %in% c("652", "654", "656","657","661","671","672","680") ~ "> 250 employees"
  )) %>% 
  mutate(firmdemp = as.numeric(FIRMPDEMP)) %>% 
  group_by(firm_size, naics2_code, SEX, ETH_GROUP, RACE_GROUP, cbsa_code) %>% 
  summarise(firmdemp = sum(firmdemp)) 
