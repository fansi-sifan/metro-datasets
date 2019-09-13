library(censusapi)
library(tidyverse)

key <- Sys.getenv("CENSUS_API_KEY")

get_SBO <- function(...){
  getCensus(name = "2012/sbo",
            vars = c( "NAICS2012","NAICS2012_TTL",
                      "RACE_GROUP_TTL","RACE_GROUP", 
                      "ETH_GROUP","ETH_GROUP_TTL",
                      "SEX","SEX_TTL", "GEO_ID",
                      "FIRMALL", "FIRMPDEMP"),
            ...,
            key = key)
}


df <- get_SBO(region = "county:081", regionin  = "state:26")
  
# df <- bind_rows (
#   get_SBO(region = "county:031", regionin  = "state:08"),
#   # get_SBO(region = "county:037", regionin  = "state:47"),
#   get_SBO(region = "us:*")
# )

traded_code <- c("31-33", "51", "52", "54")
race_code <- c("96", "30", "40")

output <- df %>%
  filter(RACE_GROUP %in% race_code)%>%
  filter(NAICS2012 %in% traded_code)%>%
  filter(ETH_GROUP == "001"& SEX == "001")

output %>%
  group_by(state, county, RACE_GROUP) %>%
  mutate(firmdemp = as.numeric(FIRMPDEMP))%>%
  summarise(firmdemp  = sum(firmdemp)) %>%
  spread(RACE_GROUP, firmdemp) %>%
  mutate(pct_bk = `96`*0.19 - `40`)
