source("R/pip.R")
rm(county_cbsa_st)
rm(co_all)
rm(cbsa_all)
rm(find_cbsa_counties)

# Select and merge datasets =============================
dfs <- objects()

df_cbsa_all <- mget(dfs[grep("cbsa_",dfs)])
df_co_all <- mget(dfs[grep("county_|co_",dfs)])

cbsa_all <- merge_cbsa(lapply(df_cbsa_all, keep_latest))
co_all <- merge_co(lapply(df_co_all, keep_latest))

save(cbsa_all,file = "GETDATA/data/cbsa_all.rda")
save(co_all,file = "GETDATA/data/co_all.rda")

# column names --------------------
list_all_cbsa <- map_depth(df_cbsa_all,names,.depth = 1)
list_all_co <- map_depth(df_co_all,names,.depth = 1)

save(list_all_cbsa,file = "GETDATA/data/list_all_cbsa.rda")
save(list_all_co,file = "GETDATA/data/list_all_co.rda")


# cbsa_all %>%
#   select(c(names(cbsa_univ_rd),names(cbsa_st)))%>%
#   filter(cbsa_code == "13820")
