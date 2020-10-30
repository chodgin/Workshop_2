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

#make plot
hdi_summary_low %>% 
  ggplot() +
  geom_point(aes(x = Country,
                 y = mean_index)) +
  geom_errorbar(aes(x = Country,
                    ymin = mean_index - se_index,
                    ymax = mean_index + se_index)) +
  scale_y_continuous(limits = c(0, 0.5),
                     expand = c(0, 0),
                     name = "HDI") +
  scale_x_discrete(expand = c(0, 0),
                   name = "") +
  theme_classic() +
  coord_flip()


#create a pipeline
hdi_tidy %>%
  filter(HDI_Value != "NA") %>%

  group_by(Country) %>% 
  summarise(mean_index = mean(HDI_Value),
            n = length(HDI_Value),
            sd_index = sd(HDI_Value),
            se_index = sd(HDI_Value)/sqrt(n())) %>%


  filter(rank(mean_index) < 11) %>% 


  ggplot() +
  geom_point(aes(x = Country,
                 y = mean_index)) +
  geom_errorbar(aes(x = Country,
                    ymin = mean_index - se_index,
                    ymax = mean_index + se_index)) +
  scale_y_continuous(limits = c(0, 0.5),
                     expand = c(0, 0),
                     name = "HDI") +
  scale_x_discrete(expand = c(0, 0),
                   name = "") +
  theme_classic() +
  coord_flip()