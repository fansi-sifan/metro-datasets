# get ABS data

library(censusapi)

df <- getCensus(name = "abscs",
          vintage = 2017,
          vars = c("GEO_ID","NAICS2017", "SEX", "ETH_GROUP", "RACE_GROUP", "FIRMPDEMP"),
          region = "county:*",
          key = Sys.getenv("CENSUS_API_KEY"))

stco_naics_ownership <- df %>% 
  mutate(stco_code = str_sub(GEO_ID, -5,-1),
         naics2_code = str_pad(NAICS2017,2,"left","0")) 


cbsa_fsize_ownership <- getCensus(name = "abscs",
                vintage = 2017,
                vars = c("GEO_ID","NAICS2017", "EMPSZFI",
                         "SEX", "ETH_GROUP", "RACE_GROUP", "FIRMPDEMP"),
                region = "metropolitan statistical area/micropolitan statistical area:*",
                key = Sys.getenv("CENSUS_API_KEY"))

cbsa_fsize_naics_ownership <- cbsa_fsize_ownership %>% 
  mutate(cbsa_code = str_sub(GEO_ID, -5,-1),
         naics2_code = str_pad(NAICS2017,2,"left","0")) 

save(stco_naics_ownership, file = "census/stco_naics_ownership.rda")
save(cbsa_fsize_naics_ownership, file = "census/cbsa_naics_ownership.rda")
