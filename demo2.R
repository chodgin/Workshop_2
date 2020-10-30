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
