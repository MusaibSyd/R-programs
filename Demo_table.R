options(repos = c(
  pharmaverse = 'https://pharmaverse.r-universe.dev',
  CRAN = 'https://cloud.r-project.org'))

install.packages("admiral")

library(admiral)
library(rtables)
library(tern)
library(dplyr)

# Read in input ADaM data 
data("admiral_adsl")
adsl <- df_explicit_na(admiral_adsl)
head(adsl)
colnames(adsl)

#Pre-processing 

adsl <- adsl %>% 
  mutate( 
    SEX=factor(case_when(
      SEX == "M" ~ "Male",
      SEX == "F" ~ "Female"
      )
               ))
unique(adsl$SEX)

#Assigning labels

vars <- c("AGE", "AGEGR1", "SEX", "RACE" )
varlables <- c("Age (years)", "Age groups", " Sex", "Race")

#Creating demoographic table using rtables and tern packages

result <- basic_table(title = "Demographic and baseline characteristics",
                      main_footer = "ADSL has been used as input dataset" ) %>%
  split_cols_by(var="ARM") %>%
  add_colcounts() %>%
  summarize_vars(
    vars = vars,
    var_labels = varlables) %>%
  build_table(adsl)
result


