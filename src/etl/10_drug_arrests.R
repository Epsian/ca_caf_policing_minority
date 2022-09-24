# to add drug arrest data to database

# setup ####

# data load ####

# load in drug data
drug = read.csv("./data/OnlineArrestData1980-2019.csv", header = TRUE, stringsAsFactors = FALSE)

# load in rest of dataset
forf = read.csv("./data/intermediate_data/9_census_full_data.csv", header = TRUE, stringsAsFactors = FALSE)

# transform drug data ####

# drop prior to 1999
drug = drug[drug$YEAR >= 1999,]

# sum all crimes by year and county
drug_list = by(drug, INDICES = list(drug$YEAR, drug$COUNTY), FUN = function(block){
  
  # sum all drug offenses for county in year
  block_sums = data.frame("year" = block$YEAR[1], "county" = block$COUNTY[1], "r_drug_off" = sum(block$F_DRUGOFF, na.rm = TRUE), stringsAsFactors = FALSE)
  
  # output
  return(block_sums)
  
})

drug_df = do.call(rbind, drug_list)

# clean county column
drug_df$county = tolower(drug_df$county)
drug_df$county = gsub(" county", "", drug_df$county)

# merge with rest of data ####

# split data by sherrif and police, as we have raw numbers for counties but not cities
s_forf = forf[grepl("sheriff$", forf$name), ] # sheriff
o_forf = forf[!grepl("sheriff$", forf$name), ] # other

# merge raw drug arrests with sheriff rows (county level)
s_forf = merge(s_forf, drug_df, by = c("year", "county"), all.x = TRUE)

# merge back with others
## make blank column to allow rbind
o_forf$r_drug_off = NA
## r bind rows back
forf = rbind(s_forf, o_forf)

# save out ####

write.csv(forf, "./data/intermediate_data/10_drug_data.csv", row.names = FALSE)





