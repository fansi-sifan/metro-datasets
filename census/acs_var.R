# acs variables list ===============================
# RACE ---------------
pop_race_codes <- c("B01003_001", map_chr(seq(1, 3), function(x) paste0("B02001_00", x))) # total population

calculate_pop_race <- function(df) {
  df %>%
    mutate(
      pop_total = B02001_001E,
      pop_white = B02001_002E,
      pop_black = B02001_003E
    )
}


pov_race_codes <- map_chr(seq(13, 21), function(x) paste0("S1701_C03_0", x)) # poverty status
calculate_pov_race <- function(df) {
  df %>%
    mutate(
      pct_belowpoverty_white = S1701_C03_013E / 100,
      pct_belowpoverty_black = S1701_C03_014E / 100
    )
}


commute_race_codes <- c(
  "S0802_C01_001", map_chr(seq(12, 20), function(x) paste0("S0802_C01_0", x)), # all commuter
  "S0802_C02_001", map_chr(seq(12, 20), function(x) paste0("S0802_C02_0", x)), # drive alone
  "S0802_C04_001", map_chr(seq(12, 20), function(x) paste0("S0802_C04_0", x))
) # public transit

calculate_commute_race <- function(df) {
  df %>%
    mutate(
      commuter_white = S0802_C01_012E * S0802_C01_001E,
      commuter_black = S0802_C01_013E * S0802_C01_001E,
      pct_drivealone_total = S0802_C02_001E / S0802_C01_001E,
      pct_drivealone_white = S0802_C02_012E * S0802_C02_001E / commuter_white,
      pct_drivealone_black = S0802_C02_013E * S0802_C02_001E / commuter_black,
      pct_publictrans_total = S0802_C04_001E / S0802_C01_001E,
      pct_publictrans_white = S0802_C04_012E * S0802_C04_001E / commuter_white,
      pct_publictrans_black = S0802_C04_013E * S0802_C04_001E / commuter_black
    ) %>%
    select(-contains("commuter"))
}

emp_race_codes <- c(
  "S2301_C02_001", map_chr(seq(12, 20), function(x) paste0("S2301_C02_0", x)), # labor force participation rate
  "S2301_C03_001", map_chr(seq(12, 20), function(x) paste0("S2301_C03_0", x)), # employment/population ratio
  "S2301_C04_001", map_chr(seq(12, 20), function(x) paste0("S2301_C04_0", x)) # unemployment rate
)

calculate_emp_race <- function(df) {
  df %>%
    mutate(
      lfp_total = S2301_C02_001E / 100,
      lfp_white = S2301_C02_012E / 100,
      lfp_black = S2301_C02_013E / 100,
      epratio_total = S2301_C03_001E / 100,
      epratio_white = S2301_C03_012E / 100,
      epratio_black = S2301_C03_013E / 100,
      unemp_total = S2301_C04_001E / 100,
      unemp_white = S2301_C04_012E / 100,
      unemp_black = S2301_C04_013E / 100
    )
}

edu_codes <- map_chr(str_pad(seq(9, 13), width = 2, side = "left", "0"), function(x) paste0("S1501_C02_0", x))

calculate_edu <- function(df) {
  df %>%
    mutate(
      pct_edu_hs = S1501_C02_009E / 100,
      pct_edu_somecollege = S1501_C02_010E / 100,
      pct_edu_associate = S1501_C02_011E / 100,
      pct_edu_ba = S1501_C02_012E / 100,
      pct_edu_grad = S1501_C02_013E / 100,
      pct_edu_baplus = pct_edu_ba + pct_edu_grad,
      pct_edu_hsplus = pct_edu_hs + pct_edu_somecollege + pct_edu_associate + pct_edu_baplus
    )
}

edu_race_codes <- c(map_chr(seq(28, 54), function(x) paste0("S1501_C01_0", x))) # education attainment

calculate_edu_race <- function(df) {
  df %>%
    mutate(
      pct_edu_hsplus_white = S1501_C01_029E / S1501_C01_028E,
      pct_edu_hsplus_black = S1501_C01_035E / S1501_C01_034E,

      pct_edu_baplus_white = S1501_C01_030E / S1501_C01_028E,
      pct_edu_baplus_black = S1501_C01_036E / S1501_C01_034E
    )
}

income_race_codes <- c("B20017_001", map_chr(LETTERS[1:9], function(x) {
  paste0("B20017", x, "_001")
})) # median earnings by race
calculate_income_race <- function(df) {
  df %>%
    mutate(
      income_total = B20017_001E,
      income_white = B20017A_001E,
      income_black = B20017B_001E
    )
}




# EDU ----------------
income_edu_codes <- map_chr(seq(1, 6), function(x) {
  paste0("B20004_00", x)
}) # median earnings by education attainment
calculate_income_edu <- function(df) {
  df %>%
    mutate(
      income_total = B20004_001E,
      income_edu_hs = B20004_003E,
      income_edu_ba = B20004_005E,
      income_edu_grad = B20004_006E
    )
}


migration_edu_codes <- c(
  map_chr(seq(1, 9), function(x) {
    paste0("B07009_00", x)
  }),
  map_chr(seq(10, 36), function(x) {
    paste0("B07009_0", x)
  })
) # migration by educational attainment

calculate_migration <- function(df) {
  df %>%
    mutate(
      frominstate_edu_baplus = (B07009_023E + B07009_024E),
      frominstate_total = B07009_019E,
      fromdiffstate_edu_baplus = (B07009_029E + B07009_030E),
      fromdiffstate_total = B07009_025E,
      fromabroad_edu_baplus = (B07009_035E + B07009_036E),
      fromabroad_total = B07009_031E,
      movein_edu_baplus = fromabroad_edu_baplus + fromdiffstate_edu_baplus + frominstate_edu_baplus,
      movein_total = fromabroad_total + fromdiffstate_total + frominstate_total,
      pct_newcomer = movein_total / B07009_001E,
      newcomer_pct_edu_baplus = movein_edu_baplus / movein_total
    ) %>%
    select(-contains("from"))
}


# OTHERS -----
zero_car_codes <- c("B08201_001", "B08201_002")
calculate_zerocar <- function(df) {
  df %>%
    mutate(pct_nocar = B08201_002E / B08201_001E)
}


# FUNCTIONS =====


calculate_num_acs <- function(df) {
  df %>%

    # customized calculations
    calculate_pop_race() %>%
    calculate_edu_race() %>%
    calculate_migration() %>%
    calculate_zerocar() %>%

    # keep only the calculated outputs
    select(-contains("E", ignore.case = F), -contains("M", ignore.case = F))
}

calculate_pct_acs <- function(df) {
  df %>%

    # customized calculations
    calculate_income_race() %>%
    calculate_pov_race() %>%
    calculate_edu() %>%
    calculate_emp_race() %>%
    calculate_income_edu() %>%
    calculate_commute_race() %>%

    # keep only the calculated outputs
    select(-contains("E", ignore.case = F), -contains("M", ignore.case = F))
}

calculate_acs <- function(df) {
  df %>%
    calculate_pop_race() %>%
    calculate_edu_race() %>%
    calculate_migration() %>%
    calculate_zerocar() %>%
    calculate_income_race() %>%
    calculate_pov_race() %>%
    calculate_edu() %>%
    calculate_emp_race() %>%
    calculate_income_edu() %>%
    calculate_commute_race() %>%
    
    # keep only the calculated outputs
    select(-contains("E", ignore.case = F), -contains("M", ignore.case = F))
}
