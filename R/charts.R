# bham report
library(tidyverse)
library(tidylog)
target_cbsa <- "13820"
target_name <- "Birmingham-Hoover, AL"

# chart 1 data --------
load("metro_monitor_2020/metro_monitor_2020_change.rda")

youngfirm <- df_change$growth_change %>% 
  filter(largest == 1) %>% 
  filter(indicator == "Percent Change in Employment at firms 0-5 years old") %>% 
  filter(year == "2008-2018") 

chart_youngfirm <- youngfirm %>% 
  mutate(hl = (cbsa == target_cbsa)) %>% 
  ggplot(aes(x = reorder(cbsa, value), 
             y = value, 
             fill = hl))+
  geom_col()+
  scale_fill_manual(values = c( "#377eb8", "#e41a1c"),guide = F) +
  scale_y_continuous("",labels = scales::percent)+
  labs(title = "Percent Change in Employment at firms 0-5 years old",
       subtitle = "2008 - 2018",
       caption = "Source: Metro Monitor 2020, Brookings")+
  theme_classic()+
  theme(axis.text.x = element_blank(),
        axis.ticks = element_blank(),
        axis.line.x = element_blank(),
        axis.title.x = element_blank())


# chart 2 data
load("opportunity industries/cbsa_oppind_race.rda")


opp_edu <- cbsa_oppind_race %>% 
  filter(cbsa_code == target_cbsa) %>%
  filter(gender == "Total", age == "Total", race == "Total") %>% 
  select(-gender, -age, -race) %>% 
  mutate(`quality jobs` = 1-other) %>% 
  filter(str_detect(education,"degree|High")) 

chart_opp_edu <- opp_edu %>% 
  ggplot(aes(x = reorder(education, `quality jobs`), 
             y = `quality jobs`))+
  geom_col(fill = "#377eb8")+
  coord_flip()+
  scale_y_continuous(labels = scales::percent)+
  labs(x = "", 
       y = "Share of jobs that are good or promising",
       title = paste0("Chance of holding a quality job in ", target_name), 
       caption = "Opportunity Industries, Brookings")+
  theme_classic()

opp_race <- cbsa_oppind_race %>% 
  filter(cbsa_code == target_cbsa) %>%
  filter(age == "Total", education == "All sub-baccalaureate levels") %>% 
  select(-age, -education) %>% 
  mutate(`quality jobs` = 1-other,
         `good jobs` = good_jobs + hi_good_jobs) %>%
  filter(gender != "Total", race != "Total", race != "Hispanic") %>% 
  mutate(demo = paste0(race, " ", gender))

chart_opp_race <- opp_race %>% 
  ggplot(aes(x = reorder(demo, `good jobs`), 
             y = `good jobs`))+
  geom_col(fill = "#377eb8")+
  coord_flip()+
  scale_y_continuous(labels = scales::percent)+
  labs(x = "", 
       y = "Share of jobs that are good",
       title = paste0("Chance of holding a good job in ", target_name),
       subtitle = "workers without a 4-year college degree",
       caption = "Opportunity Industries, Brookings")+
  theme_classic()

# transit vs auto
load("access across america/cbsa_job_access.rda")

access <- cbsa_job_access %>% 
  filter(cbsa_code == target_cbsa) %>% 
  mutate(across(-contains("cbsa"), as.numeric)) %>% 
  pivot_longer(-contains("cbsa")) %>% 
  separate(name, c("mode", "minutes")) 


ratio <- access %>% 
  filter(mode == "ratio") %>% 
  select(minutes, ratio = value) %>% 
  left_join(access %>% filter(mode == "auto"), by = "minutes")

ggplot(data = access %>% filter(mode != "ratio"), 
       aes(x = minutes, y = value, fill = mode))+
  geom_col(position = "dodge")+
  scale_fill_manual(values = c( "#377eb8", "#e41a1c")) +
  geom_text(data = ratio, 
            hjust = 1,
            vjust = -0.1,
            aes(x = minutes, y = value, 
                label = paste0("x ",scales::number(ratio, accuracy = 1))))+
  scale_y_continuous("number of jobs accessible",labels = scales::number)+
  labs(title = paste0("Share of jobs accessible by auto and by transit in ", target_name), 
       caption = "Source: Access Across America, 2018")+
  theme_classic()

load("fair_ownership/cbsa_ownership.rda")

fair_ownership <- cbsa_ownership %>% 
  filter(cbsa_size == "very large metros") %>% 
  mutate(hl = cbsa_code == target_cbsa) 

chart_fair_ownership <- fair_ownership %>% 
  ggplot(aes(x = reorder(cbsa_code, black), 
             y = black,
             fill = hl))+
  geom_col()+
  scale_fill_manual(values = c("#377eb8", "#e41a1c"), guide = F) +
  scale_y_continuous("% business ownership/% adult population",
                     labels = scales::percent)+
  theme_classic()+
  labs(x = "", 
       title = "Black business ownership fair share ratio among 53 largest metro areas",
       caption = "Source: Brookings analysis of Annual Business Survey data")+
  theme(axis.text.x = element_blank())
