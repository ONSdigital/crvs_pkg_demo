#### Births ----------------
birth_years <- 2024:2025

# Factors
# List of factor levels for categorical variables
# Defines order of categories for publication

birth_fcts <- list(
  dobyr = c("2025", "2024"),
  year = c("2025", "2024"),
  live_or_still = c("Live birth", "Stillbirth"),
  age_grp_m = c(
    "Under 15",
    "15 to 19",
    "20 to 24",
    "25 to 29",
    "30 to 34",
    "35 to 39",
    "40 and over",
    "Not stated"),
  asfr_mother_age_group = c(
    "Under 20",
    "20 to 24",
    "25 to 29",
    "30 to 34",
    "35 to 39",
    "40 and over",
    "Not stated"),
  age_m = c(0:100, "Not stated"),
  pop_age = as.character(c(0:90)),
  sex = c("Male", "Female", "Not stated"),
  urban_rural = c("Urban", "Rural", "Not stated"),
  mar_stat = c(
    "Single",
    "Married",
    "Divorced",
    "Widowed",
    "Not stated"),
  pob = c(
    "RegionA",
    "RegionB",
    "RegionC",
    "RegionD",
    "Not stated"),
  usual_residence = c(
    "RegionA",
    "RegionB",
    "RegionC",
    "RegionD",
    "Not stated"),
  geog = c(
    "RegionA",
    "RegionB",
    "RegionC",
    "RegionD",
    "Not stated"),
  pob_type = c(
    "Hospital",
    "Clinic",
    "Home",
    "Other",
    "Not stated"),
  bth_attendant = c(
    "Doctor",
    "Nurse",
    "Midwife",
    "Other",
    "Not stated")
)
