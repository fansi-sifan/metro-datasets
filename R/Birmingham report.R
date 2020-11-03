# bham report
library(tidyverse)
library(tidylog)
target_cbsa <- "13820"
target_name <- "Birmingham-Hoover, AL"
largest_cbsa <- metro.data::cbsa_18 %>%
  filter(cbsa_size == "very large metros") %>%
  pull(cbsa_code)

# CHARTS =========
# chart 1 data --------
load("metro_monitor_2020/metro_monitor_2020_change.rda")

youngfirm <- df_change$growth_change %>%
  filter(largest == 1) %>%
  filter(indicator == "Percent Change in Employment at firms 0-5 years old") %>%
  filter(year == "2008-2018")

chart_youngfirm <- youngfirm %>%
  mutate(hl = (cbsa == target_cbsa)) %>%
  ggplot(aes(
    x = reorder(cbsa, value),
    y = value,
    fill = hl
  )) +
  geom_col() +
  scale_fill_manual(values = c("#377eb8", "#e41a1c"), guide = F) +
  scale_y_continuous("", labels = scales::percent) +
  labs(
    title = "Percent Change in Employment at firms 0-5 years old",
    subtitle = "2008 - 2018",
    caption = "Source: Metro Monitor 2020, Brookings"
  ) +
  theme_classic() +
  theme(
    axis.text.x = element_blank(),
    axis.ticks = element_blank(),
    axis.line.x = element_blank(),
    axis.title.x = element_blank()
  )


# chart 2 data
load("opportunity industries/cbsa_oppind_race.rda")


opp_edu <- cbsa_oppind_race %>%
  filter(cbsa_code == target_cbsa) %>%
  filter(gender == "Total", age == "Total", race == "Total") %>%
  select(-gender, -age, -race) %>%
  mutate(`quality jobs` = 1 - other) %>%
  filter(str_detect(education, "degree|High"))

chart_opp_edu <- opp_edu %>%
  ggplot(aes(
    x = reorder(education, `quality jobs`),
    y = `quality jobs`
  )) +
  geom_col(fill = "#377eb8") +
  coord_flip() +
  scale_y_continuous(labels = scales::percent) +
  labs(
    x = "",
    y = "Share of jobs that are good or promising",
    title = paste0("Chance of holding a quality job in ", target_name),
    caption = "Opportunity Industries, Brookings"
  ) +
  theme_classic()

opp_race <- cbsa_oppind_race %>%
  filter(cbsa_code == target_cbsa) %>%
  filter(age == "Total", education == "All sub-baccalaureate levels") %>%
  select(-age, -education) %>%
  mutate(
    `quality jobs` = 1 - other,
    `good jobs` = good_jobs + hi_good_jobs
  ) %>%
  filter(gender != "Total", race != "Total", race != "Hispanic") %>%
  mutate(demo = paste0(race, " ", gender))

chart_opp_race <- opp_race %>%
  ggplot(aes(
    x = reorder(demo, `good jobs`),
    y = `good jobs`
  )) +
  geom_col(fill = "#377eb8") +
  coord_flip() +
  scale_y_continuous(labels = scales::percent) +
  labs(
    x = "",
    y = "Share of jobs that are good",
    title = paste0("Chance of holding a good job in ", target_name),
    subtitle = "workers without a 4-year college degree",
    caption = "Opportunity Industries, Brookings"
  ) +
  theme_classic()

# transit vs auto
load("access across america/cbsa_job_access.rda")

access <- cbsa_job_access %>%
  filter(cbsa_code == target_cbsa) %>%
  mutate(across(-contains("cbsa"), as.numeric)) %>%
  pivot_longer(-contains("cbsa")) %>%
  separate(name, c("mode", "minutes"))

ratio <- access %>%
  filter(mode == "ratio") %>%
  select(minutes, ratio = value) %>%
  left_join(access %>% filter(mode == "auto"), by = "minutes")

ggplot(
  data = access %>% filter(mode != "ratio"),
  aes(x = minutes, y = value, fill = mode)
) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c("#377eb8", "#e41a1c")) +
  geom_text(
    data = ratio,
    hjust = 1,
    vjust = -0.1,
    aes(
      x = minutes, y = value,
      label = paste0("x ", scales::number(ratio, accuracy = 1))
    )
  ) +
  scale_y_continuous("number of jobs accessible", labels = scales::number) +
  labs(
    title = paste0("Share of jobs accessible by auto and by transit in ", target_name),
    caption = "Source: Access Across America, 2018"
  ) +
  theme_classic()

