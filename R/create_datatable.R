# market assessment data appendix 
library(openxlsx)

# LOAD ===============
source("R/pip.R")

# change target metro and peers here 
target_cbsa <- "47900"

peer_cbsa <- c("boston", "san fran","seattle", 
               "New York", "Austin-Round","Atlanta",
               "Philadelphia-C", "Los Angeles", "Raleigh", "Durham") %>% 
  map_dfr(metro.data::find_cbsa_code) %>% 
  pull(cbsa_code)

# get counties
target_co <- (metro.data::county_cbsa_st %>%
                filter(cbsa_code == target_cbsa) )[["stco_code"]]

peer_co <- (metro.data::county_cbsa_st %>%
              filter(cbsa_code %in% peer_cbsa) )[["stco_code"]]

# filter datasets
cbsa_output <- cbsa_all %>%
  filter(cbsa_code %in% c(target_cbsa, peer_cbsa)) %>%
  left_join(metro.data::county_cbsa_st[c("cbsa_code", "cbsa_emp")], by = "cbsa_code") %>%
  unique()

# 1. Dynamism =======

# Innovation -------
# R&D per 1,000 workers--metro and peers 
# Annual average R&D expenditure at higher education institutions per 1000 workers, 2012 - 2016
# Number of start-ups launched at universities, 2006 - 2017
cbsa_innovation <- cbsa_output %>%
  mutate(`University R&D per 1000 workers` = rd_total/cbsa_emp * 1000/5,
         `Businesses R&D per 1000 workers` = biz_rd/cbsa_emp * 1000) %>% 
  select(cbsa_code, cbsa_name, cbsa_emp, 
         contains("R&D"),
         `Total VC_Capital Invested ($ M) per 1M Residents`,
         `Total university startups` = tot_st, 
         `Inc5000 per 1M workers` = i5hgc_density) %>%
  unique()

# TODO: startups

# Annual R&D expenditure at UofL, thousand US dollar
load("univ_rd_detail/univ_rd_18.rda")

cbsa_univ_rd <- univ_rd_18 %>%
  filter(stco_code %in% target_co) %>%
  select(year, univ_name, field_broad, field_detail, total_rd)%>%
  unique()%>%
  filter(field_detail == "Total") %>%
  pivot_wider(names_from = "year", values_from = "total_rd")

# Tradable share of employment--metro and peers
# Advanced Industries 

clean_ind <- function(level, col){
  col <- enquo(col)
  
  cbp_cbsa_naics_emp %>% 
    filter(cbsa_code %in% c(peer_cbsa, target_cbsa)) %>% 
    left_join(metro.data::naics) %>%
    filter(naics_level == level) %>% 
    distinct(cbsa_code, !!col, naics_code,EMP) %>% 
    
    group_by(cbsa_code, !!col) %>% 
    summarise(emp = sum(EMP, na.rm = T)) %>% 
    mutate(pct_emp = emp/sum(emp)) 
  
}

cbsa_ai <- clean_ind(4, naics4_aitype) %>% 
  group_by(cbsa_code, is.na(naics4_aitype)) %>% 
  summarise_if(is.numeric, sum) %>% 
  filter(!`is.na(naics4_aitype)`) %>% 
  select(cbsa_code, 
         `share of employment in advanced industries` = pct_emp)

cbsa_traded <- clean_ind(6, traded) %>% 
  filter(traded == 1) %>% 
  select(cbsa_code,
         `share of employment in traded industries` = pct_emp)

cbsa_dynamism <- cbsa_traded %>% 
  left_join(cbsa_ai, by = "cbsa_code") %>% 
  left_join(cbsa_innovation, by = "cbsa_code") %>% 
  select(cbsa_code, cbsa_name, everything(), -cbsa_emp)

# 2. Talent ==========
# Prevalence of health problems--metro and peers
library(RSocrata)
token <- Sys.getenv("RSocrata_token")
cities <- paste0(gsub("\\,.+","",cbsa_output$cbsa_name_short), collapse = "','")
cityhealth <- read.socrata(paste0("https://chronicdata.cdc.gov/resource/csmm-fdhi.csv?category=Health Outcomes&$where=cityname in",
                                  "('",cities,"')"),token)

