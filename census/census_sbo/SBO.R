# set up -----------------
library(censusapi)
library(tidyverse)

key <- Sys.getenv("CENSUS_API_KEY")

traded_code <- c("31-33", "51", "52", "54")
retail_resto <- c("44-45", "72")
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
                                "FIRMALL", "FIRMPDEMP", "FIRMPDEMP_S",
                                "PAYANN", "RCPALL", "RCPNOPD", "RCPPDEMP"),
                       ...,
                       key = key)
}

get_sbo <- function(code, area) {
  co_code <- paste0("county:",str_sub(code, 3, 5))
  st_code <- paste0("state:",str_sub(code, 1, 2))
  
  if (area == "stco"){
    get_SBO(region = co_code, regionin = st_code)
  } else if (area == "cbsa"){
    get_SBO(region = paste0("metropolitan statistical area/micropolitan statistical area:",code))
  }

}

# test ---------------------
sbo_us <- get_SBO(region = "us:*")
save(sbo_us, file = "census/census_sbo/sbo_us.rda")


# sbo
# us_naics_demo_12 <- sbo_us %>% 
#   filter(VET_GROUP %in% c("096","001")) %>% 
#   
#   mutate(demo = paste0(SEX_TTL, ETH_GROUP_TTL, RACE_GROUP_TTL, VET_GROUP_TTL)) %>%
#   mutate(demo = gsub("All firms", "", demo)) %>% 
#   mutate(demo = ifelse(demo == "", "Total", demo)) %>%
#   mutate(demo = ifelse(demo == " classifiable by gender, ethnicity, race, and veteran status", "classifiable", demo)) %>%
#   mutate(demo = ifelse(demo == "Publicly held and other firms not classifiable by gender, ethnicity, race, and veteran status", "not classifiable", demo)) %>%
#   
#   # mutate(FIRMPDEMP = ifelse(FIRMPDEMP == "0", NA, as.numeric(FIRMPDEMP))) %>% 
#   mutate(FIRMPDEMP = as.numeric(FIRMPDEMP)) %>% 
#   
#   select(-SEX, -SEX_TTL, -ETH_GROUP, -ETH_GROUP_TTL, -RACE_GROUP, -RACE_GROUP_TTL, -VET_GROUP, -VET_GROUP_TTL, -FIRMALL, -FIRMPDEMP_S) %>% 
#   unique() %>% 
#   pivot_wider(names_from = "demo", values_from = "FIRMPDEMP") %>% 
#   mutate(total = classifiable) %>%
#   select(
#     naics6_code = NAICS2012, 
#     NAICS2012_TTL,
#     # EMPSZFI,
#     # EMPSZFI_TTL,
#     total,
#     male = `Male-owned`, 
#     black = `Black or African American`,
#     nonminority = Nonminority
#   )  %>% 
#   mutate(naics_level = ifelse(grepl("-",naics6_code),2,
#                               str_length(naics6_code))) 
# 
# save(us_naics_demo_12, file = "../metro-datasets/census/census_sbo/us_naics_demo_12.rda")


# metro and county
get_sbo("13820", "metro")
get_sbo("01073", "county")

summarise_sbo <- function(var, df, area) {
  var <- rlang::enquo(var)
  text <- paste0(area,"_code")
  
  df %>%
    mutate(
      firmdemp = as.numeric(FIRMPDEMP),
      firmall = as.numeric(FIRMALL),
      is.traded = ifelse(NAICS2012 %in% traded_code, "traded", "local")
    ) %>%
    group_by(GEO_ID, GEO_TTL, !!var, is.traded) %>%
    summarise(
      firmdemp = sum(firmdemp),
      firmall = sum(firmall)
    ) %>% 
    ungroup() %>%
    filter(!!var != "All firms") %>%
    mutate(GEO_ID = str_sub(trimws(GEO_ID), -5,-1))%>%
    rename(label = !!var) %>%
    rename(!!text := GEO_ID)
}

get_sbo_m <- function(code, area){
  
  # get data
  sbo_df <- purrr::map_df(code, ~get_sbo(., area))
  
  # summary table by each demographics
  bind_rows(list(race = summarise_sbo(RACE_GROUP_TTL, sbo_df, area),
              ethnicity = summarise_sbo(ETH_GROUP_TTL, sbo_df, area),
              vet = summarise_sbo(VET_GROUP_TTL, sbo_df, area),
              sex = summarise_sbo(SEX_TTL, sbo_df, area)))
}

# tmp <- get_sbo_m(c("13820", "32820"), "cbsa")
# tmp <- get_sbo_m(c("01073", "28041"), "stco") 


