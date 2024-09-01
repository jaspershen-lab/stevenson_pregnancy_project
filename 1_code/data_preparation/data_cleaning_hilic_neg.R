no_source()
library(tidyverse)
library(tidymass)
setwd(masstools::get_project_wd())

rm(list = ls())

source("code/tools.R")

setwd("data_analysis/data_preparation/hilic_neg/")

load("object")

dim(object)

sample_list <-
  readxl::read_xlsx("Stevenson Final List_nHILIC.xlsx",
                    sheet = 1,
                    col_types = "text")

sample_list <-
  sample_list %>%
  dplyr::select("Sample number", "Prep Batch", "Acquisition Batch", "Injection Order") %>%
  dplyr::rename(sample_id = "Sample number",
                preparation_batch = "Prep Batch",
                acquisition_batch = "Acquisition Batch",
                injection.order = "Injection Order") %>%
  dplyr::mutate(batch = 1) %>%
  dplyr::mutate(batch = as.numeric(batch),
                injection.order = as.numeric(injection.order))

sample_list2 <-
  sample_list %>%
  dplyr::mutate(sample_id = paste0(sample_id, "_WB"))

sample_list3 <-
  sample_list %>%
  dplyr::mutate(sample_id = paste0(sample_id, "_reinj"))

sample_list <-
  rbind(sample_list,
        sample_list2,
        sample_list3)

object <-
object %>% 
  activate_mass_dataset(what = "sample_info") %>% 
  mutate(sample_id = stringr::str_replace(sample_id, "\\_$", ""))

match(object@sample_info$sample_id, sample_list$sample_id)
object@sample_info$sample_id[which(is.na(match(object@sample_info$sample_id, sample_list$sample_id)))]


object <-
  object %>%
  activate_mass_dataset(what = "sample_info") %>%
  dplyr::select(-injection.order) %>%
  left_join(sample_list, by = "sample_id")

object %>%
  extract_sample_info() %>%
  dplyr::filter(is.na(injection.order))

object %>%
  extract_sample_info() %>%
  dplyr::filter(is.na(batch))

object %>%
  activate_mass_dataset(what = "sample_info") %>%
  count(batch)

object %>%
  filter(class == "QC") %>%
  extract_sample_info() %>%
  pull(injection.order) %>%
  sort() %>%
  plot()

###remove the features who have more than 20% NA in QC samples or 50% NA in subject samples
object@sample_info$class

object %>%
  activate_mass_dataset(what = "sample_info") %>%
  dplyr::filter(class == "QC") %>%
  pull(sample_id)

qc_id <-
  object %>%
  activate_mass_dataset(what = "sample_info") %>%
  dplyr::filter(class == "QC") %>%
  pull(sample_id)

qc_id <-
  qc_id[!stringr::str_detect(qc_id, "dln")]

subject_id <-
  object %>%
  activate_mass_dataset(what = "sample_info") %>%
  dplyr::filter(class == "Subject") %>%
  pull(sample_id)

object <-
  object %>%
  mutate_variable_na_freq(according_to_samples = qc_id) %>%
  mutate_variable_na_freq(according_to_samples = subject_id) %>%
  activate_mass_dataset(what = "variable_info") %>%
  filter(na_freq < 0.2 & na_freq.1 < 0.5)

##imputate MV with 0 in blank samples
blank_id <-
  object %>%
  activate_mass_dataset(what = "sample_info") %>%
  dplyr::filter(class == "Blank") %>%
  pull(sample_id)

object <-
  impute_mv(object = object,
            sample_id = blank_id,
            method = "zero")

####remove some samples with more than 50% NA
remove_idx <-
  object %>%
  mutate_sample_na_freq(according_to_variables = "all") %>%
  activate_mass_dataset(what = "sample_info") %>%
  pull(na_freq) %>%
  `>`(0.5) %>%
  which()
remove_idx
if (length(remove_idx) > 0) {
  object <-
    object[, -remove_idx]
}

###imputate mv
non_blank_id <-
  object %>%
  activate_mass_dataset(what = "sample_info") %>%
  dplyr::filter(class != "Blank") %>%
  pull(sample_id)

object <-
  impute_mv(object, sample_id = non_blank_id, method = "knn")

###data normalization
plot <-
  object %>%
  activate_mass_dataset(what = "sample_info") %>%
  dplyr::filter(class == "QC" & !is.na(batch)) %>%
  activate_mass_dataset(what = "sample_info") %>%
  dplyr::mutate(acquisition_batch = as.character(acquisition_batch)) %>%
  dplyr::mutate(acquisition_batch = factor(acquisition_batch, levels = stringr::str_sort(unique(acquisition_batch), numeric = TRUE))) %>%
  log(10) %>%
  scale_data() %>%
  massqc::massqc_pca(color_by = "acquisition_batch", point_alpha = 0.3)

plot

ggsave(plot,
       filename = "pca_before_normalization.pdf",
       width = 9,
       height = 7)

####data normalization
###remove blank samples
# object@sample_info$batch[is.na(object@sample_info$batch)] <- "NA"

object1 <-
  normalize_data(object, method = "svr")

object1 %>%
  activate_mass_dataset(what = "sample_info") %>%
  dplyr::filter(class == "QC" & !is.na(batch)) %>%
  activate_mass_dataset(what = "sample_info") %>%
  dplyr::mutate(acquisition_batch = as.character(acquisition_batch)) %>%
  dplyr::mutate(acquisition_batch = factor(acquisition_batch, levels = stringr::str_sort(unique(acquisition_batch), numeric = TRUE))) %>%
  log(10) %>%
  scale_data() %>%
  massqc::massqc_pca(color_by = "acquisition_batch", point_alpha = 0.3)

####data normalization
object2 <-
  integrate_data(object1, method = "subject_median")

###data integration
plot <-
  object2 %>%
  activate_mass_dataset(what = "sample_info") %>%
  dplyr::filter(class == "QC" & !is.na(batch)) %>%
  activate_mass_dataset(what = "sample_info") %>%
  dplyr::mutate(acquisition_batch = as.character(acquisition_batch)) %>%
  dplyr::mutate(acquisition_batch = factor(acquisition_batch, levels = stringr::str_sort(unique(acquisition_batch), numeric = TRUE))) %>%
  log(10) %>%
  scale_data() %>%
  massqc::massqc_pca(color_by = "acquisition_batch", point_alpha = 0.3)

plot

ggsave(plot,
       filename = "pca_after_normalization.pdf",
       width = 9,
       height = 7)

save(object2, file = "object2")
load("object2")






