
Title:  Shiftshare analysis using EMSI data  

Contact:  Isha  

Source:  V:/Performance/Project files/Metro Monitor/2018v/Output/Shift Share/Monitor Shiftshare Cumulative (2-digit NAICS).csv  

Note:    

Last updated:  Fri Aug 02 15:23:20 2019 



|              label              |    names    |
|---------------------------------|-------------|
|                                 |  cbsa_code  |
|                                 |  cbsa_name  |
|                                 | naics2_code |
|                                 | naics2_name |
|                                 |    year     |
| Aggregate wage, Employment, GDP |  indicator  |
|        local shift 2006         | lsshare2006 |
|        industry mix 2006        | imshare2006 |
|       national share 2006       | nsshare2006 |
|        local shift 2011         | lsshare2011 |
|        industry mix 2011        | imshare2011 |
|       national share 2011       | nsshare2011 |
|        local shift 2015         | lsshare2015 |
|        industry mix 2015        | imshare2015 |
|       national share 2015       | nsshare2015 |
|                                 |    value    |


Skim summary statistics  
 n obs: 7800    
 n variables: 16    

Variable type: character

|  variable   | missing | complete |  n   | min | max | empty | n_unique |
|-------------|---------|----------|------|-----|-----|-------|----------|
|  cbsa_code  |    0    |   7800   | 7800 |  5  |  5  |   0   |   100    |
|  cbsa_name  |    0    |   7800   | 7800 | 39  | 76  |   0   |   100    |
|  indicator  |    0    |   7800   | 7800 |  3  | 14  |   0   |    3     |
| naics2_code |    0    |   7800   | 7800 |  2  |  6  |   0   |    26    |
| naics2_name |    0    |   7800   | 7800 |  5  | 72  |   0   |    26    |

Variable type: numeric

|  variable   | missing | complete |  n   |  mean   |   sd    |   p0   |   p25    |   p50    |   p75   |  p100   |
|-------------|---------|----------|------|---------|---------|--------|----------|----------|---------|---------|
| imshare2006 |    0    |   7800   | 7800 | 0.0028  |  0.13   | -0.69  |  -0.069  |  -0.014  |  0.092  |   1.3   |
| imshare2011 |    0    |   7800   | 7800 | 0.0029  |  0.088  | -1.01  |  -0.057  |  0.0095  |  0.06   |  0.73   |
| imshare2015 |    0    |   7800   | 7800 | -0.0017 |  0.033  |  -0.3  |  -0.011  | -4.8e-05 |  0.011  |  0.13   |
| lsshare2006 |    0    |   7800   | 7800 |  0.024  |  0.35   | -1.28  |  -0.095  | -0.0073  |  0.096  |  8.86   |
| lsshare2011 |    0    |   7800   | 7800 |  0.027  |  0.34   | -1.24  |  -0.059  |  0.0019  |  0.073  |  16.45  |
| lsshare2015 |    0    |   7800   | 7800 | 0.0046  |  0.076  | -0.63  |  -0.016  |  0.0017  |  0.02   |  2.79   |
| nsshare2006 |    0    |   7800   | 7800 |  0.11   |  0.045  | -0.012 |  0.068   |   0.11   |  0.14   |  0.76   |
| nsshare2011 |    0    |   7800   | 7800 |  0.12   |  0.027  | 0.029  |  0.095   |   0.1    |  0.14   |   0.4   |
| nsshare2015 |    0    |   7800   | 7800 |  0.017  | 0.00023 | 0.017  |  0.017   |  0.017   |  0.017  |  0.017  |
|    value    |    0    |   7800   | 7800 | 7.2e+09 |  4e+10  |   9    | 58531.25 | 4.6e+08  | 2.7e+09 | 1.5e+12 |
|    year     |    0    |   7800   | 7800 |  2016   |    0    |  2016  |   2016   |   2016   |  2016   |  2016   |
