library(tidyverse)

key = Sys.getenv("CENSUS_API_KEY")

cbsa

get_qwi <- function(st_code)censusapi::getCensus(name = "timeseries/qwi/rh",
                 # region = "metropolitan statistical area/micropolitan statistical area:13820",
                 region = "county:*",
                 regionin = paste0("state:",st_code),
                 vars = c("Emp", "EarnS", "race"),
                 year = 2018,
                 quarter = 1,
                 ownercode = "A05", # all private
                 seasonadj = "U",
                 key = key)

qwi_stco_race <- map_dfr(metro.data::st$st_code, possibly(get_qwi, otherwise = NULL))

co_100 <- metro.data::county_cbsa_st %>% 
  filter(cbsa_is.top100) 


save(qwi_stco_race, file = "qwi_stco_race.rda")

qwi_top100 <- qwi_stco_race %>% 
  mutate(stco_code = paste0(state, county), 
         Emp = as.numeric(Emp),
         EarnS = as.numeric(EarnS)) %>% 
  right_join(co_100[c("stco_code", "cbsa_code", "cbsa_name")], by = "stco_code") %>% 
  # filter(stco_code %in% co_100$stco_code) %>% 
  pivot_wider(names_from = race, values_from = c("Emp", "EarnS")) %>% 
  group_by(cbsa_code, cbsa_name) %>% 
  summarise_if(is.numeric, sum, na.rm = T) %>% 
  mutate(earns_bw_ratio = EarnS_A2/EarnS_A1) %>% 
  ungroup() %>% 
  mutate(earns_bw_ratio_rank = dense_rank(desc(earns_bw_ratio)))

qwi_top100 %>% 
  filter(cbsa_code == "13820")
