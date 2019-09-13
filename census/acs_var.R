# acs variables list ===============================
# RACE ---------------
pop_race_codes <- c("B01003_001",map_chr(seq(1,3),function(x)paste0("B02001_00",x))) # total population

calculate_pop_race <-  function(df) {
  df %>%
    mutate(
      pop_tot = B02001_001E,
      pop_wh = B02001_002E,
      pop_bk = B02001_003E)
}
      
pov_race_codes <- map_chr(seq(13,21),function(x)paste0("S1701_C03_0",x))  # poverty status
calculate_pov_race <- function(df){
  df %>% 
    mutate(
      pct_belowpoverty_wh = S1701_C03_013E/100,
      pct_belowpoverty_bk = S1701_C03_014E/100)
}


commute_race_codes = c("S0802_C01_001", map_chr(seq(12,20),function(x)paste0("S0802_C01_0",x)), # all commuter
                       "S0802_C02_001", map_chr(seq(12,20),function(x)paste0("S0802_C02_0",x)), # drive alone
                       "S0802_C04_001", map_chr(seq(12,20),function(x)paste0("S0802_C04_0",x))) # public transit

calculate_commute_race <- function(df){
  df %>%
    mutate(commuter_wh = S0802_C01_012E*S0802_C01_001E,
           commuter_bk = S0802_C01_013E*S0802_C01_001E,
           pct_drivealone_total = S0802_C02_001E/S0802_C01_001E,
           pct_drivealone_wh = S0802_C02_012E*S0802_C02_001E/commuter_wh,
           pct_drivealone_bk = S0802_C02_013E*S0802_C02_001E/commuter_bk,
           pct_publictrans_total = S0802_C04_001E/S0802_C01_001E,
           pct_publictrans_wh = S0802_C04_012E*S0802_C04_001E/commuter_wh,
           pct_publictrans_bk = S0802_C04_013E*S0802_C04_001E/commuter_bk)%>%
    select(-contains("commuter"))
}

emp_race_codes <- c("S2301_C02_001",map_chr(seq(12,20),function(x)paste0("S2301_C02_0",x)), # labor force participation rate
                    "S2301_C03_001",map_chr(seq(12,20),function(x)paste0("S2301_C03_0",x)), # employment/population ratio
                    "S2301_C04_001",map_chr(seq(12,20),function(x)paste0("S2301_C04_0",x))  # unemployment rate
  
)

calculate_emp_race <-  function(df) {
  df %>%
    mutate(
      lfp_total = S2301_C02_001E/100,
      lfp_wh = S2301_C02_012E/100,
      lfp_bk = S2301_C02_013E/100,
      epratio_total = S2301_C03_001E/100,
      epratio_wh = S2301_C03_012E/100,
      epratio_bk = S2301_C03_013E/100,
      unemp_total = S2301_C04_001E/100,
      unemp_wh = S2301_C04_012E/100,
      unemp_bk = S2301_C04_013E/100
    )
}

edu_codes <- map_chr(str_pad(seq(9,13),width = 2,side = "left","0"),function(x)paste0("S1501_C02_0",x))

calculate_edu <- function(df){
  df %>%
    mutate(
      pct_hs = S1501_C02_009E/100,
      pct_somecollege = S1501_C02_010E/100,
      pct_associate = S1501_C02_011E/100,
      pct_ba = S1501_C02_012E/100,
      pct_grad = S1501_C02_013E/100,
      pct_babeyond = pct_ba + pct_grad,
      pct_hsbeyond = pct_hs + pct_somecollege + pct_associate + pct_babeyond
     )
}

edu_race_codes <- c(map_chr(seq(28,54),function(x)paste0("S1501_C01_0",x)))# education attainment

calculate_edu_race <-  function(df) {
  df %>%
    mutate(
           pct_hs_above_wh = S1501_C01_029E/S1501_C01_028E,
           pct_hs_above_bk = S1501_C01_035E/S1501_C01_034E,
          
           pct_ba_above_wh = S1501_C01_030E/S1501_C01_028E,
           pct_ba_above_bk = S1501_C01_036E/S1501_C01_034E)}

income_race_codes <- c("B20017_001",map_chr(LETTERS[1:9],function(x){paste0("B20017",x,"_001")})) # median earnings by race
calculate_income_race <- function(df){
  df %>%
    mutate(income_total = B20017_001E,
           income_wh = B20017A_001E,
           income_bk = B20017B_001E
    )
}




# EDU ----------------
income_edu_codes <- map_chr(seq(1,6),function(x){paste0("B20004_00",x)}) # median earnings by education attainment
calculate_income_edu <- function(df){
  df %>%
    mutate(income_total = B20004_001E,
           income_hs = B20004_003E,
           income_ba = B20004_005E,
           income_prof = B20004_006E
    )
}


migration_edu_codes <- c(map_chr(seq(1,9),function(x){paste0("B07009_00",x)}),
                         map_chr(seq(10,36),function(x){paste0("B07009_0",x)}))# migration by educational attainment

calculate_migration <- function(df){
  df %>%
    mutate(frominstate_ba_above = (B07009_023E+B07009_024E),
           frominstate_total = B07009_019E,
           fromdiffstate_ba_above = (B07009_029E+B07009_030E),
           fromdiffstate_total = B07009_025E,
           fromabroad_ba_above = (B07009_035E+B07009_036E),
           fromabroad_total = B07009_031E,
           movein_ba_above = fromabroad_ba_above+fromdiffstate_ba_above+frominstate_ba_above,
           movein_total = fromabroad_total+fromdiffstate_total+frominstate_total,
           pct_newcomer = movein_total/B07009_001E,
           newcomer_pct_ba_above = movein_ba_above/movein_total) %>%
    select(-contains("from"))
}


# OTHERS -----
zero_car_codes <- c("B08201_001","B08201_002")
calculate_zerocar <- function(df){
  df %>%
    mutate(pct_nocar = B08201_002E/B08201_001E)
}


# FUNCTIONS =====


calculate_num_acs <- function(df){
  df %>%
    
    # customized calculations
    calculate_pop_race %>%
    calculate_edu_race %>%
    calculate_migration %>%
    calculate_zerocar %>%
    
    # keep only the calculated outputs
    select(-contains("E",ignore.case = F), -contains("M", ignore.case = F))
}

calculate_pct_acs <- function(df){
  df %>%
    
    # customized calculations
    calculate_income_race %>%
    calculate_pov_race %>%
    calculate_edu %>%
    calculate_emp_race %>%
    calculate_income_edu %>%
    calculate_commute_race %>%

    # keep only the calculated outputs
    select(-contains("E",ignore.case = F), -contains("M", ignore.case = F))
}

calculate_acs <- function(df){
  df %>%
    calculate_num_acs()%>%
    calculate_pct_acs()
  }
