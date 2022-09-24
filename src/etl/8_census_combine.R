# to combine census data together

# setup ####

# read in place data
census_2000_sf1 = read.csv("./data/census_data/census_2000_sf1.csv", header = TRUE, stringsAsFactors = FALSE)
census_2000_sf3 = read.csv("./data/census_data/census_2000_sf3.csv", header = TRUE, stringsAsFactors = FALSE)

acs5_2009 = read.csv("./data/census_data/acs5_2009.csv", header = TRUE, stringsAsFactors = FALSE)
acs5_2010 = read.csv("./data/census_data/acs5_2010.csv", header = TRUE, stringsAsFactors = FALSE)
acs5_2011 = read.csv("./data/census_data/acs5_2011.csv", header = TRUE, stringsAsFactors = FALSE)
acs5_2012 = read.csv("./data/census_data/acs5_2012.csv", header = TRUE, stringsAsFactors = FALSE)
acs5_2013 = read.csv("./data/census_data/acs5_2013.csv", header = TRUE, stringsAsFactors = FALSE)
acs5_2014 = read.csv("./data/census_data/acs5_2014.csv", header = TRUE, stringsAsFactors = FALSE)
acs5_2015 = read.csv("./data/census_data/acs5_2015.csv", header = TRUE, stringsAsFactors = FALSE)
acs5_2016 = read.csv("./data/census_data/acs5_2016.csv", header = TRUE, stringsAsFactors = FALSE)
acs5_2017 = read.csv("./data/census_data/acs5_2017.csv", header = TRUE, stringsAsFactors = FALSE)
acs5_2018 = read.csv("./data/census_data/acs5_2018.csv", header = TRUE, stringsAsFactors = FALSE)
acs5_2019 = read.csv("./data/census_data/acs5_2019.csv", header = TRUE, stringsAsFactors = FALSE)
acs5_2020 = read.csv("./data/census_data/acs5_2020.csv", header = TRUE, stringsAsFactors = FALSE)

# read in county data
census_2000_sf1_c = read.csv("./data/census_data/census_2000_sf1_c.csv", header = TRUE, stringsAsFactors = FALSE)
census_2000_sf3_c = read.csv("./data/census_data/census_2000_sf3_c.csv", header = TRUE, stringsAsFactors = FALSE)

acs5_2009_c = read.csv("./data/census_data/acs5_2009_c.csv", header = TRUE, stringsAsFactors = FALSE)
acs5_2010_c = read.csv("./data/census_data/acs5_2010_c.csv", header = TRUE, stringsAsFactors = FALSE)
acs5_2011_c = read.csv("./data/census_data/acs5_2011_c.csv", header = TRUE, stringsAsFactors = FALSE)
acs5_2012_c = read.csv("./data/census_data/acs5_2012_c.csv", header = TRUE, stringsAsFactors = FALSE)
acs5_2013_c = read.csv("./data/census_data/acs5_2013_c.csv", header = TRUE, stringsAsFactors = FALSE)
acs5_2014_c = read.csv("./data/census_data/acs5_2014_c.csv", header = TRUE, stringsAsFactors = FALSE)
acs5_2015_c = read.csv("./data/census_data/acs5_2015_c.csv", header = TRUE, stringsAsFactors = FALSE)
acs5_2016_c = read.csv("./data/census_data/acs5_2016_c.csv", header = TRUE, stringsAsFactors = FALSE)
acs5_2017_c = read.csv("./data/census_data/acs5_2017_c.csv", header = TRUE, stringsAsFactors = FALSE)
acs5_2018_c = read.csv("./data/census_data/acs5_2018_c.csv", header = TRUE, stringsAsFactors = FALSE)
acs5_2019_c = read.csv("./data/census_data/acs5_2019_c.csv", header = TRUE, stringsAsFactors = FALSE)
acs5_2020_c = read.csv("./data/census_data/acs5_2020_c.csv", header = TRUE, stringsAsFactors = FALSE)

# transform acs5 data ####

## combine groups for better moes ####

### function to combine
subgroup_combine_inner = function(place, vars, newvar){
  # following this census guide
  # https://www.census.gov/content/dam/Census/library/publications/2018/acs/acs_general_handbook_2018_ch08.pdf
  
  # get group sum
  gsum = sum(place[place$variable %in% vars, "estimate"])
  # get new moe
  gmoe = sqrt(sum(place[place$variable %in% vars, "moe"] ^ 2))
  
  # return new row
  return(c(place$GEOID[1], place$NAME[1], newvar, gsum, gmoe))
  
}

