# Get Raw Data and save to 'source' folder
# Author: Eleanor Noble
# Date: 6/19/2019
# SET UP ==============================================
pkgs <- c("tidyverse", "reshape2", "writexl", "httr","skimr", "janitor", "stringr","sjlabelled")

check <- sapply(pkgs, require, warn.conflicts = TRUE, character.only = TRUE)
if (any(!check)) {
  pkgs.missing <- pkgs[!check]
  install.packages(pkgs.missing)
  check <- sapply(pkgs.missing, require, warn.conflicts = TRUE, character.only = TRUE)
}

# TRANSFORM ============================================
# out of work ---------------------------------------------------
stco_oow <- read.csv("V:/Sifan/Birmingham/County Cluster/source/OutOfWork_county.csv") %>%
  mutate(county_code = str_pad(fips, 5, "left", "0")) %>%
  janitor::clean_names()

stco_oow <- stco_oow %>%
  mutate(young_less_educated_and_diverse_perc = young_less_educated_and_diverse,
         less_educated_prime_age_people_perc = less_educated_prime_age_people, 
         diverse_less_educated_and_eyeing_retirement_perc = diverse_less_educated_and_eyeing_retirement, 
         moderately_educated_older_people_perc = moderately_educated_older_people, 
         highly_educated_and_engaged_younger_people_perc = highly_educated_and_engaged_younger_people, 
         highly_educated_high_income_older_people_perc = highly_educated_high_income_older_people,
         stco_code = as.character(county_code),
         co_name = as.character(jurisdiction))%>%
  select(-young_less_educated_and_diverse,
         -less_educated_prime_age_people,
         -diverse_less_educated_and_eyeing_retirement,
         -motivated_and_moderately_educated_younger_people,
         -moderately_educated_older_people,
         -highly_educated_and_engaged_younger_people,
         -highly_educated_high_income_older_people,
         -x_1,
         -x,
         -fips,
         -cbsacode,
         -jurisdiction,
         -county_code)

#change the percentages from "%char" to numeric .xx
cols.num <- c("young_less_educated_and_diverse_perc","less_educated_prime_age_people_perc",             
              "diverse_less_educated_and_eyeing_retirement_perc","moderately_educated_older_people_perc",           
              "highly_educated_and_engaged_younger_people_perc","highly_educated_high_income_older_people_perc")

stco_oow[cols.num] <- sapply(stco_oow,function(x) gsub("%","",as.numeric(x)))
stco_oow[cols.num] <- sapply(stco_oow[cols.num],as.numeric)
stco_oow[cols.num]<-stco_oow[cols.num]/100

# check output
skim_with_defaults()
skim(stco_oow)

# save output
dir.create("out_of_work")

save(stco_oow,file = "out_of_work/stco_oow.rda")

# generate metadata county
sink("out_of_work/stco_oow.txt")
skim_with(numeric = list(hist = NULL))
skim(stco_oow)
sink()

# create README county
sink("out_of_work/README.md")
skim(stco_oow)%>% kable()
sink()


# write csv to github
write.csv(stco_oow, "out_of_work/stco_oow.csv")
