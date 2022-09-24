# transform variables into usable forms

# setup ####
source("./scripts/consumer_price_index.R")

# data laod ####
forf = read.csv("./data/intermediate_data/12_dept_policy.csv", header = TRUE, stringsAsFactors = FALSE)
forf = unique(forf)

# interpolate values?

.interpolate = TRUE

# drop unwanted variables ####

forf = forf[, !(colnames(forf) %in% c("estimated_population_rev", "gov_type"))]

# Interpolate census data 2000-2009 ####

if(.interpolate){
  
  ## interpolate between known values ####
  
  forf_cache = by(forf, forf$name, FUN = function(agency){
    
    # order by year
    agency = agency[order(agency$year),]
    
    # loop though variables of interest
    .interest = c("estimate.total_pop", "estimate.race_white", "estimate.race_black", "estimate.race_natam", "estimate.race_asian", "estimate.race_hawpi", "estimate.race_2more", "estimate.total_hisp", "estimate.total_occupied", "estimate.owner_occupied", "estimate.median_age_male", "estimate.median_age_female", "estimate.med_income", "estimate.labor_total", "estimate.foreign_born", "estimate.unemployed_over16", "estimate.pov_pop", "estimate.pov_true", "estimate.male_18_24", "estimate.female_18_24")
    
    for(vri in .interest){
      
      # are there at least 2 non-na values?
      if(sum(!is.na(agency[, vri])) > 1){
        
        # then interpolate between points
        agency[, vri] = zoo::na.approx(agency[, vri], na.rm = FALSE)
        
      }
      
    }
    
    # retrun back df
    return(agency)
    
  })
  
  # View(test[,c("name", "year", "estimate.total_pop", "estimate.total_pop_interpolate")])
  
  forf = plyr::rbind.fill(forf_cache)
  rm(forf_cache)
  
}

# Race variables ####

## change census race raw counts to percents ####

forf$jur_perc_white = (forf$estimate.race_white / forf$estimate.total_pop) * 100
forf$jur_perc_black = (forf$estimate.race_black / forf$estimate.total_pop) * 100
forf$jur_perc_natam = (forf$estimate.race_natam / forf$estimate.total_pop) * 100
forf$jur_perc_asian = (forf$estimate.race_asian / forf$estimate.total_pop) * 100
forf$jur_perc_hawpi = (forf$estimate.race_hawpi / forf$estimate.total_pop) * 100
forf$jur_perc_2more = (forf$estimate.race_2more / forf$estimate.total_pop) * 100
forf$jur_perc_hisp = (forf$estimate.total_hisp / forf$estimate.total_pop) * 100

## change department race counts to percentages ####

forf$pol_perc_ft_white = (forf$WHITE / forf$FTSWORN) * 100
forf$pol_perc_ft_black = (forf$BLACK / forf$FTSWORN) * 100
forf$pol_perc_ft_hisp = (forf$HISPANIC / forf$FTSWORN) * 100
forf$pol_perc_ft_asian = (forf$ASIAN / forf$FTSWORN) * 100
forf$pol_perc_ft_hawpi = (forf$NATHAW / forf$FTSWORN) * 100
forf$pol_perc_ft_natam = (forf$AMERIND / forf$FTSWORN) * 100
forf$pol_perc_ft_2more = (forf$MULTRACE / forf$FTSWORN) * 100
forf$pol_perc_ft_unk = (forf$UNKRACE / forf$FTSWORN) * 100

## Create race quintiles ####

forf$jur_quint_white = floor(forf$jur_perc_white / 20) + 1
forf$jur_quint_black = floor(forf$jur_perc_black / 20) + 1
forf$jur_quint_natam = floor(forf$jur_perc_natam / 20) + 1
forf$jur_quint_asian = floor(forf$jur_perc_asian / 20) + 1
forf$jur_quint_hawpi = floor(forf$jur_perc_hawpi / 20) + 1
forf$jur_quint_2more = floor(forf$jur_perc_2more / 20) + 1
forf$jur_quint_hisp =  floor(forf$jur_perc_hisp  / 20) + 1

## create race z scores ####

forf$jur_z_white = (forf$jur_perc_white - mean(forf$jur_perc_white, na.rm = TRUE)) / sd(forf$jur_perc_white, na.rm = TRUE)
forf$jur_z_black = (forf$jur_perc_black - mean(forf$jur_perc_black, na.rm = TRUE)) / sd(forf$jur_perc_black, na.rm = TRUE)
forf$jur_z_natam = (forf$jur_perc_natam - mean(forf$jur_perc_natam, na.rm = TRUE)) / sd(forf$jur_perc_natam, na.rm = TRUE)
forf$jur_z_asian = (forf$jur_perc_asian - mean(forf$jur_perc_asian, na.rm = TRUE)) / sd(forf$jur_perc_asian, na.rm = TRUE)
forf$jur_z_hawpi = (forf$jur_perc_hawpi - mean(forf$jur_perc_hawpi, na.rm = TRUE)) / sd(forf$jur_perc_hawpi, na.rm = TRUE)
forf$jur_z_2more = (forf$jur_perc_2more - mean(forf$jur_perc_2more, na.rm = TRUE)) / sd(forf$jur_perc_2more, na.rm = TRUE)
forf$jur_z_hisp =  (forf$jur_perc_hisp  - mean(forf$jur_perc_hisp , na.rm = TRUE)) / sd(forf$jur_perc_hisp , na.rm = TRUE)

