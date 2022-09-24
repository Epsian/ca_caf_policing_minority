# to download needed raw census data
# https://www.socialexplorer.com/data/metadata/

# setup ####

library(tidycensus)

# download data ####

## 2020 ####

#v20 = load_variables(2020, "acs5", cache = TRUE)
acs5_2020 = get_acs(geography = "place", year = 2020,
                    variables = c(
                      total_pop = "B01003_001",
                      race_white = "B02001_002",
                      race_black = "B02001_003",
                      race_natam = "B02001_004",
                      race_asian = "B02001_005",
                      race_hawpi = "B02001_006",
                      race_2more = "B02001_008",
                      total_hisp = "B03002_012",
                      med_income = "B19013_001", # MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2019 INFLATION-ADJUSTED DOLLARS)
                      pov_pop = "C17002_001",   # RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS. Total population for whom Poverty Status is Determined.
                      pov_0_.5 = "C17002_002", # in poverty, income ratio 0-.5
                      pov_.5_.99 = "C17002_003", # in poverty, income ratio .5 -99
                      labor_total = "B23025_001",
                      unemployed_over16 = "B23025_005", # EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER. Estimate!!Total:!!In labor force:!!Civilian labor force:!!Unemployed
                      total_occupied = "B25003_001", # total occupied housing units
                      owner_occupied = "B25003_002", # total owner occupied units
                      foreign_born = "B05006_001", # Foreign-born population excluding population born at sea
                      median_age_male = "B01002_002",
                      median_age_female = "B01002_003",
                      male_18_19 = "B01001_007",
                      male_20 = "B01001_008",
                      male_21 = "B01001_009",
                      male_22_24 = "B01001_010",
                      female_18_19 = "B01001_031",
                      female_20 = "B01001_032",
                      female_21 = "B01001_033",
                      female_22_24 = "B01001_034"
                    ), 
                    state = "CA", survey = "acs5")

acs5_2020_c = get_acs(geography = "county", year = 2020,
                      variables = c(
                        total_pop = "B01003_001",
                        race_white = "B02001_002",
                        race_black = "B02001_003",
                        race_natam = "B02001_004",
                        race_asian = "B02001_005",
                        race_hawpi = "B02001_006",
                        race_2more = "B02001_008",
                        total_hisp = "B03002_012",
                        med_income = "B19013_001", # MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2019 INFLATION-ADJUSTED DOLLARS)
                        pov_pop = "C17002_001",   # RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS. Total population for whom Poverty Status is Determined.
                        pov_0_.5 = "C17002_002", # in poverty, income ratio 0-.5
                        pov_.5_.99 = "C17002_003", # in poverty, income ratio .5 -99
                        labor_total = "B23025_001",
                        unemployed_over16 = "B23025_005", # EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER. Estimate!!Total:!!In labor force:!!Civilian labor force:!!Unemployed
                        total_occupied = "B25003_001", # total occupied housing units
                        owner_occupied = "B25003_002", # total owner occupied units
                        foreign_born = "B05006_001", # Foreign-born population excluding population born at sea
                        median_age_male = "B01002_002",
                        median_age_female = "B01002_003",
                        male_18_19 = "B01001_007",
                        male_20 = "B01001_008",
                        male_21 = "B01001_009",
                        male_22_24 = "B01001_010",
                        female_18_19 = "B01001_031",
                        female_20 = "B01001_032",
                        female_21 = "B01001_033",
                        female_22_24 = "B01001_034"
                      ), 
                      state = "CA", survey = "acs5")

## 2019 ####

#v19 = load_variables(2019, "acs5", cache = TRUE)
acs5_2019 = get_acs(geography = "place", year = 2019,
              variables = c(
                total_pop = "B01003_001",
                race_white = "B02001_002",
                race_black = "B02001_003",
                race_natam = "B02001_004",
                race_asian = "B02001_005",
                race_hawpi = "B02001_006",
                race_2more = "B02001_008",
                total_hisp = "B03002_012",
                med_income = "B19013_001", # MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2019 INFLATION-ADJUSTED DOLLARS)
                pov_pop = "C17002_001",   # RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS. Total population for whom Poverty Status is Determined.
                pov_0_.5 = "C17002_002", # in poverty, income ratio 0-.5
                pov_.5_.99 = "C17002_003", # in poverty, income ratio .5 -99
                labor_total = "B23025_001",
                unemployed_over16 = "B23025_005", # EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER. Estimate!!Total:!!In labor force:!!Civilian labor force:!!Unemployed
                total_occupied = "B25003_001", # total occupied housing units
                owner_occupied = "B25003_002", # total owner occupied units
                foreign_born = "B05006_001", # Foreign-born population excluding population born at sea
                median_age_male = "B01002_002",
                median_age_female = "B01002_003",
                male_18_19 = "B01001_007",
                male_20 = "B01001_008",
                male_21 = "B01001_009",
                male_22_24 = "B01001_010",
                female_18_19 = "B01001_031",
                female_20 = "B01001_032",
                female_21 = "B01001_033",
                female_22_24 = "B01001_034"
                ), 
              state = "CA", survey = "acs5")

acs5_2019_c = get_acs(geography = "county", year = 2019,
                    variables = c(
                      total_pop = "B01003_001",
                      race_white = "B02001_002",
                      race_black = "B02001_003",
                      race_natam = "B02001_004",
                      race_asian = "B02001_005",
                      race_hawpi = "B02001_006",
                      race_2more = "B02001_008",
                      total_hisp = "B03002_012",
                      med_income = "B19013_001", # MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2019 INFLATION-ADJUSTED DOLLARS)
                      pov_pop = "C17002_001",   # RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS. Total population for whom Poverty Status is Determined.
                      pov_0_.5 = "C17002_002", # in poverty, income ratio 0-.5
                      pov_.5_.99 = "C17002_003", # in poverty, income ratio .5 -99
                      labor_total = "B23025_001",
                      unemployed_over16 = "B23025_005", # EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER. Estimate!!Total:!!In labor force:!!Civilian labor force:!!Unemployed
                      total_occupied = "B25003_001", # total occupied housing units
                      owner_occupied = "B25003_002", # total owner occupied units
                      foreign_born = "B05006_001", # Foreign-born population excluding population born at sea
                      median_age_male = "B01002_002",
                      median_age_female = "B01002_003",
                      male_18_19 = "B01001_007",
                      male_20 = "B01001_008",
                      male_21 = "B01001_009",
                      male_22_24 = "B01001_010",
                      female_18_19 = "B01001_031",
                      female_20 = "B01001_032",
                      female_21 = "B01001_033",
                      female_22_24 = "B01001_034"
                    ), 
                    state = "CA", survey = "acs5")

## 2018 ####

