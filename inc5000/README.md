

|         labels         |     names     |
|------------------------|---------------|
|       cbsa name        |   cbsa_name   |
| large/medium/small/non |   cbsa_size   |
|     i5hgc density      | i5hgc_density |
|       cbsa geoid       |   cbsa_code   |


Skim summary statistics  
 n obs: 464    
 n variables: 4    

Variable type: character

| variable  | missing | complete |  n  | min | max | empty | n_unique |
|-----------|---------|----------|-----|-----|-----|-------|----------|
| cbsa_code |    0    |   464    | 464 |  5  |  5  |   0   |   464    |

Variable type: factor

| variable  | missing | complete |  n  | n_unique |              top_counts               | ordered |
|-----------|---------|----------|-----|----------|---------------------------------------|---------|
| cbsa_name |    0    |   464    | 464 |   464    |    Adr: 1, Akr: 1, Alb: 1, Alb: 1     |  FALSE  |
| cbsa_size |    0    |   464    | 464 |    4     | Sma: 150, Mic: 134, Med: 128, Lar: 52 |  FALSE  |

Variable type: numeric

|   variable    | missing | complete |  n  | mean  |  sd   | p0  | p25  |  p50  |  p75  | p100  |
|---------------|---------|----------|-----|-------|-------|-----|------|-------|-------|-------|
| i5hgc_density |    0    |   464    | 464 | 55.54 | 56.52 | 1.5 | 19.6 | 38.15 | 71.55 | 417.1 |