Title:  Export Monitor, 2017, all MSAs
Contact:  Sifan Liu
Source:  https://www.brookings.edu/research/export-monitor-2018/
Last updated:  Mon Jul 15 17:58:10 2019 



|                       label                       |        names         |
|---------------------------------------------------|----------------------|
|                       Year                        |         year         |
|                 CBSA FIPS (2013)                  |      cbsa_code       |
|                 CBSA Name (2013)                  |    cbsa_2013_name    |
| Nominal Exports ( mil.), by All-Industries (CBSA) | cbsa_exports_nominal |
|   Real Exports (mil.), by All-Industries (CBSA)   |  cbsa_exports_real   |
| Export Share of GDP (%), by All-Industries (CBSA) | cbsa_pct_exports_gdp |


Skim summary statistics  
 n obs: 962    
 n variables: 6    

Variable type: character

|    variable    | missing | complete |  n  | min | max | empty | n_unique |
|----------------|---------|----------|-----|-----|-----|-------|----------|
| cbsa_2013_name |    0    |   962    | 962 |  7  | 45  |   0   |   962    |
|   cbsa_code    |    0    |   962    | 962 |  5  |  5  |   0   |   962    |

Variable type: numeric

|       variable       | missing | complete |  n  |  mean   |   sd    |  p0   |  p25   |  p50  |  p75   |   p100    |
|----------------------|---------|----------|-----|---------|---------|-------|--------|-------|--------|-----------|
| cbsa_exports_nominal |    0    |   962    | 962 | 2072.63 | 7713.18 | 24.43 | 215.92 | 442.1 | 1160.8 | 133197.39 |
|  cbsa_exports_real   |    0    |   962    | 962 | 2072.63 | 7713.18 | 24.43 | 215.92 | 442.1 | 1160.8 | 133197.39 |
| cbsa_pct_exports_gdp |    0    |   962    | 962 |  0.12   |  0.063  | 0.013 | 0.079  | 0.11  |  0.16  |   0.46    |
|         year         |    0    |   962    | 962 |  2017   |    0    | 2017  |  2017  | 2017  |  2017  |   2017    |

Title:  Export Monitor, 2017, all MSAs
Contact:  Sifan Liu
Source:  https://www.brookings.edu/research/export-monitor-2018/
Last updated:  Mon Jul 15 17:58:14 2019 



|                        label                        |         names          |
|-----------------------------------------------------|------------------------|
|                        Year                         |          year          |
|                      FIPS code                      |       stco_code        |
|                  County Name (BEA)                  |        co_name         |
|                     State FIPS                      |        st_code         |
|                     State Name                      |        st_name         |
|                     State Code                      |        st_abbr         |
| Nominal Exports ( mil.), by All-Industries (County) | county_exports_nominal |
|   Real Exports (mil.), by All-Industries (County)   |  county_exports_real   |
| Export Share of GDP (%), by All-Industries (County) | county_pct_exports_gdp |


Skim summary statistics  
 n obs: 3113    
 n variables: 9    

Variable type: character

| variable  | missing | complete |  n   | min | max | empty | n_unique |
|-----------|---------|----------|------|-----|-----|-------|----------|
|  co_name  |    0    |   3113   | 3113 | 15  | 45  |   0   |   3113   |
|  st_abbr  |    0    |   3113   | 3113 |  2  |  2  |   0   |    51    |
|  st_code  |    0    |   3113   | 3113 |  2  |  2  |   0   |    51    |
|  st_name  |    0    |   3113   | 3113 |  4  | 20  |   0   |    51    |
| stco_code |    0    |   3113   | 3113 |  5  |  5  |   0   |   3113   |

Variable type: numeric

|        variable        | missing | complete |  n   | mean  |   sd    |  p0   |  p25  |  p50   |  p75   |   p100   |
|------------------------|---------|----------|------|-------|---------|-------|-------|--------|--------|----------|
| county_exports_nominal |    0    |   3113   | 3113 | 640.5 | 2690.18 | 0.85  | 43.12 | 131.26 | 379.72 | 73784.62 |
|  county_exports_real   |    0    |   3113   | 3113 | 640.5 | 2690.18 | 0.85  | 43.12 | 131.26 | 379.72 | 73784.62 |
| county_pct_exports_gdp |    0    |   3113   | 3113 | 0.13  |  0.07   | 0.009 | 0.083 |  0.12  |  0.17  |   0.68   |
|          year          |    0    |   3113   | 3113 | 2017  |    0    | 2017  | 2017  |  2017  |  2017  |   2017   |
