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

clean_naics_demo <- function(df)df %>% 
  filter(VET_GROUP %in% c("096","001")) %>% 
  
  mutate(demo = gsub("Total|Classifiabl", "", paste0(SEX_LABEL, ETH_GROUP_LABEL, RACE_GROUP_LABEL, VET_GROUP_LABEL))) %>%
  mutate(demo = ifelse(demo == "", "Total", demo)) %>%
  mutate(demo = ifelse(demo == "eeee", "Classifiable", demo)) %>% 
  
  mutate_at(vars(FIRMPDEMP:PAYANN), as.numeric) %>% 

  select(-SEX, -SEX_LABEL, -ETH_GROUP, -ETH_GROUP_LABEL, -RACE_GROUP, -RACE_GROUP_LABEL, -VET_GROUP, -VET_GROUP_LABEL) %>% 
  pivot_longer(FIRMPDEMP:PAYANN) %>% 
  pivot_wider(names_from = "demo", values_from = "value") %>% 
  mutate(total = Classifiable) %>%
  select(
    GEO_ID,
    naics6_code = NAICS2017, 
    NAICS2017_LABEL,
    EMPSZFI,
    EMPSZFI_LABEL,
    name,
    total, 
    male = Male, 
    black = `Black or African American`,
    black_male = `MaleBlack or African American`,
    hispanic = Hispanic,
    asian = Asian,
    nonminority = Nonminority,
    male_nonminority = MaleNonminority
  )  %>% 
  mutate(naics_level = ifelse(grepl("-",naics6_code),2,
                              str_length(naics6_code))) 

us_naics_demo_17 <- us_abs_naics6 %>% 
  clean_naics_demo()

cbsa_naics_demo_17 <- cbsa_abs_naics %>% 
  clean_naics_demo()

save(cbsa_naics_demo_17, file = "census/census_abs/cbsa_naics_demo_17.rda")
save(us_naics_demo_17, file = "../metro-datasets/census/census_abs/us_naics_demo_17.rda")

us_naics_demo_17 %>% 
  filter(name == "FIRMPDEMP") %>% 
  mutate(fsize = case_when(
    EMPSZFI == "001" ~ "all",
    EMPSZFI == "611" ~ "no employees",
    EMPSZFI %in% c("612","620") ~ "1 - 9",
    EMPSZFI %in% c("630", "641", "642") ~ "10 - 99",
    EMPSZFI %in% c("651", "652", "657") ~ "100 +"
  )) %>% 
  mutate(count = 1) %>% 
  group_by(naics6_code,naics_level,NAICS2017_LABEL,fsize) %>% 
  summarise_if(is.numeric, sum) %>% 
  mutate(pct_female = 1-male/total,
         pct_black = black/total,
         pct_minority = 1-nonminority/total, 
         pct_female_minority = 1-male_nonminority/total) %>% 
  filter(fsize == "10 - 99") %>% 
  view()
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
  get_cbsa_details(target_cbsa, EMPSZFI_LABEL,RACE_GROUP_LABEL == "Black or African American"),
  get_cbsa_details(target_cbsa, YIBSZFI_LABEL,RACE_GROUP_LABEL == "Black or African American"),
  get_cbsa_details(target_cbsa, RCPSZFI_LABEL,RACE_GROUP_LABEL == "Black or African American"),
  
) %>% 
  unique()%>% 
  arrange(NAICS2017) %>% 
  # filter(!(EMPSZFI == "001" & NAICS2017 != "00")) %>%
  # view()
  write_csv(paste0("../abs_cbsa_",city_name,".csv"))

get_cbsa_details(target_cbsa, EMPSZFI_LABEL,RACE_GROUP_LABEL == "Asian")

get_cbsa_details(target_cbsa, EMPSZFI_LABEL,SEX_LABEL == "Female")


load("census/census_sbo/us_naics_demo_12.rda")

df <- us_naics_demo_17 %>%
  filter(EMPSZFI == "001") %>% 
  filter(naics_level == 2) %>% 
  select(-contains("EMPSZFI")) %>% 
  mutate(year = 2018) %>% 
  bind_rows(us_naics_demo_12 %>% 
              filter(naics_level == 2) %>% 
              mutate(year = 2012) %>% 
              rename(NAICS2017_LABEL = NAICS2012_TTL)) %>% 
  mutate(pct_female = 1-male/total,
         pct_black = black/total,
         pct_minority = 1-nonminority/total) %>% 
  arrange(naics6_code) 


df %>% 
  filter(naics6_code != "99") %>% 
  ggplot(aes(x = year, y = pct_black, color = naics6_code, group = naics6_code))+
  geom_line()+
  theme_classic()
