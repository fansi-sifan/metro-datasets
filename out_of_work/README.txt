
Title:  Out of work population by group  

Contact:  Martha Ross  

Source:  https://www.brookings.edu/research/meet-the-out-of-work/  

Note:  130 large cities and counties across the United States, note that LA, Seattle, Chicago, Detroit, etc. are treated separately from their counties  

Last updated:  Fri Sep 13 14:19:28 2019 



|                               label                                |       names        |
|--------------------------------------------------------------------|--------------------|
|                         5 digit cbsa code                          |     cbsa_code      |
|                             stco_code                              |     stco_code      |
|                              pl_name                               |      pl_name       |
|                      Subset of the population                      |     population     |
|                          population label                          |  population label  |
|                          unweighted_total                          |  unweighted_total  |
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
|                               pdisi                                |       pdisi        |
|                               pdiss                                |       pdiss        |
|                        Percent foreign born                        |        pfb         |
|                       Most common fb country                       |        fb1         |
|                           Percent of fb                            |        pfb1        |
|                                fb2                                 |        fb2         |
|                                pfb2                                |        pfb2        |
|                                fb3                                 |        fb3         |
|                                pfb3                                |        pfb3        |
|            Percent reports limited English proficiency             |        plep        |
|                       Language speak at home                       |        lsh1        |
|                           Percent of lsh                           |       plsh1        |
|                                lsh2                                |        lsh2        |
|                               plsh2                                |       plsh2        |
|                                lsh3                                |        lsh3        |
|                               plsh3                                |       plsh3        |
|                          Percent married                           |       pmar_1       |
|                        Percent has a child                         |     pchildren      |
|                       Percent single parent                        |   pnospouse_kids   |
| Percent receives SSI, public assistance income, SNAP &/or Medicaid |     psafetynet     |
|                        Median family income                        | med_fam_income_adj |
|                         Most common sector                         |        ind1        |
|                           Percent of ind                           |       pind1        |
|                                ind2                                |        ind2        |
|                               pind2                                |       pind2        |
|                                ind3                                |        ind3        |
|                               pind3                                |       pind3        |
|                       Most common occupation                       |        occ1        |
|                           Percent of occ                           |       pocc1        |
|                                occ2                                |        occ2        |
|                               pocc2                                |       pocc2        |
|                                occ3                                |        occ3        |
|                               pocc3                                |       pocc3        |


Skim summary statistics  
 n obs: 1091    
 n variables: 68    

Variable type: character

|     variable     | missing | complete |  n   | min | max | empty | n_unique |
|------------------|---------|----------|------|-----|-----|-------|----------|
|    cbsa_code     |    3    |   1088   | 1091 |  5  |  5  |   0   |    72    |
|       fb1        |    3    |   1088   | 1091 |  4  | 18  |   0   |    9     |
|       fb2        |    3    |   1088   | 1091 |  3  | 30  |   0   |    74    |
|       fb3        |    3    |   1088   | 1091 |  1  | 30  |   0   |    96    |
|       ind1       |    3    |   1088   | 1091 | 12  | 36  |   0   |    6     |
|       ind2       |    3    |   1088   | 1091 | 12  | 36  |   0   |    11    |
|       ind3       |    3    |   1088   | 1091 | 12  | 36  |   0   |    12    |
|       lsh1       |    3    |   1088   | 1091 |  4  |  9  |   0   |    4     |
|       lsh2       |    3    |   1088   | 1091 |  3  | 18  |   0   |    43    |
|       lsh3       |    3    |   1088   | 1091 |  3  | 47  |   0   |    70    |
|       occ1       |    3    |   1088   | 1091 |  7  | 33  |   0   |    5     |
|       occ2       |    3    |   1088   | 1091 |  7  | 35  |   0   |    8     |
|       occ3       |    3    |   1088   | 1091 |  7  | 37  |   0   |    9     |
|     pl_name      |    1    |   1090   | 1091 | 10  | 157 |   0   |   132    |
|    population    |    3    |   1088   | 1091 | 17  | 23  |   0   |    11    |
| population label |   263   |   828    | 1091 | 30  | 48  |   0   |    7     |
|    stco_code     |    3    |   1088   | 1091 |  5  |  5  |   0   |   124    |

