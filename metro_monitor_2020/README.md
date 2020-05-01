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

Last Updated: Fri May 01 17:18:55 2020

Variables
---------

    ##    label                             names
    ## 1                                cbsa_code
    ## 2                                     year
    ## 3                                cbsa_name
    ## 4                                   top100
    ## 5                                     keep
    ## 6                                  largest
    ## 7                                    large
    ## 8                                 midsized
    ## 9        Employment at firms 0-5 years old
    ## 10                                    Jobs
    ## 11                                Real GDP
    ## 12                     Average Annual Wage
    ## 13                          Output per Job
    ## 14                       Output per Person
    ## 15                         Median Earnings
    ## 16                         Employment Rate
    ## 17            Relative Income Poverty Rate

Summary Statistics
------------------

|                                                  |      |
|:-------------------------------------------------|:-----|
| Name                                             | df   |
| Number of rows                                   | 2190 |
| Number of columns                                | 17   |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   |      |
| Column type frequency:                           |      |
| character                                        | 2    |
| numeric                                          | 15   |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |      |
| Group variables                                  | None |

**Variable type: character**

| skim\_variable |  n\_missing|  complete\_rate|  min|  max|  empty|  n\_unique|  whitespace|
|:---------------|-----------:|---------------:|----:|----:|------:|----------:|-----------:|
| cbsa\_code     |           0|               1|    5|    5|      0|        197|           0|
| cbsa\_name     |           0|               1|   13|   76|      0|        197|           0|

**Variable type: numeric**

| skim\_variable                    |  n\_missing|  complete\_rate|          mean|            sd|        p0|           p25|           p50|           p75|          p100| hist  |
|:----------------------------------|-----------:|---------------:|-------------:|-------------:|---------:|-------------:|-------------:|-------------:|-------------:|:------|
| year                              |           0|            1.00|  2.013000e+03|  3.160000e+00|   2007.00|  2.010000e+03|  2.013000e+03|  2.016000e+03|  2.018000e+03| ▆▅▅▅▇ |
| top100                            |          22|            0.99|  9.700000e-01|  1.600000e-01|      0.00|  1.000000e+00|  1.000000e+00|  1.000000e+00|  1.000000e+00| ▁▁▁▁▇ |
| keep                              |           0|            1.00|  1.000000e+00|  0.000000e+00|      1.00|  1.000000e+00|  1.000000e+00|  1.000000e+00|  1.000000e+00| ▁▁▇▁▁ |
| largest                           |          78|            0.96|  2.800000e-01|  4.500000e-01|      0.00|  0.000000e+00|  0.000000e+00|  1.000000e+00|  1.000000e+00| ▇▁▁▁▃ |
| large                             |          78|            0.96|  2.900000e-01|  4.500000e-01|      0.00|  0.000000e+00|  0.000000e+00|  1.000000e+00|  1.000000e+00| ▇▁▁▁▃ |
| midsized                          |          78|            0.96|  4.300000e-01|  5.000000e-01|      0.00|  0.000000e+00|  0.000000e+00|  1.000000e+00|  1.000000e+00| ▇▁▁▁▆ |
| Employment at firms 0-5 years old |          55|            0.97|  1.697701e+05|  9.939780e+05|   5809.00|  1.338100e+04|  2.275700e+04|  5.295250e+04|  1.257763e+07| ▇▁▁▁▁ |
| Jobs                              |          23|            0.99|  2.336993e+06|  1.375028e+07|  67995.22|  1.482374e+05|  2.385609e+05|  5.744420e+05|  1.512215e+08| ▇▁▁▁▁ |
| Real GDP                          |          22|            0.99|  3.217697e+11|  1.867652e+12|      0.00|  1.679221e+10|  2.767215e+10|  7.583337e+10|  2.010000e+13| ▇▁▁▁▁ |
| Average Annual Wage               |           1|            1.00|  4.894352e+04|  9.388950e+03|  32355.90|  4.348363e+04|  4.713948e+04|  5.202700e+04|  1.333023e+05| ▇▂▁▁▁ |
| Output per Job                    |           1|            1.00|  1.250165e+05|  2.373605e+04|  75906.88|  1.104321e+05|  1.210043e+05|  1.339354e+05|  2.983564e+05| ▇▇▁▁▁ |
| Output per Person                 |           1|            1.00|  5.334498e+04|  1.430236e+04|  22478.38|  4.511831e+04|  5.137086e+04|  5.997035e+04|  1.664393e+05| ▇▇▁▁▁ |
| Median Earnings                   |          23|            0.99|  3.191192e+04|  4.923390e+03|  17533.77|  2.889854e+04|  3.147040e+04|  3.404417e+04|  5.835438e+04| ▁▇▃▁▁ |
| Employment Rate                   |          45|            0.98|  7.000000e-01|  5.000000e-02|      0.55|  6.700000e-01|  7.000000e-01|  7.300000e-01|  8.500000e-01| ▁▃▇▅▁ |
| Relative Income Poverty Rate      |          23|            0.99|  2.700000e-01|  2.000000e-02|      0.19|  2.500000e-01|  2.700000e-01|  2.800000e-01|  3.700000e-01| ▁▆▇▁▁ |
