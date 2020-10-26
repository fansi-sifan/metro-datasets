library(tidyverse)
library(skimr)
library(expss)
library(reshape2)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "V:/Performance/Project files/Metro Monitor/2020v/Output/Flat Files/"
folder_name <- "metro_monitor_2020"
file_name <- "cbsa_metromonitor_2020"

# metadata
dt_title <- "Metro monitor, 2008 - 2018"
dt_src <- "https://www.brookings.edu/interactives/metro-monitor-2020"
dt_contact <- "Sarah Crump"
dt_notes <- "This year, for the first time, Metro Monitor measured and ranked the performance of 192 metropolitan areas on each indicator within its population size class: 
53 very large metro areas (populations of at least 1 million in 2018); 
56 large metro areas (populations of 500,000 to 999,999 in 2018); 
and 83 midsized metro areas (populations of 250,000 to 499,999 in 2018).
For more details, please check the methodology document: https://www.brookings.edu/wp-content/uploads/2020/03/2020-Metro-Monitor-Methods-and-Data.pdf"


# TRANSFORM ============================================
# Metro Monitor ---------------------------------------------------

# absolute value in 2018 and clean names
growth_value <- read_csv(paste0(source_dir, "Growth Values (SC 2020.01.22).csv"))
prosperity_value <- read_csv(paste0(source_dir, "Prosperity Values (SC 2020.01.22).csv")) 
inclusion_value <- read_csv(paste0(source_dir, "Inclusion Values (SC 2020.02.04).csv"))
racial_inclusion_value <- read_csv(paste0(source_dir, "Racial Inclusion Values (SC 2020.02.03).csv"))
geographic_inclusion_value <- read_csv(paste0(source_dir, "Geographic Inclusion Values (SC 2020.01.22).csv"))

# change from 2008 - 2018
growth_change <- read_csv(paste0(source_dir, "Growth Change (SC 2020.01.22) .csv"))
prosperity_change<- read_csv(paste0(source_dir, "Prosperity Change (SC 2020.01.22).csv")) 
inclusion_change <- read_csv(paste0(source_dir, "Inclusion Change (SC 2020.02.03).csv"))
racial_inclusion_change <- read_csv(paste0(source_dir, "Racial Inclusion Change (SC 2020.02.03).csv"))
geographic_inclusion_change <- read_csv(paste0(source_dir, "Geographic Inclusion Change (SC 2020.01.22).csv"))

# join all three absolute values
cbsa_value <- growth_value %>%
  filter(keep == 1)%>%
  pivot_wider(names_from = "indicator", values_from = "value")%>%
  rename(cbsa_code = cbsa) %>%
  
  full_join(prosperity_value %>%
              filter(keep == 1)%>%
              select(year, cbsa_code, indicator, value)%>%
              pivot_wider(names_from = "indicator", values_from = "value"), 
            by = c("year", "cbsa_code")) %>%
  
  full_join(inclusion_value %>%
              filter(keep == 1)%>%
              filter(race == "Total" & eduatt == "Total") %>%
              select(year, cbsa_code = cbsa, indicator, value)%>%
              pivot_wider(names_from = "indicator", values_from = "value"), 
            by = c("year", "cbsa_code"))

dfs <- objects()
df_list <- mget(dfs[grep("_value", dfs)])
df_change <- mget(dfs[grep("_change", dfs)])

save(df_list, file = "metro_monitor_2020/metro_monitor_2020_allyear.rda")
save(df_change, file = "metro_monitor_2020/metro_monitor_2020_change.rda")

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
df <- df %>%
  ungroup() %>% 
  filter(!is.na(cbsa_name)) %>%
  filter(year != 2007) %>% 
  mutate(cbsa_code = as.character(cbsa_code))%>%
  select(cbsa_code, cbsa_name, everything()) %>% 
  mutate_at(vars(year:midsized), as.factor)
   # make sure unique identifier is the left most column

# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
rmarkdown::render("R/codebook_template.Rmd", output_dir = folder_name, output_file = "README")

#[depreciated] save_meta(df,
#           labels = df_labels, folder = folder_name, file = file_name,
#           title = dt_title, contact = dt_contact, source = dt_src, note = dt_notes
# )
