# by race
# B01001A white non-hispanic
# B01001B black
# B01001D asian
# B01001I latino

tmp <- get_acs("county", key = Sys.getenv("CENSUS_API_KEY"),county = "073", state = "AL", 
        table = "B01001I", output = "wide")%>%
  select(-contains("M"))%>%
  mutate(all = B01001I_001E,
         postmil = rowSums(.[4:9])+rowSums(.[19:24]),
         mil = B01001I_009E + B01001I_010E + B01001I_024E + B01001I_025E) %>%
  select(all, premil, mil)



# all
get_acs("county", key = Sys.getenv("CENSUS_API_KEY"),county = "073", state = "AL", table = "B01001", output = "wide") %>%
  mutate(all = B01001_001E + B01001_026E,
         mil = B01001_011E + B01001_012E + B01001_035E + B01001_025E) %>%
  select(all, mil)

