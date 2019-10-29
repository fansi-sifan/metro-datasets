race_table <- map_chr(c("A","B","D","I"), function(x)paste0("B01001",x))

clean_race_age <- function(df){
  df %>% separate(variable, c("table","var"),"_") %>%
    mutate(var = as.numeric(var)) %>%
    mutate(age = case_when(
      var == 1 ~ "total",
      var == 2 ~ "male",
      var == 17 ~ "female",
      between(var, 3,6) | between(var,18,21) ~ "age_017",
      between(var, 7,10) | between(var,22,25) ~ "age_1834",
      between(var, 11,16) | between(var,26,31) ~ "age_35plus"
    )) %>%
    group_by(GEOID, table, age) %>%
    summarise(population = sum(estimate))%>%
    spread(age, population) %>%
    mutate(race = case_when(
      table == "B01001A" ~ "white non-hispanic",
      table == "B01001B" ~ "black",
      table == "B01001D" ~ "asian",
      table == "B01001I" ~ "latino"))
}

get_race_age <- function(race_table, stco_code){
  ct_code = substr(stco_code,3,5)
  st_code = substr(stco_code,1,2)
  
  df <- get_acs("county", key = Sys.getenv("CENSUS_API_KEY"),county = ct_code, state = st_code, 
                table = race_table) %>%
    clean_race_age()
}


get_age_group <- function(cbsa_code){
  censusapi::getCensus(name = "acs/acs5",vintage = 2017,key = Sys.getenv("CENSUS_API_KEY"),
                       var = map_chr(str_pad(seq(1,36),3,"left",0),function(x)paste0("B01001","_",x,"E")),
                       region = paste0("metropolitan statistical area/micropolitan statistical area:",cbsa_code)) %>%
    mutate(age_all = B01001_001E + B01001_026E,
           age_1824 = B01001_007E + B01001_008E + B01001_009E + B01001_010E +
             B01001_031E + B01001_032E + B01001_033E + B01001_034E,
           age_2534 = B01001_011E + B01001_012E + B01001_035E + B01001_036E,
           pct_age_1834 = (age_1824+age_2534)/age_all) %>%
    select(contains("metro"),contains("age"))
}