#v18 = load_variables(2018, "acs5", cache = TRUE)
acs5_2018 = get_acs(geography = "place", year = 2018,
                    variables = c(
                      total_pop = "B01003_001",  # TOTAL POPULATION
                      race_white = "B02001_002",
                      race_black = "B02001_003",
                      race_natam = "B02001_004",
                      race_asian = "B02001_005",
                      race_hawpi = "B02001_006",
                      race_2more = "B02001_008",
                      total_hisp = "B03002_012",
                      med_income = "B19013_001", # MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2018 INFLATION-ADJUSTED DOLLARS)
                      pov_pop = "C17002_001",   # RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS. Total population for whom Poverty Status is Determined.
                      pov_0_.5 = "C17002_002", # in poverty, income ratio 0-.5
                      pov_.5_.99 = "C17002_003", # in poverty, income ratio .5 -99
                      labor_total = "B23025_001",
                      unemployed_over16 = "B23025_005", # EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER. Estimate!!Total:!!In labor force:!!Civilian labor force:!!Unemployed
                      total_occupied = "B25003_001", # total occupied housing units
                      owner_occupied = "B25003_002", # total owner occupied units
                      foreign_born = "B05006_001", # Foreign-born population excluding population born at sea
                      median_age_male = "B01002_002",
                      median_age_female = "B01002_003",
                      male_18_19 = "B01001_007",
                      male_20 = "B01001_008",
                      male_21 = "B01001_009",
                      male_22_24 = "B01001_010",
                      female_18_19 = "B01001_031",
                      female_20 = "B01001_032",
                      female_21 = "B01001_033",
                      female_22_24 = "B01001_034"
                    ), 
                    state = "CA", survey = "acs5")

acs5_2018_c = get_acs(geography = "county", year = 2018,
                    variables = c(
                      total_pop = "B01003_001",  # TOTAL POPULATION
                      race_white = "B02001_002",
                      race_black = "B02001_003",
                      race_natam = "B02001_004",
                      race_asian = "B02001_005",
                      race_hawpi = "B02001_006",
                      race_2more = "B02001_008",
                      total_hisp = "B03002_012",
                      med_income = "B19013_001", # MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2018 INFLATION-ADJUSTED DOLLARS)
                      pov_pop = "C17002_001",   # RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS. Total population for whom Poverty Status is Determined.
                      pov_0_.5 = "C17002_002", # in poverty, income ratio 0-.5
                      pov_.5_.99 = "C17002_003", # in poverty, income ratio .5 -99
                      labor_total = "B23025_001",
                      unemployed_over16 = "B23025_005", # EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER. Estimate!!Total:!!In labor force:!!Civilian labor force:!!Unemployed
                      total_occupied = "B25003_001", # total occupied housing units
                      owner_occupied = "B25003_002", # total owner occupied units
                      foreign_born = "B05006_001", # Foreign-born population excluding population born at sea
                      median_age_male = "B01002_002",
                      median_age_female = "B01002_003",
                      male_18_19 = "B01001_007",
                      male_20 = "B01001_008",
                      male_21 = "B01001_009",
                      male_22_24 = "B01001_010",
                      female_18_19 = "B01001_031",
                      female_20 = "B01001_032",
                      female_21 = "B01001_033",
                      female_22_24 = "B01001_034"
                    ), 
                    state = "CA", survey = "acs5")

## 2017 ####

#v17 = load_variables(2017, "acs5", cache = TRUE)
acs5_2017 = get_acs(geography = "place", year = 2017,
                    variables = c(
                      total_pop = "B01003_001",  # TOTAL POPULATION
                      race_white = "B02001_002",
                      race_black = "B02001_003",
                      race_natam = "B02001_004",
                      race_asian = "B02001_005",
                      race_hawpi = "B02001_006",
                      race_2more = "B02001_008",
                      total_hisp = "B03002_012",
                      med_income = "B19013_001", # MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2017 INFLATION-ADJUSTED DOLLARS)
                      pov_pop = "C17002_001",   # RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS. Total population for whom Poverty Status is Determined.
                      pov_0_.5 = "C17002_002", # in poverty, income ratio 0-.5
                      pov_.5_.99 = "C17002_003", # in poverty, income ratio .5 -99
                      labor_total = "B23025_001",
                      unemployed_over16 = "B23025_005", # EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER. Estimate!!Total:!!In labor force:!!Civilian labor force:!!Unemployed
                      total_occupied = "B25003_001", # total occupied housing units
                      owner_occupied = "B25003_002", # total owner occupied units
                      foreign_born = "B05006_001", # Foreign-born population excluding population born at sea
                      median_age_male = "B01002_002",
                      median_age_female = "B01002_003",
                      male_18_19 = "B01001_007",
                      male_20 = "B01001_008",
                      male_21 = "B01001_009",
                      male_22_24 = "B01001_010",
                      female_18_19 = "B01001_031",
                      female_20 = "B01001_032",
                      female_21 = "B01001_033",
                      female_22_24 = "B01001_034"
                    ), 
                    state = "CA", survey = "acs5")

acs5_2017_c = get_acs(geography = "county", year = 2017,
                    variables = c(
                      total_pop = "B01003_001",  # TOTAL POPULATION
                      race_white = "B02001_002",
                      race_black = "B02001_003",
                      race_natam = "B02001_004",
                      race_asian = "B02001_005",
                      race_hawpi = "B02001_006",
                      race_2more = "B02001_008",
                      total_hisp = "B03002_012",
                      med_income = "B19013_001", # MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2017 INFLATION-ADJUSTED DOLLARS)
                      pov_pop = "C17002_001",   # RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS. Total population for whom Poverty Status is Determined.
                      pov_0_.5 = "C17002_002", # in poverty, income ratio 0-.5
                      pov_.5_.99 = "C17002_003", # in poverty, income ratio .5 -99
                      labor_total = "B23025_001",
                      unemployed_over16 = "B23025_005", # EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER. Estimate!!Total:!!In labor force:!!Civilian labor force:!!Unemployed
                      total_occupied = "B25003_001", # total occupied housing units
                      owner_occupied = "B25003_002", # total owner occupied units
                      foreign_born = "B05006_001", # Foreign-born population excluding population born at sea
                      median_age_male = "B01002_002",
                      median_age_female = "B01002_003",
                      male_18_19 = "B01001_007",
                      male_20 = "B01001_008",
                      male_21 = "B01001_009",
                      male_22_24 = "B01001_010",
                      female_18_19 = "B01001_031",
                      female_20 = "B01001_032",
                      female_21 = "B01001_033",
                      female_22_24 = "B01001_034"
                    ), 
                    state = "CA", survey = "acs5")

## 2016 ####

