# Get Raw Data and save to 'source' folder
# Author: David Whyman
# Date: Wed Jun 19 15:39:00 2019
# SET UP ==============================================
pkgs <- c("tidyverse", "reshape2", "writexl", "httr","skimr","sjlabelled")

check <- sapply(pkgs, require, warn.conflicts = TRUE, character.only = TRUE)
if (any(!check)) {
  pkgs.missing <- pkgs[!check]
  install.packages(pkgs.missing)
  check <- sapply(pkgs.missing, require, warn.conflicts = TRUE, character.only = TRUE)
}


# ShiftShare ---------------------------------------------------


#original location of source/shiftshare.csv is:
#V:\Performance\Project files\Metro Monitor\2018v/Output/Shift Share\Monitor Shiftshare Cumulative (2-digit NAICS).csv
#no 2019 version of this dataset found

cbsa_shiftshare <- read_csv("source/shiftshare.csv",
  col_types = cols(cbsa2013_fips = col_character())) %>%
  filter(year == 2016) 
  
#use old column names as labels (use View() to see labels)
set_label(cbsa_shiftshare)<-colnames(cbsa_shiftshare)

#new names
select(cbsa_shiftshare,      year,
                             cbsa_code = "cbsa2013_fips" ,
                             "cbsa_2013_name" = "cbsa2013_name",
                             "naics2_code" =  "naics2",
                             "naics2_name" = "industryname_naics2",
                             indicator,
                             "sector_ls_06" = "lsshare2006",
                             "sector_im_06" = "imshare2006",
                             "sector_ns_06" = "nsshare2006",
                             "sector_ls_11" = "lsshare2011",
                             "sector_im_11" = "imshare2011",
                             "sector_ns_11" = "nsshare2011",
                             "sector_ls_15" = "lsshare2015",
                             "sector_im_15" = "imshare2015",
                             "sector_ns_15" = "nsshare2015",
                             value
                             )
colnames(cbsa_shiftshare)
#correspondance between old names (labels) and new names
cbsa_shiftshare_key <- get_label(cbsa_shiftshare) %>%
  data.frame() %>%
  rename_at(vars(1), funs(paste0('labels'))) %>%
  mutate(names = colnames(cbsa_shiftshare)) 


#save output
dir.create("shiftshare")
save(cbsa_shiftshare,file = "shiftshare/shiftshare.rda")

skim_with(numeric = list(hist = NULL))

#save metadata in readme
sink("shiftshare/README.md") 
cbsa_shiftshare_key %>%
  kable()
skim(cbsa_shiftshare) %>%
  kable()
sink()

#txt file with metadata
sink("shiftshare/shiftshare.txt") 
cbsa_shiftshare_key
skim(cbsa_shiftshare)
sink()

#write csv
write_csv(cbsa_shiftshare, "shiftshare/shiftshare.csv")






