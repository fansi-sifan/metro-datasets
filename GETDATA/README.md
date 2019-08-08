# Metro Data Warehouse BETA
This is a tool to fetch data from the Metro Data Warehouse. The current release is a beta version which is still undergoing data checks and testing before its official release. Please do [let me know](mailto:sliu@brookings.edu) if you catch any errors, omissions or inaccuracies!

## How to fetch data

1. Click on the **County** or **Metro** tab at the top banner for intended geography
2. Search and select **place names**, or leave it blank to select all
3. Search and select the **datasets** by file names. All available datasets are listed below
4. Click **Show data** to display the data table for places and datasets you chose. Employment and population data are automatically attached in the last columns
5. Click **Download csv** to download a copy of the data table


County&nbsp;&nbsp;&nbsp; | file name | descriptions
-------|-----------|-------------
1 | co_acs | Selected indicators calculated from ACS summary tables
2 | co_acs_raw | Original columns fetched from ACS summary tables
3 | co_export | Export volume and intensity from Export Monitor
4 | co_jobdensity | Weighted actual job density, (jobs per sq mile)
5 | co_oic | Indicators from old industrial cities report
6 | co_oow | Seven major Out-of-work groups
7 | co_univ_licensing | University licensing activity and income
8 | co_univ_rd | University R&D investment, 2017
9 | co_uspto | Utility patent grants, 2015




CBSA&nbsp; &nbsp;&nbsp;| file name | descriptions
-----|-----------|---------------------------------------------------
1 | cbsa_acs | Selected indicators calculated from ACS summary tables
2 | cbsa_acs_raw | Original columns fetched from ACS summary tables
3 | cbsa_export | Export volume and intensity from Export Monitor
4 | cbsa_jobdensity | Weighted actual job density, (jobs per sq mile)
5 | cbsa_digitalization | Digitalization scores and share of jobs by digital level
6 | cbsa_housing_price | Housing-income ratio
7 | cbsa_univ_licensing | University licensing activity and income
8 | cbsa_univ_rd | University R&D investment, 2017
9 | cbsa_uspto | Utility patent grants, 2015
10| cbsa_regpat | OECD regpat patent counts, 2012
11| cbsa_patentcomplex | Patent complexity index, 2015
12| cbsa_vc | VC investment, 2017
13| cbsa_biz_rd | Domestic R&D performed by companies for selected metros, 2015
14| cbsa_i5hgc | Inc 5000 high growth firms by metro, 2017
15| cbsa_metromonitor | Rankings and values from metro monitor report, 2019
16| cbsa_low_wage_worker | Nine major low-wage-worker groups


## Codebook
Please use this [Github page](https://github.com/fansi-sifan/metro-datasets) for codebook, organized by dataset names. 

## Disclaimer
The datasets on Metro Data Warehouse are made available "as is" either by accessing open-source data repositories or provided to us by authors of research publications. 

We do our best to ensure that the data in the data warehouse is complete, accurate and useful. However, because the processing required to make the data useful is complex, we cannot be liable for omissions or inaccuracies.

