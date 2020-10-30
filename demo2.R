library(tidyverse)

#read in data
hdi <- read_csv("Human-development-index.csv")

#tidy data
hdi_tidy <- hdi %>%
  pivot_longer(names_to = "Year",
               values_to = "HDI_Value",
               cols = -c(1:2))

#drop na values
hdi_no_na <- hdi_tidy %>%
  filter(HDI_Value != "NA")

#summarise data
hdi_summary <- hdi_no_na %>% 
  group_by(Country) %>% 
  summarise(mean_index = mean(HDI_Value),
            n = length(HDI_Value),
            sd_index = sd(HDI_Value),
            se_index = sd(HDI_Value)/sqrt(n()))
view(hdi_summary)

#filter summary
hdi_summary_low <- hdi_summary %>% 
  filter(rank(mean_index) < 11)

hdi_summary_low

