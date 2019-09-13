
Title:  Low Wage Worker Clusters and Demographics and Across Metro Areas  

Contact:  Nicole Bateman and Martha Ross  

Source:  Not yet published, find additional data in V:/Human Capital/Google  

Note:  We used ACS, 5-year, 2012-2016 microdata to create clusters of low-wage workers
in order to compare the unique circumstances of various population subsets at the national, state, 
and metropolitan levels.Definitions:
'Universe population' is the total civilian, non-institutionalized population 18-64
'Workers' is a subset of the universe population, defined as follows: 
- Currently in the labor force (employed or unemployed)
- Worked at some point in the last year

We then exclude a number of populations: 
- Anyone enrolled in school who worked fewer than 14 weeks over the previous year 
- Anyone enrolled and living in group quarters
- Anyone enrolled in high school and living with a parent
- Anyone enrolled in graduate school
- People who report earning any self-employment income over the previous year or who report working in their own business
- People who report their primary job is unpaid in a family business or farm
- Those who report working more than 98 hours per week
- Those who earn wages below $.94 per hour or more than $187.38 per hour

'Mid/high-wage workers' is a subset of the worker population who earn above the hourly wage threshold we set
'Low-wage workers' is a subset of the worker population who earn above the hourly wage threshold we set

'Clusters' are low-wage workers divided into 9 groups based on age, education, and enrollment status. There are 9 total clusters. 
Those clusters are defined as follows: 
(1) 18-24 year olds, some college experience or less, not enrolled in school 
(2) 18-24 year olds, some college experience or less, enrolled in school 
(3) 18-24 year olds, associate degree or more, enrolled and not enrolled 
(4) 25-50 year olds, high school diploma or less 
(5) 25-50 year olds, some college experience, but no post-secondary degree 
(6) 25-50 year olds, associate degree or more 
(7) 51-64 year olds, high school diploma or less 
(8) 51-64 year olds, some college experience, but no post-secondary degree 
(9) 51-64 year olds, associate degree or more
  

Last updated:  Fri Sep 13 11:27:01 2019 



|                               label                                |          names          |
|--------------------------------------------------------------------|-------------------------|
|                         5 digit cbsa code                          |        cbsa_code        |
|                             Cbsa name                              |        cbsa_name        |
|                          unweighted_total                          |    unweighted_total     |
|                   Weighted population estimates                    |          total          |
|                     Percent currently employed                     |        pemployed        |
|                 Median individual hourly earnings                  |  med_hrly_earnings_adj  |
|                 Median individual annual earnings                  | med_annual_earnings_adj |
|                        Median family income                        |   med_fam_income_adj    |
|                            Percent male                            |          pmale          |
|                         Percent age 18-24                          |         pa1824          |
|                         Percent age 25-34                          |         pa2534          |
|                         Percent age 45-54                          |         pa4554          |
|                         Percent age 55-64                          |         pa5564          |
|                         Percent age 25-50                          |         pa2550          |
|                         Percent age 51-64                          |         pa5164          |
|                    Percent white, non-hispanic                     |        pwhiteNH         |
|                    Percent black, non-hispanic                     |        pblackNH         |
|                          Percent hispanic                          |         platino         |
|                    Percent asian, non-hispanic                     |        pasianNH         |
|            Percent with less than high school education            |          plths          |
|           Percent with high school diploma or equivalent           |           phs           |
|                   Percent some college education                   |           psc           |
|                  Percent with an associate degree                  |           paa           |
|             Percent with a bachelor's degree or higher             |         pbaplus         |
|                     Percent enrolled in school                     |         pinsch          |
|            Percent reports limited English proficiency             |          plep           |
|                        Percent foreign born                        |           pfb           |
|               Percent lives with parents, age 18-24                |    plivewparent1824     |
|                          Percent married                           |         pmar_1          |
|                        Percent has a child                         |        pchildren        |
|                         Percent <100% FPL                          |          ppoor          |
|                         Percent <200% FPL                          |      p_below2xfpl       |
| Percent receives SSI, public assistance income, SNAP &/or Medicaid |       psafetynet        |
|            Percent retail sales workers (SOC code 412)             |     psoc_minor_412      |
|      Percent accommodation and food services (NAICS code 72)       |       psector_72        |
|              Percent manufacturing (NAICS code 31-33)              |      psector_3133       |
|              Percent retail trade (NAICS code 44-45)               |      psector_4445       |


Skim summary statistics  
 n obs: 4849    
 n variables: 37    

Variable type: character

| variable  | missing | complete |  n   | min | max | empty | n_unique |
|-----------|---------|----------|------|-----|-----|-------|----------|
| cbsa_name |    0    |   4849   | 4849 |  8  | 46  |   0   |   373    |

Variable type: numeric

