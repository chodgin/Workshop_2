library(tidyverse)

#read in data
file <- "http://www.ndbc.noaa.gov/view_text_file.php?filename=44025h2011.txt.gz&dir=data/historical/stdmet/"
readLines(file, n = 4)

buoy44025 <- read_table(file, 
                        col_names = FALSE,
                        skip = 2)

?scan


##read in headers as a list using scan
measure <- scan(file, 
                nlines = 1,
                what = character()) %>%
  str_remove("#")
# read in the units from the second line, removing the hash and

# replacing the / with _per_ as / is a special character
units <- scan(file, 
              skip = 1,
              nlines = 1, 
              what = character()) %>% 
  str_remove("#") %>% 
  str_replace("/", "_per_")

# paste the variable name and its units together for the column names
names(buoy44025) <- paste(measure, units, sep = "_") 


names(buoy44025)