
Title:  Metro monitor, 2007 - 2017  

Contact:  Isha Shah  

Source:  https://www.brookings.edu/research/metro-monitor-2019-inclusion-remains-elusive-amid-widespread-metro-growth-and-rising-prosperity/  

Note:  The 6 missing growth rank factors were due to LEHD and EMSI job data gaps for the following MSAs:
Wichita, KS, 
Worcester, MA
Springfield, MA
Providence-New Bedford-Fall River, RI-MA
Nashville-Davidson--Murfreesboro, TN 
Boston-Cambridge-Quincy, MA-NH (Metro Area)  

Last updated:  Tue Sep 17 18:21:44 2019 



|                              label                              |                 names                 |
|-----------------------------------------------------------------|---------------------------------------|
|                                                                 |            rank_year_range            |
|                                                                 |               cbsa_code               |
|                                                                 |                 count                 |
|                                                                 |            prosperity_rank            |
|                                                                 |              growth_rank              |
|                                                                 |            inclusion_rank             |
|                                                                 |         racial_inclusion_rank         |
|                                                                 |              value_year               |
|                                                                 |          average_annual_wage          |
|                                                                 |            output_per_job             |
|                                                                 |           output_per_person           |
|                                                                 |   employment_at_firms_0_5_years_old   |
|                                                                 |                 jobs                  |
|                                                                 |               real_gdp                |
|                                                                 |    employment_to_population_ratio     |
|                                                                 |             median_income             |
| share of people earning less than half of the local median wage |        relative_income_poverty        |
|                                                                 | gap_in_employment_to_population_ratio |
|                                                                 |         gap_in_median_income          |
|                                                                 |    gap_in_relative_income_poverty     |


Skim summary statistics  
 n obs: 1139    
 n variables: 20    

Variable type: character

|    variable     | missing | complete |  n   | min | max | empty | n_unique |
|-----------------|---------|----------|------|-----|-----|-------|----------|
|    cbsa_code    |    0    |   1139   | 1139 |  1  |  5  |   0   |   939    |
| rank_year_range |   839   |   300    | 1139 |  9  |  9  |   0   |    3     |
|   value_year    |    0    |   1139   | 1139 |  4  |  4  |   0   |    1     |

Variable type: integer

|       variable        | missing | complete |  n   | mean  |  sd   | p0 |  p25  | p50  |  p75  | p100 |
|-----------------------|---------|----------|------|-------|-------|----|-------|------|-------|------|
|         count         |  1039   |   100    | 1139 |   3   |   0   | 3  |   3   |  3   |   3   |  3   |
|      growth_rank      |   849   |   290    | 1139 | 48.85 | 27.98 | 1  |  25   |  49  |  73   |  98  |
|    inclusion_rank     |   839   |   300    | 1139 | 50.5  | 28.91 | 1  | 25.75 | 50.5 | 75.25 | 100  |
|    prosperity_rank    |  1039   |   100    | 1139 | 50.5  | 29.01 | 1  | 25.75 | 50.5 | 75.25 | 100  |
| racial_inclusion_rank |   839   |   300    | 1139 | 50.5  | 28.91 | 1  | 25.75 | 50.5 | 75.25 | 100  |

Variable type: numeric

|               variable                | missing | complete |  n   |   mean    |    sd     |    p0    |   p25    |   p50    |    p75    |   p100    |
|---------------------------------------|---------|----------|------|-----------|-----------|----------|----------|----------|-----------|-----------|
|          average_annual_wage          |    4    |   1135   | 1139 | 43688.15  |  9268.57  | 25496.51 | 37938.04 | 41793.53 | 47307.83  | 122925.66 |
|   employment_at_firms_0_5_years_old   |   568   |   571    | 1139 | 74403.17  | 435594.15 |   958    |   6644   |  21260   |   45592   |   1e+07   |
|    employment_to_population_ratio     |   560   |   579    | 1139 |   0.72    |   0.05    |   0.53   |   0.69   |   0.72   |   0.75    |   0.86    |
| gap_in_employment_to_population_ratio |   560   |   579    | 1139 |   0.07    |   0.059   | 0.00016  |  0.029   |  0.056   |   0.096   |   0.42    |
|         gap_in_median_income          |   560   |   579    | 1139 | 11797.04  |  4957.03  |   3.08   | 8728.88  | 11527.57 | 15037.46  | 28716.13  |
|    gap_in_relative_income_poverty     |   560   |   579    | 1139 |   0.083   |   0.051   | 1.5e-05  |  0.053   |  0.074   |   0.11    |   0.37    |
|                 jobs                  |   20    |   1119   | 1139 | 537446.71 | 5501824.6 | 3649.57  | 18307.4  | 46715.28 | 259964.14 |  1.5e+08  |
|             median_income             |   560   |   579    | 1139 | 32241.79  |  5311.99  | 20197.01 | 29435.94 | 31036.11 | 35108.39  | 52890.57  |
|            output_per_job             |   20    |   1119   | 1139 | 108298.39 | 23209.14  | 62741.89 | 93540.7  |  1e+05   | 117355.53 | 279206.06 |
|           output_per_person           |   20    |   1119   | 1139 | 47340.29  | 16366.44  | 15458.01 | 36285.72 | 45224.02 | 55879.45  | 156625.52 |
|               real_gdp                |   20    |   1119   | 1139 |  7.2e+10  |  7.3e+11  | 3.3e+08  | 1.8e+09  | 4.7e+09  |  2.7e+10  |  1.9e+13  |
|        relative_income_poverty        |   560   |   579    | 1139 |   0.26    |   0.025   |   0.17   |   0.25   |   0.26   |   0.27    |   0.37    |
