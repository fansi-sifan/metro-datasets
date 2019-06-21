some notes:
  
what are the years for this data? (use the year to compare to the tiger file year of MSAs)

library(dplyr)

USPTO_anti<-cbsa_USPTO%>%
  mutate(geoid = as.integer(cbsa))%>%
  anti_join(Core_Based_Statistical_Areas, by=c("geoid"="GEOID"))

VC_anti <- cbsa_VC %>%
  left_join(Core_Based_Statistical_Areas, by=c("cbsa13"="GEOID"))

#INC 5000 - large, medium and small are all MSAs, micro = micropolitan areas DONE
464 obs

Large Medium  Micro  Small 
52     128     134    150

#VC DONE
looks just like cities with 113 obs

missing_vc_msas<-MSA%>%
  anti_join(cbsa_VC, by=c("msa_simple"="msa"))


#USPTO - reasonable, likely accurate, check w merge to TIGER file
Metropolitan Statistical Area  
374 
Micropolitan Statistical Area    Non Metro/Micropolitan Statistical Area    Undetermined Statistical Area 
579                                              49                                   16 

MSA<-cbsa_USPTO%>%
  select(geo_type,cbsa,us_regional_title)%>%
  filter(geo_type=="Metropolitan Statistical Area")%>%
  mutate(msa_simple = gsub("^(.*?),.*", "\\1", us_regional_title))

#patents - merge to see which are micro, which are metro
#they are all metro , need to change patent comp file
381 obs and no specific enumeration units for cbsa_complete

cbsas<-read.csv("Core_Based_Statistical_Areas.csv")%>%
  mutate(cbsa = as.character(GEOID))

msas<-cbsas%>%
  filter(LSAD=="M1")

micros<-cbsas%>%
  filter(LSAD=="M2")%>%
  mutate(cbsa2=cbsa)

patent_joing<-cbsas%>%
  left_join(cbsa_patentCOMP, by="cbsa")%>%
  filter(!is.na(complex))

merge(cbsa_patentCOMP,cbsas, by="cbsa")

missing_msa_patent<-msas%>%
  anti_join(msa_patentCOMP, by=c("cbsa"="msa"))

missing_msa_patent <-missing_msa_patent%>%
  filter(is.na(NAME))


                    