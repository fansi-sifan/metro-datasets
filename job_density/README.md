July 2019

BI Metropolitan Policy Program
Bass Center for Transformative Placemaking
Joanne Kim


1. DATA SOURCES
   * CBSA definitions: OMB's September 2018 CBSA definitions

   * Jobs: Census LEHD Origin-Destination Employment Statistics (LODES) Version 7
         - Workplace Area Characteristics (WAC) type data
    	 - Data are culled using Cecile's R script, "pull_lehd.R". You can find raw LEHD LODES data files here: 
           V:\LEHD LODES
         - Coverage: Our data includes only private sector jobs (“JT02” for All Private Jobs), from 2004 to 2015. 

   * Land area: To find the land area of each block group, the authors started with Census Bureau TIGER/Line and 
	        ESRI shapefiles for block groups, hydrology, and water features. Using ArcGIS software, 
		the authors removed water features (hydrology) from block groups’ shape and then recalculated 
		block groups’ land area.



2. METHODS
  * Weighted (perceived) actual job density: 
	The perceived job density of a metro area is found by (1) calculating the standard job density of each block 
    	group, (2) weighting the block group by its share of the metro area’s jobs, (3) multiplying each block group’s
	standard job density by its job weight, and (4) summing the weighted job density of all block areas in the 
        metro area. 


Title:  
Contact:  
Source:  
Last updated:  Fri Jul 12 10:21:49 2019 



| c..var....lab.. |
|-----------------|
|       var       |
|       lab       |


Skim summary statistics  
 n obs: 1843    
 n variables: 18    

Variable type: character

| variable  | missing | complete |  n   | min | max | empty | n_unique |
|-----------|---------|----------|------|-----|-----|-------|----------|
| cbsa_code |    0    |   1843   | 1843 |  5  |  5  |   0   |    97    |
| cbsaname  |    0    |   1843   | 1843 |  9  | 29  |   0   |    97    |
|  measure  |    0    |   1843   | 1843 | 18  | 18  |   0   |    1     |
|   naics   |    0    |   1843   | 1843 |  2  |  2  |   0   |    19    |
|  sector   |    0    |   1843   | 1843 |  5  | 18  |   0   |    19    |

Variable type: numeric

| variable | missing | complete |  n   |   mean   |    sd    |   p0   |   p25   |   p50   |   p75   |   p100    |
|----------|---------|----------|------|----------|----------|--------|---------|---------|---------|-----------|
|   cbsa   |    0    |   1843   | 1843 | 32037.77 | 16707.38 | 10420  |  19100  |  32580  |  40380  |   99999   |
| year2004 |    0    |   1843   | 1843 | 9061.42  | 17578.78 | 69.75  | 2439.26 | 4268.58 | 8308.29 | 240013.66 |
| year2005 |    0    |   1843   | 1843 | 9067.35  | 17557.17 | 110.78 | 2425.29 | 4259.08 | 8025.87 | 232644.3  |
| year2006 |    0    |   1843   | 1843 | 9134.68  | 17765.61 | 68.18  | 2410.49 | 4227.9  | 8174.52 | 245066.5  |
| year2007 |    0    |   1843   | 1843 | 9256.28  | 18640.55 | 36.89  | 2386.05 | 4182.66 | 8117.81 | 250368.05 |
| year2008 |    0    |   1843   | 1843 | 9676.01  | 20223.19 | 42.63  | 2368.28 | 4220.82 | 8320.4  | 258780.67 |
| year2009 |    0    |   1843   | 1843 | 9509.59  | 20829.62 | 42.92  | 2233.9  | 4045.56 | 8069.75 | 281562.88 |
| year2010 |    0    |   1843   | 1843 | 9349.68  | 20234.66 | 27.81  | 2180.17 | 3950.76 | 7954.16 | 277125.25 |
| year2011 |    0    |   1843   | 1843 | 9515.07  | 20957.06 | 25.42  | 2244.71 | 3932.05 | 7950.55 |   3e+05   |
| year2012 |    0    |   1843   | 1843 | 9478.66  | 21583.82 | 55.71  | 2145.64 | 3878.22 | 7737.83 |   3e+05   |
| year2013 |    0    |   1843   | 1843 | 9713.13  | 21960.13 | 47.23  | 2168.32 | 3890.69 | 7876.35 |   3e+05   |
| year2014 |    0    |   1843   | 1843 | 9772.27  | 22191.02 | 56.18  | 2159.3  | 3879.04 | 7879.44 | 311028.81 |
| year2015 |    0    |   1843   | 1843 | 10016.87 | 23370.01 | 34.35  | 2210.97 | 3913.72 | 8415.86 | 318399.94 |
Title:  
Contact:  
Source:  
Last updated:  Fri Jul 12 10:21:53 2019 



