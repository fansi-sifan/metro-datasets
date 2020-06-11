# get ABS data
library(tidyverse)
library(censusapi)

us_abs_naics6 <- getCensus(name = "abscs",
                            vintage = 2017,
                            vars = c("GEO_ID","NAICS2017", "NAICS2017_LABEL",
                                     "EMPSZFI","EMPSZFI_LABEL",
                                     "SEX", "SEX_LABEL","ETH_GROUP", "ETH_GROUP_LABEL","RACE_GROUP", "RACE_GROUP_LABEL","VET_GROUP","VET_GROUP_LABEL",
                                     "FIRMPDEMP","RCPPDEMP", "EMP", "PAYANN"),
                            region = "us:*",
                            key = Sys.getenv("CENSUS_API_KEY"))

save(us_abs_naics6, file = "census/census_abs/us_abs_naics6.rda")

stco_abs_naics <- getCensus(name = "abscs",
          vintage = 2017,
          vars = c("GEO_ID","NAICS2017", "NAICS2017_LABEL",
                   "SEX", "SEX_LABEL","ETH_GROUP", "ETH_GROUP_LABEL","RACE_GROUP", "RACE_GROUP_LABEL","VET_GROUP","VET_GROUP_LABEL",
                   "FIRMPDEMP","RCPPDEMP", "EMP", "PAYANN"),
          region = "county:*",
          key = Sys.getenv("CENSUS_API_KEY"))

stco_abs_naics  <- stco_abs_naics  %>%
  mutate(stco_code = str_sub(GEO_ID, -5,-1))
save(stco_abs_naics, file = "census/census_abs/stco_naics_ownership.rda")


cbsa_abs_naics <- getCensus(name = "abscs",
                vintage = 2017,
                vars = c("GEO_ID","NAICS2017", "NAICS2017_LABEL",
                         "EMPSZFI","EMPSZFI_LABEL","YIBSZFI","YIBSZFI_LABEL","RCPSZFI","RCPSZFI_LABEL",
                         "SEX", "SEX_LABEL","ETH_GROUP", "ETH_GROUP_LABEL","RACE_GROUP", "RACE_GROUP_LABEL","VET_GROUP","VET_GROUP_LABEL",
                         "FIRMPDEMP","RCPPDEMP", "EMP", "PAYANN"),
                region = "metropolitan statistical area/micropolitan statistical area:*",
                key = Sys.getenv("CENSUS_API_KEY"))


cbsa_abs_naics <- cbsa_abs_naics %>%
  mutate(cbsa_code = str_sub(GEO_ID, -5,-1))

save(cbsa_abs_naics, file = "census/census_abs/cbsa_naics_ownership.rda")

# SANDBOX ----


# abs_by_fsize <- function(df)df %>% 
#   mutate(firm_size = case_when(
#     EMPSZFI %in% c("612","620","630", "641", "642","651") ~ "1 - 250 employees",
#     EMPSZFI == "001" ~ "All firms",
#     EMPSZFI == "611" ~ "no employees",
#     EMPSZFI %in% c("652", "654", "656","657","661","671","672","680") ~ "> 250 employees"
#   )) %>% 
#   mutate(firmdemp = as.numeric(FIRMPDEMP)) %>% 
#   group_by(firm_size, naics2_code, SEX, ETH_GROUP, RACE_GROUP, cbsa_code) %>% 
#   summarise(firmdemp = sum(firmdemp)) 