#v16 = load_variables(2016, "acs5", cache = TRUE)
acs5_2016 = get_acs(geography = "place", year = 2016,
                    variables = c(
                      total_pop = "B01003_001",  # TOTAL POPULATION
                      race_white = "B02001_002",
                      race_black = "B02001_003",
                      race_natam = "B02001_004",
                      race_asian = "B02001_005",
                      race_hawpi = "B02001_006",
                      race_2more = "B02001_008",
                      total_hisp = "B03002_012",
                      med_income = "B19013_001", # MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2016 INFLATION-ADJUSTED DOLLARS)
                      pov_pop = "C17002_001",   # RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS. Total population for whom Poverty Status is Determined.
                      pov_0_.5 = "C17002_002", # in poverty, income ratio 0-.5
                      pov_.5_.99 = "C17002_003", # in poverty, income ratio .5 -99
                      labor_total = "B23025_001",
                      unemployed_over16 = "B23025_005", # EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER. Estimate!!Total:!!In labor force:!!Civilian labor force:!!Unemployed
                      total_occupied = "B25003_001", # total occupied housing units
                      owner_occupied = "B25003_002", # total owner occupied units
                      foreign_born = "B05006_001", # Foreign-born population excluding population born at sea
                      median_age_male = "B01002_002",
                      median_age_female = "B01002_003",
                      male_18_19 = "B01001_007",
                      male_20 = "B01001_008",
                      male_21 = "B01001_009",
                      male_22_24 = "B01001_010",
                      female_18_19 = "B01001_031",
                      female_20 = "B01001_032",
                      female_21 = "B01001_033",
                      female_22_24 = "B01001_034"
                    ), 
                    state = "CA", survey = "acs5")

acs5_2016_c = get_acs(geography = "county", year = 2016,
                    variables = c(
                      total_pop = "B01003_001",  # TOTAL POPULATION
                      race_white = "B02001_002",
                      race_black = "B02001_003",
                      race_natam = "B02001_004",
                      race_asian = "B02001_005",
                      race_hawpi = "B02001_006",
                      race_2more = "B02001_008",
                      total_hisp = "B03002_012",
                      med_income = "B19013_001", # MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2016 INFLATION-ADJUSTED DOLLARS)
                      pov_pop = "C17002_001",   # RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS. Total population for whom Poverty Status is Determined.
                      pov_0_.5 = "C17002_002", # in poverty, income ratio 0-.5
                      pov_.5_.99 = "C17002_003", # in poverty, income ratio .5 -99
                      labor_total = "B23025_001",
                      unemployed_over16 = "B23025_005", # EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER. Estimate!!Total:!!In labor force:!!Civilian labor force:!!Unemployed
                      total_occupied = "B25003_001", # total occupied housing units
                      owner_occupied = "B25003_002", # total owner occupied units
                      foreign_born = "B05006_001", # Foreign-born population excluding population born at sea
                      median_age_male = "B01002_002",
                      median_age_female = "B01002_003",
                      male_18_19 = "B01001_007",
                      male_20 = "B01001_008",
                      male_21 = "B01001_009",
                      male_22_24 = "B01001_010",
                      female_18_19 = "B01001_031",
                      female_20 = "B01001_032",
                      female_21 = "B01001_033",
                      female_22_24 = "B01001_034"
                    ), 
                    state = "CA", survey = "acs5")

## 2015 ####

#v15 = load_variables(2015, "acs5", cache = TRUE)
acs5_2015 = get_acs(geography = "place", year = 2015,
                    variables = c(
                      total_pop = "B01003_001",  # TOTAL POPULATION
                      race_white = "B02001_002",
                      race_black = "B02001_003",
                      race_natam = "B02001_004",
                      race_asian = "B02001_005",
                      race_hawpi = "B02001_006",
                      race_2more = "B02001_008",
                      total_hisp = "B03002_012",
                      med_income = "B19013_001", # MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2015 INFLATION-ADJUSTED DOLLARS)
                      pov_pop = "C17002_001",   # RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS. Total population for whom Poverty Status is Determined.
                      pov_0_.5 = "C17002_002", # in poverty, income ratio 0-.5
                      pov_.5_.99 = "C17002_003", # in poverty, income ratio .5 -99
                      labor_total = "B23025_001",
                      unemployed_over16 = "B23025_005", # EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER. Estimate!!Total:!!In labor force:!!Civilian labor force:!!Unemployed
                      total_occupied = "B25003_001", # total occupied housing units
                      owner_occupied = "B25003_002", # total owner occupied units
                      foreign_born = "B05006_001", # Foreign-born population excluding population born at sea
                      median_age_male = "B01002_002",
                      median_age_female = "B01002_003",
                      male_18_19 = "B01001_007",
                      male_20 = "B01001_008",
                      male_21 = "B01001_009",
                      male_22_24 = "B01001_010",
                      female_18_19 = "B01001_031",
                      female_20 = "B01001_032",
                      female_21 = "B01001_033",
                      female_22_24 = "B01001_034"
                    ), 
                    state = "CA", survey = "acs5")

acs5_2015_c = get_acs(geography = "county", year = 2015,
                    variables = c(
                      total_pop = "B01003_001",  # TOTAL POPULATION
                      race_white = "B02001_002",
                      race_black = "B02001_003",
                      race_natam = "B02001_004",
                      race_asian = "B02001_005",
                      race_hawpi = "B02001_006",
                      race_2more = "B02001_008",
                      total_hisp = "B03002_012",
                      med_income = "B19013_001", # MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2015 INFLATION-ADJUSTED DOLLARS)
                      pov_pop = "C17002_001",   # RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS. Total population for whom Poverty Status is Determined.
                      pov_0_.5 = "C17002_002", # in poverty, income ratio 0-.5
                      pov_.5_.99 = "C17002_003", # in poverty, income ratio .5 -99
                      labor_total = "B23025_001",
                      unemployed_over16 = "B23025_005", # EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER. Estimate!!Total:!!In labor force:!!Civilian labor force:!!Unemployed
                      total_occupied = "B25003_001", # total occupied housing units
                      owner_occupied = "B25003_002", # total owner occupied units
                      foreign_born = "B05006_001", # Foreign-born population excluding population born at sea
                      median_age_male = "B01002_002",
                      median_age_female = "B01002_003",
                      male_18_19 = "B01001_007",
                      male_20 = "B01001_008",
                      male_21 = "B01001_009",
                      male_22_24 = "B01001_010",
                      female_18_19 = "B01001_031",
                      female_20 = "B01001_032",
                      female_21 = "B01001_033",
                      female_22_24 = "B01001_034"
                    ), 
                    state = "CA", survey = "acs5")

## 2014 ####

