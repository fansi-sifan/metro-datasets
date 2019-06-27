

|                     labels                      |   names   |
|-------------------------------------------------|-----------|
|            time period of investment            |  period   |
|              total venture capital              |   round   |
| capital invested (in_millions) per 1M residents |   value   |
|                    latitude                     | latitude  |
|                    longitude                    | longitude |
|                  cbsa ranking                   |   rank    |
|                    cbsa code                    | cbsa_code |
|                    cbsa name                    | cbsa_name |

Skim summary statistics  
 n obs: 113    
 n variables: 8    

Variable type: character

| variable  | missing | complete |  n  | min | max | empty | n_unique |
|-----------|---------|----------|-----|-----|-----|-------|----------|
| cbsa_code |    0    |   113    | 113 |  5  |  5  |   0   |   112    |
| cbsa_name |    0    |   113    | 113 |  4  | 22  |   0   |   113    |

Variable type: factor

| variable | missing | complete |  n  | n_unique |            top_counts            | ordered |
|----------|---------|----------|-----|----------|----------------------------------|---------|
|  period  |    0    |   113    | 113 |    1     | 201: 113, 200: 0, 200: 0, 201: 0 |  FALSE  |
|  round   |    0    |   113    | 113 |    1     | Tot: 113, Ear: 0, Lat: 0, Pre: 0 |  FALSE  |

Variable type: numeric

| variable  | missing | complete |  n  |  mean  |   sd    |   p0    |   p25   |  p50   |  p75   |   p100   |
|-----------|---------|----------|-----|--------|---------|---------|---------|--------|--------|----------|
| latitude  |    0    |   113    | 113 | 38.15  |  4.96   |  21.31  |  35.08  | 39.16  | 41.77  |  47.66   |
| longitude |    0    |   113    | 113 | -92.51 |  17.29  | -157.86 | -105.27 | -86.16 |  -80   |  -70.26  |
|   rank    |    0    |   113    | 113 | 121.22 |  79.88  |    1    |   52    |  114   |  186   |   309    |
|   value   |    0    |   113    | 113 | 741.23 | 2081.81 |  8.39   |  108.4  | 219.16 | 525.62 | 17457.99 |
