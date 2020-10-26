
Title:  broadband adoption rates by tract  

Contact:  Adie Tomer  

Source:  https://www.brookings.edu/blog/the-avenue/2020/02/05/neighborhood-broadband-data-makes-it-clear-we-need-an-agenda-to-fight-digital-poverty/  

Note:  Source: Brookings analysis of ACS 2018 5-year estimates. 
Note: 
Tracts in digital poverty are tracts where at least half the neighborhood’s households do not have a wireline subscription and at least half do not have a wireless subscription  

Last updated:  Mon Oct 26 08:54:13 2020 



|name           |label                               |
|:--------------|:-----------------------------------|
|totalhh        |Total households                    |
|with_broadband |Number of households with broadband |
|dig_pov        |Share of tracts in digital poverty  |


```r
-- Data Summary ------------------------
                           Values    
Name                       Piped data
Number of rows             100       
Number of columns          7         
_______________________              
Column type frequency:               
  character                2         
  numeric                  5         
________________________             
Group variables            None      

-- Variable type: character -------------------------------------
# A tibble: 2 x 8
  skim_variable n_missing complete_rate   min   max empty
* <chr>             <int>         <dbl> <int> <int> <int>
1 cbsa_code             0             1     5     5     0
2 cbsa_name             0             1     2    57     0
  n_unique whitespace
*    <int>      <int>
1      100          0
2      100          0

-- Variable type: numeric ---------------------------------------
# A tibble: 5 x 11
  skim_variable       n_missing complete_rate        mean
* <chr>                   <int>         <dbl>       <dbl>
1 totalhh                     0             1 786883.    
2 with_broadband              0             1 651457.    
3 count                       0             1    466.    
4 dig_pov                     0             1     33.6   
5 pct_digital_poverty         0             1      0.0888
           sd     p0         p25         p50        p75
*       <dbl>  <dbl>       <dbl>       <dbl>      <dbl>
1 969887.     162369 269810.     416113      854988.   
2 810357.     140609 221242.     335234.     711006.   
3    608.         95    163         255         500.   
4     41.6         0      6          20.5        39.5  
5      0.0867      0      0.0224      0.0636      0.124
         p100 hist 
*       <dbl> <chr>
1 7195244     <U+2587><U+2581><U+2581><U+2581><U+2581>
2 5943840     <U+2587><U+2581><U+2581><U+2581><U+2581>
3    4611     <U+2587><U+2581><U+2581><U+2581><U+2581>
4     207     <U+2587><U+2581><U+2581><U+2581><U+2581>
5       0.473 <U+2587><U+2585><U+2581><U+2581><U+2581>
```