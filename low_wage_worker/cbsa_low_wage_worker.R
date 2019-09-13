library(tidyverse)
library(skimr)
library(expss)
library(sjlabelled)
source("R/save_output.R")

# SET UP ====================================
source_dir <- "source/LWW_Overall_stats_metros.csv"
folder_name <- "low_wage_worker"
file_name <- "cbsa_low_wage_worker"

# metadata -----------
dt_title <- "Low Wage Worker Clusters and Demographics and Across Metro Areas"
dt_src <- "Not yet published, find additional data in V:/Human Capital/Google"
dt_contact <- "Nicole Bateman and Martha Ross"
df_notes <- "We used ACS, 5-year, 2012-2016 microdata to create clusters of low-wage workers
in order to compare the unique circumstances of various population subsets at the national, state, 
and metropolitan levels.Definitions:
'Universe population' is the total civilian, non-institutionalized population 18-64
'Workers' is a subset of the universe population, defined as follows: 
- Currently in the labor force (employed or unemployed)
- Worked at some point in the last year

We then exclude a number of populations: 
- Anyone enrolled in school who worked fewer than 14 weeks over the previous year 
- Anyone enrolled and living in group quarters
- Anyone enrolled in high school and living with a parent
- Anyone enrolled in graduate school
- People who report earning any self-employment income over the previous year or who report working in their own business
- People who report their primary job is unpaid in a family business or farm
- Those who report working more than 98 hours per week
- Those who earn wages below $.94 per hour or more than $187.38 per hour

'Mid/high-wage workers' is a subset of the worker population who earn above the hourly wage threshold we set
'Low-wage workers' is a subset of the worker population who earn above the hourly wage threshold we set

'Clusters' are low-wage workers divided into 9 groups based on age, education, and enrollment status. There are 9 total clusters. 
Those clusters are defined as follows: 
(1) 18-24 year olds, some college experience or less, not enrolled in school 
(2) 18-24 year olds, some college experience or less, enrolled in school 
(3) 18-24 year olds, associate degree or more, enrolled and not enrolled 
(4) 25-50 year olds, high school diploma or less 
(5) 25-50 year olds, some college experience, but no post-secondary degree 
(6) 25-50 year olds, associate degree or more 
(7) 51-64 year olds, high school diploma or less 
(8) 51-64 year olds, some college experience, but no post-secondary degree 
(9) 51-64 year olds, associate degree or more
"

# read datasets
rm_zero <- function(df){df[,is.na(colSums(df != 0)) | colSums(df != 0) > 0]}

df <- read_csv(source_dir, col_types = cols(CBSA = col_character())) 

df <- rm_zero(df)

# variable labels
set_label(df) <- colnames(df)


