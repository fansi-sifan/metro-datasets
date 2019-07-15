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


