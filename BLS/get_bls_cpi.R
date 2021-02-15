
library(blscrapeR)
library(tidyverse)
library(tidylog)
BLS_KEY <- Sys.getenv("BLS_KEY")

# annual cpi ==============
area_code <- read.delim("https://download.bls.gov/pub/time.series/cw/cw.area")
area_code <- area_code %>%
  mutate(cpi_code = paste0("CWUS", area_code, "SA0"))

df <- bls_api(area_code$cpi_code, startyear = 2017, endyear = 2017, registrationKey = Sys.getenv("BLS_KEY"))

area_cpi <- df %>%
  full_join(area_code[c("area_name", "cpi_code")], by = c("seriesID" = "cpi_code")) %>%
  group_by(area_name, seriesID, year) %>%
  summarise(value = mean(value))

# monthly jobs by metro ===============
cbsa_53 <- metro.data::cbsa_18 %>%
  filter(cbsa_size == "very large metros") %>%
  pull(cbsa_code)

area_code <- read_delim("https://download.bls.gov/pub/time.series/la/la.area", delim = "\t") %>%
  filter(area_type_code == "B") %>%
  mutate(
    cbsa_code = str_sub(area_code, 5, 9),
    series_U = paste0("LAU", area_code, "05"),
    series_S = paste0("LAS", area_code, "05")
  ) %>%
  # left_join(metro.data::cbsa_st[c("cbsa_code", "cbsa_is.top100")], by = "cbsa_code") %>%
  # unique() %>%
  # filter(cbsa_is.top100 | is.na(cbsa_is.top100)) %>%
  filter(cbsa_code %in% cbsa_53)


# df <- bind_rows(bls_api(area_code[c(1:50),c("series")], startyear = 2007, endyear = 2019, registrationKey = Sys.getenv("BLS_key")),
#                 bls_api(area_code[c(51:100),c("series")], startyear = 2007, endyear = 2019, registrationKey = Sys.getenv("BLS_key")),
#                 bls_api(area_code[c(101:121),c("series")], startyear = 2007, endyear = 2019, registrationKey = Sys.getenv("BLS_key")))

job_monthly_cbsa53 <- bls_api(area_code$series_U,
  startyear = 1990, endyear = 2019,
  registrationKey = Sys.getenv("BLS_key")
) %>%
  left_join(area_code[c("area_text", "cbsa_code", "series_U")], by = c("seriesID" = "series_U"))


# save(job_monthly_cbsa53_S, file = "census/job_monthly_cbsa_53_S.rda")
save(job_monthly_cbsa53, file = "census/job_monthly_cbsa_53.rda")

# search_ids(c("employment", "atlanta"))

# employment by industry ===========
naics_xwalk <- read_delim("https://download.bls.gov/pub/time.series/ce/ce.industry", delim = "\t") %>%
  filter(str_length(naics_code) == 3) %>%
  mutate(seriesID = paste0("CES", industry_code, "01"))

# api only allows 50 requests at a time
ID <- naics_xwalk %>%
  select(seriesID) %>%
  group_by(as.numeric(rownames(naics_xwalk)) < 50) %>%
  group_split()

get_monthly <- function(x) {
  bls_api(
    seriesid = x$seriesID,
    startyear = 2020, endyear = 2020,
    registrationKey = BLS_KEY
  )
}

emp_naics_2020 <- purrr::map_dfr(ID, get_monthly)

