# Get Raw Data and save to 'source' folder
# Author: Eleanor Noble
# Date: 6/19/2019
# SET UP ==============================================
pkgs <- c("tidyverse", "reshape2", "writexl", "httr","skimr", "janitor", "stringr")

check <- sapply(pkgs, require, warn.conflicts = TRUE, character.only = TRUE)
if (any(!check)) {
  pkgs.missing <- pkgs[!check]
  install.packages(pkgs.missing)
  check <- sapply(pkgs.missing, require, warn.conflicts = TRUE, character.only = TRUE)
}

# TRANSFORM ============================================
# out of work ---------------------------------------------------
county_OoW <- read.csv("V:/Sifan/Birmingham/County Cluster/source/OutOfWork_county.csv") %>%
  mutate(county_code = str_pad(fips, 5, "left", "0")) %>%
  janitor::clean_names()

county_OoW <- county_OoW %>%
  mutate(young_less_educated_and_diverse_perc = young_less_educated_and_diverse,
         less_educated_prime_age_people_perc = less_educated_prime_age_people, 
         diverse_less_educated_and_eyeing_retirement_perc = diverse_less_educated_and_eyeing_retirement, 
         moderately_educated_older_people_perc = moderately_educated_older_people, 
         highly_educated_and_engaged_younger_people_perc = highly_educated_and_engaged_younger_people, 
         highly_educated_high_income_older_people_perc = highly_educated_high_income_older_people)

#remove unnecessary columns 
county_OoW$young_less_educated_and_diverse <- NULL  
county_OoW$less_educated_prime_age_people <- NULL
county_OoW$diverse_less_educated_and_eyeing_retirement <-NULL
county_OoW$motivated_and_moderately_educated_younger_people<-NULL
county_OoW$moderately_educated_older_people<-NULL
county_OoW$highly_educated_and_engaged_younger_people<-NULL
county_OoW$highly_educated_high_income_older_people<-NULL
county_OoW$x_1<-NULL
county_OoW$x<-NULL
county_OoW$fips<-NULL

#change the percentages from "%char" to numeric .xx
cols.num <- c("young_less_educated_and_diverse_perc","less_educated_prime_age_people_perc",             
              "diverse_less_educated_and_eyeing_retirement_perc","moderately_educated_older_people_perc",           
              "highly_educated_and_engaged_younger_people_perc","highly_educated_high_income_older_people_perc")

county_OoW[cols.num] <- sapply(county_OoW,function(x) gsub("%","",as.numeric(x)))

county_OoW[cols.num] <- sapply(county_OoW[cols.num],as.numeric)

county_OoW[cols.num]<-county_OoW[cols.num]/100

#rename some columns
names(county_OoW)[names(county_OoW) == 'jurisdiction'] <- 'county_name'
names(county_OoW)[names(county_OoW) == 'cbsacode'] <- 'cbsa_code'

#change classes
county_OoW$county_code<-as.character(county_OoW$county_code)
county_OoW$county_name<-as.character(county_OoW$county_name)
county_OoW$cbsa_code<-as.character(county_OoW$cbsa_code)

# check output
skim_with_defaults()
skim(county_OoW)

# save output
dir.create("out_of_work")

save(county_OoW,file = "out_of_work/county_OoW.rda")

# generate metadata county
sink("out_of_work/county_OoW.txt")
skim_with(numeric = list(hist = NULL))
skim(county_OoW)
sink()

# create README msa
sink("out_of_work/county_OoW.md")
skim(county_OoW)%>% kable()
sink()

# write csv to github
write.csv(county_OoW, "out_of_work/county_OoW.csv")


