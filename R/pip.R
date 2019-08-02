# pipeline functions
library(tidyverse)
# library(metro.data)

# load all .rda datasets to the global envior. ==============================
temp = list.files(pattern = ".rda", recursive = T)
load("../metro.data/data/county_cbsa_st.rda")

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


# Select and merge datasets =============================
dfs <- objects()

df_cbsa_all <- mget(dfs[grep("cbsa_",dfs)])
df_co_all <- mget(dfs[grep("county_|co_",dfs)])

list_cbsa_all <- map_depth(df_cbsa_all,names,.depth = 1)
list_co_all <- map_depth(df_co_all,names,.depth = 1)

save(list_cbsa_all,file = "list_cbsa_all.rda")
save(list_co_all,file = "list_co_all.rda")

cbsa_all <- merge_cbsa(lapply(list_cbsa_all, keep_latest))
co_all <- merge_co(lapply(list_co_all, keep_latest))

# save(cbsa_all,file = "cbsa_all.rda")
# save(co_all,file = "co_all.rda")

cbsa_all %>%
  select(c(names(cbsa_univ_rd),names(cbsa_st)))%>%
  filter(cbsa_code == "13820")


# find cbsa_code by short name and all counties within the CBSA ------


find_cbsa_counties <- function(msa){
  county_cbsa_st %>%
    # metro.data::county_cbsa_st %>%
    filter(grepl(!!msa,cbsa_name,ignore.case = T)) %>%
    # select(cbsa_code, cbsa_name, stco_code, co_name) %>%
    unique()
}