us_naics_demo_17 <- us_abs_naics6 %>%
  filter(VET_GROUP %in% c("096","001")) %>% 
  
  mutate(demo = gsub("Total|Classifiabl", "", paste0(SEX_LABEL, ETH_GROUP_LABEL, RACE_GROUP_LABEL))) %>%
  mutate(demo = ifelse(demo == "", "Total", demo)) %>%
  mutate(demo = ifelse(demo == "eee", "Classifiable", demo)) %>% 
  
  # mutate(FIRMPDEMP = ifelse(FIRMPDEMP == "0", NA, as.numeric(FIRMPDEMP))) %>% 
  mutate(FIRMPDEMP = as.numeric(FIRMPDEMP)) %>% 
  
  select(-SEX, -SEX_LABEL, -ETH_GROUP, -ETH_GROUP_LABEL, -RACE_GROUP, -RACE_GROUP_LABEL, -VET_GROUP, -VET_GROUP_LABEL,
         -RCPPDEMP, -EMP, -PAYANN) %>% 
  pivot_wider(names_from = "demo", values_from = "FIRMPDEMP") %>% 
  mutate(total = Classifiable) %>%
  select(
    naics6_code = NAICS2017, 
    emp_size = EMPSZFI_LABEL,
    total, 
    male = Male, 
    black = `Black or African American`,
    nonminority = Nonminority
  )  %>% 
  mutate(naics_level = ifelse(grepl("-",naics6_code),2,
                              str_length(naics6_code))) 

save(us_naics_demo_17, file = "../metro-datasets/census/census_abs/us_naics_demo_17.rda")


# Birmingham ====

place_abs_naics <- getCensus(name = "abscs",
                             vintage = 2017,
                             vars = c("GEO_ID",
                                      "SEX", "SEX_LABEL","ETH_GROUP", "ETH_GROUP_LABEL","RACE_GROUP", "RACE_GROUP_LABEL","VET_GROUP","VET_GROUP_LABEL",
                                      "FIRMPDEMP","RCPPDEMP", "EMP", "PAYANN"),
                             region = "place:07000",
                             regionin = "state:01",
                             key = Sys.getenv("CENSUS_API_KEY"))

# place + county + metro comparison
place_abs_naics %>% 
  select(contains("_LABEL"),FIRMPDEMP, RCPPDEMP,EMP, PAYANN) %>% 
  left_join(stco_abs_naics %>% 
              filter(NAICS2017 == "00") %>% 
              filter(stco_code == "01073") %>% 
              select(stco_code, contains("LABEL"),FIRMPDEMP, RCPPDEMP,EMP, PAYANN) , 
            by = c("SEX_LABEL","ETH_GROUP_LABEL","RACE_GROUP_LABEL","VET_GROUP_LABEL")) %>% 
  left_join(cbsa_abs_fsize_naics %>% 
              filter(cbsa_code == "13820") %>% 
              filter(EMPSZFI == "001") %>% 
              filter(NAICS2017 == "00") %>% 
              select(cbsa_code, contains("LABEL"),FIRMPDEMP, RCPPDEMP,EMP, PAYANN) , 
            by = c("SEX_LABEL","ETH_GROUP_LABEL","RACE_GROUP_LABEL","VET_GROUP_LABEL")) %>% 
  select(-contains("NAICS")) %>% 
  # view()
  write.csv("../abs_birmingham.csv")

# get metro level details
library(rlang)

get_cbsa_details <- function(code, col, cond){
  col = ensym(col)
  cond = enquo(cond)
  cond_val = eval_tidy(cond,cbsa_abs_naics)
  
  cbsa_abs_naics %>% 
    rename(category:=!!col) %>%
    select(cbsa_code, NAICS2017, category, SEX_LABEL, RACE_GROUP_LABEL, ETH_GROUP_LABEL, VET_GROUP_LABEL, FIRMPDEMP, RCPPDEMP, EMP, PAYANN) %>% 
    filter(cond_val) %>%
    filter(cbsa_code == code) 
}

# cuts by firm emp size, age, and receipt size
bind_rows(
  get_cbsa_details("13820", EMPSZFI_LABEL,RACE_GROUP_LABEL == "Black or African American"),
  get_cbsa_details("13820", YIBSZFI_LABEL,RACE_GROUP_LABEL == "Black or African American"),
  get_cbsa_details("13820", RCPSZFI_LABEL,RACE_GROUP_LABEL == "Black or African American"),
  
) %>% 
  unique()%>% 
  arrange(NAICS2017) %>% 
  # filter(!(EMPSZFI == "001" & NAICS2017 != "00")) %>%
  view()

get_cbsa_details("13820", EMPSZFI_LABEL,RACE_GROUP_LABEL == "Asian")

get_cbsa_details("13820", EMPSZFI_LABEL,SEX_LABEL == "Female")
