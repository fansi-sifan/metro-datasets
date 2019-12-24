# load all datasets into the environment
source("R/pip.R")

# take out datasets that should not go to the master dataset
irrelevant <- c("county_cbsa_st","co_all","cbsa_all","find_cbsa_counties", "cbsa_acs_raw","co_acs_raw")
not.include<- c("cbsa_shiftshare", "cbsa_oppind_race", "cbsa_low_wage_worker", "cbsa_agegroup_race", "cbsa_jobdensity", "cbsa_change", "cbsa_value")
rm(list = not.include)
rm(list = irrelevant)

# modify datasets
cbsa_job_density_expected <- cbsa_job_density_expected %>%
 select(cbsa_code, cbsa_name, measure, density2015) %>%
  filter(!is.na(measure))%>%
  spread(measure, density2015)

names(cbsa_job_density_expected) <- make.names(names(cbsa_job_density_expected))

co_oow <- co_oow %>%
  filter(population == "Out-of-work population")%>%
  select(stco_code,age, population, total,pemployed, pnilf,pmale,
         med_age, med_fam_income_adj,pwhiteNH, pblackNH, platino,pasianNH,potherNH,
         pbaplus,phs, pdis,pnospouse_kids,psafetynet )

cbsa_metromonitor <- cbsa_metromonitor %>%
  filter(rank_year_range == "2007-2017")

# Select and merge datasets =============================
dfs <- objects()

df_cbsa_all <- mget(dfs[grep("cbsa_",dfs)])
df_co_all <- mget(dfs[grep("county_|co_",dfs)])

# merge metro level datasets, and check if the length looks weird (>1000)
cbsa_all <- merge_cbsa(lapply(df_cbsa_all, keep_latest))%>%
  filter(!is.na(pop_total))

nrow(cbsa_all)

# merge metro level datasets, and check if the length looks weird (>4000)
co_all <- merge_co(lapply(df_co_all, keep_latest))%>%
  filter(!is.na(pop_total))

nrow(co_all)

# update master datasets
save(cbsa_all,file = "GETDATA/data/cbsa_all.rda")
save(co_all,file = "GETDATA/data/co_all.rda")

# get column names, organized by list of dataset names --------------------
list_all_cbsa <- map_depth(df_cbsa_all,names,.depth = 1)
list_all_co <- map_depth(df_co_all,names,.depth = 1)

save(list_all_cbsa,file = "GETDATA/data/list_all_cbsa.rda")
save(list_all_co,file = "GETDATA/data/list_all_co.rda")

# save src to GitHub

create_md(list_all_co, "county")
create_md(list_all_cbsa, "metro")
