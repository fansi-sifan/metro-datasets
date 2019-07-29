# pipeline to create master datasets
library(tidyverse)
# library(metro.data)

# load all .rda datasets to the global envior. ==============================
temp = list.files(pattern = ".rda", recursive = T)
list(lapply(temp, load, .GlobalEnv))

# Functions to merge all =============================
merge_cbsa <- function(list){
  plyr::join_all(list,
                 by = c("cbsa_code"),
                 type = "full")}

merge_county <- function(list){
  plyr::join_all(list,
                 by = c("stco_code"),
                 type = "full")}


# Select and merge datasets =============================
dfs <- objects()
# list_cbsa_all <- mget(dfs[grep("cbsa_",dfs)])
# list_county_all <- mget(dfs[grep("county_|co_",dfs)])

# keep latest year
keep_latest <- function(df){
  if ("year" %in% names(df)){
    df <- filter(df,year==max(year))
    return(df)
  } else{return(df)}
  
}

# supply datasets of interests
list_county_all <- list(co_uspto, county_univ_rd, export_monitor_county)
county_df <- merge_county(lapply(list_county_all, keep_latest)) 

list_cbsa_all <- list(cbsa_uspto, cbsa_i5hgc, cbsa_metromonitor, cbsa_patentcomplex)
cbsa_df <- merge_cbsa(lapply(list_cbsa_all, keep_latest)) 

# Data for which places =============================
# find cbsa_code by short name and all counties within the CBSA ------
load("../metro.data/data/county_cbsa_st.rda")

find_cbsa_counties <- function(msa){
    county_cbsa_st %>%
    # metro.data::county_cbsa_st %>%
    filter(grepl(!!msa,cbsa_name,ignore.case = T)) %>%
    select(cbsa_code, cbsa_name, stco_code, co_name) %>%
    unique()
}

find_cbsa_counties("denver")
find_cbsa_counties("Birmingham")
find_cbsa_counties("grand rapids")

# specify places of interests
cbsa_codes <- c("19740","24340")
stco_codes <- c("01073", "08014")

# Get indicators for selected places -----------
# find cbsa data
cbsa_df %>%
  filter(cbsa_code %in% cbsa_codes)

# find county data
county_df %>%
  filter(stco_code %in% stco_codes)
