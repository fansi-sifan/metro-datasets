library(tidyverse)

source_dir <- "V:/Performance/Project files/Metro Monitor/2019v/Output/"
df <- readxl::read_excel(paste0(source_dir, "2019 Metro Monitor Data - All Periods.xlsx"), sheet = "2007-2017", skip = 3, col_names = F)
df <- df[, colSums(is.na(df)) < nrow(df)]

names(df) <- c(
  "cbsa_code", "cbsa_name",
  "growth_rank",
  "GDP_rank", "GDP_change", "Jobs_rank", "Jobs_change", "entrepreneur_rank", "entrepreneur_change",
  "prosperity_rank",
  "produc_rank", "produc_change", "wage_rank", "wage_change", "stand_rank", "stand_change",
  "inclusion_rank",
  "medinc_rank", "medinc_change", "relinc_rank", "relinc_change", "epratio_rank", "epratio_change",
  "racial_rank", "racial_sum",
  "gapm_rank", "gapm_change", "gapr_rank", "gapr_change", "gape_rank", "gape_change"
)

mm <- df %>%
  select(cbsa_code, cbsa_name, contains("change")) %>%
  mutate(cbsa_code = as.character(cbsa_code)) %>%
  mutate_if(is.numeric, function(x) (x > 0)) %>%
  # relative income poverty has opposite change
  mutate(relinc_change = !relinc_change) %>%
  mutate_at(vars(contains("gap")), function(x) (!x)) %>%
  mutate(
    growth = GDP_change & Jobs_change & entrepreneur_change,
    prosperity = produc_change & wage_change & stand_change,
    inclusion = medinc_change & relinc_change & epratio_change,
    racial = gapm_change & gapr_change & gape_change
  )


# shapefile
library(sf)
sp100 <- sf::st_read("../../_metro_data_warehouse/data_spatial/shapefiles/2018/insets/top100metros/low_definition/top100_inset_ld.shp")
base <- st_read("../../_metro_data_warehouse/data_spatial/shapefiles/2018/insets/states/low_definition/states51_inset_ld.shp")

base <- st_as_sf(base)
sp <- sf::st_as_sf(sp100)

mm_map <- sp %>%
  mutate(cbsa_code = as.character(CBSAFP)) %>%
  left_join(mm, by = "cbsa_code")


library(tmap)

tm_shape(base, projection = 2163) +
  tm_fill() +
  tm_borders(lwd = 1, col = "grey") +
  tm_shape(mm_map %>%
             filter(growth) %>%
             filter(inclusion) %>%
             filter(racial) %>%
             filter(prosperity), projection = 2163
  ) +
  tm_bubbles(col = "#00659f", size = 1, border.col = "white") +
  tm_layout(frame = F, 
            bg.color = "transparent")
