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

load("../metro-data-warehouse/data/county_cbsa_st.rda")
save(county_cbsa_st,file = "GETDATA/data/county_cbsa_st.rda")

# find cbsa_code by short name and all counties within the CBSA ------
find_cbsa_counties <- function(msa){
  county_cbsa_st %>%
    # metro.data::county_cbsa_st %>%
    filter(grepl(!!msa,cbsa_name,ignore.case = T)) %>%
    # select(cbsa_code, cbsa_name, stco_code, co_name) %>%
    unique()
}

# save file source

github_path <- "https://github.com/fansi-sifan/metro-datasets/tree/master/"

create_link <- function(name){
  src <- paste0(github_path,gsub(paste0("/",name,".rda"),"",grep(paste0("/",name,".rda"),temp,value = T)))
  paste0("[",name, "]", "(", src[1],")")
  
}

create_md <- function(lt, fl){
  x <- list(name = names(lt), links = "link")
  l <- length(x$name)
  
  for(i in 1:l){
    x$links[i] = create_link(x$name[i])
  }

  sink(paste0("GETDATA/",fl,".md"))
  print(x$links)
  sink()
}

