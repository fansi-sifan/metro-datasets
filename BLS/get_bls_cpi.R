
library(blscrapeR)
library(tidyverse)
library(tidylog)


area_code <- read.delim("https://download.bls.gov/pub/time.series/cw/cw.area")
area_code <- area_code %>%
  mutate(cpi_code = paste0("CWUS",area_code, "SA0"))

df <- bls_api(area_code$cpi_code, startyear = 2017, endyear = 2017, registrationKey = Sys.getenv("BLS_KEY"))

area_cpi <- df %>%
  full_join(area_code[c("area_name", "cpi_code")], by = c("seriesID" = "cpi_code")) %>%
  group_by(area_name, seriesID, year) %>%
  summarise(value = mean(value))
  
# monthly jobs
load("metro_monitor_2020/cbsa_metromonitor_2020.rda")

cbsa_53 <- cbsa_metromonitor_2020 %>% 
  filter(largest == 1) %>% 
  select(cbsa_code) %>% 
  unique()

area_code <- read_delim("https://download.bls.gov/pub/time.series/la/la.area", delim = "\t")%>% 
  filter(area_type_code == "B") %>% 
  mutate(cbsa_code = str_sub(area_code, 5,9),
         series_U = paste0("LAU",area_code,"05"),
         series_S = paste0("LAS",area_code,"05")) %>% 
  # left_join(metro.data::cbsa_st[c("cbsa_code", "cbsa_is.top100")], by = "cbsa_code") %>% 
  # unique() %>% 
  # filter(cbsa_is.top100 | is.na(cbsa_is.top100)) %>% 
  filter(cbsa_code %in% cbsa_53$cbsa_code)


# df <- bind_rows(bls_api(area_code[c(1:50),c("series")], startyear = 2007, endyear = 2019, registrationKey = Sys.getenv("BLS_key")),
#                 bls_api(area_code[c(51:100),c("series")], startyear = 2007, endyear = 2019, registrationKey = Sys.getenv("BLS_key")),
#                 bls_api(area_code[c(101:121),c("series")], startyear = 2007, endyear = 2019, registrationKey = Sys.getenv("BLS_key")))

job_monthly_cbsa53 <- bls_api(area_code$series_U, startyear = 1990, endyear = 2019, registrationKey = Sys.getenv("BLS_key")) %>% 
  left_join(area_code[c("area_text", "cbsa_code", "series_U")], by = c("seriesID" = "series_U"))


# save(job_monthly_cbsa53_S, file = "census/job_monthly_cbsa_53_S.rda")
save(job_monthly_cbsa53, file = "census/job_monthly_cbsa_53.rda")

# search_ids(c("employment", "atlanta"))

