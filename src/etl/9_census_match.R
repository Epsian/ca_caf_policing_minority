# to match census data with forfeiture data

# setup ####

# data load
forf = read.csv("./data/intermediate_data/7_report_context.csv", header = TRUE, stringsAsFactors = FALSE)
census = read.csv("./data/census_data/total_census.csv", header = TRUE, stringsAsFactors = FALSE)

# census name cleaning ####

# remove California from end of names
census$NAME = substr(census$NAME, 1, nchar(census$NAME)-12)

# remove unincorporated areas from census data
census = census[!grepl("CDP$", census$NAME),]

# replace county with sheriff
census$NAME = gsub("County$", "sheriff", census$NAME)

# replace city with police
census$NAME = gsub("city$", "police", census$NAME)
census$NAME = gsub("town$", "police", census$NAME)

# to lower everything
census$NAME = tolower(census$NAME)

# chane NAME to name
colnames(census)[colnames(census) == "NAME"] = "name"

# name fixes ####

census[census$name == "carmel-by-the-sea police", "name"] = "carmel police"

# merge by name and year ####

# merge all onto forf, keep everything
merged = merge(forf, census, by = c("name", "year"), all.x = TRUE)

# test for duplicates
if(any(duplicated(merge(forf, census, by = c("name", "year"), all = TRUE)[, c("name", "year")]))){stop("There are duplicate agencies!")}

# sample and check what did not get matched from census?
sample(census[!(census$name %in% merged$name), "name"], 5)

# drop those that are not police or sheriff for now

pol_sher_only = merged[grepl("police", merged$name) | grepl("sherif", merged$name), ]

# save out ####
write.csv(pol_sher_only, "./data/intermediate_data/9_census_full_data.csv", row.names = FALSE)
