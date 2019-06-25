

|                labels                 |   names    |
|---------------------------------------|------------|
|    total license and option issues    |  tot_lic   |
|    total licenses, large companies    |   lg_lic   |
|    total licenses, small companoes    |   sm_lic   |
|       total licenses, start-ups       |   st_lic   |
|         gross license income          |  inc_lic   |
| total investment disclosures received |   tot_IP   |
|        total start ups formed         |   tot_st   |
|        start ups in home state        | instate_st |
|           county FIPS code            | stco_fips  |
Skim summary statistics  
 n obs: 177    
 n variables: 9    

Variable type: character

| variable  | missing | complete |  n  | min | max | empty | n_unique |
|-----------|---------|----------|-----|-----|-----|-------|----------|
| stco_fips |    1    |   176    | 177 |  5  |  5  |   0   |   176    |

Variable type: integer

|  variable  | missing | complete |  n  |  mean   |    sd    | p0 | p25 | p50 | p75  | p100  |
|------------|---------|----------|-----|---------|----------|----|-----|-----|------|-------|
| instate_st |    0    |   177    | 177 |  76.81  |  548.05  | 0  |  3  | 16  |  42  | 7278  |
|   lg_lic   |    0    |   177    | 177 | 267.07  | 2040.93  | 0  |  4  | 24  | 150  | 27114 |
|   sm_lic   |    0    |   177    | 177 | 395.65  | 2908.44  | 0  |  6  | 36  | 237  | 38695 |
|   st_lic   |    0    |   177    | 177 | 139.55  |  1005.5  | 0  |  6  | 29  |  80  | 13376 |
|   tot_IP   |    0    |   177    | 177 | 3047.11 | 22798.37 | 0  | 110 | 517 | 1694 | 3e+05 |
|  tot_lic   |    0    |   177    | 177 | 850.71  | 6412.23  | 0  | 18  | 108 | 516  | 85353 |
|   tot_st   |    0    |   177    | 177 | 103.62  |  749.81  | 0  |  4  | 22  |  57  | 9963  |

Variable type: numeric

| variable | missing | complete |  n  |  mean   |   sd    | p0 |  p25   |   p50   |   p75   |  p100   |
|----------|---------|----------|-----|---------|---------|----|--------|---------|---------|---------|
| inc_lic  |    0    |   177    | 177 | 3.6e+08 | 3.1e+09 | 0  | 588647 | 9738011 | 5.9e+07 | 4.1e+10 |