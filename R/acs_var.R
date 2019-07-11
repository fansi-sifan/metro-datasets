# acs variables list ==================

# Basics ---------------
pop_race_codes <- c("S2301_C01_001",map_chr(seq(12,20),function(x)paste0("S2301_C01_0",x))) # total population
pov_race_codes <- map_chr(seq(13,21),function(x)paste0("S1701_C03_0",x))  # poverty status
drive_codes <- c("S0802_C01_001", "S0802_C02_001") #drove to work alone

# Labor market --------------
lfp_race_codes <- c("S2301_C02_001",map_chr(seq(12,20),function(x)paste0("S2301_C01_0",x))) # labor force participation rate
epop_race_codes <- c("S2301_C03_001",map_chr(seq(12,20),function(x)paste0("S2301_C01_0",x))) # employment/population ratio
unemp_race_codes <- c("S2301_C04_001",map_chr(seq(12,20),function(x)paste0("S2301_C01_0",x))) # unemployment rate

# Education ------------
ed_race_codes <- map_chr(seq(28,54),function(x)paste0("S1501_C01_0",x)) # education attainment
earnings_edu_codes <- map_chr(seq(1,6),function(x){paste0("B20004_00",x)}) # median earnings by education attainment

