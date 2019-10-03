
Title:  Out of work population by group  

Contact:  Martha Ross  

Source:  https://www.brookings.edu/research/meet-the-out-of-work/ and 
https://www.brookings.edu/research/young-adults-who-are-out-of-work/  

Note:  This analysis is based on 2013–2015 three-year American Community Survey (ACS) PublicUse Microdata Samples data. The U.S. Census Bureau ceased production of three-year
ACS products in fall 2015, so we constructed our own three-year dataset by pooling single year data for 2013, 2014, and 2015, and adjusting weights according to annual change in
population using Population Estimates Program county population totals. All nominal dollars
were converted to 2015 dollars.
In the prior report, we focused on 130 large jurisdictions (counties, cities, and county
remainders net of large cities) that could be constructed neatly from 2010 Public-Use
Microdata Areas (PUMAs) and provided sufficient sample size for our analysis. In this
report we started from the same list of 130 jurisdictions and dropped those with samples
of fewer than 150 unweighted observations of “out-of-work” individuals, as defined below.
Consequently, we ended up with 119 jurisdictions with sample populations ranging from
155 out-of-work individuals (Seattle, Wash.) to 3,249 (Los Angeles County, Calif., net of Los
Angeles city). (The numbers in the previous sentences refer to unweighted observations from
the sample, not the estimated number of out-of-work individuals in a given jurisdiction.).  

Last updated:  Thu Oct 03 13:00:21 2019 



|                               label                                |       names        |
|--------------------------------------------------------------------|--------------------|
|                         5 digit cbsa code                          |     cbsa_code      |
|                                                                    |     stco_code      |
|                                                                    |      pl_name       |
|                      Subset of the population                      |     population     |
|                                                                    |  population label  |
|                                                                    |  unweighted_total  |
|                   Weighted population estimates                    |       total        |
|                     Percent currently employed                     |     pemployed      |
|                    Percent currently unemployed                    |    punemployed     |
|                Percent currently not in labor force                |       pnilf        |
|                Percent last worked in the past year                |        plw1        |
|              Percent last worked in the last 1-5 year              |        plw5        |
|                            Percent male                            |       pmale        |
|                           Percent female                           |      pfemale       |
|                             Median age                             |      med_age       |
|                         Percent age 25-34                          |       pa2534       |
|                         Percent age 35-44                          |       pa3544       |
|                         Percent age 45-54                          |       pa4554       |
|                         Percent age 55-64                          |       pa5564       |
|                    Percent white, non-hispanic                     |      pwhiteNH      |
|                    Percent black, non-hispanic                     |      pblackNH      |
|                          Percent hispanic                          |      platino       |
|                    Percent asian, non-hispanic                     |      pasianNH      |
|               Percent all other races, non-hispanic                |      potherNH      |
|                     Percent enrolled in school                     |       pinsch       |
|            Percent with less than high school education            |       plths        |
|           Percent with high school diploma or equivalent           |        phs         |
|                   Percent some college education                   |        psc         |
|                  Percent with an associate degree                  |        paa         |
|             Percent with a bachelor's degree or higher             |      pbaplus       |
|                   Percent reports any disability                   |        pdis        |
|               Percent reports any disability, vision               |       pdisv        |
|              Percent reports any disability, hearing               |       pdish        |
|             Percent reports any disability, cognitive              |       pdisc        |
|             Percent reports any disability, ambulatory             |       pdisa        |
|                                                                    |       pdisi        |
|                                                                    |       pdiss        |
|                        Percent foreign born                        |        pfb         |
|                       Most common fb country                       |        fb1         |
|                           Percent of fb                            |        pfb1        |
|                                                                    |        fb2         |
|                                                                    |        pfb2        |
|                                                                    |        fb3         |
|                                                                    |        pfb3        |
|            Percent reports limited English proficiency             |        plep        |
|                       Language speak at home                       |        lsh1        |
|                           Percent of lsh                           |       plsh1        |
|                                                                    |        lsh2        |
|                                                                    |       plsh2        |
|                                                                    |        lsh3        |
|                                                                    |       plsh3        |
|                          Percent married                           |       pmar_1       |
|                        Percent has a child                         |     pchildren      |
|                       Percent single parent                        |   pnospouse_kids   |
| Percent receives SSI, public assistance income, SNAP &/or Medicaid |     psafetynet     |
|                        Median family income                        | med_fam_income_adj |
|                         Most common sector                         |        ind1        |
|                           Percent of ind                           |       pind1        |
|                                                                    |        ind2        |
|                                                                    |       pind2        |
|                                                                    |        ind3        |
|                                                                    |       pind3        |
|                       Most common occupation                       |        occ1        |
|                           Percent of occ                           |       pocc1        |
|                                                                    |        occ2        |
|                                                                    |       pocc2        |
|                                                                    |        occ3        |
|                                                                    |       pocc3        |
|                                                                    |        age         |
|                                                                    |      pl_code       |
|                                                                    |     stco_name      |
|                                                                    |     cbsa_name      |
|                                                                    |       ptotal       |
|                                                                    |      plw5plus      |
|                                                                    |       pa1821       |
|                                                                    |       pa2224       |
|                                                                    |       pdisw        |
|                                                                    |     pwparents      |
|                                                                    |   pgroupquarters   |
|                                                                    |       ppoor        |
|                                                                    |       psnap        |
|                                                                    |     pmedicaid      |


