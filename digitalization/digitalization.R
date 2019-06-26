# Get Raw Data and save to 'source' folder
# Author: David Whyman
# Date: Wed Jun 19 14:55:00 2019
# SET UP ==============================================
pkgs <- c("tidyverse", "reshape2", "writexl", "httr","skimr")

check <- sapply(pkgs, require, warn.conflicts = TRUE, character.only = TRUE)
if (any(!check)) {
  pkgs.missing <- pkgs[!check]
  install.packages(pkgs.missing)
  check <- sapply(pkgs.missing, require, warn.conflicts = TRUE, character.only = TRUE)
}



# Digitalization ---------------------------------------------------

#data up to 2016 exists (read source data)
cbsa_digital <- read.csv("source/metro_all_updated.csv") %>%
  mutate(cbsa_code = as.character(`AREA`)) %>%
  janitor::clean_names() %>%
  select(-x)

names<-c(
"cbsa_code",
"2002_score",
"2016_socre",
"2002_pct_high",
"2002_pct_medium",
"2002_pct_low",
"2016_pct_high",
"2016_pct_medium",
"2016_pct_low",
"2002_wage",
"2016_wage",
"2002_employ",
"2016_employ",
"metro",
"cbsa_name",
"2002_employ",
"2010_emoloy",
"2016_employ",
"2002_gdp",
"2010_gdp",
"2016_gdp",
"2002_wage",
"2010_wage",
"2016_wage",
"2002_prod",
"2010_prod",
"2016_prod"
)


#create directory
dir.create("digitalization")
save(cbsa_digital,file = "digitalization/digitalization.rda")

skim_with(integer = list(hist = NULL), numeric = list(hist = NULL))

# sink metadata into .md
sink("digitalization/README.md")
skim(cbsa_digital) %>% kable()
sink()


#txt file with metadata
sink("digitalization/digitalization.txt") 
skim(cbsa_digital)
sink()

#write csv
write_csv(cbsa_digital,"digitalization/digitalization.csv")

