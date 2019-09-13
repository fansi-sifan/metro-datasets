
Title:  young (18-24) Out of work population by group  

Contact:  Martha Ross  

Source:  https://www.brookings.edu/research/young-adults-who-are-out-of-work/  

Note:  
This analysis is based on 2013–2015 three-year American Community Survey (ACS) PublicUse Microdata Samples data. The U.S. Census Bureau ceased production of three-year
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
the sample, not the estimated number of out-of-work individuals in a given jurisdiction.) 
  

Last updated:  Fri Sep 13 15:29:21 2019 



|                               label                                |       names        |
|--------------------------------------------------------------------|--------------------|
|                              pl_code                               |      pl_code       |
|                             stco_name                              |     stco_name      |
|                             cbsa_name                              |     cbsa_name      |
|                      Subset of the population                      |     population     |
|                          unweighted_total                          |  unweighted_total  |
|                   Weighted population estimates                    |       total        |
|                               ptotal                               |       ptotal       |
|                     Percent currently employed                     |     pemployed      |
|                    Percent currently unemployed                    |    punemployed     |
|                Percent currently not in labor force                |       pnilf        |
|                Percent last worked in the past year                |        plw1        |
|             Percent last worked more than 5 years ago              |        plw5        |
|                              plw5plus                              |      plw5plus      |
|                            Percent male                            |       pmale        |
|                             Median age                             |      med_age       |
|                         Percent age 18-21                          |       pa1821       |
|                         Percent age 22-24                          |       pa2224       |
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
|             Percent reports any disability, self-care              |       pdiss        |
|              Percent reports any disability, hearing               |       pdish        |
|               Percent reports any disability, vision               |       pdisv        |
|         Percent reports any disability, independent living         |       pdisi        |
|              Percent reports any disability, walking               |       pdisw        |
|             Percent reports any disability, cognitive              |       pdisc        |
|                        Percent foreign born                        |        pfb         |
|            Percent reports limited English proficiency             |        plep        |
|                          Percent married                           |       pmar_1       |
|                       Percent single parent                        |   pnospouse_kids   |
|                        Percent has a child                         |     pchildren      |
|                    Percent living with parents                     |     pwparents      |
|                  Percent living in group quarters                  |   pgroupquarters   |
|                        Median family income                        | med_fam_income_adj |
|                         Percent <100% FPL                          |       ppoor        |
| Percent receives SSI, public assistance income, SNAP &/or Medicaid |     psafetynet     |
|                               psnap                                |       psnap        |
|                             pmedicaid                              |     pmedicaid      |
|                       Most common occupation                       |        occ1        |
|                           Percent of occ                           |       pocc1        |
|                                occ2                                |        occ2        |
|                               pocc2                                |       pocc2        |
|                                occ3                                |        occ3        |
|                               pocc3                                |       pocc3        |
|                         Most common sector                         |        ind1        |
|                           Percent of ind                           |       pind1        |
|                                ind2                                |        ind2        |
|                               pind2                                |       pind2        |
|                                ind3                                |        ind3        |
|                               pind3                                |       pind3        |
|                       Most common fb country                       |        fb1         |
|                           Percent of fb                            |        pfb1        |
|                                fb2                                 |        fb2         |
|                                pfb2                                |        pfb2        |
|                                fb3                                 |        fb3         |
|                                pfb3                                |        pfb3        |
|                       Language speak at home                       |        lsh1        |
|                           Percent of lsh                           |       plsh1        |
|                                lsh2                                |        lsh2        |
|                               plsh2                                |       plsh2        |
|                                lsh3                                |        lsh3        |
|                               plsh3                                |       plsh3        |
|                             stco_code                              |     stco_code      |
|                             cbsa_code                              |     cbsa_code      |


Skim summary statistics  
 n obs: 807    
 n variables: 73    

Variable type: character

|  variable  | missing | complete |  n  | min | max | empty | n_unique |
|------------|---------|----------|-----|-----|-----|-------|----------|
| cbsa_code  |    0    |   807    | 807 |  5  |  5  |   0   |    67    |
| cbsa_name  |    0    |   807    | 807 |  9  | 46  |   0   |    67    |
|    fb1     |    0    |   807    | 807 |  6  | 30  |   0   |    3     |
|    fb2     |    0    |   807    | 807 |  1  | 30  |   0   |    86    |
|    fb3     |    0    |   807    | 807 |  1  | 30  |   0   |    98    |
|    ind1    |    0    |   807    | 807 | 12  | 36  |   0   |    9     |
|    ind2    |    0    |   807    | 807 | 11  | 36  |   0   |    10    |
|    ind3    |    0    |   807    | 807 | 11  | 36  |   0   |    13    |
|    lsh1    |    0    |   807    | 807 |  7  | 10  |   0   |    4     |
|    lsh2    |    0    |   807    | 807 |  4  | 47  |   0   |    45    |
|    lsh3    |    0    |   807    | 807 |  3  | 47  |   0   |    70    |
|    occ1    |    0    |   807    | 807 |  7  | 35  |   0   |    6     |
|    occ2    |    0    |   807    | 807 |  7  | 35  |   0   |    6     |
|    occ3    |    0    |   807    | 807 |  7  | 37  |   0   |    9     |
|  pl_code   |    0    |   807    | 807 |  5  |  6  |   0   |   119    |
| population |    0    |   807    | 807 |  9  | 22  |   0   |    8     |
| stco_code  |    0    |   807    | 807 |  5  |  5  |   0   |   113    |
| stco_name  |    0    |   807    | 807 | 10  | 51  |   0   |   119    |

