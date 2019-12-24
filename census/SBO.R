# set up -----------------
library(censusapi)
library(tidyverse)

key <- Sys.getenv("CENSUS_API_KEY")

traded_code <- c("31-33", "51", "52", "54")
race_code <- c("96", "30", "40")

# func---------------------
get_SBO <- function(...){
  censusapi::getCensus(name = "2012/sbo",
                       vars = c("GEO_ID","GEO_TTL", # geography
                                "NAICS2012","NAICS2012_TTL", # industry sectors
                                "RACE_GROUP_TTL","RACE_GROUP",  # race
                                "ETH_GROUP","ETH_GROUP_TTL", # ethnicity
                                "SEX","SEX_TTL", # gender
                                "VET_GROUP", "VET_GROUP_TTL", # veteran
                                "FIRMALL", "FIRMPDEMP", "FIRMPDEMP_S", "FIRMPDEMP_F", "FIRMPDEMP_S_F"),
                       ...,
                       key = key)
}

# test ---------------------
# metro
# df <- get_SBO(region = "metropolitan statistical area/micropolitan statistical area:24340")

# county
get_sbo_co <- function(stco_code) {
  
  
  co_code <- paste0("county:",str_sub(stco_code, 3, 5))
  st_code <- paste0("state:",str_sub(stco_code, 1, 2))
  
  get_SBO(region = co_code, regionin = st_code)

  
}


