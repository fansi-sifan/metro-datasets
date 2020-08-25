# get nonemployer ststs

library(censusapi)
library(tidyverse)

nes_var <- c("NESTAB")

stco_nes <- getCensus(
  
  name = "nonemp",
  vintage = 2018,
  vars = nes_var,
  region = "county:*",
  key = Sys.getenv("CENSUS_API_KEY")
)

stco_nes %>% 
  mutate(nestab = as.numeric(NESTAB),
         stco_code = paste0(state,county)) %>% 
  # skimr::skim() %>%
  left_join(metro.data::county_cbsa_st_18) %>% 
  group_by(co_type) %>% 
  summarise_if(is.numeric,sum, na.rm = T) %>% 
  mutate(pct_nes = nestab/co_emp) %>% 
  select(co_type, pct_nes)
