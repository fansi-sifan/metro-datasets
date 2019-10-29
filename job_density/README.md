
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