load("fair_ownership/cbsa_ownership.rda")

fair_ownership <- cbsa_ownership %>%
  filter(cbsa_size == "very large metros") %>%
  mutate(hl = cbsa_code == target_cbsa)

chart_fair_ownership <- fair_ownership %>%
  ggplot(aes(
    x = reorder(cbsa_code, black),
    y = black,
    fill = hl
  )) +
  geom_col() +
  scale_fill_manual(values = c("#377eb8", "#e41a1c"), guide = F) +
  scale_y_continuous("% business ownership/% adult population",
    labels = scales::percent
  ) +
  theme_classic() +
  labs(
    x = "",
    title = "Black business ownership fair share ratio among 53 largest metro areas",
    caption = "Source: Brookings analysis of Annual Business Survey data"
  ) +
  theme(axis.text.x = element_blank())

# broadband --
load("broadband_2020/cbsa_broadband.rda")

broadband <- cbsa_broadband %>%
  filter(cbsa_code %in% largest_cbsa) %>%
  mutate(hl = cbsa_code == target_cbsa)

broadband %>%
  ggplot(aes(
    x = reorder(cbsa_code, pct_digital_poverty),
    y = pct_digital_poverty,
    fill = hl
  )) +
  geom_col() +
  scale_fill_manual(values = c("#377eb8", "#e41a1c"), guide = F) +
  scale_y_continuous("% of tracts in digital poverty",
    labels = scales::percent
  ) +
  theme_classic() +
  labs(
    x = "",
    title = "Share of tracts in digital poverty among 53 largest metro areas",
    caption = "Source: Brookings analysis of ACS 2018 5-year data"
  ) +
  theme(axis.text.x = element_blank())

# GOALS ===========
peers.county <- c(
  "01073", "18097", "22033", "22071", "29095",
  "36029", "36055", "39035", "47157", "51710",
  "51760", "55079", "21111", "47037", "01089", "01073"
)

Peers <- metro.data::county_cbsa_st_18 %>% filter(stco_code %in% peers.county)

# find the nth largest value (or the smallest positive value if nth is negative)
nth_pos <- function(x, n) {
  a <- nth(x, order_by = x, n)
  ifelse(a > 0, a, min(x[which(x > 0)]))
}

# Job creation -----
# Net job creation in young firms (firms less than 5 years old)
load("metro_monitor_2020/metro_monitor_2020_allyear.rda")

# missing Nashivlle due to metro monitor data gaps
# LEVEL
youngfirm <- df_list$growth_value %>%
  filter(year %in% c(2008, 2013, 2018)) %>%
  filter(cbsa %in% Peers$cbsa_code) %>%
  pivot_wider(names_from = "indicator", values_from = "value") %>% 
  mutate(pct_young = `Employment at firms 0-5 years old`/Jobs) %>% 
  select(cbsa, year, pct_young) %>% 
  pivot_wider(names_from = "year", values_from = "pct_young") %>% 
  # negative growth for all peers from 2008 - 2013, using 2013 to 2018 instead
  mutate(value_23 = nth_pos(`2018`/`2013` * `2018`, -7),
         value_28 = nth_pos(`2018`/`2013` * `2018`, -5),
         value_33 = nth_pos(value_28 * `2018`/`2013`, -3)) %>% 
  filter(cbsa == target_cbsa)

# RATE OF CHANGE
mm_chg <- df_change$growth_change %>%
  select(cbsa, year, indicator, value) %>%
  filter(cbsa %in% Peers$cbsa_code) %>%
  filter(indicator == "Percent Change in Employment at firms 0-5 years old") %>%
  pivot_wider(names_from = "year", values_from = "value") %>%
  mutate(`2008-2013` = (1 + `2008-2018`) / (1 + `2013-2018`) - 1)