# poverty percent ####

forf$jur_perc_pov = (forf$estimate.pov_true / forf$estimate.pov_pop) * 100

# rm raw poverty variables
forf = forf = forf[, !(colnames(forf) %in% c("estimate.pov_true", "estimate.pov_pop"))]

# create variable for percent home owners ####

forf$jur_perc_home_own = (forf$estimate.owner_occupied / forf$estimate.total_occupied) * 100

# create variable for percent non-citizen ####

forf$jur_perc_foreign_born = (forf$estimate.foreign_born / forf$estimate.total_pop) * 100

# create variable for percent 18-24 ####

forf$jur_perc_male_18_24 = (forf$estimate.male_18_24 / forf$estimate.total_pop) * 100
forf$jur_perc_female_18_24 = (forf$estimate.female_18_24 / forf$estimate.total_pop) * 100


# create drug arrests estimates for cities ####

## subset forf for population
pop_key = forf[,c("name", "county", "year", "estimate.total_pop")]
pop_key = pop_key[grepl("sheriff", pop_key$name), ]
pop_key = unique(pop_key[,-1])
pop_key = pop_key[!is.na(pop_key$estimate.total_pop),]
colnames(pop_key)[3] = "county_pop"

## subset forf for drug data
drug_key = forf[, c("name", "year", "county", "r_drug_off")]
drug_key = drug_key[grepl("sheriff", drug_key$name), ]
drug_key = unique(drug_key[,-1])
drug_key = drug_key[!is.na(drug_key$r_drug_off),]

## merge pop and drug keys
keys = merge(pop_key, drug_key)

## subset forf to work with
working = forf[, c("name", "year", "county", "estimate.total_pop", "r_drug_off")]

# by row, make drug estimate if not one already and population available
working = apply(working, 1, FUN = function(drow){
  
  drow = as.data.frame(t(drow), stringsAsFactors = FALSE)
  
  # if there is already a value in e_drug_off, skip
  # this is an actual value from r_drug_off
  if(!is.na(drow$r_drug_off)){drow$e_drug_off = drow$r_drug_off; return(drow)}
  
  # otherwise create estimate using city population, county population, and drug numbers
  county_pop = keys[keys$county == drow$county & keys$year == drow$year, "county_pop"]
  if(length(county_pop) != 1){county_pop = NA}
  county_drugs = keys[keys$county == drow$county & keys$year == drow$year, "r_drug_off"]
  if(length(county_drugs) != 1){county_drugs = NA}
  
  # test for NAs, if NA, return as is
  if(any(is.na(county_pop), is.na(county_drugs), is.na(drow$estimate.total_pop))){drow$e_drug_off = drow$r_drug_off; return(drow)}
  
  #browser()
  
  drow$e_drug_off = (as.numeric(drow$estimate.total_pop) * county_drugs) / county_pop
  
  return(drow)
  
})

working = do.call(rbind, working)
working$estimate.total_pop = as.numeric(working$estimate.total_pop)
working$e_drug_off = as.numeric(working$e_drug_off)

# merge that back with full forf dataset

forf = merge(forf, working[,c("name", "year", "e_drug_off")])

# make simple estimate for now as above under estiamtes ####

## subset forf for drug data
drug_key = forf[, c("year", "county", "r_drug_off")]
# make a key of drug arrests per county
drug_key = drug_key[!is.na(drug_key$r_drug_off),]

# get the naive drug off column
buffer = merge(forf[, !(colnames(forf) %in% c("r_drug_off"))], drug_key, by = c("county", "year"), all.x = TRUE)

# put it in forf
forf$se_drug_off = buffer$r_drug_off

# make rates per 10000 people for violent, property, drug crime ####

forf$violent_r_10000 = (forf$Violent_sum / forf$estimate.total_pop) * 10000
forf$property_r_10000 = (forf$Property_sum / forf$estimate.total_pop) * 10000
forf$drug_r_10000 = (forf$se_drug_off / forf$estimate.total_pop) * 10000

# Make num and amount z scores ####

forf$num_forfeitures_z = (forf$num_forfeitures - mean(forf$num_forfeitures, na.rm = TRUE)) / sd(forf$num_forfeitures, na.rm = TRUE)
forf$mean_forfeitures_z = (forf$mean_forfeitures - mean(forf$mean_forfeitures, na.rm = TRUE)) / sd(forf$mean_forfeitures, na.rm = TRUE)
forf$median_forfeitures_z = (forf$median_forfeitures - mean(forf$median_forfeitures, na.rm = TRUE)) / sd(forf$median_forfeitures, na.rm = TRUE)

