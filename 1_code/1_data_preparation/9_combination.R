no_source()
library(tidyverse)
library(tidymass)
setwd(masstools::get_project_wd())

rm(list = ls())

source("1_code/100_tools.R")

dir.create("3_data_analysis/1_data_preparation/combination")
setwd("3_data_analysis/1_data_preparation/combination")

# load("../rplc_pos/metabolite_annotation/object3")
# object_rplc_pos <- object3
#
# load("../rplc_neg/metabolite_annotation/object3")
# object_rplc_neg <- object3
#
# load("../hilic_pos/metabolite_annotation/object3")
# object_hilic_pos <- object3
#
# load("../hilic_neg/metabolite_annotation/object3")
# object_hilic_neg <- object3
#
# dim(object_rplc_pos)
# dim(object_rplc_neg)
#
# dim(object_hilic_pos)
# dim(object_hilic_neg)
#
# unique(
#   c(
#     object_rplc_pos@annotation_table$Compound.name,
#     object_rplc_neg@annotation_table$Compound.name,
#     object_hilic_pos@annotation_table$Compound.name,
#     object_hilic_neg@annotation_table$Compound.name
#   )
# )
#
#
# ####remove duplicated samples
# ####rplc_pos
# grep("\\-", colnames(object_rplc_pos))
# grep("\\_", colnames(object_rplc_pos))
# grep("\\_", colnames(object_rplc_pos), value = TRUE)
# sort(grep("\\_", colnames(object_rplc_pos), value = TRUE))
#
# sort(grep("wb", colnames(object_rplc_pos), value = TRUE)) %>%
#   purrr::map(function(x) {
#     x <- stringr::str_replace(x, "\\_wb", "")
#     grep(x, colnames(object_rplc_pos), value = TRUE)
#   })
#
# object_rplc_pos <-
#   object_rplc_pos %>%
#   activate_mass_dataset(what = "sample_info") %>%
#   mutate(sample_id = stringr::str_replace(sample_id, "\\_wb", ""))
#
# sort(grep("\\_", colnames(object_rplc_pos), value = TRUE))
#
# colnames(object_rplc_pos)[stringr::str_detect(colnames(object_rplc_pos), "_[0-9]{1}")] %>%
#   purrr::map(function(x) {
#     x <- stringr::str_replace(x, "_[0-9]{1}", "")
#     grep(x, colnames(object_rplc_pos), value = TRUE)
#   })
#
# duplicated_id <-
#   colnames(object_rplc_pos)[stringr::str_detect(colnames(object_rplc_pos), "_[0-9]{1}")] %>%
#   purrr::map(function(x) {
#     x <- stringr::str_replace(x, "_[0-9]{1}", "")
#     grep(x, colnames(object_rplc_pos), value = TRUE)
#   }) %>%
#   unlist() %>%
#   unique() %>%
#   stringr::str_replace("_[0-9]{1,2}$", "") %>%
#   unique()
#
# plot(log(object_rplc_pos$QC110, 2),
#      log(object_rplc_pos$QC110_2, 2))
#
# plot(log(object_rplc_pos$QC110, 2),
#      log(object_rplc_pos$QC110_3, 2))
#
# plot(log(object_rplc_pos$QC112, 2),
#      log(object_rplc_pos$QC112_2, 2))
#
# for (x in duplicated_id) {
#   object_rplc_pos <-
#     object_rplc_pos %>%
#     activate_mass_dataset(what = "sample_info") %>%
#     filter(!sample_id %in% paste(x, 1:9, sep = "_"))
# }
#
#
#
#
#
#
# ####rplc_neg
# grep("\\-", colnames(object_rplc_neg))
# grep("\\_", colnames(object_rplc_neg))
# grep("\\_", colnames(object_rplc_neg), value = TRUE)
# sort(grep("\\_", colnames(object_rplc_neg), value = TRUE))
#
# sort(grep("wb", colnames(object_rplc_neg), value = TRUE)) %>%
#   purrr::map(function(x) {
#     x <- stringr::str_replace(x, "\\_wb", "")
#     grep(x, colnames(object_rplc_neg), value = TRUE)
#   })
#
# object_rplc_neg <-
#   object_rplc_neg %>%
#   activate_mass_dataset(what = "sample_info") %>%
#   mutate(sample_id = stringr::str_replace(sample_id, "\\_wb", ""))
#
# sort(grep("\\_", colnames(object_rplc_neg), value = TRUE))
#
# colnames(object_rplc_neg)[stringr::str_detect(colnames(object_rplc_neg), "_[0-9]{1}")] %>%
#   purrr::map(function(x) {
#     x <- stringr::str_replace(x, "_[0-9]{1}", "")
#     grep(x, colnames(object_rplc_neg), value = TRUE)
#   })
#
# duplicated_id <-
#   colnames(object_rplc_neg)[stringr::str_detect(colnames(object_rplc_neg), "_[0-9]{1}")] %>%
#   purrr::map(function(x) {
#     x <- stringr::str_replace(x, "_[0-9]{1}", "")
#     colnames(object_rplc_neg)[colnames(object_rplc_neg) %in% c(paste(x, 1:9, sep = "_"))]
#   }) %>%
#   unlist() %>%
#   unique() %>%
#   stringr::str_replace("_[0-9]{1,2}$", "") %>%
#   unique()
#
# plot(log(object_rplc_neg$QC110, 2),
#      log(object_rplc_neg$QC110_2, 2))
#
# plot(log(object_rplc_neg$QC110, 2),
#      log(object_rplc_neg$QC110_3, 2))
#
# plot(log(object_rplc_neg$QC112, 2),
#      log(object_rplc_neg$QC112_2, 2))
#
# for (x in duplicated_id) {
#   object_rplc_neg <-
#     object_rplc_neg %>%
#     activate_mass_dataset(what = "sample_info") %>%
#     filter(!sample_id %in% paste(x, 1:9, sep = "_"))
# }
#
#
#
#
#
#
#
#
#
# ####hilic_pos
# object_hilic_pos <-
#   object_hilic_pos %>%
#   activate_mass_dataset(what = "sample_info") %>%
#   mutate(sample_id = stringr::str_replace(sample_id, "\\-", "\\_"))
#
# grep("\\-", colnames(object_hilic_pos), value = TRUE)
# grep("\\_", colnames(object_hilic_pos), value = TRUE)
# sort(grep("\\_", colnames(object_hilic_pos), value = TRUE))
#
# sort(grep("Rerun", colnames(object_hilic_pos), value = TRUE)) %>%
#   purrr::map(function(x) {
#     x <- stringr::str_replace(x, "\\_Rerun", "")
#     grep(x, colnames(object_hilic_pos), value = TRUE)
#   })
#
# object_hilic_pos <-
#   object_hilic_pos %>%
#   activate_mass_dataset(what = "sample_info") %>%
#   mutate(sample_id = stringr::str_replace(sample_id, "\\_Rerun", ""))
#
# sort(grep("\\_", colnames(object_hilic_pos), value = TRUE))
#
# colnames(object_hilic_pos)[stringr::str_detect(colnames(object_hilic_pos), "_[0-9]{1}")] %>%
#   purrr::map(function(x) {
#     x <- stringr::str_replace(x, "_[0-9]{1}", "")
#     grep(x, colnames(object_hilic_pos), value = TRUE)
#   })
#
# duplicated_id <-
#   colnames(object_hilic_pos)[stringr::str_detect(colnames(object_hilic_pos), "_[0-9]{1}")] %>%
#   purrr::map(function(x) {
#     x <- stringr::str_replace(x, "_[0-9]{1}", "")
#     colnames(object_hilic_pos)[colnames(object_hilic_pos) %in% c(paste(x, 1:9, sep = "_"))]
#   }) %>%
#   unlist() %>%
#   unique() %>%
#   stringr::str_replace("_[0-9]{1,2}$", "") %>%
#   unique()
#
# plot(log(object_hilic_pos$QC154, 2),
#      log(object_hilic_pos$QC154_2, 2))
#
# plot(log(object_hilic_pos$QC174, 2),
#      log(object_hilic_pos$QC174_2, 2))
#
# for (x in duplicated_id) {
#   object_hilic_pos <-
#     object_hilic_pos %>%
#     activate_mass_dataset(what = "sample_info") %>%
#     filter(!sample_id %in% paste(x, 1:9, sep = "_"))
# }
#
#
#
#
#
#
#
#
# ####hilic_neg
# object_hilic_neg <-
#   object_hilic_neg %>%
#   activate_mass_dataset(what = "sample_info") %>%
#   mutate(sample_id = stringr::str_replace(sample_id, "\\-", "\\_"))
#
# grep("\\-", colnames(object_hilic_neg), value = TRUE)
# grep("\\_", colnames(object_hilic_neg), value = TRUE)
# sort(grep("\\_", colnames(object_hilic_neg), value = TRUE))
#
# object_hilic_neg <-
#   object_hilic_neg %>%
#   activate_mass_dataset(what = "sample_info") %>%
#   mutate(sample_id = stringr::str_replace(sample_id, "QC103_20221205155354", "QC103_9"))
#
# object_hilic_neg <-
#   object_hilic_neg %>%
#   activate_mass_dataset(what = "sample_info") %>%
#   mutate(sample_id = stringr::str_replace(sample_id, "QC133_20230120162323", "QC133_9"))
#
# object_hilic_neg <-
#   object_hilic_neg %>%
#   activate_mass_dataset(what = "sample_info") %>%
#   mutate(sample_id = stringr::str_replace(sample_id, "QC29_2_20221004113634", "QC29_9"))
#
# sort(grep("reinj", colnames(object_hilic_neg), value = TRUE)) %>%
#   purrr::map(function(x) {
#     x <- stringr::str_replace(x, "\\reinj", "")
#     grep(x, colnames(object_hilic_neg), value = TRUE)
#   })
#
# object_hilic_neg <-
#   object_hilic_neg %>%
#   activate_mass_dataset(what = "sample_info") %>%
#   mutate(sample_id = stringr::str_replace(sample_id, "\\_reinj", ""))
#
# sort(grep("\\_", colnames(object_hilic_neg), value = TRUE))
#
# object_hilic_neg <-
#   object_hilic_neg %>%
#   activate_mass_dataset(what = "sample_info") %>%
#   mutate(sample_id = stringr::str_replace(sample_id, "QC29_2 \\(2\\)", "QC29_3"))
#
# colnames(object_hilic_neg)[stringr::str_detect(colnames(object_hilic_neg), "_[0-9]{1}")] %>%
#   purrr::map(function(x) {
#     x <- stringr::str_replace(x, "_[0-9]{1,20}", "")
#     grep(x, colnames(object_hilic_neg), value = TRUE)
#   })
#
# duplicated_id <-
#   colnames(object_hilic_neg)[stringr::str_detect(colnames(object_hilic_neg), "_[0-9]{1}")] %>%
#   purrr::map(function(x) {
#     x <- stringr::str_replace(x, "_[0-9]{1}", "")
#     colnames(object_hilic_neg)[colnames(object_hilic_neg) %in% c(paste(x, 1:9, sep = "_"))]
#   }) %>%
#   unlist() %>%
#   unique() %>%
#   stringr::str_replace("_[0-9]{1,2}$", "") %>%
#   unique()
#
# plot(log(object_hilic_neg$QC100, 2),
#      log(object_hilic_neg$QC100_2, 2))
#
# for (x in duplicated_id) {
#   object_hilic_neg <-
#     object_hilic_neg %>%
#     activate_mass_dataset(what = "sample_info") %>%
#     filter(!sample_id %in% paste(x, 1:9, sep = "_"))
# }
#
# ####combine 4 datasets
# dim(object_rplc_pos)
# dim(object_rplc_neg)
#
# dim(object_hilic_pos)
# dim(object_hilic_neg)
#
# ##remove blanks
# object_rplc_pos <-
#   object_rplc_pos %>%
#   activate_mass_dataset(what = "sample_info") %>%
#   filter(class != "Blank")
#
# object_rplc_neg <-
#   object_rplc_neg %>%
#   activate_mass_dataset(what = "sample_info") %>%
#   filter(class != "Blank")
#
# object_hilic_pos <-
#   object_hilic_pos %>%
#   activate_mass_dataset(what = "sample_info") %>%
#   filter(class != "Blank")
#
# object_hilic_neg <-
#   object_hilic_neg %>%
#   activate_mass_dataset(what = "sample_info") %>%
#   filter(class != "Blank")
#
# object_rplc_pos <-
#   object_rplc_pos %>%
#   activate_mass_dataset(what = "variable_info") %>%
#   mutate(variable_id = paste0(variable_id, "_RPLC"),
#          mode = "RPLC_POS")
#
# object_rplc_neg <-
#   object_rplc_neg %>%
#   activate_mass_dataset(what = "variable_info") %>%
#   mutate(variable_id = paste0(variable_id, "_RPLC"),
#          mode = "RPLC_NEG")
#
# object_hilic_pos <-
#   object_hilic_pos %>%
#   activate_mass_dataset(what = "variable_info") %>%
#   mutate(variable_id = paste0(variable_id, "_HILIC"),
#          mode = "HILIC_POS")
#
# object_hilic_neg <-
#   object_hilic_neg %>%
#   activate_mass_dataset(what = "variable_info") %>%
#   mutate(variable_id = paste0(variable_id, "_HILIC"),
#          mode = "HILIC_NEG")
#
# ###rplc
# setdiff(colnames(object_rplc_pos),
#         colnames(object_rplc_neg))
#
# setdiff(colnames(object_rplc_neg),
#         colnames(object_rplc_pos))
#
#
# object_rplc <-
#   rbind(object_rplc_pos[, intersect(colnames(object_rplc_pos),
#                                     colnames(object_rplc_neg))],
#         object_rplc_neg[, intersect(colnames(object_rplc_pos),
#                                     colnames(object_rplc_neg))])
#
# ###hilic
# setdiff(colnames(object_hilic_pos),
#         colnames(object_hilic_neg))
#
# setdiff(colnames(object_hilic_neg),
#         colnames(object_hilic_pos))
#
#
# object_hilic <-
#   rbind(object_hilic_pos[, intersect(colnames(object_hilic_pos),
#                                      colnames(object_hilic_neg))],
#         object_hilic_neg[, intersect(colnames(object_hilic_pos),
#                                      colnames(object_hilic_neg))])
#
# dim(object_hilic)
#
# ###all
# setdiff(colnames(object_rplc),
#         colnames(object_hilic))
#
# setdiff(colnames(object_hilic),
#         colnames(object_rplc))
#
# head(object_rplc@sample_info)
#
# object_rplc <-
#   object_rplc %>%
#   activate_mass_dataset(what = "sample_info") %>%
#   dplyr::rename(injection.order_RPLC_POS = injection.order,
#                 injection.order_RPLC_NEG = injection.order_2)
#
# head(object_hilic@sample_info_note)
#
#
# object_hilic <-
#   object_hilic %>%
#   activate_mass_dataset(what = "sample_info") %>%
#   dplyr::rename(
#     acquisition_batch_HILIC_POS = acquisition_batch,
#     acquisition_batch_HILIC_NEG = acquisition_batch_2,
#     injection.order_HILIC_POS = injection.order,
#     injection.order_HILIC_NEG = injection.order_2
#   )
#
# object <-
#   rbind(object_rplc[, intersect(colnames(object_rplc),
#                                 colnames(object_hilic))],
#         object_hilic[, intersect(colnames(object_rplc),
#                                  colnames(object_hilic))])
#
# dir.create("peaks")
# save(object, file = "peaks/object")

