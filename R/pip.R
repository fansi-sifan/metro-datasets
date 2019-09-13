# pipeline functions
library(tidyverse)
# library(metro.data)

# load all .rda datasets to the global envior. ==============================
temp = list.files(pattern = ".rda", recursive = T)


# temp[grep("cbsa_",temp)]
# temp[grep("co_",temp)]
# temp[grep("tract_",temp)]

list(lapply(temp, load, .GlobalEnv))

# Functions to merge all =============================
merge_cbsa <- function(list){
  plyr::join_all(list,
                 by = c("cbsa_code"),
                 type = "full")}

merge_co <- function(list){
  plyr::join_all(list,
                 by = c("stco_code"),
                 type = "full")}

# keep latest year
keep_latest <- function(df){
  if ("year" %in% names(df)){
    df <- filter(df,year == max(year))
    return(df)
  } else{return(df)}
  
}

load("../metro.data/data/county_cbsa_st.rda")
save(county_cbsa_st,file = "GETDATA/data/county_cbsa_st.rda")

# find cbsa_code by short name and all counties within the CBSA ------
find_cbsa_counties <- function(msa){
  county_cbsa_st %>%
    # metro.data::county_cbsa_st %>%
    filter(grepl(!!msa,cbsa_name,ignore.case = T)) %>%
    # select(cbsa_code, cbsa_name, stco_code, co_name) %>%
    unique()
}