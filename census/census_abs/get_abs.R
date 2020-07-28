# get ABS data
library(tidyverse)
library(censusapi)

# install metro.data R package from remote GitHub
# devtools::install_github("BrookingsInstitution/metro-data-warehouse")

# define API endpoints ============
var_base <- c("GEO_ID", "NAICS2017", "NAICS2017_LABEL", "FIRMPDEMP", "RCPPDEMP", "EMP", "PAYANN")
var_firm <- c("EMPSZFI", "EMPSZFI_LABEL", "YIBSZFI", "YIBSZFI_LABEL", "RCPSZFI", "RCPSZFI_LABEL")
var_owner <- c("SEX", "SEX_LABEL", "ETH_GROUP", "ETH_GROUP_LABEL", "RACE_GROUP", "RACE_GROUP_LABEL", "VET_GROUP", "VET_GROUP_LABEL")

abs_var <- c(var_base, var_firm, var_owner)

# fetch raw ============
# company summary  * NAICS all level * all
# US total --------------------
us_abs_naics6 <- getCensus(

# note: censusapi::getCensus has an known issue that coerce NAICS2017 LABELS to numeric variables. see the bug report here: 
# https://github.com/hrecht/censusapi/pull/65/files
  
  name = "abscs",
  vintage = 2017,
  vars = abs_var,
  region = "us:*",
  key = Sys.getenv("CENSUS_API_KEY")
)

save(us_abs_naics6, file = "census/census_abs/us_abs_naics6.rda")

# county --------------------
# stco_abs_naics <- getCensus(name = "abscs",
#           vintage = 2017,
#           vars = c(var_base, var_owner),
#           region = "county:*",
#           key = Sys.getenv("CENSUS_API_KEY"))
#
# stco_abs_naics  <- stco_abs_naics  %>%
#   mutate(stco_code = str_sub(GEO_ID, -5,-1))
#
# save(stco_abs_naics, file = "census/census_abs/stco_naics_ownership.rda")

# metro --------------------
cbsa_abs_naics <- getCensus(
  name = "abscs",
  vintage = 2017,
  vars = abs_var,
  region = "metropolitan statistical area/micropolitan statistical area:*",
  key = Sys.getenv("CENSUS_API_KEY")
)

save(cbsa_abs_naics, file = "census/census_abs/cbsa_naics_ownership.rda")


# clean ========================

# summarise by firm size
abs_sum_fsize <- function(df) {
  df %>%
    mutate(firm_size = case_when(
      EMPSZFI %in% c("612", "620", "630", "641", "642", "651") ~ "1 - 250 employees",
      EMPSZFI == "001" ~ "All firms",
      EMPSZFI == "611" ~ "no employees",
      EMPSZFI %in% c("652", "654", "656", "657", "661", "671", "672", "680") ~ "> 250 employees"
    )) 
}

# TODO: summarise by firm age and receipt size

# test
us_abs_naics6 %>% 
  abs_sum_fsize() %>% 
  count(firm_size)

# drop vet, combine demographic categories (sex + race + ethnicity), only keep minorities 

clean_naics_demo <- function(df, ...) {
  df %>%
    filter(VET_GROUP %in% c("096", "001")) %>%
    mutate(demo = gsub("Total|Classifiabl", "", paste0(SEX_LABEL, ETH_GROUP_LABEL, RACE_GROUP_LABEL, VET_GROUP_LABEL))) %>%
    mutate(demo = ifelse(demo == "", "Total", demo)) %>%
    mutate(demo = ifelse(demo == "eeee", "Classifiable", demo)) %>%
    
    mutate_at(vars(FIRMPDEMP:PAYANN), as.numeric) %>%
    select(-SEX, -SEX_LABEL, -ETH_GROUP, -ETH_GROUP_LABEL, -RACE_GROUP, -RACE_GROUP_LABEL, -VET_GROUP, -VET_GROUP_LABEL) %>%
    pivot_longer(FIRMPDEMP:PAYANN) %>%
    pivot_wider(names_from = "demo", values_from = "value") %>%
    mutate(total = Classifiable) %>%
    
    select(
      ...,
      naics6_code = NAICS2017,
      NAICS2017_LABEL,
      EMPSZFI,
      EMPSZFI_LABEL,
      YIBSZFI,
      YIBSZFI_LABEL,
      RCPSZFI,
      RCPSZFI_LABEL,
      name,
      total,
      male = Male,
      black = `Black or African American`,
      black_male = `MaleBlack or African American`,
      hispanic = Hispanic,
      asian = Asian,
      nonminority = Nonminority,
      male_nonminority = MaleNonminority
    ) %>%
    mutate(naics_level = ifelse(grepl("-", naics6_code), 2,
      str_length(naics6_code)
    ))
}

