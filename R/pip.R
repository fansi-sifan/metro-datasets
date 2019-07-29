# pipeline functions
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
# dfs <- objects()
# list_cbsa_all <- mget(dfs[grep("cbsa_",dfs)])
# list_county_all <- mget(dfs[grep("county_|co_",dfs)])

# keep latest year
keep_latest <- function(df){
  if ("year" %in% names(df)){
    df <- filter(df,year==max(year))
    return(df)
  } else{return(df)}
  
}


# find cbsa_code by short name and all counties within the CBSA ------
load("../metro.data/data/county_cbsa_st.rda")

find_cbsa_counties <- function(msa){
  county_cbsa_st %>%
    # metro.data::county_cbsa_st %>%
    filter(grepl(!!msa,cbsa_name,ignore.case = T)) %>%
    # select(cbsa_code, cbsa_name, stco_code, co_name) %>%
    unique()
}