df_list$growth_value %>%
  filter(year == 2018, cbsa %in% Peers$cbsa_code, indicator == "Employment at firms 0-5 years old") %>% 
  select(cbsa, value) %>% 
  left_join(mm_chg, by = "cbsa") %>% 
  mutate(value_23 = nth_pos(`2013-2018`, -7) * value,
         value_28 = nth_pos(`2013-2018`, -5) * value, 
         value_33 = nth_pos(`2013-2018`, -3) * value) %>% 
  filter(cbsa == target_cbsa) %>% 
  select(contains("value"))

# 	Net job creation in industries rich in “secure jobs”   (wage threshold that could lift half of families with children out of economic insecurity as calculated by Brookings; $21 in Birmingham)
# 1. USE CBP for employment, QWI for demographics 
# 08, 13, 18
# 2. employment in secure wage industries (3-digit for each metro)
# qwi

# 	Share of secure jobs held by people of color and women

# 	Capital invested in Birmingham-based businesses
# FDIC? Pitchbook?
# 	Capital invested in businesses owned  by people of color and women

#Job preparation -------------
#Share of population with associate’s degree, credential, or higher
#Share of people of color with associate’s degree, credential, or higher

# ACS
# load("acs1_2019/cbsa_acs_raw.rda")
# source("census/acs_var.R")
library(tidycensus)
geo <- "metropolitan statistical area/micropolitan statistical area"
edu_race_codes <- ""

for (i in LETTERS[2:9]) {
  new <- paste0("C15002", i, "_0", str_pad(seq(1,11), 2, "left","0"),"E")
  edu_race_codes <- c(edu_race_codes, new)
}

acs_09_raw <- get_acs(geography = geo,
                                variables = edu_race_codes,
                                year = 2009, 
                                survey = "acs1",
                                key = Sys.getenv("CENSUS_API_KEY"))

calculate_edu_race <- function(df){
  tmp <- df %>% 
    separate(variable, c("race", "edu"), -4) %>% 
    select(GEOID, race, edu, estimate) %>% 
    pivot_wider(names_from = "edu", values_from = "estimate") 
  
  tmp %>% 
    group_by(GEOID) %>% 
    summarise(across(`_001`:`_011`, sum, na.rm = T)) %>% 
    mutate(race = "all") %>% 
    bind_rows(tmp %>% 
                filter(race != "C15002H") %>% 
                group_by(GEOID) %>% 
                summarise(across(`_001`:`_011`, sum, na.rm = T)) %>% 
                mutate(race = "POC")) %>% 
    mutate(pct_edu_hs = (`_004` + `_009`)/`_001`, 
           pct_edu_aa = (`_005` + `_010`)/`_001`, 
           pct_edu_baplus = (`_006` + `_011`)/`_001`, 
           pct_edu_aaplus = (`_005` + `_010` + `_006` + `_011`)/`_001`) %>% 
    select(GEOID, race, pct_edu_aaplus) %>% 
    pivot_wider(names_from = "race", values_from = "pct_edu_aaplus")
}

# aa or above

multi_year <- function(df, year){
  df %>% 
    filter(GEOID %in% Peers$cbsa_code) %>% 
    calculate_edu_race() %>% 
    mutate(year = year) 
}

race_edu <- bind_rows(
  multi_year(acs_09_raw, 2009),
  multi_year(acs_14_raw, 2014),
  multi_year(acs_19_raw, 2019)
)%>% 
  pivot_wider(names_from = "year", values_from = c("POC", "all")) %>% 
  mutate(POC_0919 = POC_2019/POC_2009,
         POC_0914 = POC_2014/POC_2009,
         all_0919 = all_2019/all_2009,
         all_0914 = all_2014/all_2009
         ) %>% 
  mutate(value_23_POC = nth_pos(POC_2019 * POC_0914, -7),
         value_28_POC = nth_pos(POC_2019 * POC_0914, -5),
         value_33_POC = nth_pos(POC_2019 * POC_0919, -3),
         value_23_all = nth_pos(all_2019 * all_0914, -7),
         value_28_all = nth_pos(all_2019 * all_0914, -5),
         value_33_all = nth_pos(all_2019 * all_0919, -3)) %>%
  filter(GEOID == target_cbsa) %>% 
  select(GEOID, contains("value_")) 
  
  
eacs_19 <- cbsa_acs %>% 
  filter(cbsa_code %in% Peers$cbsa_code) %>% 
  select(cbsa_code, cbsa_name, contains("pct_edu"))


#Share of workers with associate’s or higher in low-wage jobs 
# 2/3 median wage (BLS) + ACS earnings by education??
  
