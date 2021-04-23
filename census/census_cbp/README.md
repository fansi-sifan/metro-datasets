
Title:  Employment by industry from County Business Pattern, 2019  

Contact:  Sifan Liu  

Source:  http://www.census.gov/programs-surveys/cbp/data/datasets.html  

Note:  2-, 3-, 4- and 6-digit NAICS code  

Last updated:  Thu Apr 22 21:43:54 2021 



|var   |label         |
|:-----|:-------------|
|EMP   |employment    |
|ESTAB |establishment |


```r
-- Data Summary ------------------------
                           Values    
Name                       Piped data
Number of rows             569017    
Number of columns          5         
_______________________              
Column type frequency:               
  character                2         
  numeric                  3         
________________________             
Group variables            None      

-- Variable type: character ---------------------------------------------------------------------
# A tibble: 2 x 8
  skim_variable n_missing complete_rate   min   max empty n_unique whitespace
* <chr>             <int>         <dbl> <int> <int> <int>    <int>      <int>
1 cbsa_code             0             1     5     5     0      933          0
2 naics_code            0             1     2     6     0     1992          0

-- Variable type: numeric -----------------------------------------------------------------------
# A tibble: 3 x 11
  skim_variable n_missing complete_rate    mean       sd    p0   p25   p50   p75    p100 hist 
* <chr>             <int>         <dbl>   <dbl>    <dbl> <dbl> <dbl> <dbl> <dbl>   <dbl> <chr>
1 naics_level           0             1    4.87     1.08     2     4     5     6       6 <U+2581><U+2582><U+2585><U+2587><U+2587>
2 EMP                   0             1 1263.   21649.       0    34   107   398 8672415 <U+2587><U+2581><U+2581><U+2581><U+2581>
3 ESTAB                 0             1   78.4   1372.       3     5     9    27  582686 <U+2587><U+2581><U+2581><U+2581><U+2581>
```