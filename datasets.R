# Get Raw Data and save to 'source' folder
# Author: Sifan Liu
# Date: Fri Aug 03 14:00:12 2018
# SET UP ==============================================
pkgs <- c("tidyverse", "reshape2", "writexl", "httr","skimr")

check <- sapply(pkgs, require, warn.conflicts = TRUE, character.only = TRUE)
if (any(!check)) {
  pkgs.missing <- pkgs[!check]
  install.packages(pkgs.missing)
  check <- sapply(pkgs.missing, require, warn.conflicts = TRUE, character.only = TRUE)
}

# TRANSFORM ============================================
# Metro Monitor ---------------------------------------------------

paths <- "V:/Performance/Project files/Metro Monitor/2018v/Output/"

# change in values (ranking)
growth_change <- read.csv(paste0(paths, "Growth/Growth Ranks (IS 2017.11.15).csv"))
prosperity_change <- read.csv(paste0(paths, "Prosperity/Prosperity Ranks (IS 2017.11.14).csv"))
inclusion_change <- read.csv(paste0(paths, "Inclusion/Inclusion Ranks (IS 2017.11.17).csv"))

# absolute value in 2016
growth_value <- read.csv(paste0(paths, "Growth/Growth Values (IS 2017.11.15).csv")) %>%
  filter(year == 2016) %>%
  dcast(year + cbsa ~ indicator, var.value = "value")

prosperity_value <- read.csv(paste0(paths, "Prosperity/Prosperity Values (IS 2017.11.14).csv")) %>%
  filter(year == 2016) %>%
  dcast(year + CBSA ~ indicator, var.value = "value")

inclusion_value <- read.csv(paste0(paths, "Inclusion/Inclusion Values (IS 2017.11.17).csv")) %>%
  filter(year == 2016) %>%
  filter(race == "Total") %>%
  filter(eduatt == "Total") %>%
  dcast(year + cbsa ~ indicator, var.value = "value")

# inconsistent column names
names(inclusion_change) <- names(growth_change)
names(prosperity_value)[[2]] <- "cbsa"

# join all three changes
cbsa_change <- prosperity_change %>%
  filter(year == "2006-2016") %>%
  left_join(growth_change, by = c("year", "CBSA")) %>%
  left_join(inclusion_change, by = c("year", "CBSA")) %>%
  select(-contains("score"), -contains("name"))


# join all three absolute values
cbsa_value <- prosperity_value %>%
  filter(year == "2016") %>%
  left_join(growth_value, by = c("year", "cbsa")) %>%
  left_join(inclusion_value, by = c("year", "cbsa"))

# join everything
cbsa_metromonitor <- cbsa_change %>%
  left_join(cbsa_value, by = c("CBSA" = "cbsa")) %>%
  rename(
    cbsa_code = CBSA,
    value_year = year.y,
    rank_year_range = year.x,
    inclusion_rank = rank,
    prosperity_rank = rank.x,
    growth_rank = rank.y
  )

# format
cbsa_metromonitor <- cbsa_metromonitor %>%
  mutate_at(c("cbsa_code","value_year","rank_year_range"),as.character) %>%
  mutate_at(vars(contains("_rank")),as.factor) 

# check output
skim_with_defaults()
skim(cbsa_metromonitor)

# save output
dir.create("metro_monitor")
save(cbsa_metromonitor,file = "metro_monitor/metro_monitor.rda")
write.csv(cbsa_metromonitor,"metro_monitor/metro_monitor.csv")

# generate metadata
sink("metro_monitor/metro_monitor.txt")
skim_with(numeric = list(hist = NULL))
skim(cbsa_metromonitor)
sink()

# create README
sink("metro_monitor/README.md")
skim(cbsa_metromonitor)%>% kable()
sink()

# Export Monitor---------------------------------------------------
cbsa_export <- readxl::read_xlsx("V:/Export Monitor/2018/Deliverables/Deliverables/Metros Data/Metros by Total, NAICS 2 3.xlsx", sheet = "Total") %>%
  filter(Year == 2017) %>%
  mutate(cbsa = as.character(`(CBSA)`))

skim(cbsa_export)

county_export <- readxl::read_xlsx("V:/Export Monitor/2018/Deliverables/Deliverables/Counties Data/Counties by Total, NAICS 2.xlsx", sheet = "Total") %>%
  filter(Year == 2017) %>%
  mutate(FIPS = str_pad(as.character(`(County)`), 5, "left", "0"))

# cbsa_naics4_export <- read.csv("V:/Export Monitor/2018/Deliverables/Deliverables/Metros Data/Metros  by NAICS 4.csv") %>%
#   filter(gm == msa_FIPS) %>%
#   filter(year == 2017)
# 
# county_naics4_export <- read.csv("V:/Export Monitor/2018/Deliverables/Deliverables/Counties Data/Counties by NAICS 4.csv") %>%
#   filter(gc == as.integer(county_FIPS)) %>%
#   filter(year == 2017)