#v14 = load_variables(2014, "acs5", cache = TRUE)
acs5_2014 = get_acs(geography = "place", year = 2014,
                    variables = c(
                      total_pop = "B01003_001",  # TOTAL POPULATION
                      race_white = "B02001_002",
                      race_black = "B02001_003",
                      race_natam = "B02001_004",
                      race_asian = "B02001_005",
                      race_hawpi = "B02001_006",
                      race_2more = "B02001_008",
                      total_hisp = "B03002_012",
                      med_income = "B19013_001", # MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2014 INFLATION-ADJUSTED DOLLARS)
                      pov_pop = "C17002_001",   # RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS. Total population for whom Poverty Status is Determined.
                      pov_0_.5 = "C17002_002", # in poverty, income ratio 0-.5
                      pov_.5_.99 = "C17002_003", # in poverty, income ratio .5 -99
                      labor_total = "B23025_001",
                      unemployed_over16 = "B23025_005", # EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER. Estimate!!Total:!!In labor force:!!Civilian labor force:!!Unemployed
                      total_occupied = "B25003_001", # total occupied housing units
                      owner_occupied = "B25003_002", # total owner occupied units
                      foreign_born = "B05006_001", # Foreign-born population excluding population born at sea
                      median_age_male = "B01002_002",
                      median_age_female = "B01002_003",
                      male_18_19 = "B01001_007",
                      male_20 = "B01001_008",
                      male_21 = "B01001_009",
                      male_22_24 = "B01001_010",
                      female_18_19 = "B01001_031",
                      female_20 = "B01001_032",
                      female_21 = "B01001_033",
                      female_22_24 = "B01001_034"
                    ), 
                    state = "CA", survey = "acs5")

acs5_2014_c = get_acs(geography = "county", year = 2014,
                    variables = c(
                      total_pop = "B01003_001",  # TOTAL POPULATION
                      race_white = "B02001_002",
                      race_black = "B02001_003",
                      race_natam = "B02001_004",
                      race_asian = "B02001_005",
                      race_hawpi = "B02001_006",
                      race_2more = "B02001_008",
                      total_hisp = "B03002_012",
                      med_income = "B19013_001", # MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2014 INFLATION-ADJUSTED DOLLARS)
                      pov_pop = "C17002_001",   # RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS. Total population for whom Poverty Status is Determined.
                      pov_0_.5 = "C17002_002", # in poverty, income ratio 0-.5
                      pov_.5_.99 = "C17002_003", # in poverty, income ratio .5 -99
                      labor_total = "B23025_001",
                      unemployed_over16 = "B23025_005", # EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER. Estimate!!Total:!!In labor force:!!Civilian labor force:!!Unemployed
                      total_occupied = "B25003_001", # total occupied housing units
                      owner_occupied = "B25003_002", # total owner occupied units
                      foreign_born = "B05006_001", # Foreign-born population excluding population born at sea
                      median_age_male = "B01002_002",
                      median_age_female = "B01002_003",
                      male_18_19 = "B01001_007",
                      male_20 = "B01001_008",
                      male_21 = "B01001_009",
                      male_22_24 = "B01001_010",
                      female_18_19 = "B01001_031",
                      female_20 = "B01001_032",
                      female_21 = "B01001_033",
                      female_22_24 = "B01001_034"
                    ), 
                    state = "CA", survey = "acs5")

## 2013 ####

#v13 = load_variables(2013, "acs5", cache = TRUE)
acs5_2013 = get_acs(geography = "place", year = 2013,
                    variables = c(
                      total_pop = "B01003_001",  # TOTAL POPULATION
                      race_white = "B02001_002",
                      race_black = "B02001_003",
                      race_natam = "B02001_004",
                      race_asian = "B02001_005",
                      race_hawpi = "B02001_006",
                      race_2more = "B02001_008",
                      total_hisp = "B03002_012",
                      med_income = "B19013_001", # MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2013 INFLATION-ADJUSTED DOLLARS)
                      pov_pop = "C17002_001",   # RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS. Total population for whom Poverty Status is Determined.
                      pov_0_.5 = "C17002_002", # in poverty, income ratio 0-.5
                      pov_.5_.99 = "C17002_003", # in poverty, income ratio .5 -99
                      labor_total = "B23025_001",
                      unemployed_over16 = "B23025_005", # EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER. Estimate!!Total:!!In labor force:!!Civilian labor force:!!Unemployed
                      total_occupied = "B25003_001", # total occupied housing units
                      owner_occupied = "B25003_002", # total owner occupied units
                      foreign_born = "B05006_001", # Foreign-born population excluding population born at sea
                      median_age_male = "B01002_002",
                      median_age_female = "B01002_003",
                      male_18_19 = "B01001_007",
                      male_20 = "B01001_008",
                      male_21 = "B01001_009",
                      male_22_24 = "B01001_010",
                      female_18_19 = "B01001_031",
                      female_20 = "B01001_032",
                      female_21 = "B01001_033",
                      female_22_24 = "B01001_034"
                    ), 
                    state = "CA", survey = "acs5")

acs5_2013_c = get_acs(geography = "county", year = 2013,
                    variables = c(
                      total_pop = "B01003_001",  # TOTAL POPULATION
                      race_white = "B02001_002",
                      race_black = "B02001_003",
                      race_natam = "B02001_004",
                      race_asian = "B02001_005",
                      race_hawpi = "B02001_006",
                      race_2more = "B02001_008",
                      total_hisp = "B03002_012",
                      med_income = "B19013_001", # MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2013 INFLATION-ADJUSTED DOLLARS)
                      pov_pop = "C17002_001",   # RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS. Total population for whom Poverty Status is Determined.
                      pov_0_.5 = "C17002_002", # in poverty, income ratio 0-.5
                      pov_.5_.99 = "C17002_003", # in poverty, income ratio .5 -99
                      labor_total = "B23025_001",
                      unemployed_over16 = "B23025_005", # EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER. Estimate!!Total:!!In labor force:!!Civilian labor force:!!Unemployed
                      total_occupied = "B25003_001", # total occupied housing units
                      owner_occupied = "B25003_002", # total owner occupied units
                      foreign_born = "B05006_001", # Foreign-born population excluding population born at sea
                      median_age_male = "B01002_002",
                      median_age_female = "B01002_003",
                      male_18_19 = "B01001_007",
                      male_20 = "B01001_008",
                      male_21 = "B01001_009",
                      male_22_24 = "B01001_010",
                      female_18_19 = "B01001_031",
                      female_20 = "B01001_032",
                      female_21 = "B01001_033",
                      female_22_24 = "B01001_034"
                    ), 
                    state = "CA", survey = "acs5")

## 2012 ####

