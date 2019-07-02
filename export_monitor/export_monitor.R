# Get Raw Data and save to 'source' folder
# Author: David Whyman
# Date: Wed Jun 19 14:55:00 2019
# SET UP ==============================================
pkgs <- c("tidyverse", "reshape2", "writexl", "httr", "skimr", "sjlabelled") # sjlabelled for column labels

check <- sapply(pkgs, require, warn.conflicts = TRUE, character.only = TRUE)
if (any(!check)) {
  pkgs.missing <- pkgs[!check]
  install.packages(pkgs.missing)
  check <- sapply(pkgs.missing, require, warn.conflicts = TRUE, character.only = TRUE)
}


# Export Monitor---------------------------------------------------

# data up to 2017 exists


cbsa_export <- readxl::read_xlsx("V:/Export Monitor/2018/Deliverables/Deliverables/Metros Data/Metros by Total, NAICS 2 3.xlsx", sheet = "Total") %>%
  filter(Year == 2017)


# use old column names as labels (use View() to see labels)
set_label(cbsa_export) <- colnames(cbsa_export)

cbsa_export <- select(cbsa_export,
  year = "Year",
  cbsa_code = "CBSA FIPS (2013)",
  cbsa_2013_name = "CBSA Name (2013)",
  cbsa_2013_short_name = "CBSA Short Name (2013)",
  is_top100 = "Largest 100 Metro",
  is_top100_label = "Largest 100 Metro Label",
  is_metro = "Metro",
  is_metro_label = "Metro Label",
  cbsa_exports_nominal = "Nominal Exports ( mil.), by All-Industries (CBSA)",
  cbsa_exports_real = "Real Exports (mil.), by All-Industries (CBSA)",
  cbsa_pct_exports_gdp = "Export Share of GDP (%), by All-Industries (CBSA)",
  cbsa_export_jobs_direct = "Direct Export-supported Jobs, by All-Industries (CBSA)",
  cbsa_export_jobs_direct_intensity = "Direct Export Jobs Intensity, by All-Industries (CBSA)",
  cbsa_export_jobs_total = "Total Export-supported Jobs, by All-Industries (CBSA)",
  cbsa_export_jobs_total_intensity = "Total Export Jobs Intensity, by All-Industries (CBSA)",
  cbsa_2003_2014_pct_export_growth = "Annualized Export Growth 2003-2014 (%), by All-Industries (CBSA)",
  cbsa_2008_2017_pct_export_growth = "Annualized Export Growth 2008-2017 (%), by All-Industries (CBSA)",
  cbsa_2014_2017_pct_export_growth = "Annualized Export Growth 2014-2017 (%), by All-Industries (CBSA)",
  cbsa_2003_2017_pct_export_growth = "Annualized Export Growth 2003-2017 (%), by All-Industries (CBSA)",
  cbsa_pct_export_growth = "Year-to-Year Export Growth (%), by All-Industries (CBSA)",
  cbsa_gdp_nominal = "Nominal GDP (mil.), by All-Industries (CBSA)",
  cbsa_gdp_real = "Real GDP (mil.), by All-Industries (CBSA)",
  cbsa_2003_2014_pct_gdp_growth = "Annualized GDP Growth 2003-2014 (%), by All-Industries (CBSA)",
  cbsa_2008_2017_pct_gdp_growth = "Annualized GDP Growth 2008-2017 (%), by All-Industries (CBSA)",
  cbsa_2003_2017_pct_gdp_growth = "Annualized GDP Growth 2003-2017 (%), by All-Industries (CBSA)",
  cbsa_2014_2017_pct_gdp_growth = "Annualized GDP Growth 2014-2017 (%), by All-Industries (CBSA)",
  cbsa_pct_gdp_growth = "Year-to-Year GDP Growth (%), by All-Industries (CBSA)",
  cbsa_jobs = "Total Jobs, by All-Industries (CBSA)"
)