load("peaks/object")

massdataset::export_mass_dataset(object = object, path = "peaks")

variable_info <-
  extract_variable_info(object) %>%
  dplyr::select(-c(na_freq, na_freq.1, mode.y)) %>%
  dplyr::rename(mode = mode.x)

write.csv(variable_info, file = "peaks/variable_info.csv", row.names = FALSE)

####only remain metabolites
# metid::summary_annotation_table(object)
#
# object <-
#   object %>%
#   activate_mass_dataset(what = "annotation_table") %>%
#   dplyr::filter(!is.na(Level))
#
#
# ###remove redundant metabolites
# variable_info <-
#   extract_variable_info(object)
#
# library(plyr)
#
# variable_info <-
#   variable_info %>%
#   plyr::dlply(.variables = .(Compound.name))
#
# variable_info <-
#   variable_info %>%
#   purrr::map(function(x) {
#     if (nrow(x) == 1) {
#       return(x)
#     } else{
#       x %>%
#         dplyr::filter(Level == min(Level)) %>%
#         dplyr::filter(SS == max(SS)) %>%
#         dplyr::filter(Total.score == max(Total.score)) %>%
#         head(1)
#     }
#   }) %>%
#   dplyr::bind_rows() %>%
#   as.data.frame()
#
# object <-
#   object %>%
#   activate_mass_dataset(what = "variable_info") %>%
#   dplyr::filter(variable_id %in% variable_info$variable_id)
#
# dir.create("metabolites")
# save(object, file = "metabolites/object")
load("metabolites/object")