#Share of people of color and women with associates’ or higher in low-wage jobs
# earnings by education by demographics? (microdata...)
  
#Share of high school students that are college/career ready 
# CCR rate
#Share of students of color that are college/career ready

#Job access: 
# Change in employment rate between white/POC
emp_18 <- df_list$racial_inclusion_value %>% 
  filter(indicator == "Employment-to-Population Ratio") %>% 
  filter(cbsa %in% Peers$cbsa_code) %>% 
  filter(year == "2018") 

df_change$racial_inclusion_change %>% 
  filter(cbsa %in% Peers$cbsa_code) %>% 
  filter(indicator == "Percentage-Point Change in the white/POC Employment Rate Gap") %>% 
  select(cbsa, year, value) %>% 
  pivot_wider(names_from = "year", values_from = "value")

#Change in employment rate between top/bottom neighborhood 
emp_18 <- df_list$geographic_inclusion_value %>% 
    filter(indicator == "Employment Rate") %>% 
    filter(cbsa %in% Peers$cbsa_code) %>% 
    filter(year == "2014-2018") %>% 
    filter(tractlevel == "bottom") 
  
emp_chg <- df_change$geographic_inclusion_change %>% 
    filter(indicator == "Change in Top/Bottom Tract Employment Rate Gap") %>% 
    filter(cbsa %in% Peers$cbsa_code) %>% 
    select(cbsa, base = value) 

emp_18 %>% 
  left_join(emp_chg, by = "cbsa") %>%
  mutate(chg_3 = nth_pos((base * (1 + value)), -7),
         chg_5 = nth_pos((base * (1 + value)), -5),
         chg_10 = nth_pos((base * (1 + value)), -3)) %>% 
  mutate(exp_value3 = value * (1 + chg_3),
         exp_value5 = value * (1 + chg_5),
         exp_value10 = value * (1 + chg_10)) %>% 
  filter(cbsa == target_cbsa) %>% 
  select(cbsa, indicator, value, 
         exp_value3, 
         exp_value5, 
         exp_value10)

#Change in broadband subscription rate between top/bottom neighborhood
# ACS??

co_health_10 <- read_csv("https://www.countyhealthrankings.org/sites/default/files/analytic_data2010.csv", skip = 1)
co_health_15 <- read_csv("https://www.countyhealthrankings.org/sites/default/files/analytic_data2015.csv", skip = 1)


calculate_pctpoorhealth <- function(df){
  df %>%
    select(fipscode, year, contains("v002")) %>% 
    right_join(Peers, by = c("fipscode" = "stco_code")) %>% 
    group_by(cbsa_code) %>% 
    summarise(poorhealth = sum(v002_numerator),
              total = sum(v002_denominator)) %>% 
    mutate(pct_poor_health = poorhealth/total) %>% 
    select(cbsa_code, pct_poor_health)
}

health <- list(co_health_10, co_health_15) %>%
  map_dfc(calculate_pctpoorhealth)


#Change in share of residents reporting poor or fair health (county level via CDC)
# CDC timeseries? 
# Prevalence of health problems--metro and peers

library(RSocrata)
token <- Sys.getenv("RSocrata_token")
cities <- Peers$cbsa_name %>% 
  str_replace(",.+","") %>% 
  str_replace("\\/.+|-.+","")


# 2019 release of 2017 data
mental_health_17 <- read.socrata("https://chronicdata.cdc.gov/resource/i2ek-k3pa.csv?year=2017",token)
physical_health_17 <- read.socrata("https://chronicdata.cdc.gov/resource/5w59-iqre.csv?year=2017",token)

city_health_17 <- physical_health_17 %>% 
  # bind_rows(mental_health_17) %>% 
  filter(CityName %in% cities) %>% 
  filter(GeographicLevel == "City") %>% 
  filter(DataValueTypeID == "AgeAdjPrv") %>% 
  select(CityName, MeasureId, Data_Value, PopulationCount) %>%
  group_by(CityName, MeasureId) %>% 
  summarise(Data_Value = weighted.mean(Data_Value, PopulationCount)) %>% 
  pivot_wider(names_from = "MeasureId", values_from = "Data_Value")
  