# Make diversity index for jurisdictions ####

# function from https://github.com/DLEIVA/diversity/blob/master/R/blau.index.R

# X: A string vector with categorical data.
# categories: The number of possible categories for the random variable.

# A perfectly homogeneous group would receive a score of 0, while a perfectly heterogeneous group (with members spread evenly among an infinitesimal number of categories) would receive a score of 1. 

blau.index <- function (X,categories)
{
  if (!is.character(X)) cat('ERROR: String vector should be specified in X.
      \n')
  else {
    blau.index <- 1-sum(prop.table(table(X))**2)
    n <- length(X)
    k <- categories
    a <- n - k * floor(n / k)
    blau.max <- (n**2*(k-1)+a*(a-k))/(k*n**2)
    blau.norm <- blau.index/blau.max
    res <- list(call = match.call(),categories = categories,
                blau.index = blau.index, blau.max = blau.max, blau.norm = blau.norm)
    class(res) <- "blau"
    res
  }
}

# apply by case across race quintiles
forf$jur_race_quint_blau = apply(forf, 1, FUN = function(jur_vec){
  
  blau = blau.index(as.character(
    jur_vec[c("jur_quint_white", "jur_quint_black", "jur_quint_natam", "jur_quint_asian", "jur_quint_hawpi", "jur_quint_2more", "jur_quint_hisp")]
    ), 5)$blau.index
  
  return(blau)
  
})

# all perfect 1s set to NA (is 1 if all input are NA)
forf$jur_race_quint_blau[forf$jur_race_quint_blau == 1] = NA

# add variables for growing minority populations 2000-2010 ####

# get all cases that are 2000 or 2010
change_df = forf[forf$year == 2000 | forf$year == 2010, ]

# split sheriff and police
change_sheriff = change_df[grepl(change_df$name, pattern = "sheriff"), ]
change_police = change_df[!grepl(change_df$name, pattern = "sheriff"), ]

# for sheriff, group by county
#by(change_sheriff, INDICES = list(change_sheriff$county), FUN = function(county){
#  
#  # if they don't have at least two rows (2000 and 2010), pass
#  if(nrow(county) != 2){next}
#  
#  
#  
#  
#  
#  
#  
#  
#  
#  
#  
#  
#  
#  
#  
#  
#  
#  
#  
#  
#})


# adjust all dollars to 2020 values using consumer price index average ####

forf_list = by(forf, factor(forf$year), FUN = function(year_df){
  
  # for each year, adjust the following columns into 2020 dollars
  
  # get the year
  year = year_df$year[1]
  
  # OPBUDGET
  year_df$OPBUDGET = inflation_convert(usd_amount = year_df$OPBUDGET, base_year = year, target_year = 2020)
  # ASSETFOR
  year_df$ASSETFOR = inflation_convert(usd_amount = year_df$ASSETFOR, base_year = year, target_year = 2020)
  # CHIEFMIN
  year_df$CHIEFMIN = inflation_convert(usd_amount = year_df$CHIEFMIN, base_year = year, target_year = 2020)
  # CHIEFMAX
  year_df$CHIEFMAX = inflation_convert(usd_amount = year_df$CHIEFMAX, base_year = year, target_year = 2020)
  # SGTMIN
  year_df$SGTMIN = inflation_convert(usd_amount = year_df$SGTMIN, base_year = year, target_year = 2020)
  # SGTMAX
  year_df$SGTMAX = inflation_convert(usd_amount = year_df$SGTMAX, base_year = year, target_year = 2020)
  # ENTRYMIN
  year_df$ENTRYMIN = inflation_convert(usd_amount = year_df$ENTRYMIN, base_year = year, target_year = 2020)
  # ENTRYMAX
  year_df$ENTRYMAX = inflation_convert(usd_amount = year_df$ENTRYMAX, base_year = year, target_year = 2020)
  # total_revenue
  year_df$total_revenue = inflation_convert(usd_amount = year_df$total_revenue, base_year = year, target_year = 2020)
  # amount_forfeitures
  year_df$amount_forfeitures = inflation_convert(usd_amount = year_df$amount_forfeitures, base_year = year, target_year = 2020)
  # mean_forfeitures
  year_df$mean_forfeitures = inflation_convert(usd_amount = year_df$mean_forfeitures, base_year = year, target_year = 2020)
  # estimate.med_income
  year_df$estimate.med_income = inflation_convert(usd_amount = year_df$estimate.med_income, base_year = year, target_year = 2020)
  
  # return
  return(year_df)
})

# return to df
forf_adjust = do.call(rbind, forf_list)

# make rate
forf_adjust$revenue_r_10000 = (forf_adjust$total_revenue / forf_adjust$estimate.total_pop) * 10000

# save out ####

if(.interpolate){write.csv(forf_adjust, "./data/complete_data_interpolated.csv", row.names = FALSE)} else {
  write.csv(forf_adjust, "./data/complete_data.csv", row.names = FALSE)}