Variable type: numeric

|      variable      | missing | complete |  n   |   mean   |    sd     |    p0    |   p25    |   p50    |   p75    |    p100    |
|--------------------|---------|----------|------|----------|-----------|----------|----------|----------|----------|------------|
|      med_age       |    3    |   1088   | 1091 |  44.32   |   9.75    |    27    |    37    |    44    |    52    |     61     |
| med_fam_income_adj |    3    |   1088   | 1091 | 57227.83 | 24637.44  | 18451.96 | 37929.02 | 51171.15 | 70771.75 | 166739.07  |
|       pa2534       |    3    |   1088   | 1091 |   0.31   |   0.33    |    0     |    0     |   0.26   |   0.41   |     1      |
|       pa3544       |    3    |   1088   | 1091 |   0.19   |   0.13    |    0     |  0.032   |   0.22   |   0.27   |    0.65    |
|       pa4554       |    3    |   1088   | 1091 |   0.21   |   0.15    |    0     |  0.043   |   0.25   |   0.31   |    0.73    |
|       pa5564       |    3    |   1088   | 1091 |   0.29   |   0.33    |    0     |    0     |   0.23   |   0.41   |     1      |
|        paa         |    3    |   1088   | 1091 |  0.076   |    0.1    |    0     |    0     |    0     |   0.11   |    0.45    |
|      pasianNH      |    3    |   1088   | 1091 |  0.096   |    0.1    |    0     |   0.03   |  0.061   |   0.12   |    0.68    |
|      pbaplus       |    3    |   1088   | 1091 |   0.31   |   0.41    |    0     |    0     |    0     |   0.51   |     1      |
|      pblackNH      |    3    |   1088   | 1091 |   0.16   |   0.16    |    0     |   0.05   |   0.11   |   0.22   |    0.89    |
|     pchildren      |    3    |   1088   | 1091 |   0.28   |   0.17    |    0     |   0.18   |   0.29   |   0.38   |     1      |
|        pdis        |    3    |   1088   | 1091 |   0.14   |   0.066   |    0     |  0.091   |   0.13   |   0.18   |    0.38    |
|       pdisa        |    3    |   1088   | 1091 |  0.072   |   0.046   |    0     |   0.04   |  0.063   |  0.098   |    0.31    |
|       pdisc        |    3    |   1088   | 1091 |  0.061   |   0.034   |    0     |  0.036   |  0.055   |  0.082   |    0.23    |
|       pdish        |    3    |   1088   | 1091 |   0.02   |   0.015   |    0     |  0.011   |  0.018   |  0.028   |   0.094    |
|       pdisi        |    3    |   1088   | 1091 |  0.053   |   0.03    |    0     |  0.031   |  0.047   |   0.07   |    0.2     |
|       pdiss        |    3    |   1088   | 1091 |  0.024   |   0.017   |    0     |  0.012   |  0.021   |  0.034   |    0.12    |
|       pdisv        |    3    |   1088   | 1091 |  0.025   |   0.019   |    0     |  0.012   |  0.021   |  0.033   |    0.17    |
|     pemployed      |    3    |   1088   | 1091 |  0.089   |   0.24    |    0     |    0     |    0     |    0     |    0.83    |
|        pfb         |    3    |   1088   | 1091 |   0.29   |   0.18    |    0     |   0.15   |   0.25   |   0.39   |     1      |
|        pfb1        |    3    |   1088   | 1091 |   0.71   |   0.16    |   0.16   |   0.6    |   0.73   |   0.84   |    0.99    |
|        pfb2        |    3    |   1088   | 1091 |  0.099   |   0.095   |  0.0054  |  0.034   |  0.062   |   0.13   |    0.48    |
|        pfb3        |    6    |   1085   | 1091 |  0.034   |   0.026   |  0.001   |  0.016   |  0.027   |  0.044   |    0.19    |
|      pfemale       |    3    |   1088   | 1091 |   0.62   |   0.077   |   0.39   |   0.56   |   0.62   |   0.67   |    0.87    |
|        phs         |    3    |   1088   | 1091 |   0.24   |   0.27    |    0     |    0     |   0.17   |   0.46   |    0.91    |
|       pind1        |    3    |   1088   | 1091 |   0.37   |   0.12    |   0.15   |   0.27   |   0.36   |   0.45   |    0.79    |
|       pind2        |    3    |   1088   | 1091 |   0.15   |   0.041   |  0.036   |   0.12   |   0.15   |   0.17   |    0.32    |
|       pind3        |    3    |   1088   | 1091 |   0.11   |   0.03    |  0.022   |   0.09   |   0.11   |   0.13   |    0.22    |
|       pinsch       |    3    |   1088   | 1091 |  0.028   |   0.034   |    0     |  0.0037  |  0.017   |  0.043   |    0.3     |
|      platino       |    3    |   1088   | 1091 |   0.21   |    0.2    |    0     |  0.067   |   0.15   |   0.3    |    0.99    |
|        plep        |    3    |   1088   | 1091 |   0.19   |   0.16    |    0     |  0.075   |   0.14   |   0.25   |     1      |
|       plsh1        |    3    |   1088   | 1091 |   0.7    |   0.16    |   0.2    |   0.58   |   0.71   |   0.83   |    0.99    |
|       plsh2        |    3    |   1088   | 1091 |   0.16   |   0.12    |  0.0075  |  0.063   |   0.12   |   0.23   |    0.48    |
|       plsh3        |    6    |   1085   | 1091 |  0.033   |   0.027   |  0.0023  |  0.014   |  0.025   |  0.042   |    0.21    |
|       plths        |    3    |   1088   | 1091 |   0.15   |   0.18    |    0     |    0     |  0.073   |   0.29   |    0.81    |
|        plw1        |    3    |   1088   | 1091 |   0.36   |    0.2    |    0     |   0.23   |   0.3    |   0.39   |     1      |
|        plw5        |    3    |   1088   | 1091 |   0.26   |   0.092   |    0     |   0.22   |   0.28   |   0.31   |    0.61    |
|       pmale        |    3    |   1088   | 1091 |   0.38   |   0.077   |   0.13   |   0.33   |   0.38   |   0.44   |    0.61    |
|       pmar_1       |    3    |   1088   | 1091 |   0.52   |   0.14    |  0.085   |   0.43   |   0.54   |   0.62   |    0.97    |
|       pnilf        |    3    |   1088   | 1091 |   0.61   |   0.19    |   0.14   |   0.54   |   0.65   |   0.74   |     1      |
|   pnospouse_kids   |    3    |   1088   | 1091 |  0.094   |   0.073   |    0     |  0.043   |  0.084   |   0.13   |    0.44    |
|       pocc1        |    3    |   1088   | 1091 |   0.46   |   0.14    |   0.19   |   0.36   |   0.47   |   0.56   |    0.92    |
|       pocc2        |    3    |   1088   | 1091 |   0.17   |   0.053   |  0.054   |   0.13   |   0.17   |   0.21   |    0.36    |
|       pocc3        |    4    |   1087   | 1091 |   0.12   |   0.04    |   0.02   |  0.085   |   0.11   |   0.15   |    0.24    |
|      potherNH      |    3    |   1088   | 1091 |  0.028   |   0.028   |    0     |  0.013   |  0.021   |  0.034   |    0.36    |
|     psafetynet     |    3    |   1088   | 1091 |   0.25   |   0.15    |    0     |   0.12   |   0.22   |   0.35   |    0.67    |
|        psc         |    3    |   1088   | 1091 |   0.23   |   0.31    |    0     |    0     |    0     |   0.26   |    0.9     |
|    punemployed     |    3    |   1088   | 1091 |   0.3    |   0.14    |    0     |   0.21   |   0.31   |   0.4    |    0.69    |
|      pwhiteNH      |    3    |   1088   | 1091 |   0.5    |   0.23    |    0     |   0.33   |   0.52   |   0.68   |     1      |
|       total        |    3    |   1088   | 1091 | 93290.42 | 248182.31 |  752.81  | 5957.81  | 12389.96 | 43120.47 | 3302775.56 |
|  unweighted_total  |    3    |   1088   | 1091 | 2471.05  |  6753.95  |    19    |  155.75  |   319    |   1086   |   97891    |