#v12 = load_variables(2012, "acs5", cache = TRUE)
acs5_2012 = get_acs(geography = "place", year = 2012,
                    variables = c(
                      total_pop = "B01003_001",  # TOTAL POPULATION
                      race_white = "B02001_002",
                      race_black = "B02001_003",
                      race_natam = "B02001_004",
                      race_asian = "B02001_005",
                      race_hawpi = "B02001_006",
                      race_2more = "B02001_008",
                      total_hisp = "B03002_012",
                      med_income = "B19013_001", # MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2012 INFLATION-ADJUSTED DOLLARS)
                      pov_pop = "C17002_001",   # RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS. Total population for whom Poverty Status is Determined.
                      pov_0_.5 = "C17002_002", # in poverty, income ratio 0-.5
                      pov_.5_.99 = "C17002_003", # in poverty, income ratio .5 -99
                      labor_total = "B23025_001",
                      unemployed_over16 = "B23025_005", # EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER. Estimate!!Total:!!In labor force:!!Civilian labor force:!!Unemployed
                      total_occupied = "B25003_001", # total occupied housing units
                      owner_occupied = "B25003_002", # total owner occupied units
                      foreign_born = "B05006_001", # Foreign-born population excluding population born at sea
                      median_age_male = "B01002_002",
                      median_age_female = "B01002_003",
                      male_18_19 = "B01001_007",
                      male_20 = "B01001_008",
                      male_21 = "B01001_009",
                      male_22_24 = "B01001_010",
                      female_18_19 = "B01001_031",
                      female_20 = "B01001_032",
                      female_21 = "B01001_033",
                      female_22_24 = "B01001_034"
                    ), 
                    state = "CA", survey = "acs5")

acs5_2012_c = get_acs(geography = "county", year = 2012,
                    variables = c(
                      total_pop = "B01003_001",  # TOTAL POPULATION
                      race_white = "B02001_002",
                      race_black = "B02001_003",
                      race_natam = "B02001_004",
                      race_asian = "B02001_005",
                      race_hawpi = "B02001_006",
                      race_2more = "B02001_008",
                      total_hisp = "B03002_012",
                      med_income = "B19013_001", # MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2012 INFLATION-ADJUSTED DOLLARS)
                      pov_pop = "C17002_001",   # RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS. Total population for whom Poverty Status is Determined.
                      pov_0_.5 = "C17002_002", # in poverty, income ratio 0-.5
                      pov_.5_.99 = "C17002_003", # in poverty, income ratio .5 -99
                      labor_total = "B23025_001",
                      unemployed_over16 = "B23025_005", # EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER. Estimate!!Total:!!In labor force:!!Civilian labor force:!!Unemployed
                      total_occupied = "B25003_001", # total occupied housing units
                      owner_occupied = "B25003_002", # total owner occupied units
                      foreign_born = "B05006_001", # Foreign-born population excluding population born at sea
                      median_age_male = "B01002_002",
                      median_age_female = "B01002_003",
                      male_18_19 = "B01001_007",
                      male_20 = "B01001_008",
                      male_21 = "B01001_009",
                      male_22_24 = "B01001_010",
                      female_18_19 = "B01001_031",
                      female_20 = "B01001_032",
                      female_21 = "B01001_033",
                      female_22_24 = "B01001_034"
                    ), 
                    state = "CA", survey = "acs5")

## 2011 ####

#v11 = load_variables(2011, "acs5", cache = TRUE)
acs5_2011 = get_acs(geography = "place", year = 2011,
                    variables = c(
                      total_pop = "B01003_001",  # TOTAL POPULATION
                      race_white = "B02001_002",
                      race_black = "B02001_003",
                      race_natam = "B02001_004",
                      race_asian = "B02001_005",
                      race_hawpi = "B02001_006",
                      race_2more = "B02001_008",
                      total_hisp = "B03002_012",
                      med_income = "B19013_001", # MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2011 INFLATION-ADJUSTED DOLLARS)
                      pov_pop = "C17002_001",   # RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS. Total population for whom Poverty Status is Determined.
                      pov_0_.5 = "C17002_002", # in poverty, income ratio 0-.5
                      pov_.5_.99 = "C17002_003", # in poverty, income ratio .5 -99
                      labor_total = "B23025_001",
                      unemployed_over16 = "B23025_005", # EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER. Estimate!!Total:!!In labor force:!!Civilian labor force:!!Unemployed
                      total_occupied = "B25003_001", # total occupied housing units
                      owner_occupied = "B25003_002", # total owner occupied units
                      foreign_born = "B05006_001", # Foreign-born population excluding population born at sea
                      median_age_male = "B01002_002",
                      median_age_female = "B01002_003",
                      male_18_19 = "B01001_007",
                      male_20 = "B01001_008",
                      male_21 = "B01001_009",
                      male_22_24 = "B01001_010",
                      female_18_19 = "B01001_031",
                      female_20 = "B01001_032",
                      female_21 = "B01001_033",
                      female_22_24 = "B01001_034"
                    ), 
                    state = "CA", survey = "acs5")

acs5_2011_c = get_acs(geography = "county", year = 2011,
                    variables = c(
                      total_pop = "B01003_001",  # TOTAL POPULATION
                      race_white = "B02001_002",
                      race_black = "B02001_003",
                      race_natam = "B02001_004",
                      race_asian = "B02001_005",
                      race_hawpi = "B02001_006",
                      race_2more = "B02001_008",
                      total_hisp = "B03002_012",
                      med_income = "B19013_001", # MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2011 INFLATION-ADJUSTED DOLLARS)
                      pov_pop = "C17002_001",   # RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS. Total population for whom Poverty Status is Determined.
                      pov_0_.5 = "C17002_002", # in poverty, income ratio 0-.5
                      pov_.5_.99 = "C17002_003", # in poverty, income ratio .5 -99
                      labor_total = "B23025_001",
                      unemployed_over16 = "B23025_005", # EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER. Estimate!!Total:!!In labor force:!!Civilian labor force:!!Unemployed
                      total_occupied = "B25003_001", # total occupied housing units
                      owner_occupied = "B25003_002", # total owner occupied units
                      foreign_born = "B05006_001", # Foreign-born population excluding population born at sea
                      median_age_male = "B01002_002",
                      median_age_female = "B01002_003",
                      male_18_19 = "B01001_007",
                      male_20 = "B01001_008",
                      male_21 = "B01001_009",
                      male_22_24 = "B01001_010",
                      female_18_19 = "B01001_031",
                      female_20 = "B01001_032",
                      female_21 = "B01001_033",
                      female_22_24 = "B01001_034"
                    ), 
                    state = "CA", survey = "acs5")

## 2010 ####

