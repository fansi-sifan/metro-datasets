library(tidyverse)
library(skimr)
library(expss)
library(sjlabelled)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "source/housing_price.csv"
folder_name <- "housing_price"
file_name <- "cbsa_housing_price"

# metadata -----------
dt_title <- "Housing Price to Income Ratios Across Metro Areas"
dt_src <- "https://www.brookings.edu/research/housing-in-the-u-s-is-too-expensive-too-cheap-and-just-right-it-depends-on-where-you-live/"
dt_contact <- "Jenny Schuetz"
df_notes <- "Figures include only tracts where at least 10% of homes are owner-occupied;
 percentile columns contain % of tracts where the price-income ratio is in the given percentile range"

# read datasets
df <- read_csv(source_dir, skip = 5, col_types = cols(CBSA = col_character()))

# variable labels
set_label(df) <- colnames(df)


# variable names
df <- df %>%
  mutate(pi_map = as.factor(`Map category`))%>%
  select(
    "cbsa_code" = "CBSA",
    "cbsa_name" = "Metro Name",
    "tracts" = "# Tracts",
    "households" = "# Households",
    "price" = "Average price",
    "income" = "Average income",
    "pi" = "Average price-income rato",
    "pi_map" = "Map category",
    "pi_10" = "Under 10th percentile",
    "pi_90" = "Above the 90th percentile",
    "pi_10_90" = "Between 10th-90th percentile"
  ) 

# label key
df_labels <- create_labels(df)


# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
  labels = df_labels, folder = folder_name, file = file_name,
  title = dt_title, contact = dt_contact, source = dt_src, note = df_notes
)
