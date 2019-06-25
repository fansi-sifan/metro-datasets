# Get Raw Data and save to 'source' folder
# Author: Sifan Liu
# Date: Fri Aug 03 14:00:12 2018
# SET UP ==============================================
pkgs <- c("tidyverse", "reshape2", "writexl", "httr","skimr", "janitor")

check <- sapply(pkgs, require, warn.conflicts = TRUE, character.only = TRUE)
if (any(!check)) {
  pkgs.missing <- pkgs[!check]
  install.packages(pkgs.missing)
  check <- sapply(pkgs.missing, require, warn.conflicts = TRUE, character.only = TRUE)
}

# TRANSFORM ============================================
# Metro Monitor ---------------------------------------------------

paths <- "V:/Performance/Project files/Metro Monitor/2019v/Output/"

# change in values (ranking) - update to 2019 file paths and add janitor to clean var names
growth_change <- read.csv(paste0(paths, "Growth Ranks 2019-03-09 .csv")) %>% janitor::clean_names()
prosperity_change <- read.csv(paste0(paths, "Prosperity Ranks 2019-03-09 .csv")) %>% janitor::clean_names()
inclusion_change <- read.csv(paste0(paths, "Inclusion/Inclusion Ranks (IS 2018.12.11).csv"))%>% janitor::clean_names()
racial_inclusion_change <- read.csv(paste0(paths, "Inclusion/Racial Inclusion Ranks (IS 2019.03.06).csv"))%>% janitor::clean_names() #racial inclusion = new category in 2019

# absolute value in 2017 (instead of 2016) and clean names
growth_value <- read.csv(paste0(paths, "Growth Values 2019-03-09 .csv")) %>% 
  filter(year == 2017) %>%
  dcast(year + cbsa ~ indicator, var.value = "value") %>% 
  janitor::clean_names()

prosperity_value <- read.csv(paste0(paths, "Prosperity Values 2019-03-09 .csv")) %>% 
  filter(year == 2017) %>%
  dcast(year + cbsa_code ~ indicator, var.value = "value") %>% #repalce CBSA with cbsa_code 
  janitor::clean_names()

inclusion_value <- read.csv(paste0(paths, "Inclusion/Inclusion Values (IS 2018.12.11).csv")) %>% 
  filter(year == 2017) %>%
  filter(race == "Total") %>%
  filter(eduatt == "Total") %>%
  dcast(year + cbsa ~ indicator, var.value = "value") %>% 
  janitor::clean_names()

racial_inclusion_value <- read.csv(paste0(paths, "Inclusion/Racial Inclusion Values (IS 2019.03.06).csv")) %>% #racial inclusion = new category in 2019
  filter(year == 2017) %>%
  dcast(year + cbsa ~ indicator, var.value = "value") %>% 
  janitor::clean_names()

# inconsistent column names
names(prosperity_value)[[2]] <- "cbsa"
names(prosperity_change)[[2]] <- "cbsa"

# join all three changes
cbsa_change <- prosperity_change %>%
  filter(year == "2007-2017") %>% #update year
  left_join(growth_change, by = c("year", "cbsa")) %>%
  left_join(inclusion_change, by = c("year", "cbsa")) %>%
  left_join(racial_inclusion_change, by = c("year", "cbsa")) %>%
  select(-contains("score"), -contains("name"))

# join all three absolute values
cbsa_value <- prosperity_value %>%
  filter(year == "2017") %>% #update year
  left_join(growth_value, by = c("year", "cbsa")) %>%
  left_join(inclusion_value, by = c("year", "cbsa")) %>%
  left_join(racial_inclusion_value, by = c("year", "cbsa"))
  
# join everything (recoded rank.?.? to the 4 rank categories using Akron as visual sample)
cbsa_metromonitor <- cbsa_change %>%
  left_join(cbsa_value, by = c("cbsa" = "cbsa")) %>%
  rename(
    cbsa_code = cbsa,
    value_year = year.y,
    rank_year_range = year.x,
    prosperity_rank = rank.x,
    growth_rank = rank.y,
    inclusion_rank = rank.x.x,
    racial_inclusion_rank = rank.y.y
  )

# format
cbsa_metromonitor <- cbsa_metromonitor %>%
  mutate_at(c("cbsa_code","value_year","rank_year_range"),as.character) %>%
  mutate_at(vars(contains("_rank")),as.factor) 

# check output
skim_with_defaults()
skim(cbsa_metromonitor)

# save output
dir.create("metro_monitor_2019")
save(cbsa_metromonitor,file = "metro_monitor_2019/metro_monitor_2019.rda")
write.csv(cbsa_metromonitor, "metro_monitor_2019/metro_monitor_2019.csv")

# generate metadata
sink("metro_monitor_2019/metro_monitor_2019.txt")
skim_with(numeric = list(hist = NULL))
skim(cbsa_metromonitor)
sink()

# create README
sink("metro_monitor_2019/README.md")
skim(cbsa_metromonitor)%>% kable()
sink()