### function to combine all groups of interest

subgroup_combine_outer = function(acs_data){
  
  # for each place, do the combinations
  combined_vars = by(acs_data, INDICES = as.factor(acs_data$NAME), FUN = function(place){
    
    place = rbind(place,
                  # combine male age
                  subgroup_combine_inner(place, c("male_18_19", "male_20", "male_21", "male_22_24"), "male_18_24"),
                  # combine female age
                  subgroup_combine_inner(place, c("female_18_19", "female_20", "female_21", "female_22_24"), "female_18_24"),
                  # combine poverty
                  subgroup_combine_inner(place, c("pov_0_.5", "pov_.5_.99"), "pov_true")
    )
    
    # remove pov varaibles
    place = place[place$variable != "pov_0_.5" & place$variable != "pov_.5_.99", ]
    
    # combine unemployment for 2010 + 2009
    if("unemp_male_16_19" %in% place$variable){
      
      place$estimate = as.numeric(place$estimate)
      place$moe = as.numeric(place$moe)
      
      # combine all unemployment into one over 16 measure to match other years
      place = rbind(place,
                    subgroup_combine_inner(place, c("unemp_male_16_19", "unemp_male_20_21", "unemp_male_22_24", "unemp_male_25_29", "unemp_male_30_34", "unemp_male_35_44", "unemp_male_45_54", "unemp_male_55_59", "unemp_male_60_61", "unemp_male_62_64", "unemp_male_65_69", "unemp_male_70_74", "unemp_male_75_over", "unemp_female_16_19", "unemp_female_20_21", "unemp_female_22_24", "unemp_female_25_29", "unemp_female_30_34", "unemp_female_35_44", "unemp_female_45_54", "unemp_female_55_59", "unemp_female_60_61", "unemp_female_62_64", "unemp_female_65_69", "unemp_female_70_74", "unemp_female_75_over"), "unemployed_over16")
                    )
      
      place = place[!(place$variable %in% c("unemp_male_16_19", "unemp_male_20_21", "unemp_male_22_24", "unemp_male_25_29", "unemp_male_30_34", "unemp_male_35_44", "unemp_male_45_54", "unemp_male_55_59", "unemp_male_60_61", "unemp_male_62_64", "unemp_male_65_69", "unemp_male_70_74", "unemp_male_75_over", "unemp_female_16_19", "unemp_female_20_21", "unemp_female_22_24", "unemp_female_25_29", "unemp_female_30_34", "unemp_female_35_44", "unemp_female_45_54", "unemp_female_55_59", "unemp_female_60_61", "unemp_female_62_64", "unemp_female_65_69", "unemp_female_70_74", "unemp_female_75_over")), ]
      
    }
    
    # fix types
    place$estimate = as.numeric(place$estimate)
    place$moe = as.numeric(place$moe)
    
    # return
    return(place)
  })
  
  # bind back to df
  combined_vars = do.call(rbind, combined_vars)
  
  # return
  return(combined_vars)
  
}

### combine ####

acs5_2009 = subgroup_combine_outer(acs5_2009)
acs5_2010 = subgroup_combine_outer(acs5_2010)
acs5_2011 = subgroup_combine_outer(acs5_2011)
acs5_2012 = subgroup_combine_outer(acs5_2012)
acs5_2013 = subgroup_combine_outer(acs5_2013)
acs5_2014 = subgroup_combine_outer(acs5_2014)
acs5_2015 = subgroup_combine_outer(acs5_2015)
acs5_2016 = subgroup_combine_outer(acs5_2016)
acs5_2017 = subgroup_combine_outer(acs5_2017)
acs5_2018 = subgroup_combine_outer(acs5_2018)
acs5_2019 = subgroup_combine_outer(acs5_2019)
acs5_2020 = subgroup_combine_outer(acs5_2020)

acs5_2009_c = subgroup_combine_outer(acs5_2009_c)
acs5_2010_c = subgroup_combine_outer(acs5_2010_c)
acs5_2011_c = subgroup_combine_outer(acs5_2011_c)
acs5_2012_c = subgroup_combine_outer(acs5_2012_c)
acs5_2013_c = subgroup_combine_outer(acs5_2013_c)
acs5_2014_c = subgroup_combine_outer(acs5_2014_c)
acs5_2015_c = subgroup_combine_outer(acs5_2015_c)
acs5_2016_c = subgroup_combine_outer(acs5_2016_c)
acs5_2017_c = subgroup_combine_outer(acs5_2017_c)
acs5_2018_c = subgroup_combine_outer(acs5_2018_c)
acs5_2019_c = subgroup_combine_outer(acs5_2019_c)
acs5_2020_c = subgroup_combine_outer(acs5_2020_c)

