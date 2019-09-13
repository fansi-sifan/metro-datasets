
Title:  Opportunity industries  

Contact:  Isha Shah  

Source:  https://www.brookings.edu/research/opportunity-industries/  

Note:  Good jobs provide stable employment, middle-class wages and benefits
Promising jobs are entry-level positions from which most workers can reach a good job within 10 years
Other jobs do not provide decent pay, benefits, or pathways to good jobs   

Last updated:  Fri Sep 13 18:04:12 2019 



| label |       names       |
|-------|-------------------|
|       |     cbsa_code     |
|       |   cbsa_code_alt   |
|       |    metdiv_code    |
|       |    cbsa_title     |
|       |   metdiv_title    |
|       |      gender       |
|       |        age        |
|       |       race        |
|       |     education     |
|       |     good_jobs     |
|       |  promising_jobs   |
|       |   hi_good_jobs    |
|       | hi_promising_jobs |
|       |       other       |
|       |     cbsa_name     |


Skim summary statistics  
 n obs: 49807    
 n variables: 15    

Variable type: character

| variable  | missing | complete |   n   | min | max | empty | n_unique |
|-----------|---------|----------|-------|-----|-----|-------|----------|
| cbsa_code |    0    |  49807   | 49807 |  5  |  5  |   0   |   120    |

Variable type: factor

|     variable      | missing | complete |   n   | n_unique |                   top_counts                   | ordered |
|-------------------|---------|----------|-------|----------|------------------------------------------------|---------|
|        age        |    0    |  49807   | 49807 |    5     |  Tot: 10055, 45 : 9990, 35 : 9978, 25 : 9955   |  FALSE  |
|     cbsa_name     |    0    |  49807   | 49807 |   100    |   Chi: 1680, New: 1680, Phi: 1680, Bos: 1260   |  FALSE  |
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
| cbsa_code_alt |    0    |  49807   | 49807 | 30596.48 | 11769.65 | 10420 | 19740 | 32820 | 40900 | 49660 |
|  metdiv_code  |  36789  |  13018   | 49807 | 31616.9  | 11529.79 | 11244 | 20524 | 33874 | 42034 | 48864 |

Title:  Opportunity industries  




| label |               names                |
|-------|------------------------------------|
|       |             cbsa_code              |
|       |                CBSA                |
|       |             CBSA.Title             |
|       |     Metropolitan.Division.Code     |
|       |    Metropolitan.Division.Title     |
|       |               Level                |
|       |              SOC.code              |
|       |          Occupation.title          |
|       |          Good.sub.BA.jobs          |
|       |       Promising.sub.BA.jobs        |
|       |   Good.and.promising.sub.BA.jobs   |
|       |        Good.high.skill.jobs        |
|       |     Promising.high.skill.jobs      |
|       | Good.and.promising.high.skill.jobs |
|       |             Other.jobs             |
|       |          Quality.unknown           |
|       |     Opportunity.jobs..sub.BA.      |
|       |   Opportunity.jobs..high.skill.    |
|       |             cbsa_name              |


Skim summary statistics  
 n obs: 101    
 n variables: 19    

Variable type: character

| variable  | missing | complete |  n  | min | max | empty | n_unique |
|-----------|---------|----------|-----|-----|-----|-------|----------|
| cbsa_code |    0    |   101    | 101 |  5  |  5  |   0   |   101    |

Variable type: factor

|     variable     | missing | complete |  n  | n_unique |           top_counts           | ordered |
|------------------|---------|----------|-----|----------|--------------------------------|---------|
|    CBSA.Title    |    0    |   101    | 101 |   101    | Akr: 1, Alb: 1, Alb: 1, All: 1 |  FALSE  |
|    cbsa_name     |    0    |   101    | 101 |   101    | Akr: 1, Alb: 1, Alb: 1, All: 1 |  FALSE  |
| Occupation.title |    0    |   101    | 101 |    1     |        Tot: 101, NA: 0         |  FALSE  |

Variable type: integer

| variable | missing | complete |  n  |   mean   |    sd    |  p0   |  p25  |  p50  |  p75  | p100  |
|----------|---------|----------|-----|----------|----------|-------|-------|-------|-------|-------|
|   CBSA   |    0    |   101    | 101 | 31009.68 | 13649.18 | 10420 | 19380 | 32580 | 40380 | 99998 |
|  Level   |    0    |   101    | 101 |    1     |    0     |   1   |   1   |   1   |   1   |   1   |

Variable type: logical

|          variable           | missing | complete |  n  | mean | count |
|-----------------------------|---------|----------|-----|------|-------|
| Metropolitan.Division.Code  |   101   |    0     | 101 | NaN  |  101  |
| Metropolitan.Division.Title |   101   |    0     | 101 | NaN  |  101  |
|          SOC.code           |   101   |    0     | 101 | NaN  |  101  |

Variable type: numeric

|              variable              | missing | complete |  n  |  mean  |   sd   |   p0    |  p25   |  p50   |  p75   | p100  |
|------------------------------------|---------|----------|-----|--------|--------|---------|--------|--------|--------|-------|
| Good.and.promising.high.skill.jobs |    0    |   101    | 101 |  0.21  | 0.041  |  0.13   |  0.19  |  0.21  |  0.23  | 0.35  |
|   Good.and.promising.sub.BA.jobs   |    0    |   101    | 101 |  0.23  | 0.051  |  0.093  |  0.21  |  0.24  |  0.27  | 0.35  |
|        Good.high.skill.jobs        |    0    |   101    | 101 |  0.17  |  0.03  |  0.099  |  0.15  |  0.17  |  0.18  | 0.28  |
|          Good.sub.BA.jobs          |    0    |   101    | 101 |  0.13  | 0.032  |  0.049  |  0.11  |  0.13  |  0.15  | 0.21  |
|   Opportunity.jobs..high.skill.    |    0    |   101    | 101 |  0.21  |  0.04  |  0.12   |  0.18  |  0.21  |  0.22  | 0.34  |
|     Opportunity.jobs..sub.BA.      |    0    |   101    | 101 |  0.22  | 0.047  |  0.083  |  0.19  |  0.22  |  0.25  | 0.33  |
|             Other.jobs             |    0    |   101    | 101 |  0.55  | 0.041  |  0.45   |  0.52  |  0.54  |  0.58  | 0.65  |
|     Promising.high.skill.jobs      |    0    |   101    | 101 | 0.048  | 0.013  |  0.019  | 0.038  | 0.046  | 0.057  | 0.078 |
|       Promising.sub.BA.jobs        |    0    |   101    | 101 |  0.1   |  0.02  |  0.044  | 0.092  |  0.11  |  0.12  | 0.15  |
|          Quality.unknown           |    0    |   101    | 101 | 0.0038 | 0.0021 | 0.00095 | 0.0019 | 0.0036 | 0.0052 | 0.011 |