#v10 = load_variables(2010, "acs5", cache = TRUE)
acs5_2010 = get_acs(geography = "place", year = 2010,
                    variables = c(
                      total_pop = "B01003_001",  # TOTAL POPULATION
                      race_white = "B02001_002",
                      race_black = "B02001_003",
                      race_natam = "B02001_004",
                      race_asian = "B02001_005",
                      race_hawpi = "B02001_006",
                      race_2more = "B02001_008",
                      total_hisp = "B03002_012",
                      med_income = "B19013_001", # MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2010 INFLATION-ADJUSTED DOLLARS)
                      pov_pop = "C17002_001",   # RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS. Total population for whom Poverty Status is Determined.
                      pov_0_.5 = "C17002_002", # in poverty, income ratio 0-.5
                      pov_.5_.99 = "C17002_003", # in poverty, income ratio .5 -99
                      labor_total = "B23001_001",
                      unemp_male_16_19 = "B23001_008", # unemployed male 16_19
                      unemp_male_20_21 = "B23001_015", # unemployed male 20_21
                      unemp_male_22_24 = "B23001_022", # unemployed male 22_24
                      unemp_male_25_29 = "B23001_029", # unemployed male 25_29
                      unemp_male_30_34 = "B23001_036", # unemployed male 30_34
                      unemp_male_35_44 = "B23001_043", # unemployed male 35_44
                      unemp_male_45_54 = "B23001_050", # unemployed male 45_54
                      unemp_male_55_59 = "B23001_057", # unemployed male 55_59
                      unemp_male_60_61 = "B23001_064", # unemployed male 60_61
                      unemp_male_62_64 = "B23001_071", # unemployed male 62_64
                      unemp_male_65_69 = "B23001_076", # unemployed male 65_69
                      unemp_male_70_74 = "B23001_081", # unemployed male 70_74
                      unemp_male_75_over = "B23001_086", # unemployed male 75_over
                      unemp_female_16_19 = "B23001_094", # unemployed female 16_19
                      unemp_female_20_21 = "B23001_101", # unemployed female 20_21
                      unemp_female_22_24 = "B23001_108", # unemployed female 22_24
                      unemp_female_25_29 = "B23001_115", # unemployed female 25_29
                      unemp_female_30_34 = "B23001_122", # unemployed female 30_34
                      unemp_female_35_44 = "B23001_129", # unemployed female 35_44
                      unemp_female_45_54 = "B23001_136", # unemployed female 45_54
                      unemp_female_55_59 = "B23001_143", # unemployed female 55_59
                      unemp_female_60_61 = "B23001_150", # unemployed female 60_61
                      unemp_female_62_64 = "B23001_157", # unemployed female 62_64
                      unemp_female_65_69 = "B23001_162", # unemployed female 65_69
                      unemp_female_70_74 = "B23001_167", # unemployed female 70_74
                      unemp_female_75_over = "B23001_172", # unemployed female 75_over
                      total_occupied = "B25003_001", # total occupied housing units
                      owner_occupied = "B25003_002", # total owner occupied units
                      foreign_born = "B05006_001", # Foreign-born population excluding population born at sea
                      median_age_male = "B01002_002",
                      median_age_female = "B01002_003",
                      male_18_19 = "B01001_007",
                      male_20 = "B01001_008",
                      male_21 = "B01001_009",
                      male_22_24 = "B01001_010",
                      female_18_19 = "B01001_031",
                      female_20 = "B01001_032",
                      female_21 = "B01001_033",
                      female_22_24 = "B01001_034"
                    ), 
                    state = "CA", survey = "acs5")

acs5_2010_c = get_acs(geography = "county", year = 2010,
                    variables = c(
                      total_pop = "B01003_001",  # TOTAL POPULATION
                      race_white = "B02001_002",
                      race_black = "B02001_003",
                      race_natam = "B02001_004",
                      race_asian = "B02001_005",
                      race_hawpi = "B02001_006",
                      race_2more = "B02001_008",
                      total_hisp = "B03002_012",
                      med_income = "B19013_001", # MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2010 INFLATION-ADJUSTED DOLLARS)
                      pov_pop = "C17002_001",   # RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS. Total population for whom Poverty Status is Determined.
                      pov_0_.5 = "C17002_002", # in poverty, income ratio 0-.5
                      pov_.5_.99 = "C17002_003", # in poverty, income ratio .5 -99
                      labor_total = "B23001_001",
                      unemp_male_16_19 = "B23001_008", # unemployed male 16_19
                      unemp_male_20_21 = "B23001_015", # unemployed male 20_21
                      unemp_male_22_24 = "B23001_022", # unemployed male 22_24
                      unemp_male_25_29 = "B23001_029", # unemployed male 25_29
                      unemp_male_30_34 = "B23001_036", # unemployed male 30_34
                      unemp_male_35_44 = "B23001_043", # unemployed male 35_44
                      unemp_male_45_54 = "B23001_050", # unemployed male 45_54
                      unemp_male_55_59 = "B23001_057", # unemployed male 55_59
                      unemp_male_60_61 = "B23001_064", # unemployed male 60_61
                      unemp_male_62_64 = "B23001_071", # unemployed male 62_64
                      unemp_male_65_69 = "B23001_076", # unemployed male 65_69
                      unemp_male_70_74 = "B23001_081", # unemployed male 70_74
                      unemp_male_75_over = "B23001_086", # unemployed male 75_over
                      unemp_female_16_19 = "B23001_094", # unemployed female 16_19
                      unemp_female_20_21 = "B23001_101", # unemployed female 20_21
                      unemp_female_22_24 = "B23001_108", # unemployed female 22_24
                      unemp_female_25_29 = "B23001_115", # unemployed female 25_29
                      unemp_female_30_34 = "B23001_122", # unemployed female 30_34
                      unemp_female_35_44 = "B23001_129", # unemployed female 35_44
                      unemp_female_45_54 = "B23001_136", # unemployed female 45_54
                      unemp_female_55_59 = "B23001_143", # unemployed female 55_59
                      unemp_female_60_61 = "B23001_150", # unemployed female 60_61
                      unemp_female_62_64 = "B23001_157", # unemployed female 62_64
                      unemp_female_65_69 = "B23001_162", # unemployed female 65_69
                      unemp_female_70_74 = "B23001_167", # unemployed female 70_74
                      unemp_female_75_over = "B23001_172", # unemployed female 75_over
                      total_occupied = "B25003_001", # total occupied housing units
                      owner_occupied = "B25003_002", # total owner occupied units
                      foreign_born = "B05006_001", # Foreign-born population excluding population born at sea
                      median_age_male = "B01002_002",
                      median_age_female = "B01002_003",
                      male_18_19 = "B01001_007",
                      male_20 = "B01001_008",
                      male_21 = "B01001_009",
                      male_22_24 = "B01001_010",
                      female_18_19 = "B01001_031",
                      female_20 = "B01001_032",
                      female_21 = "B01001_033",
                      female_22_24 = "B01001_034"
                    ), 
                    state = "CA", survey = "acs5")