Skim summary statistics  
 n obs: 1895    
 n variables: 82    

Variable type: character

|     variable     | missing | complete |  n   | min | max | empty | n_unique |
|------------------|---------|----------|------|-----|-----|-------|----------|
|       age        |    0    |   1895   | 1895 |  5  |  5  |   0   |    2     |
|    cbsa_code     |    0    |   1895   | 1895 |  5  |  5  |   0   |    73    |
|    cbsa_name     |  1088   |   807    | 1895 |  9  | 46  |   0   |    67    |
|       fb1        |    0    |   1895   | 1895 |  4  | 30  |   0   |    10    |
|       fb2        |    0    |   1895   | 1895 |  1  | 30  |   0   |   102    |
|       fb3        |    0    |   1895   | 1895 |  1  | 30  |   0   |   121    |
|       ind1       |    0    |   1895   | 1895 | 12  | 36  |   0   |    9     |
|       ind2       |    0    |   1895   | 1895 | 11  | 36  |   0   |    12    |
|       ind3       |    0    |   1895   | 1895 | 11  | 36  |   0   |    13    |
|       lsh1       |    0    |   1895   | 1895 |  4  | 10  |   0   |    6     |
|       lsh2       |    0    |   1895   | 1895 |  3  | 47  |   0   |    57    |
|       lsh3       |    0    |   1895   | 1895 |  3  | 47  |   0   |    79    |
|       occ1       |    0    |   1895   | 1895 |  7  | 35  |   0   |    6     |
|       occ2       |    0    |   1895   | 1895 |  7  | 35  |   0   |    8     |
|       occ3       |    0    |   1895   | 1895 |  7  | 37  |   0   |    9     |
|     pl_code      |  1088   |   807    | 1895 |  5  |  6  |   0   |   119    |
|     pl_name      |   807   |   1088   | 1895 | 10  | 51  |   0   |   130    |
|    population    |    0    |   1895   | 1895 |  9  | 23  |   0   |    17    |
| population label |  1067   |   828    | 1895 | 30  | 48  |   0   |    7     |
|    stco_code     |    0    |   1895   | 1895 |  5  |  5  |   0   |   125    |
|    stco_name     |  1088   |   807    | 1895 | 10  | 51  |   0   |   119    |

Variable type: numeric