## make function to clean and transform acs 5 data ####

ct_acs5 = function(acs5_raw_long){
  
  # !!! FOR NOW fill any missing moe with 0, as it always happens with population and num hispanic. There is a pattern here I need to research. Seems more data artifact than random.
  acs5_raw_long[is.na(acs5_raw_long$moe), "moe"] = 0
  
  # calculate coefficient of variation
  # use 1.645 for a 90% confidence interval
  acs5_raw_long$cov = ((acs5_raw_long$moe/1.645)/acs5_raw_long$estimate) * 100
  
  # drop any with NA in estimates
  acs5_raw_long = acs5_raw_long[!is.na(acs5_raw_long$estimate),]
  
  # drop any nans from divide by 0
  acs5_raw_long = acs5_raw_long[!is.nan(acs5_raw_long$cov),]
  
  # drop any with cov > 40, following white-paper guide for low-reliability
  acs5_raw_long = acs5_raw_long[acs5_raw_long$cov < 40,]
  
  # long to wide census data, dropping cov and moe
  acs5_wide = reshape(acs5_raw_long, idvar = c("NAME", "GEOID"), timevar = "variable", drop = c("moe", "cov"), direction = "wide")
  
  # out
  return(acs5_wide)
}

## transform acs5 dataframes ####

acs5_2009 = ct_acs5(acs5_2009)
acs5_2010 = ct_acs5(acs5_2010)
acs5_2011 = ct_acs5(acs5_2011)
acs5_2012 = ct_acs5(acs5_2012)
acs5_2013 = ct_acs5(acs5_2013)
acs5_2014 = ct_acs5(acs5_2014)
acs5_2015 = ct_acs5(acs5_2015)
acs5_2016 = ct_acs5(acs5_2016)
acs5_2017 = ct_acs5(acs5_2017)
acs5_2018 = ct_acs5(acs5_2018)
acs5_2019 = ct_acs5(acs5_2019)
acs5_2020 = ct_acs5(acs5_2020)

acs5_2009_c = ct_acs5(acs5_2009_c)
acs5_2010_c = ct_acs5(acs5_2010_c)
acs5_2011_c = ct_acs5(acs5_2011_c)
acs5_2012_c = ct_acs5(acs5_2012_c)
acs5_2013_c = ct_acs5(acs5_2013_c)
acs5_2014_c = ct_acs5(acs5_2014_c)
acs5_2015_c = ct_acs5(acs5_2015_c)
acs5_2016_c = ct_acs5(acs5_2016_c)
acs5_2017_c = ct_acs5(acs5_2017_c)
acs5_2018_c = ct_acs5(acs5_2018_c)
acs5_2019_c = ct_acs5(acs5_2019_c)
acs5_2020_c = ct_acs5(acs5_2020_c)

# transform census data ####

## make function to work on census data ####

ct_census = function(census_sf1, census_sf3){
  
  # fix one random name that is different between the census tables
  census_sf3$NAME[census_sf3$NAME == "La Canada Flintridge city, California"] = "La Cañada Flintridge city, California"
  
  # rename value column to estimate to match acs5
  colnames(census_sf1)[colnames(census_sf1) == "value"] = "estimate"
  colnames(census_sf3)[colnames(census_sf3) == "value"] = "estimate"
  
  # long to wide census data, dropping cov and moe
  census_sf1_wide = reshape(census_sf1, idvar = c("NAME", "GEOID"), timevar = "variable", direction = "wide")
  census_sf3_wide = reshape(census_sf3, idvar = c("NAME", "GEOID"), timevar = "variable", direction = "wide")
  
  # combine sf1 and sf3
  census_total = merge(census_sf1_wide, census_sf3_wide, all = TRUE)
  
  # combine poverty variables
  census_total$estimate.pov_true = rowSums(census_total[, c("estimate.pov_0_.5", "estimate.pov_.5_.74", "estimate.pov_.75_.99")], na.rm = TRUE)
  census_total = census_total[ , !(colnames(census_total) %in% c("estimate.pov_0_.5", "estimate.pov_.5_.74", "estimate.pov_.75_.99"))]
  
  # combine unemployment variables
  census_total$estimate.unemployed_over16 = rowSums(census_total[, c("estimate.unemployed_over16_school", "estimate.unemployed_over16_hsgrad", "estimate.unemployed_over16_nograd")], na.rm = TRUE)
  census_total = census_total[ , !(colnames(census_total) %in% c("estimate.unemployed_over16_school", "estimate.unemployed_over16_hsgrad", "estimate.unemployed_over16_nograd"))]
  
  # combine age/sex variables
  census_total$estimate.male_18_24 = rowSums(census_total[, c("estimate.male_18_19", "estimate.male_20", "estimate.male_21", "estimate.male_22_24")], na.rm = TRUE)
  census_total$estimate.female_18_24 = rowSums(census_total[, c("estimate.female_18_19", "estimate.female_20", "estimate.female_21", "estimate.female_22_24")], na.rm = TRUE)
  
  # return
  return(census_total)
  
}