# test
us_naics_demo_17 <- us_abs_naics6 %>%
  clean_naics_demo()

cbsa_naics_demo_17 <- cbsa_abs_naics %>%
  clean_naics_demo(cbsa_code)

save(cbsa_naics_demo_17, file = "census/census_abs/cbsa_naics_demo_17.rda")
save(us_naics_demo_17, file = "../metro-datasets/census/census_abs/us_naics_demo_17.rda")


# get metro level details -----
library(rlang)
#' get metro level abs details by specificied conditions
#' 
#' @param code cbsa code
#' @param col firm characteristics EMPSZFI, YIBSZFI, RCPSZFI
#' @param cond filter condition, SEX, RACE, ETHINICITY, VET

get_cbsa_details <- function(code, col, cond) {
  col <- ensym(col)
  cond <- enquo(cond)
  cond_val <- eval_tidy(cond, cbsa_abs_naics)

  cbsa_abs_naics %>%
    rename(category := !!col) %>%
    select(cbsa_code, NAICS2017, category, SEX_LABEL, RACE_GROUP_LABEL, ETH_GROUP_LABEL, VET_GROUP_LABEL, FIRMPDEMP, RCPPDEMP, EMP, PAYANN) %>%
    filter(cond_val) %>%
    filter(cbsa_code == code)
}

# cuts by firm emp size, age, and receipt size for Birmingham
target_cbsa <- "13820"
city_name <- "Birmingham"

bind_rows(
  get_cbsa_details(target_cbsa, EMPSZFI_LABEL, RACE_GROUP_LABEL == "Black or African American"),
  get_cbsa_details(target_cbsa, YIBSZFI_LABEL, RACE_GROUP_LABEL == "Black or African American"),
  get_cbsa_details(target_cbsa, RCPSZFI_LABEL, RACE_GROUP_LABEL == "Black or African American"),
) %>%
  unique() %>%
  arrange(NAICS2017) %>%
  # filter(!(EMPSZFI == "001" & NAICS2017 != "00")) %>%
  # view()
  write_csv(paste0("../abs_cbsa_", city_name, ".csv"))

get_cbsa_details(target_cbsa, EMPSZFI_LABEL, RACE_GROUP_LABEL == "Asian")
get_cbsa_details(target_cbsa, EMPSZFI_LABEL, SEX_LABEL == "Female")


# USE CASE ==========================

# 1. metro level, industry total, firms with direct employees, all firm size and age, 
cbsa_naics_demo_17 %>%
  filter(naics6_code == "00") %>%
  filter(name == "FIRMPDEMP") %>%
  filter(EMPSZFI == "001" & YIBSZFI == "001" & RCPSZFI == "001") %>%
  # mutate(cbsa_code = str_sub(GEO_ID,-5,-1)) %>%
  left_join(metro.data::cbsa) %>%
  filter(cbsa_size != "micro") %>%
  select(contains("cbsa_"), total:male_nonminority) %>%
  write.csv("census/census_abs/cbsa_demo_17.csv")

# 2. national level, share of firms with 0 employees by industry
us_naics_demo_17 %>%
  filter(emp_size %in% c("All firms", "Firms with no employees")) %>%
  filter(naics_level == 2) %>%
  pivot_longer(total:nonminority) %>%
  pivot_wider(names_from = "emp_size", values_from = value) %>%
  mutate(pct = `Firms with no employees` / `All firms`) %>%
  left_join(metro.data::naics[c("naics_code", "naics_name")], by = c("naics6_code" = "naics_code")) %>%
  write.csv("employer_0EMP.csv")
