# pipeline to create master datasets
library(tidyverse)

# load all .rda datasets ==============================
temp = list.files(pattern = ".rda", recursive = T)
lapply(temp, load, .GlobalEnv)


# Functions to merge all =============================
merge_cbsa <- function(list){
  plyr::join_all(list,
                 by = c("cbsa_code"),
                 type = "full")}

merge_county <- function(list){
  plyr::join_all(list,
                 by = c("stco_code"),
                 type = "full")}


# which ones are needed? =============================

cbsa_df <- merge_cbsa(list(cbsa_I5HGC,cbsa_univRD,cbsa_VC))

county_df <- merge_cbsa(c(""))


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
