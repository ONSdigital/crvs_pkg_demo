##### Pipeline Setup -----------------------------------------------------------

source("config.R")
source("excel_user_input.R")
library(crvs.pkg)

data_lookup <- read.csv("inputs/data_dictionary.csv", na.strings = "")

##### Create dummy data --------------------------------------------------------

data_list <- list(
  raw_birth_data = create_birth_data_raw(),
  long_pop_data = create_tidy_pop_data() |>
    add_totals_tidy_pop(birth_fcts)
)

##### Rename all the columns using lookup --------------------------------------

data_list <- lapply(data_list, rename_crvs_columns, data_lookup)

##### Births -------------------------------------------------------------------

birth_data <- process_dummy_birth_data(
  data_list$raw_birth_data,
  birth_fcts$age_grp_m
)

# Optional cleaning

birth_data <- birth_data |>
  dplyr::filter(dobyr %in% birth_years) |>
  derive_live_or_still(birth_fcts) |>
  derive_var("urban_rural", birth_fcts$urban_rural) |>
  derive_var("mar_stat", birth_fcts$mar_stat) |>
  derive_var("pob", birth_fcts$pob) |>
  derive_var("usual_residence", birth_fcts$usual_residence) |>
  derive_var("bth_attendant", birth_fcts$bth_attendant) |>
  derive_var("pob_type", birth_fcts$pob_type) |>
  derive_var("sex", birth_fcts$sex) |>
  factorise_cols(level_list = birth_fcts)


# Table 4.2
tab4_2 <- general_count_by_var(
  data = birth_data,
  agg_cols = c("dobyr", "pob", "sex"),
  agg_cols_pub_names =
    c("Year", "Place of birth", "Sex"),
  agg_count_colname = "Counts of live births",
  fcts = birth_fcts,
  pre_agg_levels_to_keep = list(live_or_still = "Live birth"),
  post_agg_levels_to_keep = list(Year = c("2025", "2024"))
)

# Table 4.3
tab4_3 <- general_count_by_var(
  data = birth_data,
  agg_cols = c("dobyr", "pob", "usual_residence"),
  agg_cols_pub_names =
    c("Year", "Place of birth", "Place of usual residence"),
  agg_count_colname = "Counts of live births",
  fcts = birth_fcts,
  pre_agg_levels_to_keep = list(live_or_still = "Live birth"),
  post_agg_levels_to_keep = list(Year = c("2025", "2024"))
)

# Table 4.4
tab4_4 <- general_count_by_var(
  data = birth_data,
  agg_cols = c("dobyr", "live_or_still", "age_grp_m"),
  agg_cols_pub_names = c("Year", "Birth type", "Mothers age"),
  fcts = birth_fcts,
  post_agg_levels_to_keep = list(Year = c("2025", "2024"))
)

## Single year of age, too many rows so not very informative
tab4_4_sing_yr <- general_count_by_var(
  data = birth_data,
  agg_cols = c("dobyr", "live_or_still", "age_m"),
  agg_cols_pub_names = c("Year", "Birth type", "Mothers age"),
  fcts = birth_fcts,
  post_agg_levels_to_keep = list(Year = c("2025", "2024"))
)

# Table 4.5, 4.6
tab4_5 <- general_count_by_var(
  data = birth_data,
  agg_cols = c("dobyr", "urban_rural", "age_grp_m", "mar_stat"),
  agg_cols_pub_names =
    c("Year", "Urban or rural", "Mothers age", "Marital status"),
  agg_count_colname = "Counts of live births",
  fcts = birth_fcts,
  pre_agg_levels_to_keep = list(live_or_still = "Live birth"),
  post_agg_levels_to_keep = list(
    `Urban or rural` = "Urban",
    Year = c("2025", "2024")
  )
)

tab4_6 <- general_count_by_var(
  data = birth_data,
  agg_cols = c("dobyr", "urban_rural", "age_grp_m", "mar_stat"),
  agg_cols_pub_names =
    c("Year", "Urban or rural", "Mothers age", "Marital status"),
  agg_count_colname = "Counts of live births",
  fcts = birth_fcts,
  pre_agg_levels_to_keep = list(live_or_still = "Live birth"),
  post_agg_levels_to_keep = list(
    `Urban or rural` = "Rural",
    Year = c("2025", "2024")
  )
)

## How we might suggest presenting the data together
tab4_5_6 <- general_count_by_var(
  data = birth_data,
  agg_cols = c("dobyr", "urban_rural", "age_grp_m", "mar_stat"),
  agg_cols_pub_names =
    c("Year", "Urban or rural", "Mothers age", "Marital status"),
  agg_count_colname = "Counts of live births",
  fcts = birth_fcts,
  pre_agg_levels_to_keep = list(live_or_still = "Live birth"),
  post_agg_levels_to_keep = list(
    `Urban or rural` = c("All places rural or urban", "Urban", "Rural",
                         "Not stated"),
    Year = c("2025", "2024")
  )
)

# Table 4.7
tab4_7 <- general_count_by_var(
  data = birth_data,
  agg_cols = c("dobyr", "pob", "pob_type", "bth_attendant"),
  agg_cols_pub_names =
    c("Year", "Place of birth", "Place of birth type", "Birth attendant"),
  agg_count_colname = "Counts of live births",
  fcts = birth_fcts,
  pre_agg_levels_to_keep = list(live_or_still = "Live birth"),
  post_agg_levels_to_keep = list(Year = c("2025", "2024"))
)

tab4_8 <- calc_cbr_usual_residence(
  data = birth_data,
  pop = data_list$long_pop_data,
  fcts = birth_fcts
)


tab4_9 <- calc_age_spec_fert_rate_m(
  data = birth_data,
  pop = data_list$long_pop_data,
  fcts = birth_fcts
)