## 2009 ####

#v09 = load_variables(2009, "acs5", cache = TRUE)
acs5_2009 = get_acs(geography = "place", year = 2009,
                    variables = c(
                      total_pop = "B01003_001",  # TOTAL POPULATION
                      race_white = "B02001_002",
                      race_black = "B02001_003",
                      race_natam = "B02001_004",
                      race_asian = "B02001_005",
                      race_hawpi = "B02001_006",
                      race_2more = "B02001_008",
                      total_hisp = "B03002_012",
                      med_income = "B19013_001", # MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2009 INFLATION-ADJUSTED DOLLARS)
                      pov_pop = "C17002_001",   # RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS. Total population for whom Poverty Status is Determined.
                      pov_0_.5 = "C17002_002", # in poverty, income ratio 0-.5
                      pov_.5_.99 = "C17002_003", # in poverty, income ratio .5 -99
                      labor_total = "B23001_001",
                      unemp_male_16_19 = "B23001_008", # unemployed male 16_19
                      unemp_male_20_21 = "B23001_015", # unemployed male 20_21
                      unemp_male_22_24 = "B23001_022", # unemployed male 22_24
                      unemp_male_25_29 = "B23001_029", # unemployed male 25_29
                      unemp_male_30_34 = "B23001_036", # unemployed male 30_34
                      unemp_male_35_44 = "B23001_043", # unemployed male 35_44
                      unemp_male_45_54 = "B23001_050", # unemployed male 45_54
                      unemp_male_55_59 = "B23001_057", # unemployed male 55_59
                      unemp_male_60_61 = "B23001_064", # unemployed male 60_61
                      unemp_male_62_64 = "B23001_071", # unemployed male 62_64
                      unemp_male_65_69 = "B23001_076", # unemployed male 65_69
                      unemp_male_70_74 = "B23001_081", # unemployed male 70_74
                      unemp_male_75_over = "B23001_086", # unemployed male 75_over
                      unemp_female_16_19 = "B23001_094", # unemployed female 16_19
                      unemp_female_20_21 = "B23001_101", # unemployed female 20_21
                      unemp_female_22_24 = "B23001_108", # unemployed female 22_24
                      unemp_female_25_29 = "B23001_115", # unemployed female 25_29
                      unemp_female_30_34 = "B23001_122", # unemployed female 30_34
                      unemp_female_35_44 = "B23001_129", # unemployed female 35_44
                      unemp_female_45_54 = "B23001_136", # unemployed female 45_54
                      unemp_female_55_59 = "B23001_143", # unemployed female 55_59
                      unemp_female_60_61 = "B23001_150", # unemployed female 60_61
                      unemp_female_62_64 = "B23001_157", # unemployed female 62_64
                      unemp_female_65_69 = "B23001_162", # unemployed female 65_69
                      unemp_female_70_74 = "B23001_167", # unemployed female 70_74
                      unemp_female_75_over = "B23001_172", # unemployed female 75_over
                      total_occupied = "B25003_001", # total occupied housing units
                      owner_occupied = "B25003_002", # total owner occupied units
                      foreign_born = "B05006_001", # Foreign-born population excluding population born at sea
                      median_age_male = "B01002_002",
                      median_age_female = "B01002_003",
                      male_18_19 = "B01001_007",
                      male_20 = "B01001_008",
                      male_21 = "B01001_009",
                      male_22_24 = "B01001_010",
                      female_18_19 = "B01001_031",
                      female_20 = "B01001_032",
                      female_21 = "B01001_033",
                      female_22_24 = "B01001_034"
                    ), 
                    state = "CA", survey = "acs5")

acs5_2009_c = get_acs(geography = "county", year = 2009,
                    variables = c(
                      total_pop = "B01003_001",  # TOTAL POPULATION
                      race_white = "B02001_002",
                      race_black = "B02001_003",
                      race_natam = "B02001_004",
                      race_asian = "B02001_005",
                      race_hawpi = "B02001_006",
                      race_2more = "B02001_008",
                      total_hisp = "B03002_012",
                      med_income = "B19013_001", # MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2009 INFLATION-ADJUSTED DOLLARS)
                      pov_pop = "C17002_001",   # RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS. Total population for whom Poverty Status is Determined.
                      pov_0_.5 = "C17002_002", # in poverty, income ratio 0-.5
                      pov_.5_.99 = "C17002_003", # in poverty, income ratio .5 -99
                      labor_total = "B23001_001",
                      unemp_male_16_19 = "B23001_008", # unemployed male 16_19
                      unemp_male_20_21 = "B23001_015", # unemployed male 20_21
                      unemp_male_22_24 = "B23001_022", # unemployed male 22_24
                      unemp_male_25_29 = "B23001_029", # unemployed male 25_29
                      unemp_male_30_34 = "B23001_036", # unemployed male 30_34
                      unemp_male_35_44 = "B23001_043", # unemployed male 35_44
                      unemp_male_45_54 = "B23001_050", # unemployed male 45_54
                      unemp_male_55_59 = "B23001_057", # unemployed male 55_59
                      unemp_male_60_61 = "B23001_064", # unemployed male 60_61
                      unemp_male_62_64 = "B23001_071", # unemployed male 62_64
                      unemp_male_65_69 = "B23001_076", # unemployed male 65_69
                      unemp_male_70_74 = "B23001_081", # unemployed male 70_74
                      unemp_male_75_over = "B23001_086", # unemployed male 75_over
                      unemp_female_16_19 = "B23001_094", # unemployed female 16_19
                      unemp_female_20_21 = "B23001_101", # unemployed female 20_21
                      unemp_female_22_24 = "B23001_108", # unemployed female 22_24
                      unemp_female_25_29 = "B23001_115", # unemployed female 25_29
                      unemp_female_30_34 = "B23001_122", # unemployed female 30_34
                      unemp_female_35_44 = "B23001_129", # unemployed female 35_44
                      unemp_female_45_54 = "B23001_136", # unemployed female 45_54
                      unemp_female_55_59 = "B23001_143", # unemployed female 55_59
                      unemp_female_60_61 = "B23001_150", # unemployed female 60_61
                      unemp_female_62_64 = "B23001_157", # unemployed female 62_64
                      unemp_female_65_69 = "B23001_162", # unemployed female 65_69
                      unemp_female_70_74 = "B23001_167", # unemployed female 70_74
                      unemp_female_75_over = "B23001_172", # unemployed female 75_over
                      total_occupied = "B25003_001", # total occupied housing units
                      owner_occupied = "B25003_002", # total owner occupied units
                      foreign_born = "B05006_001", # Foreign-born population excluding population born at sea
                      median_age_male = "B01002_002",
                      median_age_female = "B01002_003",
                      male_18_19 = "B01001_007",
                      male_20 = "B01001_008",
                      male_21 = "B01001_009",
                      male_22_24 = "B01001_010",
                      female_18_19 = "B01001_031",
                      female_20 = "B01001_032",
                      female_21 = "B01001_033",
                      female_22_24 = "B01001_034"
                    ), 
                    state = "CA", survey = "acs5")