# ShiftShare ---------------------------------------------------
cbsa_shiftshare <- read.csv("V:/Performance/Project files/Metro Monitor/2018v/Output/Shift Share/Monitor Shiftshare Cumulative (2-digit NAICS).csv") %>%
  filter(cbsa2013_fips == msa_FIPS) %>%
  filter(year == 2016)

# Digitalization ---------------------------------------------------
cbsa_digital <- read.csv("source/metro_all_updated.csv") %>%
  mutate(cbsa = as.character(`AREA`))

# Univ R&D ---------------------------------------------------
NSF_univRD <- read.csv("source/NSF_univ.csv")

cbsa_univRD <- NSF_univRD %>%
  group_by(cbsacode) %>%
  summarise(
    RDtotal = sum(Deflated.Total.R.D.Expenditures.in.All.Fields.Sum.),
    RDtotal_biz = sum(as.numeric(as.character(Deflated.Business.Financed.R.D.Expenditures.Sum.)))
  ) %>%
  mutate(cbsa = as.character(cbsacode))

county_univRD <- NSF_univRD %>%
  group_by(county) %>%
  summarise(
    RDtotal = sum(Deflated.Total.R.D.Expenditures.in.All.Fields.Sum.),
    RDtotal_biz = sum(as.numeric(as.character(Deflated.Business.Financed.R.D.Expenditures.Sum.)))
  ) %>%
  mutate(FIPS = str_pad(as.character(county), 5, "left", "0"))


# AUTM ---------------------------------------------------
AUTM <- read.csv("source/AUTM.csv")

county_AUTM <- AUTM %>%
  group_by(FIPS) %>%
  # summarise_if(is.numeric, sum, na.rm = TRUE) %>%
  summarise(
    tot_lic = sum(Lic.Iss, na.rm = TRUE) + sum(Opt.Iss, na.rm = TRUE),
    lg_lic = sum(Tot.Lic.Lg.Co, na.rm = TRUE),
    sm_lic = sum(Tot.Lic.Sm.Co, na.rm = TRUE),
    st_lic = sum(Tot.Lic.St.Ups, na.rm = TRUE),
    inc_lic = sum(Gross.Lic.Inc, na.rm = TRUE),
    tot_IP = sum(Inv.Dis.Rec, na.rm = TRUE),
    tot_st = sum(St.Ups.Formed, na.rm = TRUE),
    instate_st = sum(St.Ups.in.Home.St, na.rm = TRUE)
  ) %>%
  mutate(FIPS = str_pad(as.character(FIPS), 5, "left", "0"))


# REGPAT ---------------------------------------------------
cbsa_REGPAT <- readxl::read_xlsx("V:/Global Profiles/Data/REGPAT/Analysis Files/_g4.xlsx", sheet = "i0") %>%
  filter(`Year Range` == "2008-2012")

# USPTO ---------------------------------------------------
cbsa_USPTO <- read.csv("source/USPTO_msa.csv") %>%
  mutate(cbsa = substr(as.character(ID.Code), 2, 6))

county_USPTO <- read.csv("source/USPTO_county.csv") %>%
  mutate(FIPS = str_pad(as.character(FIPS.Code), 5, "left", "0"))

# Patent Complexity ---------------------------------------------------
cbsa_patentCOMP <- read.csv("source/Complexity_msa.csv") %>%
  mutate(cbsa = as.character(cbsa))

# VC ---------------------------------------------------
cbsa_VC <- read.csv("source/VC.csv") %>%
  filter(round == "Total VC" & measure == "Capital Invested ($ M) per 1M Residents") %>%
  mutate(cbsa = as.character(cbsa13))

# Inc5000 ---------------------------------------------------
cbsa_I5HGC <- read.csv("source/I5HGC_density.csv") %>%
  mutate(cbsa = as.character(CBSA))

# Broadband ---------------------------------------------------
tract_broadband <- readxl::read_xlsx("V:/Infrastructure/2 Long Form Projects/Broadband/Final Layout/Masterfile_Final.xlsx")

# out of work ---------------------------------------------------
county_OoW <- read.csv("source/OutOfWork_county.csv") %>%
  mutate(FIPS = str_pad(fips, 5, "left", "0"))


# SAVE ALL OUTPUT ==============================================
dfs <- objects()
datafiles <- mget(dfs[grep("cbsa|county|tract", dfs)])

# new <- mget(dfs[grep("export_ind", dfs)])
# datafiles <- gdata::update.list(datafiles, new)

save(datafiles, file = "source/all data.Rdata")

# writexl::write_xlsx(new, path = paste0("result/",msa_FIPS,"_Market Assessment_new.xlsx"))