# variable names
df <- df %>%
  apply_labels(
    cbsa_code	=	"5 digit cbsa code",
    cbsa_name	=	"Cbsa name",
    population	=	"Subset of the population",
    total	=	"Weighted population estimates",
    med_annual_earnings_adj	=	"Median individual annual earnings",
    med_hrly_earnings_adj	=	"Median individual hourly earnings",
    med_fam_income_adj	=	"Median family income ",
    pemployed	=	"Percent currently employed",
    punemployed	=	"Percent currently unemployed",
    pnilf	=	"Percent currently not in labor force",
    pmale	=	"Percent male",
    pa1824	=	"Percent age 18-24",
    pa2534	=	"Percent age 25-34",
    pa3544	=	"Percent age 35-44",
    pa4554	=	"Percent age 45-54",
    pa5564	=	"Percent age 55-64",
    pa2550	=	"Percent age 25-50",
    pa5164	=	"Percent age 51-64",
    pwhiteNH	=	"Percent white, non-hispanic",
    pblackNH	=	"Percent black, non-hispanic",
    platino	=	"Percent hispanic",
    pasianNH	=	"Percent asian, non-hispanic",
    potherNH	=	"Percent all other races, non-hispanic",
    plths	=	"Percent with less than high school education",
    phs	=	"Percent with high school diploma or equivalent",
    psc	=	"Percent some college education",
    paa	=	"Percent with an associate degree",
    pbaplus	=	"Percent with a bachelor's degree or higher",
    pinsch	=	"Percent enrolled in school",
    pdis	=	"Percent reports any disability",
    plep	=	"Percent reports limited English proficiency",
    pfb	=	"Percent foreign born",
    pvet	=	"Percent veteran",
    plivewparent1824	=	"Percent lives with parents, age 18-24 ",
    plivewparent2534	=	"Percent lives with parents, age 25-34",
    pmar_1	=	"Percent married",
    pnospouse_kids	=	"Percent single parent",
    pchildren	=	"Percent has a child",
    ppoor	=	"Percent <100% FPL",
    p_below2xfpl	=	"Percent <200% FPL",
    psafetynet	=	"Percent receives SSI, public assistance income, SNAP &/or Medicaid",
    psoc_minor_412	=	"Percent retail sales workers (SOC code 412)",
    psoc_minor_434	=	"Percent information and records clerks (SOC code 434)",
    psoc_minor_352	=	"Percent cooks and food preparation workers (SOC code 352)",
    psoc_minor_372	=	"Percent building cleaning and pest control work (SOC code 372)",
    psoc_minor_537	=	"Percent material moving workers (SOC code 537)",
    psoc_minor_353	=	"Percent food and beverage serving workers (SOC code 353)",
    psoc_minor_472	=	"Percent construction trades workers (SOC code 472)",
    psoc_minor_435	=	"Percent material recording, scheduling, dispatching, and distributing workers (SOC code 435)",
    psoc_minor_533	=	"Percent motor vehicle operators (SOC code 533)",
    psoc_minor_399	=	"Percent other personal care and service workers (SOC code 399)",
    psoc_minor_519	=	"Percent other production occupations (SOC code 519)",
    psoc_minor_311	=	"Percent nursing, psychiatric, and home health aides (SOC code 311)",
    psoc_minor_439	=	"Percent other office and administrative support (SOC code 439)",
    psoc_minor_411	=	"Percent supervisors of sales workers (SOC code 411)",
    psoc_minor_119	=	"Percent other management occupations (SOC code 119)",
    psoc_minor_436	=	"Percent secretaries and administrative assistants (SOC code 436)",
    psoc_minor_252	=	"Percent preschool, primary, secondary, and special education school teachers (SOC code 252)",
    psoc_minor_433	=	"Percent financial clerks (SOC code 433)",
    psoc_minor_292	=	"Percent health technologists and technicians (SOC code 292)",
    psoc_minor_373	=	"Percent grounds and maintenance workers (SOC code 373)",
    psoc_minor_319	=	"Percent other healthcare support occupations (SOC code 319)",
    psoc_minor_259	=	"Percent other education, training, and library (SOC code 259)",
    psoc_minor_339	=	"Percent other protective service workers (SOC code 339)",
    psoc_minor_512	=	"Percent assemblers and fabricators (SOC code 512)",
    psoc_minor_514	=	"Percent metal workers and plastic workers (SOC code 514)",
    psoc_minor_452	=	"Percent agricultural workers (SOC code 452)",
    psoc_minor_359	=	"Percent other food preparation and serving related workers (SOC code 359)",
    psoc_minor_351	=	"Percent supervisors of food preparation and serving workers (SOC code 351)",
    psoc_minor_493	=	"Percent vehicle and mobile equipment mechanics, installers and repairers (SOC code 493)",
    psoc_minor_131	=	"Percent business operations specialists (SOC code 131)",
    psoc_minor_499	=	"Percent other installation, maintenance, and repair occupations (SOC code 499)",
    psoc_minor_395	=	"Percent personal appearance workers (SOC code 395)",
    psoc_minor_211	=	"Percent counselors, social workers, and other community and social service specialists (SOC code 211)",
    psoc_minor_513	=	"Percent food processing workers (SOC code 513)",
    psoc_minor_291	=	"Percent health diagnosing and treating practitioners (SOC code 291)",
    psoc_minor_132	=	"Percent financial specialists (SOC code 132)",
    psoc_minor_516	=	"Percent textile, apparel, and furnishing workers (SOC code 516)",
    psoc_minor_413	=	"Percent sales representatives, services (SOC code 413)",
    psoc_minor_1511	=	"Percent computer occupations (SOC code 1511)",
    psoc_minor_419	=	"Percent other sales and related workers (SOC code 419)",
    psoc_minor_431	=	"Percent supervisors of office and administrative support workers (SOC code 431)",
    psoc_minor_113	=	"Percent operations specialties managers (SOC code 113)",
    psoc_minor_253	=	"Percent other teachers and instructors (SOC code 253)",
    psoc_minor_414	=	"Percent sales representatives, wholesale and manufacturing (SOC code 414)",
    psoc_minor_333	=	"Percent law enforcement workers (SOC code 333)",
    psoc_minor_271	=	"Percent art and design workers (SOC code 271)",
    psoc_minor_511	=	"Percent supervisors of production workers (SOC code 511)",
    psoc_minor_536	=	"Percent other transportation workers (SOC code 536)",
    psoc_minor_393	=	"Percent mathematical science occupations (SOC code 393)",
    psoc_minor_272	=	"Percent entertainers and performers, sports and related workers (SOC code 272)",
    psoc_minor_251	=	"Percent postsecondary teachers (SOC code 251)",
    psoc_minor_111	=	"Percent top executives (SOC code 111)",
    psoc_minor_212	=	"Percent religious workers (SOC code 212)",
    psoc_minor_492	=	"Percent electrical and electronic equipment mechanics, installers, and repairers (SOC code 492)",
    psoc_minor_273	=	"Percent media and communication workers (SOC code 273)",
    psoc_minor_392	=	"Percent animal care and service workers (SOC code 392)",
    psoc_minor_371	=	"Percent supervisors of building and grounds cleaning maintenance workers (SOC code 371)",
    psoc_minor_232	=	"Percent legal support workers (SOC code 232)",
    psoc_minor_173	=	"Percent drafters, engineering technicians, and mapping technicians (SOC code 173)",
    psoc_minor_112	=	"Percent advertising, marketing, promotions, public relations, and sales managers (SOC code 112)",
    psoc_minor_5151	=	"Percent printing workers (SOC code 5151)",
    psoc_minor_471	=	"Percent supervisors of construction and extraction workers (SOC code 471)",
    psoc_minor_194	=	"Percent life, physical, and social science technicians (SOC code 194)",
    psoc_minor_172	=	"Percent engineers (SOC code 172)",
    psoc_minor_474	=	"Percent other construction and related workers (SOC code 474)",
    psoc_minor_254	=	"Percent librarians, curators, and archivists (SOC code 254)",
    psoc_minor_517	=	"Percent woodworkers (SOC code 517)",
    psoc_minor_274	=	"Percent media and communication equipment workers (SOC code 274)",
    psoc_minor_531	=	"Percent supervisors of transportation and material moving workers (SOC code 531)",
    psoc_minor_332	=	"Percent fire fighting and prevention workers (SOC code 332)",
    psoc_minor_475	=	"Percent extraction workers (SOC code 475)",
    psoc_minor_396	=	"Percent baggage porters, bellhops, and concierge (SOC code 396)",
    psoc_minor_391	=	"Percent supervisors of personal care and service workers (SOC code 391)",
    psoc_minor_432	=	"Percent communications equipment operators (SOC code 432)",
    psoc_minor_518	=	"Percent plant and system operators (SOC code 518)",
    psoc_minor_491	=	"Percent supervisors of installation, maintenance, and repair workers (SOC code 491)",
    psoc_minor_532	=	"Percent air transportation workers (SOC code 532)",
    psoc_minor_331	=	"Percent supervisors of protective service workers (SOC code 331)",
    psoc_minor_192	=	"Percent physical scientists (SOC code 192)",
    psoc_minor_454	=	"Percent forest, conservation, and logging worker (SOC code 454)",
    psoc_minor_231	=	"Percent lawyers, judges, and related workers (SOC code 231)",
    psoc_minor_473	=	"Percent helpers, construction trades (SOC code 473)",
    psoc_minor_312	=	"Percent occupational therapy and physical therapist assistants and aides (SOC code 312)",
    psoc_minor_191	=	"Percent life scientists (SOC code 191)",
    psoc_minor_451	=	"Percent supervisors of farming, fishing, and forestry workers (SOC code 451)",
    psoc_minor_47	=	"Percent miscellaneous construction workers (SOC code 47)",
    psoc_minor_397	=	"Percent tour and travel guides (SOC code 397)",
    psoc_minor_193	=	"Percent social scientists and related workers (SOC code 193)",
    psoc_minor_299	=	"Percent other healthcare practitioners and technical occupations (SOC code 299)",
    psoc_minor_535	=	"Percent water transportation workers (SOC code 535)",
    psoc_minor_171	=	"Percent architects, surveyors, and cartographers (SOC code 171)",
    psoc_minor_534	=	"Percent rail transportation workers (SOC code 534)",
    psoc_minor_394	=	"Percent funeral service workers (SOC code 394)",
    psoc_minor_152	=	"Percent mathematical science occupations (SOC code 152)",
    psoc_minor_453	=	"Percent fishing and hunting workers (SOC code 453)",
    psoc_minor_551	=	"Percent military officer special and tactical operations leaders (SOC code 551)",
    psoc_minor_552	=	"Percent first-line enlisted military supervisors (SOC code 552)",
    psoc_minor_553	=	"Percent military enlisted tactical operations and air/weapons specialists and crew members (SOC code 553)",
    psoc_minor_559	=	"Percent military, rank not specified (SOC code 559)",
    psector_11	=	"Percent percent agriculture, forestry, fishing, and hunting sector (NAICS code 11)",
    psector_21	=	"Percent mining (NAICS code 21)",
    psector_22	=	"Percent utilities (NAICS code 22)",
    psector_23	=	"Percent construction (NAICS code 23)",
    psector_42	=	"Percent wholesale trade (NAICS code 42)",
    psector_51	=	"Percent information (NAICS code 51)",
    psector_52	=	"Percent finance and insurance (NAICS code 52)",
    psector_53	=	"Percent real estate and rental and leasing (NAICS code 53)",
    psector_54	=	"Percent professional, scientific, and technical services (NAICS code 54)",
    psector_55	=	"Percent management of companies and enterprises (NAICS code 55)",
    psector_56	=	"Percent administrative and waste services (NAICS code 56)",
    psector_61	=	"Percent educational services (NAICS code 61)",
    psector_62	=	"Percent health care and social assistance (NAICS code 62)",
    psector_71	=	"Percent arts, entertainment, and recreation (NAICS code 71)",
    psector_72	=	"Percent accommodation and food services (NAICS code 72)",
    psector_81	=	"Percent other services (NAICS code 81)",
    psector_92	=	"Percent public administration (NAICS code 92)",
    psector_99	=	"Percent unemployed and last worked 5 years ago (NAICS code 99)",
    psector_3133	=	"Percent manufacturing (NAICS code 31-33)",
    psector_4445	=	"Percent retail trade (NAICS code 44-45)",
    psector_4849	=	"Percent transportation and warehousing (NAICS code 48-49)"
  )

# label key
df_labels <- create_labels(df)


# datasets
save_datasets(df, folder = folder_name, file = file_name)

# meta file
save_meta(df,
          labels = df_labels, folder = folder_name, file = file_name,
          title = dt_title, contact = dt_contact, source = dt_src, note = df_notes
)

