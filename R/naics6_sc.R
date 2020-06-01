library(tabulizer)
library(tidyverse)
library(tidylog)

#"https://www.dropbox.com/s/909kjdhad4z0w0f/AppendixB_SupplyChain_Categorization.pdf?dl=0"
tmp <- tabulizer::extract_tables("../../../The Brookings Institution/Metro Research - JParilla/COVID recession/library/small biz/AppendixB_SupplyChain_Categorization.pdf")

naics_sc <- purrr::map(tmp[3:20], as.data.frame) %>%
  dplyr::bind_rows() %>%
  filter(V1 != "") %>%
  select(naics6_code = V2, naics6_name = V3, sc = V5, traded = V6, mfg = V7,
         emp15 = V8, pct_pce = V9) %>%
  mutate_at(vars(sc:pct_pce), ~as.numeric(gsub("%","",.)))

save(naics_sc, file = "R/naics_sc.rda")