|      variable      | missing | complete |  n   |   mean   |    sd     |    p0    |   p25    |   p50    |   p75    |    p100    |
|--------------------|---------|----------|------|----------|-----------|----------|----------|----------|----------|------------|
|      med_age       |    0    |   1895   | 1895 |  34.59   |   13.52   |    19    |    22    |    30    |    45    |     61     |
| med_fam_income_adj |    0    |   1895   | 1895 | 57092.7  | 25016.45  | 10012.64 | 38039.78 | 51127.26 | 70476.22 | 174159.79  |
|       pa1821       |  1088   |   807    | 1895 |   0.47   |   0.41    |    0     |    0     |   0.54   |    1     |     1      |
|       pa2224       |  1088   |   807    | 1895 |   0.53   |   0.41    |    0     |    0     |   0.46   |    1     |     1      |
|       pa2534       |   807   |   1088   | 1895 |   0.31   |   0.33    |    0     |    0     |   0.26   |   0.41   |     1      |
|       pa3544       |   807   |   1088   | 1895 |   0.19   |   0.13    |    0     |  0.032   |   0.22   |   0.27   |    0.65    |
|       pa4554       |   807   |   1088   | 1895 |   0.21   |   0.15    |    0     |  0.043   |   0.25   |   0.31   |    0.73    |
|       pa5564       |   807   |   1088   | 1895 |   0.29   |   0.33    |    0     |    0     |   0.23   |   0.41   |     1      |
|        paa         |    0    |   1895   | 1895 |  0.062   |   0.092   |    0     |    0     |  0.018   |  0.082   |     1      |
|      pasianNH      |    0    |   1895   | 1895 |  0.086   |    0.1    |    0     |  0.024   |  0.053   |   0.11   |    0.88    |
|      pbaplus       |    0    |   1895   | 1895 |   0.25   |   0.38    |    0     |    0     |    0     |   0.32   |     1      |
|      pblackNH      |    0    |   1895   | 1895 |   0.19   |   0.18    |    0     |  0.057   |   0.14   |   0.27   |     1      |
|     pchildren      |    0    |   1895   | 1895 |   0.21   |   0.16    |    0     |  0.075   |   0.2    |   0.32   |     1      |
|        pdis        |    0    |   1895   | 1895 |   0.11   |   0.066   |    0     |  0.063   |   0.1    |   0.15   |    0.38    |
|       pdisa        |   807   |   1088   | 1895 |  0.072   |   0.046   |    0     |   0.04   |  0.063   |  0.098   |    0.31    |
|       pdisc        |    0    |   1895   | 1895 |  0.057   |   0.035   |    0     |  0.032   |   0.05   |  0.078   |    0.23    |
|       pdish        |    0    |   1895   | 1895 |  0.015   |   0.015   |    0     |  0.0024  |  0.012   |  0.023   |    0.13    |
|       pdisi        |    0    |   1895   | 1895 |  0.042   |   0.031   |    0     |   0.02   |  0.037   |  0.059   |    0.2     |
|       pdiss        |    0    |   1895   | 1895 |  0.017   |   0.017   |    0     |  0.0031  |  0.013   |  0.026   |    0.12    |
|       pdisv        |    0    |   1895   | 1895 |   0.02   |   0.02    |    0     |  0.0063  |  0.015   |  0.028   |    0.2     |
|       pdisw        |  1088   |   807    | 1895 |  0.014   |   0.019   |    0     |    0     |  0.0086  |  0.018   |    0.16    |
|     pemployed      |    0    |   1895   | 1895 |  0.087   |   0.23    |    0     |    0     |    0     |    0     |    0.83    |
|        pfb         |    0    |   1895   | 1895 |   0.23   |   0.17    |    0     |   0.1    |   0.18   |   0.31   |     1      |
|        pfb1        |    0    |   1895   | 1895 |   0.77   |   0.15    |   0.16   |   0.67   |   0.8    |   0.88   |     1      |
|        pfb2        |   23    |   1872   | 1895 |  0.087   |   0.082   |  0.0054  |  0.033   |  0.059   |   0.11   |    0.48    |
|        pfb3        |   63    |   1832   | 1895 |  0.032   |   0.024   |  0.001   |  0.015   |  0.025   |  0.041   |    0.2     |
|      pfemale       |   807   |   1088   | 1895 |   0.62   |   0.077   |   0.39   |   0.56   |   0.62   |   0.67   |    0.87    |
|   pgroupquarters   |  1088   |   807    | 1895 |   0.02   |   0.038   |    0     |    0     |  0.0057  |  0.021   |    0.34    |
|        phs         |    1    |   1894   | 1895 |   0.27   |   0.28    |    0     |    0     |   0.24   |   0.53   |    0.98    |
|       pind1        |    0    |   1895   | 1895 |   0.34   |   0.12    |   0.15   |   0.25   |   0.33   |   0.41   |     1      |
|       pind2        |    4    |   1891   | 1895 |   0.17   |   0.048   |  0.036   |   0.14   |   0.17   |   0.2    |    0.38    |
|       pind3        |    7    |   1888   | 1895 |   0.13   |   0.036   |  0.022   |   0.1    |   0.13   |   0.15   |    0.25    |
|       pinsch       |    0    |   1895   | 1895 |   0.12   |   0.17    |    0     |  0.0094  |  0.042   |   0.15   |     1      |
|      platino       |    0    |   1895   | 1895 |   0.24   |    0.2    |    0     |  0.078   |   0.18   |   0.34   |     1      |
|        plep        |    0    |   1895   | 1895 |   0.14   |   0.15    |    0     |  0.049   |  0.098   |   0.19   |     1      |
|       plsh1        |    0    |   1895   | 1895 |   0.71   |   0.15    |   0.2    |   0.58   |   0.71   |   0.84   |     1      |
|       plsh2        |   10    |   1885   | 1895 |   0.17   |   0.12    |  0.0075  |  0.069   |   0.14   |   0.26   |    0.48    |
|       plsh3        |   43    |   1852   | 1895 |  0.034   |   0.029   |  0.0019  |  0.014   |  0.026   |  0.044   |    0.23    |
|       plths        |    0    |   1895   | 1895 |   0.15   |   0.17    |    0     |    0     |   0.1    |   0.27   |    0.81    |
|        plw1        |    0    |   1895   | 1895 |   0.4    |   0.19    |    0     |   0.26   |   0.35   |   0.49   |     1      |
|        plw5        |    0    |   1895   | 1895 |   0.23   |    0.1    |    0     |   0.16   |   0.24   |   0.3    |     1      |
|      plw5plus      |  1088   |   807    | 1895 |   0.36   |   0.16    |    0     |   0.23   |   0.35   |   0.47   |     1      |
|       pmale        |    0    |   1895   | 1895 |   0.43   |    0.1    |    0     |   0.36   |   0.43   |   0.5    |     1      |
|       pmar_1       |    0    |   1895   | 1895 |   0.34   |   0.24    |    0     |  0.084   |   0.36   |   0.55   |     1      |
|     pmedicaid      |  1088   |   807    | 1895 |   0.23   |   0.14    |    0     |   0.13   |   0.21   |   0.32   |     1      |
|       pnilf        |    0    |   1895   | 1895 |   0.53   |   0.19    |    0     |   0.38   |   0.55   |   0.68   |     1      |
|   pnospouse_kids   |    0    |   1895   | 1895 |   0.09   |   0.075   |    0     |   0.04   |  0.078   |   0.12   |     1      |
|       pocc1        |    0    |   1895   | 1895 |   0.46   |   0.14    |   0.19   |   0.35   |   0.46   |   0.56   |     1      |
|       pocc2        |    5    |   1890   | 1895 |   0.19   |   0.058   |   0.04   |   0.14   |   0.19   |   0.23   |    0.43    |
|       pocc3        |    8    |   1887   | 1895 |   0.12   |   0.042   |   0.02   |  0.093   |   0.13   |   0.15   |    0.26    |
|      potherNH      |    0    |   1895   | 1895 |  0.035   |   0.037   |    0     |  0.015   |  0.025   |  0.043   |    0.36    |
|       ppoor        |  1088   |   807    | 1895 |   0.32   |   0.13    |    0     |   0.23   |   0.33   |   0.41   |     1      |
|     psafetynet     |    0    |   1895   | 1895 |   0.3    |   0.17    |    0     |   0.16   |   0.28   |   0.42   |     1      |
|        psc         |    0    |   1895   | 1895 |   0.28   |   0.34    |    0     |    0     |   0.17   |   0.61   |     1      |
|       psnap        |  1088   |   807    | 1895 |   0.27   |   0.16    |    0     |   0.14   |   0.26   |   0.37   |     1      |
|       ptotal       |  1326   |   569    | 1895 |   0.21   |   0.11    |  0.0015  |   0.13   |   0.19   |   0.29   |    0.49    |
|    punemployed     |    0    |   1895   | 1895 |   0.38   |    0.2    |    0     |   0.25   |   0.38   |   0.52   |     1      |
|      pwhiteNH      |    0    |   1895   | 1895 |   0.45   |   0.23    |    0     |   0.27   |   0.44   |   0.63   |     1      |
|     pwparents      |  1088   |   807    | 1895 |   0.64   |   0.15    |    0     |   0.55   |   0.66   |   0.74   |     1      |
|       total        |    0    |   1895   | 1895 | 63089.25 | 194140.13 |  26.33   |   3536   | 8571.81  | 28981.42 | 3302775.56 |
|  unweighted_total  |    0    |   1895   | 1895 | 1655.96  |  5276.78  |    1     |    84    |   212    |  708.5   |   97891    |
