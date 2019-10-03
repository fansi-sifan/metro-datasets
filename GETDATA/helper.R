# load all datasets into the environment
source("R/pip.R")

# take out datasets that should not go to the master dataset
irrelevant <- c("county_cbsa_st","co_all","cbsa_all","find_cbsa_counties", "cbsa_acs_raw","co_acs_raw")
not.include<- c("cbsa_shiftshare", "cbsa_oppind_race", "cbsa_low_wage_worker")
rm(list = not.include)
rm(list = irrelevant)

# modify datasets
cbsa_jobdensity <- cbsa_jobdensity %>%
  filter(naics2_code == "00")

co_oow <- co_oow %>%
  filter(population == "Out-of-work population")%>%
  select(stco_code,age, population, total,pemployed, pnilf,pmale,
         med_age, med_fam_income_adj,pwhiteNH, pblackNH, platino,pasianNH,potherNH,
         pbaplus,phs, pdis,pnospouse_kids,psafetynet )


# Select and merge datasets =============================
dfs <- objects()

df_cbsa_all <- mget(dfs[grep("cbsa_",dfs)])
df_co_all <- mget(dfs[grep("county_|co_",dfs)])

# merge metro level datasets, and check if the length looks weird (>1000)
cbsa_all <- merge_cbsa(lapply(df_cbsa_all, keep_latest))
nrow(cbsa_all)

# merge metro level datasets, and check if the length looks weird (>4000)
co_all <- merge_co(lapply(df_co_all, keep_latest))
nrow(co_all)

# update master datasets
save(cbsa_all,file = "GETDATA/data/cbsa_all.rda")
save(co_all,file = "GETDATA/data/co_all.rda")

# get column names, organized by list of dataset names --------------------
list_all_cbsa <- map_depth(df_cbsa_all,names,.depth = 1)
list_all_co <- map_depth(df_co_all,names,.depth = 1)

save(list_all_cbsa,file = "GETDATA/data/list_all_cbsa.rda")
save(list_all_co,file = "GETDATA/data/list_all_co.rda")