# COUNTY LEVEL   -------------

# load data
county_export <- readxl::read_xlsx("V:/Export Monitor/2018/Deliverables/Deliverables/Counties Data/Counties by Total, NAICS 2.xlsx", sheet = "Total") %>%
  filter(Year == 2017) %>%
  mutate(stcofips_code = str_pad(as.character(`(County)`), 5, "left", "0"))

# use old column names as labels (use View() to see labels)
set_label(county_export) <- colnames(county_export)

# set new column names
county_export <- select(county_export,
  year = Year,
  co_name = "County Name (BEA)",
  is_top100 = "Largest 100 Metro",
  is_top100_label = "Largest 100 Metro Label",
  is_metro = Metro,
  is_metro_label = "Metro Label",
  st_code = "State FIPS",
  st_name = "State Name",
  st_abbr = "State Code",
  county_exports_nominal = "Nominal Exports ( mil.), by All-Industries (County)",
  county_exports_real = "Real Exports (mil.), by All-Industries (County)",
  county_pct_exports_gdp = "Export Share of GDP (%), by All-Industries (County)",
  county_export_jobs_direct = "Direct Export-supported Jobs, by All-Industries (County)",
  county_export_jobs_direct_intensity = "Direct Export Jobs Intensity, by All-Industries (County)",
  county_export_jobs_total = "Total Export-supported Jobs, by All-Industries (County)",
  county_export_jobs_total_intensity = "Total Export Jobs Intensity, by All-Industries (County)",
  county_2003_2014_pct_export_growth = "Annualized Export Growth 2003-2014 (%), by All-Industries (County)",
  county_2008_2017_pct_export_growth = "Annualized Export Growth 2008-2017 (%), by All-Industries (County)",
  county_2014_2017_pct_export_growth = "Annualized Export Growth 2014-2017 (%), by All-Industries (County)",
  county_2003_2017_pct_export_growth = "Annualized Export Growth 2003-2017 (%), by All-Industries (County)",
  county_pct_export_growth = "Year-to-Year Export Growth (%), by All-Industries (County)",
  county_gdp_nominal = "Nominal GDP (mil.), by All-Industries (County)",
  county_gdp_real = "Real GDP (mil.), by All-Industries (County)",
  county_2003_2014_pct_gdp_growth = "Annualized GDP Growth 2003-2014 (%), by All-Industries (County)",
  county_2008_2017_pct_gdp_growth = "Annualized GDP Growth 2008-2017 (%), by All-Industries (County)",
  county_2003_2017_pct_gdp_growth = "Annualized GDP Growth 2003-2017 (%), by All-Industries (County)",
  county_2014_2017_pct_gdp_growth = "Annualized GDP Growth 2014-2017 (%), by All-Industries (County)",
  county_pct_gdp_growth = "Year-to-Year GDP Growth (%), by All-Industries (County)",
  county_jobs = "Total Jobs, by All-Industries (County)",
  stco_code = "stcofips_code"
)



# correspondance between old names (labels) and new names
county_export_key <- get_label(county_export) %>%
  data.frame() %>%
  rename_at(vars(1), funs(paste0("labels"))) %>%
  mutate(names = colnames(county_export))


# create directory
# dir.create("export_monitor")
save(cbsa_export, file = "export_monitor/export_monitor_cbsa.rda")
save(county_export, file = "export_monitor/export_monitor_county.rda")

skim_with(integer = list(hist = NULL), numeric = list(hist = NULL))

# sink metadata into .md
sink("export_monitor/README.md")
county_export_key %>% kable()
cbsa_export_key %>% kable()
skim(county_export) %>% kable()
skim(cbsa_export) %>% kable()
sink()


# txt file with metadata
sink("export_monitor/export_monitor.txt")
county_export_key
cbsa_export_key
skim(county_export) %>% kable()
skim(cbsa_export) %>% kable()
sink()


