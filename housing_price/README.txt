
Title:  Housing Price to Income Ratios Across Metro Areas  

Contact:  Jenny Schuetz  

Source:  https://www.brookings.edu/research/housing-in-the-u-s-is-too-expensive-too-cheap-and-just-right-it-depends-on-where-you-live/  

Note:  Figures include only tracts where at least 10% of homes are owner-occupied;
 percentile columns contain % of tracts where the price-income ratio is in the given percentile range  

Last updated:  Tue Oct 29 11:30:16 2019 



|            label             |   names    |
|------------------------------|------------|
|             CBSA             | cbsa_code  |
|          Metro Name          | cbsa_name  |
|           # Tracts           |   tracts   |
|         # Households         | households |
|        Average price         |   price    |
|        Average income        |   income   |
|  Average price-income rato   |     pi     |
|         Map category         |   pi_map   |
|    Under 10th percentile     |   pi_10    |
|  Above the 90th percentile   |   pi_90    |
| Between 10th-90th percentile |  pi_10_90  |


Skim summary statistics  
 n obs: 381    
 n variables: 11    

Variable type: character

| variable  | missing | complete |  n  | min | max | empty | n_unique |
|-----------|---------|----------|-----|-----|-----|-------|----------|
| cbsa_code |    0    |   381    | 381 |  5  |  5  |   0   |   381    |
| cbsa_name |    0    |   381    | 381 |  8  | 46  |   0   |   381    |
|  pi_map   |    0    |   381    | 381 |  3  | 12  |   0   |    5     |

Variable type: numeric

|  variable  | missing | complete |  n  |   mean    |    sd    |  p0   |  p25   |  p50   |  p75   |  p100   |
|------------|---------|----------|-----|-----------|----------|-------|--------|--------|--------|---------|
| households |    0    |   381    | 381 | 254664.43 | 538250.8 | 21802 | 52539  | 89955  | 211470 | 6300000 |
|   income   |    0    |   381    | 381 | 53713.43  | 11066.1  | 33560 | 46359  | 51667  | 58533  | 106472  |
|     pi     |    0    |   381    | 381 |   3.34    |   1.17   | 1.68  |  2.59  |  3.07  |  3.71  |  8.56   |
|   pi_10    |    0    |   381    | 381 |   0.095   |   0.14   |   0   |   0    |  0.03  |  0.13  |  0.92   |
|  pi_10_90  |    0    |   381    | 381 |   0.85    |   0.16   | 0.08  |  0.79  |  0.9   |  0.96  |    1    |
|   pi_90    |    0    |   381    | 381 |   0.051   |   0.12   |   0   |   0    |  0.01  |  0.04  |  0.87   |
|   price    |    0    |   381    | 381 | 181305.39 | 99908.5  | 73779 | 121820 | 156300 | 205731 |  8e+05  |
|   tracts   |    0    |   381    | 381 |  152.58   |  339.12  |  12   |   30   |   51   |  120   |  4153   |
