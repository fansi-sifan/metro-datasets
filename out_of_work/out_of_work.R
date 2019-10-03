library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
source_dir1 <- "source/out-of-work_appendix_tables_final.xlsx"
source_dir2 <- "source/2019.04.09_Brookings-metro_Out-of-work_Data-Appendix_Ross-Holmes.xlsx"
folder_name <- "out_of_work"
file_name <- "co_oow"

# metadata
dt_title <- "Out of work population by group"
dt_src <- "https://www.brookings.edu/research/meet-the-out-of-work/ and 
https://www.brookings.edu/research/young-adults-who-are-out-of-work/"
dt_contact <- "Martha Ross"
df_notes <- "This analysis is based on 2013–2015 three-year American Community Survey (ACS) PublicUse Microdata Samples data. The U.S. Census Bureau ceased production of three-year
ACS products in fall 2015, so we constructed our own three-year dataset by pooling single year data for 2013, 2014, and 2015, and adjusting weights according to annual change in
population using Population Estimates Program county population totals. All nominal dollars
were converted to 2015 dollars.
In the prior report, we focused on 130 large jurisdictions (counties, cities, and county
remainders net of large cities) that could be constructed neatly from 2010 Public-Use
Microdata Areas (PUMAs) and provided sufficient sample size for our analysis. In this
report we started from the same list of 130 jurisdictions and dropped those with samples
of fewer than 150 unweighted observations of “out-of-work” individuals, as defined below.
Consequently, we ended up with 119 jurisdictions with sample populations ranging from
155 out-of-work individuals (Seattle, Wash.) to 3,249 (Los Angeles County, Calif., net of Los
Angeles city). (The numbers in the previous sentences refer to unweighted observations from
the sample, not the estimated number of out-of-work individuals in a given jurisdiction.)."

# FUNCTION load
df1 <- readxl::read_xlsx(source_dir1, sheet = "Jurisdiction Data", skip = 4) %>%
  mutate(stco_code = str_pad(stco_code, 5, "left", "0"), 
         cbsa_code = as.character(cbsa_code),
         age = "25-64",
         population = case_when(
           population == "Sample population" ~ "Out-of-work population",
           TRUE ~ population
         )) 

df2 <- readxl::read_xlsx(source_dir2, sheet = "stats by jurisdiction", skip = 12) %>%
  mutate(stco_code = str_pad(str_sub(pl_code,1,-2), 5, "left", "0"),
         age = "18-24") %>%
  left_join(metro.data::county_cbsa_st[c("stco_code","cbsa_code")], by = "stco_code")

df <- bind_rows(df1,df2)

# variable names
df <- df %>%
  apply_labels(
    cbsa_code	=	"5 digit cbsa code",
    population	=	"Subset of the population",
    total	=	"Weighted population estimates",
    med_fam_income_adj	=	"Median family income ",
    pemployed	=	"Percent currently employed",
    punemployed	=	"Percent currently unemployed",
    pnilf	=	"Percent currently not in labor force",
    plw1 = "Percent last worked in the past year",
    plw5 = "Percent last worked in the last 1-5 year",
    pfemale = "Percent female",
    pmale	=	"Percent male",
    med_age = "Median age",
    pa2534	=	"Percent age 25-34",
    pa3544	=	"Percent age 35-44",
    pa4554	=	"Percent age 45-54",
    pa5564	=	"Percent age 55-64",
    pa2550	=	"Percent age 25-50",
    pa5164	=	"Percent age 51-64",
    pwhiteNH	=	"Percent white, non-hispanic",
    pblackNH	=	"Percent black, non-hispanic",
    platino	=	"Percent hispanic",
    pasianNH	=	"Percent asian, non-hispanic",
    potherNH	=	"Percent all other races, non-hispanic",
    plths	=	"Percent with less than high school education",
    phs	=	"Percent with high school diploma or equivalent",
    psc	=	"Percent some college education",
    paa	=	"Percent with an associate degree",
    pbaplus	=	"Percent with a bachelor's degree or higher",
    pinsch	=	"Percent enrolled in school",
    pdis	=	"Percent reports any disability",
    pdisv	=	"Percent reports any disability, vision",
    pdish	=	"Percent reports any disability, hearing",
    pdisc	=	"Percent reports any disability, cognitive",
    pdisa	=	"Percent reports any disability, ambulatory",
    plep	=	"Percent reports limited English proficiency",
    pfb	=	"Percent foreign born",
    fb1 = "Most common fb country",
    pfb1	=	"Percent of fb",
    lsh1 = "Language speak at home",
    plsh1 = "Percent of lsh",
    ind1 = "Most common sector", 
    pind1 = "Percent of ind",
    occ1 = "Most common occupation", 
    pocc1 = "Percent of occ",
    pmar_1	=	"Percent married",
    pnospouse_kids	=	"Percent single parent",
    pchildren	=	"Percent has a child",
    psafetynet	=	"Percent receives SSI, public assistance income, SNAP &/or Medicaid"
  )

df_labels <- create_labels(df)

df <- select(df, stco_code, age, everything()) %>%
  filter(!is.na(cbsa_code))

# SAVE OUTPUT
# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
labels = df_labels, folder = folder_name, file = file_name,
title = dt_title, contact = dt_contact, source = dt_src, note = df_notes
)