Variable type: numeric

|      variable      | missing | complete |  n  |   mean   |    sd    |    p0    |   p25    |   p50    |   p75    |   p100    |
|--------------------|---------|----------|-----|----------|----------|----------|----------|----------|----------|-----------|
|      med_age       |    0    |   807    | 807 |  21.48   |   1.35   |    19    |    20    |    21    |    23    |    24     |
| med_fam_income_adj |    0    |   807    | 807 | 56910.51 | 25532.75 | 10012.64 | 38698.95 | 51127.26 | 69717.71 | 174159.79 |
|       pa1821       |    0    |   807    | 807 |   0.47   |   0.41   |    0     |    0     |   0.54   |    1     |     1     |
|       pa2224       |    0    |   807    | 807 |   0.53   |   0.41   |    0     |    0     |   0.46   |    1     |     1     |
|        paa         |    0    |   807    | 807 |  0.044   |   0.07   |    0     |    0     |  0.023   |  0.055   |     1     |
|      pasianNH      |    0    |   807    | 807 |  0.073   |  0.098   |    0     |  0.016   |   0.04   |   0.09   |   0.88    |
|      pbaplus       |    0    |   807    | 807 |   0.16   |   0.32   |    0     |    0     |    0     |   0.12   |     1     |
|      pblackNH      |    0    |   807    | 807 |   0.23   |   0.21   |    0     |  0.078   |   0.17   |   0.33   |     1     |
|     pchildren      |    0    |   807    | 807 |   0.12   |   0.1    |    0     |  0.058   |  0.098   |   0.16   |     1     |
|        pdis        |    0    |   807    | 807 |  0.074   |  0.044   |    0     |  0.046   |  0.068   |  0.098   |   0.24    |
|       pdisc        |    0    |   807    | 807 |   0.05   |  0.035   |    0     |  0.028   |  0.045   |   0.07   |    0.2    |
|       pdish        |    0    |   807    | 807 |  0.0076  |  0.012   |    0     |    0     |  0.0033  |   0.01   |   0.13    |
|       pdisi        |    0    |   807    | 807 |  0.027   |  0.024   |    0     |  0.011   |  0.023   |  0.039   |   0.14    |
|       pdiss        |    0    |   807    | 807 |  0.0075  |  0.011   |    0     |    0     |  0.0048  |   0.01   |   0.11    |
|       pdisv        |    0    |   807    | 807 |  0.013   |  0.018   |    0     |    0     |  0.0087  |  0.017   |    0.2    |
|       pdisw        |    0    |   807    | 807 |  0.014   |  0.019   |    0     |    0     |  0.0086  |  0.018   |   0.16    |
|     pemployed      |    0    |   807    | 807 |  0.085   |   0.21   |    0     |    0     |    0     |    0     |   0.71    |
|        pfb         |    0    |   807    | 807 |   0.15   |   0.1    |    0     |  0.074   |   0.13   |   0.2    |     1     |
|        pfb1        |    0    |   807    | 807 |   0.84   |  0.098   |   0.43   |   0.78   |   0.86   |   0.91   |     1     |
|        pfb2        |   23    |   784    | 807 |   0.07   |  0.056   |  0.0075  |  0.031   |  0.055   |  0.092   |   0.41    |
|        pfb3        |   60    |   747    | 807 |  0.028   |  0.022   |  0.002   |  0.013   |  0.022   |  0.036   |    0.2    |
|   pgroupquarters   |    0    |   807    | 807 |   0.02   |  0.038   |    0     |    0     |  0.0057  |  0.021   |   0.34    |
|        phs         |    1    |   806    | 807 |   0.31   |   0.29   |    0     |    0     |   0.3    |   0.6    |   0.98    |
|       pind1        |    0    |   807    | 807 |   0.31   |   0.11   |   0.16   |   0.24   |   0.29   |   0.36   |     1     |
|       pind2        |    4    |   803    | 807 |   0.2    |   0.04   |  0.063   |   0.17   |   0.2    |   0.22   |   0.38    |
|       pind3        |    7    |   800    | 807 |   0.15   |  0.031   |  0.048   |   0.13   |   0.15   |   0.17   |   0.25    |
|       pinsch       |    0    |   807    | 807 |   0.25   |   0.2    |    0     |  0.082   |   0.2    |   0.43   |     1     |
|      platino       |    0    |   807    | 807 |   0.27   |   0.21   |    0     |   0.1    |   0.22   |   0.4    |     1     |
|        plep        |    0    |   807    | 807 |  0.082   |   0.09   |    0     |  0.031   |  0.062   |   0.11   |     1     |
|       plsh1        |    0    |   807    | 807 |   0.72   |   0.15   |   0.23   |   0.59   |   0.72   |   0.85   |     1     |
|       plsh2        |   10    |   797    | 807 |   0.19   |   0.12   |  0.015   |  0.084   |   0.17   |   0.29   |   0.48    |
|       plsh3        |   40    |   767    | 807 |  0.036   |  0.033   |  0.0019  |  0.014   |  0.026   |  0.046   |   0.23    |
|       plths        |    0    |   807    | 807 |   0.14   |   0.14   |    0     |    0     |   0.13   |   0.25   |   0.63    |
|        plw1        |    0    |   807    | 807 |   0.46   |   0.17   |    0     |   0.33   |   0.43   |   0.57   |     1     |
|        plw5        |    0    |   807    | 807 |   0.19   |   0.1    |    0     |   0.12   |   0.18   |   0.24   |     1     |
|      plw5plus      |    0    |   807    | 807 |   0.36   |   0.16   |    0     |   0.23   |   0.35   |   0.47   |     1     |
|       pmale        |    0    |   807    | 807 |   0.49   |  0.095   |    0     |   0.45   |   0.5    |   0.54   |     1     |
|       pmar_1       |    0    |   807    | 807 |  0.091   |  0.086   |    0     |  0.038   |  0.072   |   0.12   |     1     |
|     pmedicaid      |    0    |   807    | 807 |   0.23   |   0.14   |    0     |   0.13   |   0.21   |   0.32   |     1     |
|       pnilf        |    0    |   807    | 807 |   0.42   |   0.15   |    0     |   0.32   |   0.42   |   0.53   |     1     |
|   pnospouse_kids   |    0    |   807    | 807 |  0.084   |  0.076   |    0     |  0.039   |  0.071   |   0.11   |     1     |
|       pocc1        |    0    |   807    | 807 |   0.46   |   0.14   |   0.21   |   0.35   |   0.44   |   0.56   |     1     |
|       pocc2        |    5    |   802    | 807 |   0.21   |  0.059   |   0.04   |   0.16   |   0.21   |   0.25   |   0.43    |
|       pocc3        |    7    |   800    | 807 |   0.14   |  0.041   |  0.022   |   0.11   |   0.14   |   0.16   |   0.26    |
|      potherNH      |    0    |   807    | 807 |  0.045   |  0.045   |    0     |  0.017   |  0.033   |  0.056   |   0.29    |
|       ppoor        |    0    |   807    | 807 |   0.32   |   0.13   |    0     |   0.23   |   0.33   |   0.41   |     1     |
|     psafetynet     |    0    |   807    | 807 |   0.37   |   0.18   |    0     |   0.23   |   0.36   |   0.49   |     1     |
|        psc         |    0    |   807    | 807 |   0.35   |   0.36   |    0     |    0     |   0.28   |   0.72   |     1     |
|       psnap        |    0    |   807    | 807 |   0.27   |   0.16   |    0     |   0.14   |   0.26   |   0.37   |     1     |
|       ptotal       |   238   |   569    | 807 |   0.21   |   0.11   |  0.0015  |   0.13   |   0.19   |   0.29   |   0.49    |
|    punemployed     |    0    |   807    | 807 |   0.49   |   0.21   |    0     |   0.4    |   0.52   |   0.63   |     1     |
|      pwhiteNH      |    0    |   807    | 807 |   0.38   |   0.21   |    0     |   0.22   |   0.37   |   0.54   |     1     |
|     pwparents      |    0    |   807    | 807 |   0.64   |   0.15   |    0     |   0.55   |   0.66   |   0.74   |     1     |
|       total        |    0    |   807    | 807 | 22371.94 | 51069.5  |  26.33   | 1957.56  | 4072.72  | 13541.51 | 619798.68 |
|  unweighted_total  |    0    |   807    | 807 |  557.04  | 1343.76  |    1     |   45.5   |    91    |   303    |   18314   |
