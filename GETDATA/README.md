# Metro Data Warehouse BETA
This is a tool to look up data from the Metro Data Warehouse. It only includes summary statistics for the latest year, and industry total. For complete datasets, please go to the raw data files, located on V:/metro_data_warehouse/data_final

## How to fetch data

1. Click on the **County** or **Metro** tab at the top banner for intended geography
2. Search and select **place names**, or leave it blank to select all
3. Search and select the **datasets** by file names. All available datasets are listed below
4. Click **Show data** to display the data table for places and datasets you chose. Employment and population data are automatically attached in the last columns
5. Click **Download csv** to download a copy of the data table

## Create scatter plot for metro level data
1. Select the datasets first, then check the "create a scatter plot" box
2. Select the variables on x axis and y axis

## Appendix

County&nbsp;&nbsp;&nbsp; | file name | descriptions
-------|-----------|-------------
1 | co_acs | Selected indicators calculated from ACS 2017-5 year summary tables
2 | co_export | Export volume and intensity from Export Monitor
3 | co_jobdensity | Weighted actual job density, (jobs per sq mile)
4 | co_oic | Indicators from old industrial cities report
5 | co_oow | Out of Work population charateristics, 18-24 and 25-64, 2018
6 | co_school_proficiency | State MATH and RLA assessment (grade 4-8), 2018
7 | co_univ_licensing | University licensing activity and income
8 | co_univ_rd | University R&D investment, 2017
9 | co_uspto | Utility patent grants, 2015


&nbsp;


CBSA&nbsp; &nbsp;&nbsp;| file name | descriptions
-----|-----------|---------------------------------------------------
1 | cbsa_acs | Selected indicators calculated from ACS 2017-5 year summary tables
2 | cbsa_oppind | Opportunity industries share, 2017
3 | cbsa_export | Export volume and intensity from Export Monitor
4 | cbsa_job_density | Actual and expected job density, 2015
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

&nbsp;

## Codebook
Please use this [Github page](https://github.com/fansi-sifan/metro-datasets) for codebook, organized by dataset names. 

## Disclaimer
The datasets on Metro Data Warehouse are made available "as is" either by accessing open-source data repositories or provided to us by authors of research publications. 

We do our best to ensure that the data in the data warehouse is complete, accurate and useful. However, because the processing required to make the data useful is complex, we cannot be liable for omissions or inaccuracies.

