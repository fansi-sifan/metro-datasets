# pipeline to create master datasets
library(tidyverse)

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
list_cbsa_all <- mget(dfs[grep("cbsa_",dfs)])
list_county_all <- mget(dfs[grep("county_",dfs)])

county_df <- merge_cbsa()
cbsa_df <- merge_cbsa(list_cbsa_all)

# Data for which places =============================
# find cbsa_code ----

find_cbsa <- function(msa){
  metro.data::county_cbsa_st %>%
  filter(grepl(!!msa,cbsa_name,ignore.case = T)) %>%
    select(cbsa_code, cbsa_name) %>%
    unique()
}

find_cbsa("denver")
find_cbsa("grand rapids")

cbsa_codes <- c("19740","24340")

# select data ----
cbsa_df %>%
  filter(cbsa_code %in% cbsa_codes)
