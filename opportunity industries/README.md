
Title:  Opportunity industries  

Contact:  Isha Shah  

Source:  https://www.brookings.edu/research/opportunity-industries/  

Note:  Good jobs provide stable employment, middle-class wages and benefits
Promising jobs are entry-level positions from which most workers can reach a good job within 10 years
Other jobs do not provide decent pay, benefits, or pathways to good jobs   

Last updated:  Fri Sep 13 16:16:16 2019 



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
 n obs: 49807    
 n variables: 14    

Variable type: factor

|     variable      | missing | complete |   n   | n_unique |                   top_counts                   | ordered |
|-------------------|---------|----------|-------|----------|------------------------------------------------|---------|
|        age        |    0    |  49807   | 49807 |    5     |  Tot: 10055, 45 : 9990, 35 : 9978, 25 : 9955   |  FALSE  |
|    cbsa_title     |    0    |  49807   | 49807 |   100    |   Chi: 1680, New: 1680, Phi: 1680, Bos: 1260   |  FALSE  |
|     education     |    0    |  49807   | 49807 |    7     |   Tot: 7198, All: 7195, Som: 7180, Hig: 7178   |  FALSE  |
|      gender       |    0    |  49807   | 49807 |    3     |   Tot: 16684, Men: 16583, Wom: 16540, NA: 0    |  FALSE  |
|     good_jobs     |    0    |  49807   | 49807 |   742    |                  0.0: 8668, 0                  |  FALSE  |
|   hi_good_jobs    |    0    |  49807   | 49807 |   832    |                 0.0: 35577, 0                  |  FALSE  |
| hi_promising_jobs |    0    |  49807   | 49807 |   417    |                 0.0: 35545, 2                  |  FALSE  |
|   metdiv_title    |    0    |  49807   | 49807 |    32    |    emp: 36789, Ana: 420, Bos: 420, Cam: 420    |  FALSE  |
|       other       |    0    |  49807   | 49807 |   870    |                  78.: 103, 70                  |  FALSE  |
|  promising_jobs   |    0    |  49807   | 49807 |   387    |                 0.0: 7194, 10                  |  FALSE  |
|       race        |    0    |  49807   | 49807 |    4     | Tot: 12600, Whi: 12580, His: 12431, Bla: 12196 |  FALSE  |

Variable type: integer

|   variable    | missing | complete |   n   |   mean   |    sd    |  p0   |  p25  |  p50  |  p75  | p100  |
|---------------|---------|----------|-------|----------|----------|-------|-------|-------|-------|-------|
|   cbsa_code   |    0    |  49807   | 49807 | 30596.48 | 11769.65 | 10420 | 19740 | 32820 | 40900 | 49660 |
| cbsa_code_alt |    0    |  49807   | 49807 | 30596.48 | 11769.65 | 10420 | 19740 | 32820 | 40900 | 49660 |
|  metdiv_code  |  36789  |  13018   | 49807 | 31616.9  | 11529.79 | 11244 | 20524 | 33874 | 42034 | 48864 |