massdataset::export_mass_dataset(object = object, path = "metabolites/")

variable_info <-
  extract_variable_info(object) %>%
  dplyr::select(-c(na_freq, na_freq.1, mode.y)) %>%
  dplyr::rename(mode = mode.x)

write.csv(variable_info, file = "metabolites/variable_info.csv", row.names = FALSE)


###add compound classes
library(masstools)


##get the InChIKey
inchikey <-
  rep(NA, nrow(variable_info))
for (i in 1:nrow(variable_info)) {
  cat(i, " ")
  if (is.na(variable_info$CAS.ID[i])) {
    next
  }
  inchikey[i] <-
    masstools::trans_ID(query = variable_info$CAS.ID[i],
                        from = "CAS",
                        to = "InChIKey")$InChIKey
}

variable_info$InChIKey <- inchikey

###get the compound class

# inchikey <-
#   rep(NA, nrow(variable_info))
compound_class <-
  vector("list", nrow(variable_info))
for (i in 480:nrow(variable_info)) {
  cat(i, " ")
  if (is.na(inchikey[i])) {
    next
  }
  temp <-
    masstools::get_compound_class(inchikey = inchikey[i])
  if (is.na(temp)) {
    next
  }
  compound_class[[i]] <-
    temp@classification_info %>%
    dplyr::filter(name %in% c("Kingdom", "Superclass", "Class", "Subclass")) %>%
    tibble::column_to_rownames(var = "name") %>%
    t() %>%
    as.data.frame()
}

compound_class <-
  compound_class %>%
  lapply(function(x) {
    if (is.null(x)) {
      x <- data.frame(matrix(NA, nrow = 1, ncol = 4))
      colnames(x) <- c("Kingdom", "Superclass", "Class", "Subclass")
      return(x)
    }
    return(x)
  })

compound_class <-
  compound_class %>%
  do.call(rbind, .) %>%
  as.data.frame()

save(compound_class, file = "compound_class")

variable_info <- cbind(variable_info, compound_class)

write.csv(variable_info, file = "metabolites/variable_info.csv", row.names = FALSE)
