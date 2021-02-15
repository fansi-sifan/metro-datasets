library(tidyverse)
library(skimr)
library(expss)

source("R/save_output.R")

# SET UP ====================================
source_dir <- "source/metro monitor 2021/"
folder_name <- "metro_monitor_2021"
file_name <- "cbsa_metromonitor_2021"

# metadata
dt_title <- "Metro monitor, 2009 - 2019"
dt_src <- "https://www.brookings.edu/interactives/metro-monitor-2021"
dt_contact <- "Sarah Crump"
dt_notes <- ""

# TRANSFORM ============================================
# Metro Monitor ---------------------------------------------------

# absolute value in 2019 and clean names
growth_value <- read_csv(paste0(source_dir, "Growth Values (SC 2021.01.14).csv"))
prosperity_value <- read_csv(paste0(source_dir, "Prosperity Values (SC 2021.01.12 ).csv")) 
inclusion_value <- read_csv(paste0(source_dir, "Inclusion Values (SC 2021.02.13).csv"))
racial_inclusion_value <- read_csv(paste0(source_dir, "Racial Inclusion Values (SC 2021.02.13).csv"))
geographic_inclusion_value <- read_csv(paste0(source_dir, "Geographic Inclusion Values (SC 2020.12.10).csv"))

# change 10 year
growth_change <- read_csv(paste0(source_dir, "Growth Change (SC 2021.01.14).csv"))
prosperity_change<- read_csv(paste0(source_dir, "Prosperity Change (SC 2021.01.12).csv")) 
inclusion_change <- read_csv(paste0(source_dir, "Inclusion Change (SC 2021.02.13).csv"))
racial_inclusion_change <- read_csv(paste0(source_dir, "Racial Inclusion Change (SC 2021.02.13).csv"))
geographic_inclusion_change <- read_csv(paste0(source_dir, "Geographic Inclusion Change (SC 2020.12.10).csv"))

# join all three absolute values
cbsa_value <- growth_value %>% 
  filter(!is.na(metrosize))%>%
  pivot_wider(names_from = "indicator", values_from = "value")%>% 
  rename(cbsa_code = cbsa) %>%
  
  full_join(prosperity_value %>%
              filter(!is.na(metrosize))%>%
              select(year, cbsa_code, indicator, value)%>%
              pivot_wider(names_from = "indicator", values_from = "value"), 
            by = c("year", "cbsa_code")) %>%
  

    full_join(inclusion_value %>% 
              filter(!is.na(metrosize))%>%
              filter(race == "Total" & education == "Total") %>%
              select(year, cbsa_code = cbsa, indicator, value)%>%
              pivot_wider(names_from = "indicator", values_from = "value"), 
            by = c("year", "cbsa_code"))



# FUNCTION load

df_labels <- cbsa_value %>% 
  expss::apply_labels(
  `cbsa_code` = "United States = 99999",
  largest  = "populations of at least 1 million in 2018",
  large = "populations of 500,000 to 999,999 in 2018",
  midsized = "populations of 250,000 to 499,999 in 2018",
  `Relative Income Poverty Rate` = "share of people earning less than half of the local median wage"
) %>% 
  create_labels()

# SAVE OUTPUT
df <- cbsa_value %>%
  ungroup() %>% 
  filter(!is.na(cbsa_name)) %>%
  # filter(year != 2007) %>% 
  mutate(cbsa_code = as.character(cbsa_code))%>%
  select(cbsa_code, cbsa_name, everything()) 
   # make sure unique identifier is the left most column

# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
rmarkdown::render("R/codebook_template.Rmd", output_dir = folder_name, output_file = "README")

dfs <- objects()
df_list <- mget(dfs[grep("_value", dfs)])
df_change <- mget(dfs[grep("_change", dfs)])

save(df_list, file = "metro_monitor_2021/metro_monitor_2021_allyear.rda")
save(df_change, file = "metro_monitor_2021/metro_monitor_2021_change.rda")

#[depreciated] save_meta(df,
#           labels = df_labels, folder = folder_name, file = file_name,
#           title = dt_title, contact = dt_contact, source = dt_src, note = dt_notes
# )