# peer comparison
cbsa_health <- cityhealth %>% 
  filter(measureid %in% c("MHLTH", "PHLTH")) %>%
  filter(geographiclevel == "City") %>%
  filter(datavaluetypeid == "AgeAdjPrv") %>%
  select(cityname, measure, data_value, year) %>%
  group_by(cityname, measure)%>%
  summarise(data_value = mean(data_value))%>%
  pivot_wider(names_from = "measure", values_from = "data_value")
  
# TODO: struggling share?

# low-wage
cbsa_worker <- cbsa_low_wage_worker %>%
  filter(cbsa_code %in% c(target_cbsa, peer_cbsa)) %>%
  filter(population %in% c("Low-wage workers","Workers"))%>%
  select(cbsa_code, cbsa_name, population, total)%>%
  pivot_wider(names_from = "population", values_from = "total") %>%
  mutate(pct_low_wage = `Low-wage workers`/`Workers`) %>% 
  select(cbsa_code, 
         `Share of workers that are low wage` = pct_low_wage)

# out of work
names <- co_oow %>%
  filter(cbsa_code %in% c(target_cbsa, peer_cbsa)) %>%
  select(cbsa_code, cbsa_name, pl_name) %>%
  unique()%>%
  group_by(cbsa_code) %>%
  summarise(cbsa_name = last(cbsa_name),
            core_counties = paste0(pl_name, collapse = ", "))

cbsa_skill <- cbsa_output %>%
  select(cbsa_code, cbsa_name, 
         `% with associate degree`=pct_edu_associate, 
         `% with bachelor degree or above`=pct_edu_baplus,
         `% jobs require high digital skills` = cbsa_pct_high_16,
         `employment-to-population ratio`= epratio_total)

cbsa_talent <- cbsa_skill %>% 
  left_join(cbsa_worker %>% mutate(cbsa_code = as.character(cbsa_code)),
            by = "cbsa_code")

# 3. ACCESS ========

tract_health <- cityhealth %>%
  filter(measureid %in% c("MHLTH", "PHLTH")) %>%
  filter(geographiclevel == "Census Tract") %>%
  mutate(stcotr_code = str_pad(tractfips, 11, "left","0"),
         stco_code = str_sub(stcotr_code, 1,5))%>%
  filter(stco_code %in% target_co) %>% 
  select(year, stco_code, stcotr_code, measureid, data_value) %>%
  pivot_wider(names_from = "measureid", values_from = "data_value")

tract_school <- final %>%
  mutate(stco_code = str_sub(fips,1,5)) %>%
  filter(stco_code %in% target_co) %>%
  mutate(stcotr_code = str_sub(fips, 1,11)) %>%
  group_by(stcotr_code) %>%
  summarise(pct_pass = sum(ALL_TOTAL_passed_H)/sum(ALL_TOTAL_total))

# Number of jobs reachable by 30 minutes auto and 30 minutes transit
cbsa_access <- cbsa_output %>% 
  select(cbsa_code, cbsa_name,
         `jobs reachable by 30 minutes auto` = auto_30, 
         `jobs reachable by 30 minutes transit` = transit_30, 
         `auto-transit ratio of jobs reachable by 30 minutes` = ratio_30,
        `Average housing price-income ratio`  = pi, 
        `Median rental price-income ratio` = `Med rent/med inc`
         )

# 4. Metro monitor ------
cbsa_metromonitor <- cbsa_metromonitor_2020 %>% 
  filter(cbsa_code %in% c(peer_cbsa, target_cbsa)) %>% 
  filter(year == 2018)

# SAVE =========
result <- list(
  outcome = cbsa_metromonitor,
  dynamism = cbsa_dynamism,
  talent = cbsa_talent,
  access = cbsa_access
)

readme <- result %>% 
  map(names) %>% 
  map(as_tibble) %>% 
  # map(function(x)mutate(x,category = names(x))) %>% 
  bind_rows() %>% 
  unique()
  
write.xlsx(c(README = readme, result), file = paste0("R/result/market assessment_",target_cbsa,".xlsx"))
