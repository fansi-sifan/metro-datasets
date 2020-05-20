
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

area_code <- read_delim("R/la_area.txt", delim = "\t")%>% 
  filter(area_type_code == "B") %>% 
  mutate(cbsa_code = str_sub(area_code, 5,9),
         series = paste0("LAU",area_code,"05")) %>% 
  left_join(metro.data::cbsa_st[c("cbsa_code", "cbsa_is.top100")], by = "cbsa_code") %>% 
  unique() %>% 
  filter(cbsa_is.top100 | is.na(cbsa_is.top100))

area_code[c(50:100),c("series")]

df <- bind_rows(bls_api(area_code[c(1:50),c("series")], startyear = 2007, endyear = 2019, registrationKey = Sys.getenv("BLS_key")),
                bls_api(area_code[c(51:100),c("series")], startyear = 2007, endyear = 2019, registrationKey = Sys.getenv("BLS_key")),
                bls_api(area_code[c(101:121),c("series")], startyear = 2007, endyear = 2019, registrationKey = Sys.getenv("BLS_key")))

# search_ids(c("employment", "atlanta"))

