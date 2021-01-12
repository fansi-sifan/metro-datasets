
Title:  Demographic Data on Nonemployer businesses, 2017  

Contact:  Sifan Liu  

Source:  https://www.census.gov/programs-surveys/abs/data/nesd.html  

Note:    

Last updated:  Mon Jan 11 22:09:02 2021 



|Meaning of Sex Code |      n|
|:-------------------|------:|
|Classifiable        |  17461|
|Equally male/female |  22630|
|Female              |  27800|
|Male                |  29577|
|Total               | 222932|
|Unclassifiable      |   8747|

|Meaning of Race Code                       |      n|
|:------------------------------------------|------:|
|American Indian and Alaska Native          |  13157|
|Asian                                      |  18306|
|Black or African American                  |  19298|
|Classifiable                               |  17461|
|Equally minority/nonminority               |  10215|
|Minority                                   |  20725|
|Native Hawaiian and Other Pacific Islander |   7711|
|Nonminority                                |  23018|
|Total                                      | 164808|
|Unclassifiable                             |   8747|
|White                                      |  25701|

|Meaning of Ethnicity Code     |      n|
|:-----------------------------|------:|
|Classifiable                  |  17461|
|Equally Hispanic/non-Hispanic |   9151|
|Hispanic                      |  22171|
|Non-Hispanic                  |  27381|
|Total                         | 244236|
|Unclassifiable                |   8747|


```r
-- Data Summary ------------------------
                           Values    
Name                       Piped data
Number of rows             329147    
Number of columns          14        
_______________________              
Column type frequency:               
  character                13        
  numeric                  1         
________________________             
Group variables            None      

-- Variable type: character --------------------------------------------------------------------------------------------------
# A tibble: 13 x 8
   skim_variable                                                       n_missing complete_rate   min   max empty n_unique
 * <chr>                                                                   <int>         <dbl> <int> <int> <int>    <int>
 1 cbsa_code                                                                   0             1     5     5     0      932
 2 cbsa_name                                                                   0             1     7    46     0      932
 3 cbsa_size                                                                   0             1     5    17     0        5
 4 Geographic Area Name                                                        0             1    18    57     0      932
 5 2017 NAICS Code                                                             0             1     2     5     0       19
 6 Meaning of 2017 NAICS Code                                                  0             1     9    72     0       19
 7 Meaning of Sex Code                                                         0             1     4    19     0        6
 8 Meaning of Ethnicity Code                                                   0             1     5    29     0        6
 9 Meaning of Race Code                                                        0             1     5    42     0       11
10 Meaning of Veteran Code                                                     0             1     5    26     0        6
11 Noise Flag                                                                  0             1     1     1     0        3
12 Number of Nonemployer Firms                                                 0             1     1     9     0      609
13 Sales, Value of Shipments, or Revenue of Nonemployer Firms ($1,000)         0             1     1    11     0    70507
   whitespace
 *      <int>
 1          0
 2          0
 3          0
 4          0
 5          0
 6          0
 7          0
 8          0
 9          0
10          0
11          0
12          0
13          0

-- Variable type: numeric ----------------------------------------------------------------------------------------------------
# A tibble: 1 x 11
  skim_variable n_missing complete_rate  mean    sd    p0   p25   p50   p75  p100 hist 
* <chr>             <int>         <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <chr>
1 Year                  0             1  2017     0  2017  2017  2017  2017  2017 <U+2581><U+2581><U+2587><U+2581><U+2581>
```