# 2016 release of 2014 data
health_14 <- read.socrata(paste0("https://chronicdata.cdc.gov/resource/9z78-nsfp.csv?category=Health Outcomes&$where=cityname in",
                                  "('",paste0(cities, collapse = "','"),"')"),token)

health_17 <- read.socrata(paste0("https://chronicdata.cdc.gov/resource/6vp6-wxuq.csv?category=Health Outcomes&$where=cityname in",
                                 "('",paste0(cities, collapse = "','"),"')"),token)

city_health_14 <- health_14 %>% 
  filter(measureid == "PHLTH") %>% 
  # filter(measureid %in% c("MHLTH", "PHLTH")) %>%
  filter(geographiclevel == "City") %>%
  filter(datavaluetypeid == "AgeAdjPrv") %>% 
  select(cityname, measureid, data_value, population2010) %>%
  group_by(cityname, measureid) %>%
  summarise(data_value = weighted.mean(data_value, population2010))%>%
  pivot_wider(names_from = "measureid", values_from = "data_value")


city_health_14 %>% 
  ungroup() %>% 
  left_join(city_health_17, by = c("cityname" = "CityName"),
            suffix = c("14", "17")) %>% 
  mutate(PHLTH_CAGR = (PHLTH17/PHLTH14)^(1/3)-1) %>% 
  mutate(PHLTH_23 = nth_pos(PHLTH17 * (1 + PHLTH_CAGR)^6,7),
         PHLTH_28 = nth_pos(PHLTH17 * (1 + PHLTH_CAGR)^11,5),
         PHLTH_33 = nth_pos(PHLTH17 * (1 + PHLTH_CAGR)^16,3)) %>% 
  filter(cityname == "Birmingham")
  
# Change in share of people of color reporting poor or fair health
# majority-black neighborhood?
# get acs tract data
source("census/acs_var.R")
st <- Peers %>% distinct(st_code) %>% pull(st_code) 

# 2018 5-year tracts
acs_tract <- map_dfr(st, function(x)get_acs(geography = "tract", 
                                  variables = pop_race_codes, 
                                  year = 2018, 
                                  output = "wide",
                                  key = Sys.getenv("CENSUS_API_KEY"),
                                  state = x))

tract_nbtype <- acs_tract %>%
  mutate(stco_code = str_sub(GEOID, 1,5)) %>% 
  left_join(metro.data::county_cbsa_st_18[c("stco_code", "cbsa_code")], 
            by = "stco_code") %>% 
  filter(cbsa_code %in% Peers$cbsa_code) %>% 
  calculate_pop_race() %>% 
  mutate(nb_type = ifelse(pct_white >=0.5, "white", "majority minority")) %>% 
  select(cbsa_code, GEOID, nb_type)

# majority minority neighborhoods
clean_tract_health <- function(df){
df %>% 
  filter(measureid == "PHLTH") %>% 
  # filter(measureid %in% c("MHLTH", "PHLTH")) %>%
  filter(geographiclevel == "Census Tract") %>%
  # filter(datavaluetypeid == "AgeAdjPrv") %>% 
  mutate(GEOID = str_pad(tractfips, 11, "left", "0")) %>% 
  left_join(tract_nbtype) %>%
  filter(nb_type == "majority minority") %>% 
  select(cbsa_code, measureid, data_value, population2010) %>%
  group_by(cbsa_code, measureid) %>%
  summarise(data_value = weighted.mean(data_value, population2010, na.rm = T))%>%
  pivot_wider(names_from = "measureid", values_from = "data_value")
}

health_14 %>% 
  clean_tract_health() %>% 
  rename(PHLTH14 = PHLTH) %>% 
  left_join(health_17 %>% 
              rename(population2010 = populationcount) %>% 
              clean_tract_health() %>% 
              rename(PHLTH17 = PHLTH)) %>% 
  mutate(PHLTH_CAGR = (PHLTH17/PHLTH14)^(1/3)-1) %>% 
  mutate(PHLTH_23 = nth_pos(PHLTH17 * (1 + PHLTH_CAGR)^6,1),
         PHLTH_28 = nth_pos(PHLTH17 * (1 + PHLTH_CAGR)^11,1),
         PHLTH_33 = nth_pos(PHLTH17 * (1 + PHLTH_CAGR)^16,1)) %>% 
  filter(cbsa_code == "13820")

# FDIC

