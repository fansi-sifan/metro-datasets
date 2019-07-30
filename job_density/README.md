
Title:  Job density 

Contact:  Joanne Kim 

Source:  https://www.brookings.edu/research/where-jobs-are-concentrating-why-it-matters-to-cities-and-regions/ 

1. DATA 

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

   * County typology: Counties in metro areas are assigned a type according to the share of their population 
		     that lives in urbanized areas in 2000, which are defined by the U.S. Census Bureau.
		     - based on Census 2000 Census Summary File
                     - https://factfinder.census.gov/bkmk/table/1.0/en/DEC/00_SF2/PCT002/0100000US.05000.003
  
   * Coverage: 
		A. Metro areas: The analysis excludes six of the nation’s largest 100 metropolitan areas:
		Boston; Madison, Wis.; Milwaukee; Springfield, Mass.; Washington; and Worcester, Mass. 
		Additionally, the Massachusetts portion of the Providence, R.I. metro area and 
		the Wisconsin portions of the Chicago and Minneapolis-St. Paul metro areas are excluded from 
		the analysis.

		B. Sectors: Authors exclude jobs in Administrative and Support and Waste Management 
		and Remediation Services & Public Administration (NAICS sector 56 and 92) from the analysis 
		as we weren't sure of its reliability. In some cases the Census Bureau has incomplete data or
		cannot determine the location of jobs for multi-establishment firms. This issue is especially 
		prevalent in the government, public administration, and administrative services sectors. 
  

2. METHODS

  * Job density: Actual job-weighted job density 
	The perceived job density of a metro area is found by (1) calculating the standard job density of each block 
    	group, (2) weighting the block group by its share of the metro area’s jobs, (3) multiplying each block group’s
	standard job density by its job weight, and (4) summing the weighted job density of all block areas in the 
        metro area.
Last updated:  Mon Jul 15 18:38:29 2019 



|                           label                           |      names      |
|-----------------------------------------------------------|-----------------|
|                                                           |    cbsa_code    |
|                                                           |    cbsa_name    |
|                                                           |   naics2_code   |
|                                                           |   naics2_name   |
|                                                           |      year       |
| Weighted (perceived) actual job density, jobs per sq mile | cbsa_jobdensity |


Skim summary statistics  
 n obs: 22116    
 n variables: 6    

Variable type: character

|  variable   | missing | complete |   n   | min | max | empty | n_unique |
|-------------|---------|----------|-------|-----|-----|-------|----------|
|  cbsa_code  |    0    |  22116   | 22116 |  5  |  5  |   0   |    97    |
|  cbsa_name  |    0    |  22116   | 22116 |  9  | 29  |   0   |    97    |
| naics2_code |    0    |  22116   | 22116 |  2  |  2  |   0   |    19    |
| naics2_name |    0    |  22116   | 22116 |  5  | 18  |   0   |    19    |

Variable type: integer

| variable | missing | complete |   n   |  mean  |  sd  |  p0  |   p25   |  p50   |   p75   | p100 |
|----------|---------|----------|-------|--------|------|------|---------|--------|---------|------|
|   year   |    0    |  22116   | 22116 | 2009.5 | 3.45 | 2004 | 2006.75 | 2009.5 | 2012.25 | 2015 |

Variable type: numeric

|    variable     | missing | complete |   n   |  mean   |    sd    |  p0   |   p25   |   p50   |   p75   |   p100    |
|-----------------|---------|----------|-------|---------|----------|-------|---------|---------|---------|-----------|
| cbsa_jobdensity |    0    |  22116   | 22116 | 9462.59 | 20324.62 | 25.42 | 2274.79 | 4052.76 | 8072.17 | 318399.94 |


Title:   

Contact:   

Source:   

Note:   

Last updated:  Mon Jul 15 18:51:35 2019 



|                           label                           |       names       |
|-----------------------------------------------------------|-------------------|
|                                                           |     cbsa_code     |
|                                                           |     cbsa_name     |
|                                                           |     stco_code     |
|                                                           |     stco_name     |
|                                                           |    naics2_code    |
|                                                           |    naics2_name    |
| UC(Urban COre);ES(Emerging Suburban);MS(Mature Suburban)  |       type        |
|                                                           |       year        |
| Weighted (perceived) actual job density, jobs per sq mile | county_jobdensity |


Skim summary statistics  
 n obs: 7728    
 n variables: 9    

Variable type: character

|  variable   | missing | complete |  n   | min | max | empty | n_unique |
|-------------|---------|----------|------|-----|-----|-------|----------|
|  cbsa_code  |    0    |   7728   | 7728 |  5  |  5  |   0   |    95    |
|  cbsa_name  |    0    |   7728   | 7728 |  9  | 25  |   0   |    95    |
| naics2_code |    0    |   7728   | 7728 |  2  |  2  |   0   |    1     |
| naics2_name |    0    |   7728   | 7728 |  5  |  5  |   0   |    1     |
|  stco_code  |    0    |   7728   | 7728 |  5  |  5  |   0   |   550    |
|  stco_name  |    0    |   7728   | 7728 | 11  | 38  |   0   |   549    |
|    type     |    0    |   7728   | 7728 |  2  |  5  |   0   |    5     |

Variable type: integer

| variable | missing | complete |  n   |  mean  |  sd  |  p0  |   p25   |  p50   |   p75   | p100 |
|----------|---------|----------|------|--------|------|------|---------|--------|---------|------|
|   year   |    0    |   7728   | 7728 | 2009.5 | 3.45 | 2004 | 2006.75 | 2009.5 | 2012.25 | 2015 |

Variable type: numeric

|     variable      | missing | complete |  n   |  mean   |    sd    |  p0   |  p25   |   p50   |   p75   |   p100   |
|-------------------|---------|----------|------|---------|----------|-------|--------|---------|---------|----------|
| county_jobdensity |    0    |   7728   | 7728 | 4978.82 | 18187.43 | 0.065 | 430.92 | 1591.08 | 4443.74 | 441559.5 |
