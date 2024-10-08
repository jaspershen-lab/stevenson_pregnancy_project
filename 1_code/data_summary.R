no_source()

rm(list = ls())

setwd(masstools::get_project_wd())

library(tidyverse)
library(tidymass)

setwd("3_data_analysis/1_data_preparation/combination/metabolites/")

load("object")

object %>%
  activate_mass_dataset(what = 'sample_info') %>%
  count(class)

dim(object)

variable_info <-
  extract_variable_info(object)



