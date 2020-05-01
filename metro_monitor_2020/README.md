Descriptions
------------

Title: Metro monitor, 2008 - 2018

Source:
<a href="https://www.brookings.edu/interactives/metro-monitor-2020" class="uri">https://www.brookings.edu/interactives/metro-monitor-2020</a>

Note: This year, for the first time, Metro Monitor measured and ranked
the performance of 192 metropolitan areas on each indicator within its
population size class: 53 very large metro areas (populations of at
least 1 million in 2018); 56 large metro areas (populations of 500,000
to 999,999 in 2018); and 83 midsized metro areas (populations of 250,000
to 499,999 in 2018). more details here:
<a href="https://www.brookings.edu/wp-content/uploads/2020/03/2020-Metro-Monitor-Methods-and-Data.pdf" class="uri">https://www.brookings.edu/wp-content/uploads/2020/03/2020-Metro-Monitor-Methods-and-Data.pdf</a>

Contact: Sarah Crump

Last Updated: Fri May 01 17:10:57 2020

Variables
---------

| label | names                             |
|:------|:----------------------------------|
|       | cbsa\_code                        |
|       | year                              |
|       | cbsa\_name                        |
|       | top100                            |
|       | keep                              |
|       | largest                           |
|       | large                             |
|       | midsized                          |
|       | Employment at firms 0-5 years old |
|       | Jobs                              |
|       | Real GDP                          |
|       | Average Annual Wage               |
|       | Output per Job                    |
|       | Output per Person                 |
|       | Median Earnings                   |
|       | Employment Rate                   |
|       | Relative Income Poverty Rate      |

Summary Statistics
------------------

``` r
skimr::skim(df)
```

    ## -- Data Summary ------------------------
    ##                            Values
    ## Name                       df    
    ## Number of rows             2234  
    ## Number of columns          17    
    ## _______________________          
    ## Column type frequency:           
    ##   character                2     
    ##   numeric                  15    
    ## ________________________         
    ## Group variables            None  
    ## 
    ## -- Variable type: character ------------------------------------------------------------------------------------------------------------------------
    ## # A tibble: 2 x 8
    ##   skim_variable n_missing complete_rate   min   max empty n_unique whitespace
    ## * <chr>             <int>         <dbl> <int> <int> <int>    <int>      <int>
    ## 1 cbsa_code             0         1         1     5     0      201          0
    ## 2 cbsa_name            44         0.980    13    76     0      197          0
    ## 
    ## -- Variable type: numeric --------------------------------------------------------------------------------------------------------------------------
    ## # A tibble: 15 x 11
    ##    skim_variable                     n_missing complete_rate     mean       sd        p0      p25      p50      p75     p100 hist 
    ##  * <chr>                                 <int>         <dbl>    <dbl>    <dbl>     <dbl>    <dbl>    <dbl>    <dbl>    <dbl> <chr>
    ##  1 year                                      0         1     2.01e+ 3 3.16e+ 0  2007     2.01e+ 3 2.01e+ 3 2.02e+ 3 2.02e+ 3 <U+2586><U+2585><U+2585><U+2585><U+2587>
    ##  2 top100                                   66         0.970 9.74e- 1 1.59e- 1     0     1.00e+ 0 1.00e+ 0 1.00e+ 0 1.00e+ 0 <U+2581><U+2581><U+2581><U+2581><U+2587>
    ##  3 keep                                     44         0.980 1.00e+ 0 0.           1     1.00e+ 0 1.00e+ 0 1.00e+ 0 1.00e+ 0 <U+2581><U+2581><U+2587><U+2581><U+2581>
    ##  4 largest                                 122         0.945 2.76e- 1 4.47e- 1     0     0.       0.       1.00e+ 0 1.00e+ 0 <U+2587><U+2581><U+2581><U+2581><U+2583>
    ##  5 large                                   122         0.945 2.92e- 1 4.55e- 1     0     0.       0.       1.00e+ 0 1.00e+ 0 <U+2587><U+2581><U+2581><U+2581><U+2583>
    ##  6 midsized                                122         0.945 4.32e- 1 4.96e- 1     0     0.       0.       1.00e+ 0 1.00e+ 0 <U+2587><U+2581><U+2581><U+2581><U+2586>
    ##  7 Employment at firms 0-5 years old        99         0.956 1.70e+ 5 9.94e+ 5  5809     1.34e+ 4 2.28e+ 4 5.30e+ 4 1.26e+ 7 <U+2587><U+2581><U+2581><U+2581><U+2581>
    ##  8 Jobs                                     67         0.970 2.34e+ 6 1.38e+ 7 67995.    1.48e+ 5 2.39e+ 5 5.74e+ 5 1.51e+ 8 <U+2587><U+2581><U+2581><U+2581><U+2581>
    ##  9 Real GDP                                 66         0.970 3.22e+11 1.87e+12     0     1.68e+10 2.77e+10 7.58e+10 2.01e+13 <U+2587><U+2581><U+2581><U+2581><U+2581>
    ## 10 Average Annual Wage                      45         0.980 4.89e+ 4 9.39e+ 3 32356.    4.35e+ 4 4.71e+ 4 5.20e+ 4 1.33e+ 5 <U+2587><U+2582><U+2581><U+2581><U+2581>
    ## 11 Output per Job                           45         0.980 1.25e+ 5 2.37e+ 4 75907.    1.10e+ 5 1.21e+ 5 1.34e+ 5 2.98e+ 5 <U+2587><U+2587><U+2581><U+2581><U+2581>
    ## 12 Output per Person                        45         0.980 5.33e+ 4 1.43e+ 4 22478.    4.51e+ 4 5.14e+ 4 6.00e+ 4 1.66e+ 5 <U+2587><U+2587><U+2581><U+2581><U+2581>
    ## 13 Median Earnings                          23         0.990 3.19e+ 4 4.90e+ 3 17534.    2.89e+ 4 3.15e+ 4 3.40e+ 4 5.84e+ 4 <U+2581><U+2587><U+2583><U+2581><U+2581>
    ## 14 Employment Rate                          89         0.960 7.03e- 1 4.65e- 2     0.554 6.74e- 1 7.05e- 1 7.34e- 1 8.46e- 1 <U+2581><U+2583><U+2587><U+2585><U+2581>
    ## 15 Relative Income Poverty Rate             67         0.970 2.69e- 1 2.25e- 2     0.193 2.55e- 1 2.69e- 1 2.82e- 1 3.72e- 1 <U+2581><U+2586><U+2587><U+2581><U+2581>
