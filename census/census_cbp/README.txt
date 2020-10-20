
Title:  Employment by industry from County Business Pattern, 2018  

Contact:  Sifan Liu  

Source:  https://www.census.gov/data/datasets/2018/econ/cbp/2018-cbp.html  

Note:  2-, 3-, 4- and 6-digit NAICS code  

Last updated:  Tue Oct 20 07:57:49 2020 



|var   |label         |
|:-----|:-------------|
|EMP   |employment    |
|ESTAB |establishment |


```r
-- Data Summary ------------------------
                           Values    
Name                       Piped data
Number of rows             569217    
Number of columns          5         
_______________________              
Column type frequency:               
  character                2         
  numeric                  3         
________________________             
Group variables            None      

-- Variable type: character -------------------------------------
# A tibble: 2 x 8
  skim_variable n_missing complete_rate   min   max empty
* <chr>             <int>         <dbl> <int> <int> <int>
1 cbsa_code             0             1     5     5     0
2 naics_code            0             1     2     6     0
  n_unique whitespace
*    <int>      <int>
1      933          0
2     1995          0

-- Variable type: numeric ---------------------------------------
# A tibble: 3 x 11
  skim_variable n_missing complete_rate    mean       sd    p0
* <chr>             <int>         <dbl>   <dbl>    <dbl> <dbl>
1 naics_level           0             1    4.87     1.08     2
2 EMP                   0             1 1245.   21296.       0
3 ESTAB                 0             1   77.8   1362.       3
    p25   p50   p75    p100 hist 
* <dbl> <dbl> <dbl>   <dbl> <chr>
1     4     5     6       6 <U+2581><U+2582><U+2585><U+2587><U+2587>
2    34   106   393 8503944 <U+2587><U+2581><U+2581><U+2581><U+2581>
3     5    10    27  582021 <U+2587><U+2581><U+2581><U+2581><U+2581>
```