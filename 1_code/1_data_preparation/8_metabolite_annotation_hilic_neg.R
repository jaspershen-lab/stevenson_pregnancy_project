no_source()
library(tidyverse)
library(tidymass)
setwd(masstools::get_project_wd())

rm(list = ls())

source("1_code/100_tools.R")

dir.create("3_data_analysis/1_data_preparation/hilic_neg/metabolite_annotation")
setwd("3_data_analysis/1_data_preparation/hilic_neg/metabolite_annotation")
# load("../object2")
# 
# #####mutate MS2 data into the object
# object2 <-
#   mutate_ms2(
#     object = object2,
#     column = "hilic",
#     polarity = "negative",
#     path = "."
#   )
# 
# #####mpsnyder database
# load("../../database/mpsnyder_hilic_ms2.rda")
# object2 <-
#   annotate_metabolites_mass_dataset(
#     object = object2,
#     polarity = "negative",
#     column = "hilic",
#     database = mpsnyder_hilic_ms2,
#     threads = 4
#   )
# 
# load("../../database/metlin_ms2.rda")
# object2 <-
#   annotate_metabolites_mass_dataset(
#     object = object2,
#     polarity = "negative",
#     column = "hilic",
#     database = metlin_ms2,
#     threads = 4
#   )
# 
# load("../../database/hmdb_ms2.rda")
# object2 <-
#   annotate_metabolites_mass_dataset(
#     object = object2,
#     polarity = "negative",
#     column = "hilic",
#     database = hmdb_ms2,
#     threads = 4
#   )
# 
# load("../../database/massbank_ms2.rda")
# object2 <-
#   annotate_metabolites_mass_dataset(
#     object = object2,
#     polarity = "negative",
#     column = "hilic",
#     database = massbank_ms2,
#     threads = 4
#   )
# 
# 
# load("../../database/mona_ms2.rda")
# object2 <-
#   annotate_metabolites_mass_dataset(
#     object = object2,
#     polarity = "negative",
#     column = "hilic",
#     database = mona_ms2,
#     threads = 4
#   )
# 
# load("../../database/nist_ms2.rda")
# object2 <-
#   annotate_metabolites_mass_dataset(
#     object = object2,
#     polarity = "negative",
#     column = "hilic",
#     database = nist_ms2,
#     threads = 4
#   )
# 
# object3 <- object2
# 
# save(object3, file = "object3")
# 
# 
# 
# 
# 

load("object3")

####output ms2 plot
load("../../database/hmdb_ms2.rda")
load("../../database/massbank_ms2.rda")
load("../../database/metlin_ms2.rda")
load("../../database/mona_ms2.rda")
load("../../database/mpsnyder_hilic_ms2.rda")
load("../../database/mpsnyder_rplc_ms2.rda")
load("../../database/nist_ms2.rda")

library(plyr)

object3@annotation_table <-
  object3@annotation_table %>%
  plyr::dlply(.variables = .(Compound.name)) %>%
  purrr::map(function(x) {
    if (nrow(x) == 1) {
      return(x)
    } else{
      x %>%
        dplyr::filter(Level == min(Level)) %>%
        dplyr::filter(SS == max(SS)) %>%
        dplyr::filter(Total.score == max(Total.score)) %>%
        head(1)
    }
  }) %>%
  dplyr::bind_rows() %>%
  as.data.frame()

annotation_table <-
  extract_annotation_table(object3)

dir.create("ms2_rplc_pos")
for (i in seq_len(nrow(annotation_table))) {
  cat(i, " ")
  
  database <-
    switch(
      EXPR = annotation_table$Database[i],
      NIST_20220425 = nist_ms2,
      `HMDB_2022-04-11` = hmdb_ms2,
      `METLIN_20220425` = metlin_ms2,
      Michael_Snyder_HILIC_20220424 = mpsnyder_hilic_ms2,
      `MassBank_2022-04-27` = massbank_ms2,
      `MoNA_2022-04-27` = mona_ms2
    )
  
  plot <-
    ms2_plot_mass_dataset(
      object = object3,
      variable_id = annotation_table$variable_id[i],
      polarity = "positive",
      database = database
    )
  
  seq_along(plot) %>%
    purrr::map(function(i) {
      x <- plot[[i]]
      ggsave(
        plot = x,
        filename = file.path(
          "ms2_rplc_pos",
          paste0(names(plot)[i],
                 "_",
                 annotation_table$Lab.ID[i], ".pdf")
        ),
        width = 9,
        height = 7
      )
    })
  
}
