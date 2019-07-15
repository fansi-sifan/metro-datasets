
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

Last updated:  Mon Jul 15 19:08:42 2019 



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
 n obs: 100    
 n variables: 20    

Variable type: character

|    variable     | missing | complete |  n  | min | max | empty | n_unique |
|-----------------|---------|----------|-----|-----|-----|-------|----------|
|    cbsa_code    |    0    |   100    | 100 |  5  |  5  |   0   |   100    |
| rank_year_range |    0    |   100    | 100 |  9  |  9  |   0   |    1     |
|   value_year    |    0    |   100    | 100 |  4  |  4  |   0   |    1     |

Variable type: integer

|       variable        | missing | complete |  n  | mean |  sd   | p0 |  p25  | p50  |  p75  | p100 |
|-----------------------|---------|----------|-----|------|-------|----|-------|------|-------|------|
|         count         |    0    |   100    | 100 |  3   |   0   | 3  |   3   |  3   |   3   |  3   |
|      growth_rank      |    6    |    94    | 100 | 47.5 | 27.28 | 1  | 24.25 | 47.5 | 70.75 |  94  |
|    inclusion_rank     |    0    |   100    | 100 | 50.5 | 29.01 | 1  | 25.75 | 50.5 | 75.25 | 100  |
|    prosperity_rank    |    0    |   100    | 100 | 50.5 | 29.01 | 1  | 25.75 | 50.5 | 75.25 | 100  |
| racial_inclusion_rank |    0    |   100    | 100 | 50.5 | 29.01 | 1  | 25.75 | 50.5 | 75.25 | 100  |

Variable type: numeric

|               variable                | missing | complete |  n  |   mean    |     sd     |    p0    |    p25    |    p50    |    p75     |   p100    |
|---------------------------------------|---------|----------|-----|-----------|------------|----------|-----------|-----------|------------|-----------|
|          average_annual_wage          |    0    |   100    | 100 | 52130.57  |  11466.65  | 33246.19 | 45759.86  | 49723.55  |  54163.46  | 122925.66 |
|   employment_at_firms_0_5_years_old   |    2    |    98    | 100 |   1e+05   | 151893.41  |  15250   |  28671.5  |   45098   | 109763.25  |  1064924  |
|    employment_to_population_ratio     |    0    |   100    | 100 |   0.73    |   0.037    |   0.61   |   0.71    |   0.73    |    0.75    |   0.82    |
| gap_in_employment_to_population_ratio |    0    |   100    | 100 |   0.057   |   0.039    |  0.0014  |   0.025   |   0.05    |   0.077    |   0.16    |
|         gap_in_median_income          |    0    |   100    | 100 | 13315.13  |  4895.34   |  917.53  |  10046.5  | 12801.99  |  15959.9   | 28716.13  |
|    gap_in_relative_income_poverty     |    0    |   100    | 100 |   0.077   |   0.033    |  0.0061  |   0.057   |   0.074   |    0.1     |   0.17    |
|                 jobs                  |    0    |   100    | 100 |   1e+06   | 1315998.77 |  2e+05   | 335738.5  | 546661.34 | 1130563.83 | 9516272.7 |
|             median_income             |    0    |   100    | 100 | 34389.27  |  5368.51   | 20983.13 | 30124.12  | 34052.01  |  36580.98  | 52890.57  |
|            output_per_job             |    0    |   100    | 100 | 124365.72 |  26774.61  | 75756.02 | 108378.39 | 118084.97 | 130887.79  | 279206.06 |
|           output_per_person           |    0    |   100    | 100 | 58687.32  |  17394.42  | 23159.45 | 50049.95  | 57172.63  |  65982.39  | 156625.52 |
|               real_gdp                |    0    |   100    | 100 |  1.4e+11  |  2.2e+11   | 1.8e+10  |  3.9e+10  |  6.6e+10  |  1.4e+11   |  1.7e+12  |
|        relative_income_poverty        |    0    |   100    | 100 |   0.26    |    0.02    |   0.2    |   0.25    |   0.26    |    0.27    |   0.33    |
