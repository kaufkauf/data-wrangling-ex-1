install.packages("data.table")
install.packages("dplyr")
install.packages("tidyr")
library(data.table)
library(dplyr)
library(tidyr)

fread("C:/Users/Kim/Dropbox/Data science/refine_original.csv")
df1 <- fread("C:/Users/Kim/Dropbox/Data science/refine_original.csv")

df1 %>%
  separate("Product code / number",c("Product code","Product number"),"-") %>%
  mutate(`company` = tolower(company)) %>%
  mutate(`company` = case_when(substring(company,1,1) == "p" ~ "philips",
                               substring(company,1,1) == "f" ~ "philips",
                               substring(company,1,1) == "a" ~ "akzo",
                               substring(company,1,1) == "v" ~ "van houten",
                               substring(company,1,1) == "u" ~ "unilever")) %>%
  mutate(`Product category` = recode(`Product code`,
  p = "Smartphone", v = "TV", x = "Laptop", q = "Tablet")) %>% 
  mutate(`Full address` = paste(`address`,`city`,`country`, sep = ", ")) %>% 
  ##company dummy binary variables
  mutate(`company_philips` = ifelse(`company` == "philips", 1, 0)) %>%
  mutate(`company_akzo` = ifelse(`company` == "akzo", 1, 0)) %>%
  mutate(`company_van_houten` = ifelse(`company` == "van houten", 1, 0)) %>%
  mutate(`company_unilever` = ifelse(`company` == "unilever", 1, 0)) %>%
  ##product category dummy binary variables
  mutate(`company_smartphone` = ifelse(`Product category` == "Smartphone", 1, 0)) %>%
  mutate(`company_tv` = ifelse(`Product category` == "TV", 1, 0)) %>%
  mutate(`company_laptop` = ifelse(`Product category` == "Laptop", 1, 0)) %>%
  mutate(`company_tablet` = ifelse(`Product category` == "Tablet", 1, 0)) %>%
  fwrite("C:/Users/Kim/Dropbox/Data science/refine_clean.csv")

  