|        variable         | missing | complete |  n   |   mean   |    sd     |  p0   |  p25  |  p50  |  p75  |  p100   |
|-------------------------|---------|----------|------|----------|-----------|-------|-------|-------|-------|---------|
|        cbsa_code        |    0    |   4849   | 4849 | 29746.68 | 11401.34  | 10180 | 19780 | 29460 | 39820 |  49740  |
| med_annual_earnings_adj |    0    |   4849   | 4849 | 20904.82 | 10649.99  | 3168  | 15209 | 19009 | 21571 |  88944  |
|   med_fam_income_adj    |    0    |   4849   | 4849 | 50098.13 | 18160.09  | 5112  | 37383 | 46718 | 59807 | 143844  |
|  med_hrly_earnings_adj  |    0    |   4849   | 4849 |  12.09   |   4.63    |   5   |  10   |  11   |  13   |   42    |
|      p_below2xfpl       |    0    |   4849   | 4849 |   0.24   |   0.43    |   0   |   0   |   0   |   0   |    1    |
|         pa1824          |    0    |   4849   | 4849 |   0.23   |   0.42    |   0   |   0   |   0   |   0   |    1    |
|         pa2534          |    0    |   4849   | 4849 |   0.13   |   0.33    |   0   |   0   |   0   |   0   |    1    |
|         pa2550          |    0    |   4849   | 4849 |   0.51   |    0.5    |   0   |   0   |   1   |   1   |    1    |
|         pa4554          |    0    |   4849   | 4849 |  0.0027  |   0.052   |   0   |   0   |   0   |   0   |    1    |
|         pa5164          |    0    |   4849   | 4849 |   0.23   |   0.42    |   0   |   0   |   0   |   0   |    1    |
|         pa5564          |    0    |   4849   | 4849 |   0.23   |   0.42    |   0   |   0   |   0   |   0   |    1    |
|           paa           |    0    |   4849   | 4849 |  0.051   |   0.22    |   0   |   0   |   0   |   0   |    1    |
|        pasianNH         |    0    |   4849   | 4849 |  0.0031  |   0.056   |   0   |   0   |   0   |   0   |    1    |
|         pbaplus         |    0    |   4849   | 4849 |   0.19   |   0.39    |   0   |   0   |   0   |   0   |    1    |
|        pblackNH         |    0    |   4849   | 4849 |  0.024   |   0.15    |   0   |   0   |   0   |   0   |    1    |
|        pchildren        |    0    |   4849   | 4849 |  0.044   |    0.2    |   0   |   0   |   0   |   0   |    1    |
|        pemployed        |    0    |   4849   | 4849 |    1     |     0     |   1   |   1   |   1   |   1   |    1    |
|           pfb           |    0    |   4849   | 4849 |  0.016   |   0.13    |   0   |   0   |   0   |   0   |    1    |
|           phs           |    0    |   4849   | 4849 |   0.2    |    0.4    |   0   |   0   |   0   |   0   |    1    |
|         pinsch          |    0    |   4849   | 4849 |  0.084   |   0.28    |   0   |   0   |   0   |   0   |    1    |
|         platino         |    0    |   4849   | 4849 |  0.066   |   0.25    |   0   |   0   |   0   |   0   |    1    |
|          plep           |    0    |   4849   | 4849 |  0.0095  |   0.097   |   0   |   0   |   0   |   0   |    1    |
|    plivewparent1824     |    0    |   4849   | 4849 |   0.13   |   0.34    |   0   |   0   |   0   |   0   |    1    |
|          plths          |    0    |   4849   | 4849 |  0.011   |    0.1    |   0   |   0   |   0   |   0   |    1    |
|          pmale          |    0    |   4849   | 4849 |   0.31   |   0.46    |   0   |   0   |   0   |   1   |    1    |
|         pmar_1          |    0    |   4849   | 4849 |   0.42   |   0.49    |   0   |   0   |   0   |   1   |    1    |
|          ppoor          |    0    |   4849   | 4849 |   0.01   |    0.1    |   0   |   0   |   0   |   0   |    1    |
|       psafetynet        |    0    |   4849   | 4849 |  0.0066  |   0.081   |   0   |   0   |   0   |   0   |    1    |
|           psc           |    0    |   4849   | 4849 |   0.23   |   0.42    |   0   |   0   |   0   |   0   |    1    |
|      psector_3133       |    0    |   4849   | 4849 | 0.00021  |   0.014   |   0   |   0   |   0   |   0   |    1    |
|      psector_4445       |    0    |   4849   | 4849 | 0.00062  |   0.025   |   0   |   0   |   0   |   0   |    1    |
|       psector_72        |    0    |   4849   | 4849 | 0.00021  |   0.014   |   0   |   0   |   0   |   0   |    1    |
|     psoc_minor_412      |    0    |   4849   | 4849 | 0.00021  |   0.014   |   0   |   0   |   0   |   0   |    1    |
|        pwhiteNH         |    0    |   4849   | 4849 |   0.8    |    0.4    |   0   |   1   |   1   |   1   |    1    |
|          total          |    0    |   4849   | 4849 | 87950.03 | 388099.78 |  189  | 2967  | 8937  | 49017 | 1.3e+07 |
|    unweighted_total     |    0    |   4849   | 4849 | 3876.02  | 17260.74  |  11   |  127  |  372  | 2146  | 557657  |
