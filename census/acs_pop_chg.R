# acs --------
library(tidycensus)
key = Sys.getenv("CENSUS_API_KEY")
geo <- "metropolitan statistical area/micropolitan statistical area"
vars <- map_chr(str_pad(seq(1, 12), 2, "left", "0"), function(x) paste0("B03002_0", x)) # total population

calculate_pop_race <- function(df) {
  df %>%
    mutate(
      pop_total = B03002_001E,
      pop_white = B03002_003E,
      pop_black = B03002_004E,
      pop_latino = B03002_012E,
      pop_asian = B03002_006E,
      pct_white = pop_white / pop_total,
      pct_black = pop_black / pop_total,
      pct_latino = pop_latino / pop_total,
      pct_asian = pop_asian / pop_total
    )
}

pop_msa_07 <- get_acs(geography = geo, variables = vars, year = 2009, key = key, output = "wide", survey = "acs5")
pop_msa_12 <- get_acs(geography = geo, variables = vars, year = 2012, key = key, output = "wide", survey = "acs1")

pop_msa_0712 <- pop_msa_12 %>%
  mutate(year = 2012) %>%
  bind_rows(pop_msa_07 %>% mutate(year = 2007)) %>%
  calculate_pop_race() %>%
  select(-NAME, -contains("B03002")) %>%
  pivot_wider(names_from = year, values_from = contains("_")) %>%
  mutate(GEOID = case_when(
    GEOID == "31100" ~ "31080",
    GEOID == "26180" ~ "46520",
    GEOID == "19380" ~ "19430",
    
    T ~ GEOID
  ))

# save(pop_msa_0712, file = "data/acs.rda")

pop_msa_17 <- get_acs(geography = geo, variables = vars, year = 2017, key = key, output = "wide", survey = "acs1") %>% 
  calculate_pop_race() %>%
  select(-NAME, -contains("B03002")) %>%
  # pivot_wider(names_from = year, values_from = contains("_")) %>%
  mutate(GEOID = case_when(
    GEOID == "31100" ~ "31080",
    GEOID == "26180" ~ "46520",
    GEOID == "19380" ~ "19430",
    
    T ~ GEOID
  )) %>% 
  filter(!is.na(pop_total))

# save(pop_msa_17, file = "data/acs_17.rda")

# adult population
vars_07 <- c("B15001_001","B15001_043",map_chr(LETTERS[1:9], function(x) paste0("C21001",x,"_001"))) # adults 18 and over
vars <- c("B21001_022",map_chr(c("",LETTERS[1:9]), function(x) paste0("B21001",x,"_001"))) # adults 18 and over

calcualte_adult_race <- function(df)df %>% 
  mutate(pop_total = B21001_001E,
         pop_black = B21001B_001E,
         pop_female = B21001_022E,
         pop_latino = B21001I_001E, 
         pop_asian = B21001D_001E, 
         pop_nonminority = B21001H_001E,
         
         pct_female = pop_female/pop_total,
         pct_minority = 1-pop_nonminority/pop_total,
         pct_black = pop_black/pop_total,
         pct_asian = pop_asian/pop_total,
         pct_latino = pop_latino/pop_total)

# geo = "county"
stco_adult_pop_17 <- tidycensus::get_acs(geography = geo, variables = vars, 
                                         year = 2017, key = Sys.getenv("CENSUS_API_KEY"), output = "wide", survey = "acs1") %>%
  calcualte_adult_race() %>% 
  select(-NAME, -contains("B03002")) %>%
  filter(!is.na(pop_total))

# 
# bham <- tidycensus::get_acs(geography = "place", variables = vars, state = "01", 
#                             year = 2017, key = Sys.getenv("CENSUS_API_KEY"), output = "wide", survey = "acs1") %>%
#   calcualte_adult_race() %>% 
#   select(-NAME, -contains("B03002")) %>%
#   filter(!is.na(pop_total))
# 
# bham %>% 
#   filter(GEOID == "0107000") %>% 
#   bind_rows(stco_adult_pop_17 %>% filter(GEOID == "01073")) %>% 
#   bind_rows(cbsa_adult_pop_17 %>% filter(GEOID == "13820")) %>% 
#   write.csv("../demo_birmingham.csv")

save(stco_adult_pop_17, file = "../metro-datasets/census/acs5_2018/stco_adult_pop_17.rda")

cbsa_adult_pop_17 <- tidycensus::get_acs(geography = geo, variables = vars, 
                                         year = 2017, key = Sys.getenv("CENSUS_API_KEY"), output = "wide", survey = "acs1") %>%
  calcualte_adult_race() %>% 
  select(-NAME, -contains("B03002")) %>%
  mutate(GEOID = case_when(
    GEOID == "31100" ~ "31080",
    GEOID == "26180" ~ "46520",
    GEOID == "19380" ~ "19430",
    
    T ~ GEOID
  )) %>% 
  filter(!is.na(pop_total))

# save(cbsa_adult_pop_17, file = "data/cbsa_adult_pop_17.rda")

# geo <- "us"
geo <- "metropolitan statistical area/micropolitan statistical area"

df <- bind_rows(
  tidycensus::get_acs(geography = geo,
                      variables = vars,
                      year = 2017,
                      key = key,
                      output = "wide",
                      survey = "acs1") %>% 
    calcualte_adult_race() %>% 
    mutate(year = 2017),
  
  tidycensus::get_acs(geography = geo,
                      variables = vars,
                      year = 2012,
                      key = key,
                      output = "wide",
                      survey = "acs1") %>% 
    calcualte_adult_race() %>% 
    mutate(year = 2012),
  
  tmp <- tidycensus::get_acs(geography = geo,
                             variables = vars_07,
                             year = 2009,
                             key = key,
                             output = "wide",
                             survey = "acs5") %>% 
    rename_all(~gsub("C21001","B21001",.)) %>% 
    rename(B21001_001E = B15001_001E,
           B21001_022E = B15001_043E) %>% 
    calcualte_adult_race() %>% 
    mutate(year = 2007)) 

cbsa_adult_pop_071217 <- df %>% 
  select(year,GEOID, contains("pop_"),contains("pct_"))

# save(us_adult_pop_071217, file = "census/us_adult_pop_071217.rda")
save(cbsa_adult_pop_071217, file = "census/cbsa_adult_pop_071217.rda")