# 2000 census ####

#v00 = load_variables(2000, "sf1", cache = TRUE)
# these are from SF1, which has 100% coverage
census_2000_sf1 = get_decennial(geography = "place", year = 2000,
                     variables = c(
                       total_pop = "P001001",
                       race_white = "P003003",
                       race_black = "P003004",
                       race_natam = "P003005",
                       race_asian = "P003006",
                       race_hawpi = "P003007",
                       race_2more = "P003009",
                       total_hisp = "P011001",
                       total_occupied = "H012001",
                       owner_occupied = "H012002",
                       median_age_male = "P013002",
                       median_age_female = "P013003",
                       male_18_19 = "P012007",
                       male_20 = "P012008",
                       male_21 = "P012009",
                       male_22_24 = "P012010",
                       female_18_19 = "P012031",
                       female_20 = "P012032",
                       female_21 = "P012033",
                       female_22_24 = "P012034"
                     ),
                     state = "CA", sumfile = "sf1")

# this is from sf3 which is a sample (16%)
census_2000_sf3 = get_decennial(geography = "place", year = 2000,
                     variables = c(
                       med_income = "P053001",
                       pov_pop = "P088001",
                       pov_0_.5 = "P088002",
                       pov_.5_.74 = "P088003",
                       pov_.75_.99 = "P088004",
                       labor_total = "P038001",
                       unemployed_over16_school = "P038012",
                       unemployed_over16_hsgrad = "P038017",
                       unemployed_over16_nograd = "P038021",
                       foreign_born = "PCT019001"
                     ),
                     state = "CA", sumfile = "sf3")

census_2000_sf1_c = get_decennial(geography = "county", year = 2000,
                                variables = c(
                                  total_pop = "P001001",
                                  race_white = "P003003",
                                  race_black = "P003004",
                                  race_natam = "P003005",
                                  race_asian = "P003006",
                                  race_hawpi = "P003007",
                                  race_2more = "P003009",
                                  total_hisp = "P011001",
                                  total_occupied = "H012001",
                                  owner_occupied = "H012002",
                                  median_age_male = "P013002",
                                  median_age_female = "P013003",
                                  male_18_19 = "P012007",
                                  male_20 = "P012008",
                                  male_21 = "P012009",
                                  male_22_24 = "P012010",
                                  female_18_19 = "P012031",
                                  female_20 = "P012032",
                                  female_21 = "P012033",
                                  female_22_24 = "P012034"
                                ),
                                state = "CA", sumfile = "sf1")

# this is from sf3 which is a sample (16%)
census_2000_sf3_c = get_decennial(geography = "county", year = 2000,
                                variables = c(
                                  med_income = "P053001",
                                  pov_pop = "P088001",
                                  pov_0_.5 = "P088002",
                                  pov_.5_.74 = "P088003",
                                  pov_.75_.99 = "P088004",
                                  labor_total = "P038001",
                                  unemployed_over16_school = "P038012",
                                  unemployed_over16_hsgrad = "P038017",
                                  unemployed_over16_nograd = "P038021",
                                  foreign_born = "PCT019001"
                                ),
                                state = "CA", sumfile = "sf3")

# save raw census data ####

write.csv(census_2000_sf1, "./data/census_data/census_2000_sf1.csv", row.names = FALSE)
write.csv(census_2000_sf3, "./data/census_data/census_2000_sf3.csv", row.names = FALSE)

write.csv(acs5_2009, "./data/census_data/acs5_2009.csv", row.names = FALSE)
write.csv(acs5_2010, "./data/census_data/acs5_2010.csv", row.names = FALSE)
write.csv(acs5_2011, "./data/census_data/acs5_2011.csv", row.names = FALSE)
write.csv(acs5_2012, "./data/census_data/acs5_2012.csv", row.names = FALSE)
write.csv(acs5_2013, "./data/census_data/acs5_2013.csv", row.names = FALSE)
write.csv(acs5_2014, "./data/census_data/acs5_2014.csv", row.names = FALSE)
write.csv(acs5_2015, "./data/census_data/acs5_2015.csv", row.names = FALSE)
write.csv(acs5_2016, "./data/census_data/acs5_2016.csv", row.names = FALSE)
write.csv(acs5_2017, "./data/census_data/acs5_2017.csv", row.names = FALSE)
write.csv(acs5_2018, "./data/census_data/acs5_2018.csv", row.names = FALSE)
write.csv(acs5_2019, "./data/census_data/acs5_2019.csv", row.names = FALSE)
write.csv(acs5_2020, "./data/census_data/acs5_2020.csv", row.names = FALSE)

write.csv(census_2000_sf1_c, "./data/census_data/census_2000_sf1_c.csv", row.names = FALSE)
write.csv(census_2000_sf3_c, "./data/census_data/census_2000_sf3_c.csv", row.names = FALSE)

write.csv(acs5_2009_c, "./data/census_data/acs5_2009_c.csv", row.names = FALSE)
write.csv(acs5_2010_c, "./data/census_data/acs5_2010_c.csv", row.names = FALSE)
write.csv(acs5_2011_c, "./data/census_data/acs5_2011_c.csv", row.names = FALSE)
write.csv(acs5_2012_c, "./data/census_data/acs5_2012_c.csv", row.names = FALSE)
write.csv(acs5_2013_c, "./data/census_data/acs5_2013_c.csv", row.names = FALSE)
write.csv(acs5_2014_c, "./data/census_data/acs5_2014_c.csv", row.names = FALSE)
write.csv(acs5_2015_c, "./data/census_data/acs5_2015_c.csv", row.names = FALSE)
write.csv(acs5_2016_c, "./data/census_data/acs5_2016_c.csv", row.names = FALSE)
write.csv(acs5_2017_c, "./data/census_data/acs5_2017_c.csv", row.names = FALSE)
write.csv(acs5_2018_c, "./data/census_data/acs5_2018_c.csv", row.names = FALSE)
write.csv(acs5_2019_c, "./data/census_data/acs5_2019_c.csv", row.names = FALSE)
write.csv(acs5_2020_c, "./data/census_data/acs5_2020_c.csv", row.names = FALSE)