| c..var....lab.. |
|-----------------|
|       var       |
|       lab       |


Skim summary statistics  
 n obs: 644    
 n variables: 21    

Variable type: character

| variable  | missing | complete |  n  | min | max | empty | n_unique |
|-----------|---------|----------|-----|-----|-----|-------|----------|
| cbsa_code |    0    |   644    | 644 |  5  |  5  |   0   |    95    |
| cbsaname  |    0    |   644    | 644 |  9  | 25  |   0   |    95    |
|  county   |    0    |   644    | 644 | 11  | 38  |   0   |   549    |
|  measure  |    0    |   644    | 644 | 18  | 18  |   0   |    1     |
|   naics   |    0    |   644    | 644 |  2  |  2  |   0   |    1     |
|  sector   |    0    |   644    | 644 |  5  |  5  |   0   |    1     |
| stco_code |    0    |   644    | 644 |  5  |  5  |   0   |   550    |
|   type    |    0    |   644    | 644 |  2  |  5  |   0   |    5     |

Variable type: numeric

| variable | missing | complete |  n  |   mean   |    sd    |  p0   |  p25   |   p50   |   p75   |   p100    |
|----------|---------|----------|-----|----------|----------|-------|--------|---------|---------|-----------|
|   cbsa   |    0    |   644    | 644 | 29117.67 | 11908.94 | 10420 | 17460  |  30780  |  38900  |   99999   |
| year2004 |    0    |   644    | 644 | 4728.15  | 15778.37 | 0.077 | 489.86 | 1768.94 | 4434.31 | 337973.97 |
| year2005 |    0    |   644    | 644 | 4753.17  | 16028.86 | 0.066 | 486.79 | 1709.9  | 4451.71 | 342336.22 |
| year2006 |    0    |   644    | 644 | 4794.72  | 16468.56 | 0.065 | 483.41 | 1729.33 | 4403.89 |  353552   |
| year2007 |    0    |   644    | 644 | 4821.43  | 16894.36 | 0.088 | 437.97 | 1639.46 | 4374.23 | 360627.06 |
| year2008 |    0    |   644    | 644 | 4981.76  | 17668.27 | 0.12  | 438.53 | 1636.36 | 4454.06 | 375102.06 |
| year2009 |    0    |   644    | 644 | 4994.03  | 18130.42 | 0.11  | 410.98 | 1621.17 | 4397.78 | 385079.19 |
| year2010 |    0    |   644    | 644 | 4999.12  | 18046.84 | 0.11  | 425.44 | 1611.97 | 4474.95 | 381033.16 |
| year2011 |    0    |   644    | 644 | 5114.53  | 18829.02 | 0.087 | 420.46 | 1625.95 | 4502.27 |   4e+05   |
| year2012 |    0    |   644    | 644 | 4966.78  | 19231.23 | 0.36  | 404.28 | 1524.41 | 4308.79 | 414568.62 |
| year2013 |    0    |   644    | 644 | 5148.81  | 19684.57 | 0.42  | 403.24 | 1519.55 | 4385.42 | 418466.16 |
| year2014 |    0    |   644    | 644 | 5174.17  | 20082.36 | 0.58  | 409.93 | 1487.58 | 4383.61 | 426887.66 |
| year2015 |    0    |   644    | 644 | 5269.18  | 20747.77 | 0.45  | 402.6  | 1535.2  | 4526.62 | 441559.5  |
