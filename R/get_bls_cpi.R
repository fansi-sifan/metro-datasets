install.packages("blscrapeR")
# https://github.com/keberwein/blscrapeR

library(blscrapeR)


area_code <- read.delim("https://download.bls.gov/pub/time.series/cw/cw.area")
area_code <- area_code %>%
  mutate(cpi_code = paste0("CWUS",area_code, "SA0"))

df <- bls_api(area_code$cpi_code, startyear = 2017, endyear = 2017, registrationKey = Sys.getenv("BLS_KEY"))

area_cpi <- df %>%
  full_join(area_code[c("area_name", "cpi_code")], by = c("seriesID" = "cpi_code")) %>%
  group_by(area_name, seriesID, year) %>%
  summarise(value = mean(value))
  

