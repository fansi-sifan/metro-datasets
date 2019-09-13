library(tidyverse)
library(skimr)
library(expss)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "source/out-of-work_appendix_tables_final.xlsx"
folder_name <- "out_of_work"
file_name <- "co_oow"

# metadata
dt_title <- "Out of work population by group"
dt_src <- "https://www.brookings.edu/research/meet-the-out-of-work/"
dt_contact <- "Martha Ross"
df_notes <- "130 large cities and counties across the United States, note that LA, Seattle, Chicago, Detroit, etc. are treated separately from their counties"

# FUNCTION load
df <- readxl::read_xlsx(source_dir, sheet = "Jurisdiction Data", skip = 4) %>%
  mutate(stco_code = str_pad(stco_code, 5, "left", "0"), 
         cbsa_code = as.character(cbsa_code))

# variable labels
set_label(df) <- colnames(df)


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

# SAVE OUTPUT
# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
labels = df_labels, folder = folder_name, file = file_name,
title = dt_title, contact = dt_contact, source = dt_src, note = df_notes
)

