

|                   label                   |     names      |
|-------------------------------------------|----------------|
|                cbsa geoid                 |   cbsa_code    |
| cbsa type: metro, mico, non, undetermined |   cbsa_type    |
|                cbsa names                 |   cbsa_name    |
|          year patent was issued           |      year      |
|           total patents issued            | patents_issued |


Skim summary statistics  
 n obs: 16288    
 n variables: 5    

Variable type: character

| variable  | missing | complete |   n   | min | max | empty | n_unique |
|-----------|---------|----------|-------|-----|-----|-------|----------|
| cbsa_code |    0    |  16288   | 16288 |  2  |  5  |   0   |   1018   |
| cbsa_name |    0    |  16288   | 16288 |  7  | 50  |   0   |   1018   |
| cbsa_type |    0    |  16288   | 16288 | 29  | 39  |   0   |    4     |

Variable type: numeric

|    variable    | missing | complete |   n   |  mean  |  sd   |  p0  |   p25   |  p50   |   p75   | p100  |
|----------------|---------|----------|-------|--------|-------|------|---------|--------|---------|-------|
| patents_issued |    0    |  16288   | 16288 | 97.77  | 520.7 |  0   |    2    |   6    |   24    | 14894 |
|      year      |    0    |  16288   | 16288 | 2007.5 | 4.61  | 2000 | 2003.75 | 2007.5 | 2011.25 | 2015  |


|         label          |     names      |
|------------------------|----------------|
|      county code       |   stco_code    |
|      county names      |    co_name     |
| year patent was issued |      year      |
|  total patents issued  | patents_issued |


Skim summary statistics  
 n obs: 48304    
 n variables: 4    

Variable type: character

| variable  | missing | complete |   n   | min | max | empty | n_unique |
|-----------|---------|----------|-------|-----|-----|-------|----------|
|  co_name  |    0    |  48304   | 48304 | 10  | 33  |   0   |   1821   |
| stco_code |    0    |  48304   | 48304 |  5  |  5  |   0   |   3019   |

Variable type: numeric

|    variable    | missing | complete |   n   | mean  |   sd   | p0 | p25  | p50 |  p75  | p100  |
|----------------|---------|----------|-------|-------|--------|----|------|-----|-------|-------|
| patents_issued |    0    |  48304   | 48304 | 32.98 | 230.53 | 0  |  0   |  1  |   7   | 14847 |
|      year      |    0    |  48304   | 48304 |  7.5  |  4.61  | 0  | 3.75 | 7.5 | 11.25 |  15   |