## transform census dataframes ####

census_2000 = ct_census(census_2000_sf1, census_2000_sf3)
census_2000_c = ct_census(census_2000_sf1_c, census_2000_sf3_c)

# add year ####

census_2000$year = 2000

acs5_2009$year = 2009
acs5_2010$year = 2010
acs5_2011$year = 2011
acs5_2012$year = 2012
acs5_2013$year = 2013
acs5_2014$year = 2014
acs5_2015$year = 2015
acs5_2016$year = 2016
acs5_2017$year = 2017
acs5_2018$year = 2018
acs5_2019$year = 2019
acs5_2020$year = 2020

census_2000_c$year = 2000

acs5_2009_c$year = 2009
acs5_2010_c$year = 2010
acs5_2011_c$year = 2011
acs5_2012_c$year = 2012
acs5_2013_c$year = 2013
acs5_2014_c$year = 2014
acs5_2015_c$year = 2015
acs5_2016_c$year = 2016
acs5_2017_c$year = 2017
acs5_2018_c$year = 2018
acs5_2019_c$year = 2019
acs5_2020_c$year = 2020

# combine census years together ####

total_census = rbind(census_2000, census_2000_c, acs5_2009_c, acs5_2010_c, acs5_2011_c, acs5_2012_c, acs5_2013_c, acs5_2014_c, acs5_2015_c, acs5_2016_c, acs5_2017_c, acs5_2018_c, acs5_2019_c, acs5_2020_c, acs5_2009, acs5_2010, acs5_2011, acs5_2012, acs5_2013, acs5_2014, acs5_2015, acs5_2016, acs5_2017, acs5_2018, acs5_2019, acs5_2020)

# clean out individual dfs
rm(census_2000, census_2000_c, acs5_2009_c, acs5_2010_c, acs5_2011_c, acs5_2012_c, acs5_2013_c, acs5_2014_c, acs5_2015_c, acs5_2016_c, acs5_2017_c, acs5_2018_c, acs5_2019_c, acs5_2020_c, acs5_2009, acs5_2010, acs5_2011, acs5_2012, acs5_2013, acs5_2014, acs5_2015, acs5_2016, acs5_2017, acs5_2018, acs5_2019, acs5_2020)

# Noli revision - group into 5 year chunks ####

# make new 5 year chunks
g20 = total_census[total_census$year == 2020, ]
g19 = total_census[total_census$year == 2020, ]
g18 = total_census[total_census$year == 2020, ]
g17 = total_census[total_census$year == 2020, ]
g16 = total_census[total_census$year == 2020, ]
g15 = total_census[total_census$year == 2015, ]
g14 = total_census[total_census$year == 2015, ]
g13 = total_census[total_census$year == 2015, ]
g12 = total_census[total_census$year == 2015, ]
g11 = total_census[total_census$year == 2015, ]
g10 = total_census[total_census$year == 2010, ]
g09 = total_census[total_census$year == 2010, ]
g00 = total_census[total_census$year == 2000, ]

# change years
g20$year = 2020
g19$year = 2019
g18$year = 2018
g17$year = 2017
g16$year = 2016
g15$year = 2015
g14$year = 2014
g13$year = 2013
g12$year = 2012
g11$year = 2011
g10$year = 2010
g09$year = 2009
g00$year = 2000

# bind together
grouped_years = rbind(g20, g19, g18, g17, g16, g15, g14, g13, g12, g11, g10, g09, g00)

# output ####

# save out
write.csv(grouped_years, "./data/census_data/total_census.csv", row.names = FALSE)




