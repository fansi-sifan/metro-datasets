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
to 499,999 in 2018). For more details, please check the methodology
document:
<a href="https://www.brookings.edu/wp-content/uploads/2020/03/2020-Metro-Monitor-Methods-and-Data.pdf" class="uri">https://www.brookings.edu/wp-content/uploads/2020/03/2020-Metro-Monitor-Methods-and-Data.pdf</a>

Contact: Sarah Crump

Last Updated: Fri May 01 17:36:22 2020

Variables
---------

| label                                                           | names                             |
|:----------------------------------------------------------------|:----------------------------------|
| United States = 99999                                           | cbsa\_code                        |
|                                                                 | year                              |
|                                                                 | cbsa\_name                        |
|                                                                 | top100                            |
|                                                                 | keep                              |
| populations of at least 1 million in 2018                       | largest                           |
| populations of 500,000 to 999,999 in 2018                       | large                             |
| populations of 250,000 to 499,999 in 2018                       | midsized                          |
|                                                                 | Employment at firms 0-5 years old |
|                                                                 | Jobs                              |
|                                                                 | Real GDP                          |
|                                                                 | Average Annual Wage               |
|                                                                 | Output per Job                    |
|                                                                 | Output per Person                 |
|                                                                 | Median Earnings                   |
|                                                                 | Employment Rate                   |
| share of people earning less than half of the local median wage | Relative Income Poverty Rate      |

Summary Statistics
------------------

|                                                  |      |
|:-------------------------------------------------|:-----|
| Name                                             | df   |
| Number of rows                                   | 2189 |
| Number of columns                                | 17   |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   |      |
| Column type frequency:                           |      |
| character                                        | 2    |
| factor                                           | 6    |
| numeric                                          | 9    |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |      |
| Group variables                                  | None |

**Variable type: character**

| skim\_variable |  n\_missing|  complete\_rate|  min|  max|  empty|  n\_unique|  whitespace|
|:---------------|-----------:|---------------:|----:|----:|------:|----------:|-----------:|
| cbsa\_code     |           0|               1|    5|    5|      0|        197|           0|
| cbsa\_name     |           0|               1|   13|   76|      0|        197|           0|

**Variable type: factor**

| skim\_variable |  n\_missing|  complete\_rate| ordered |  n\_unique| top\_counts                            |
|:---------------|-----------:|---------------:|:--------|----------:|:---------------------------------------|
| year           |           0|            1.00| FALSE   |         11| 200: 199, 200: 199, 201: 199, 201: 199 |
| top100         |          22|            0.99| FALSE   |          2| 1: 2112, 0: 55                         |
| keep           |           0|            1.00| FALSE   |          1| 1: 2189                                |
| largest        |          77|            0.96| FALSE   |          2| 0: 1529, 1: 583                        |
| large          |          77|            0.96| FALSE   |          2| 0: 1496, 1: 616                        |
| midsized       |          77|            0.96| FALSE   |          2| 0: 1199, 1: 913                        |

**Variable type: numeric**

| skim\_variable                    |  n\_missing|  complete\_rate|          mean|            sd|            p0|           p25|           p50|           p75|          p100| hist  |
|:----------------------------------|-----------:|---------------:|-------------:|-------------:|-------------:|-------------:|-------------:|-------------:|-------------:|:------|
| Employment at firms 0-5 years old |          54|            0.98|  1.697701e+05|  9.939780e+05|  5.809000e+03|  1.338100e+04|  2.275700e+04|  5.295250e+04|  1.257763e+07| ▇▁▁▁▁ |
| Jobs                              |          22|            0.99|  2.336993e+06|  1.375028e+07|  6.799522e+04|  1.482374e+05|  2.385609e+05|  5.744420e+05|  1.512215e+08| ▇▁▁▁▁ |
| Real GDP                          |          22|            0.99|  3.219182e+11|  1.868071e+12|  6.899147e+09|  1.679800e+10|  2.769056e+10|  7.585834e+10|  2.010000e+13| ▇▁▁▁▁ |
| Average Annual Wage               |           0|            1.00|  4.894352e+04|  9.388950e+03|  3.235590e+04|  4.348363e+04|  4.713948e+04|  5.202700e+04|  1.333023e+05| ▇▂▁▁▁ |
| Output per Job                    |           0|            1.00|  1.250165e+05|  2.373605e+04|  7.590688e+04|  1.104321e+05|  1.210043e+05|  1.339354e+05|  2.983564e+05| ▇▇▁▁▁ |
| Output per Person                 |           0|            1.00|  5.334498e+04|  1.430236e+04|  2.247838e+04|  4.511831e+04|  5.137086e+04|  5.997035e+04|  1.664393e+05| ▇▇▁▁▁ |
| Median Earnings                   |          22|            0.99|  3.191192e+04|  4.923390e+03|  1.753377e+04|  2.889854e+04|  3.147040e+04|  3.404417e+04|  5.835438e+04| ▁▇▃▁▁ |
| Employment Rate                   |          44|            0.98|  7.000000e-01|  5.000000e-02|  5.500000e-01|  6.700000e-01|  7.000000e-01|  7.300000e-01|  8.500000e-01| ▁▃▇▅▁ |
| Relative Income Poverty Rate      |          22|            0.99|  2.700000e-01|  2.000000e-02|  1.900000e-01|  2.500000e-01|  2.700000e-01|  2.800000e-01|  3.700000e-01| ▁▆▇▁▁ |
