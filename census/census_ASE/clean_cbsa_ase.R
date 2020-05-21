library(tidyverse)
load("ASE/cbsa_ase.rda")
# analysis
target_cbsa <- "19740"
peer_cbsa <- c("12420", "33460", "38060", "38900", "41740", "41620", "42660")
young_firms <- c("311", "321", "322")
traded_code <- c("31-33", "51", "52", "54")
race_code <- c("96", "30", "40")

# young firm ownership gap, overall
cbsa_ase %>%
  filter(naics2_code == "00" & VET_GROUP.id  == "001" & SEX.id == "001" & ETH_GROUP.id == "001") %>%
  filter(RACE_GROUP.id == "00") %>%
  # filter(RACE_GROUP.id %in% c("40","00")) %>%
  mutate(firm_age = case_when(
    YIBSZFI.id %in% young_firms ~ "young",
    YIBSZFI.id %in% c("323", "318", "319") ~ "mature", 
    YIBSZFI.id == "001" ~ "total"
  )) %>%
  group_by(cbsa_code, cbsa_name, firm_age, `RACE_GROUP.display-label`) %>%
  summarise(n_firms = sum(FIRMPDEMP, na.rm = T))%>%
  pivot_wider(names_from = "firm_age", values_from = "n_firms") %>%
  mutate(pct_young = young/total) %>%
  filter(cbsa_code %in% c(target_cbsa, peer_cbsa)) %>%
  ungroup() %>%
  mutate(gap = (max(pct_young) - pct_young)*total,
         gap_avg = (mean(pct_young) - pct_young)*total) %>%
  left_join(metro.data::cbsa_st[c("cbsa_code", "cbsa_emp")]) %>%
  mutate(pct_startup = young/cbsa_emp) %>% 
  View()

# young firms by race
cbsa_ase %>%
  filter(naics2_code == "00" & VET_GROUP.id  == "001" & SEX.id == "001" & ETH_GROUP.id == "001") %>%
  # filter(YIBSZFI.id == "311") %>%
  filter(YIBSZFI.id %in% young_firms) %>%
  group_by(cbsa_code, cbsa_name, `RACE_GROUP.display-label`) %>%
  summarise(n_firms = sum(FIRMPDEMP))%>%
  pivot_wider(names_from = "RACE_GROUP.display-label", values_from = "n_firms") %>%
  filter(as.character(cbsa_code) %in% c(target_cbsa, peer_cbsa)) %>%
  View()

# average size of young firms by race
cbsa_ase %>% 
  filter(cbsa_code == target_cbsa) %>%
  filter(naics2_code == "00" & VET_GROUP.id  == "001" & SEX.id == "001" & ETH_GROUP.id == "001") %>%
  filter(YIBSZFI.id == young_firms) %>%
  mutate(size = EMP/FIRMPDEMP) %>%
  select(`RACE_GROUP.display-label`, size) 
