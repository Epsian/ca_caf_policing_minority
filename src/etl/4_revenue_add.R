# add the municiple budget data with LEMAS and CSLLEA

# setup ####

# load combined csllea and lemas data
lemas_csllea = read.csv("./data/intermediate_data/3_csllea_lemas_comb.csv", header = TRUE, stringsAsFactors = FALSE)
# load revenue data
revenue_raw = read.csv("./data/City_Revenues_raw.csv", header = TRUE, stringsAsFactors = FALSE)
county_revenue_raw = read.csv("./data/County_Revenues_raw.csv", header = TRUE, stringsAsFactors = FALSE)

# aggregation of revenue data ####

# aggregate by city and year
revenue_df = by(revenue_raw, INDICES = list(revenue_raw$Fiscal.Year, revenue_raw$Entity.Name), FUN = function(x){
  
  df = data.frame("city" = x$Entity.Name[1],
             "year" = x$Fiscal.Year[1],
             "total_revenue" = sum(x$Value, na.rm = TRUE),
             "revenue_na_count" = sum(is.na(x$Value)),
             "estimated_population_rev" = x$Estimated.Population[1],
             stringsAsFactors = FALSE)
  
  return(df)
})

# convert list back to dataframe
revenue_df = do.call(rbind, revenue_df)

## save out revenue specifically ####
write.csv(revenue_df, "./data/revenue_cleaned.csv", row.names = FALSE)
rm(revenue_raw)

# add to combined lemas and csllea to revenue ####

# text pre-process on revenue
revenue_df$city = tolower(revenue_df$city)

# merge revenue data onto le data
merged = merge(lemas_csllea, revenue_df, by = c("city", "year"), all = TRUE, sort = FALSE)

# try to fill in missing LE agencies for years with city data but not LE ####

# make a key of all unique city, le agency combos
city_le_key = data.frame("name" = merged$name, "city" = merged$city, stringsAsFactors = FALSE)
city_le_key = city_le_key[complete.cases(city_le_key),]
city_le_key = unique(city_le_key)

# take out all the already good merges, leaving only those with no names
good_merged = merged[!is.na(merged$name),]
merged = merged[is.na(merged$name),]

# try to fill in names
noname = merge(merged[, !(colnames(merged) %in% c("name"))], city_le_key, by = "city")

# put back together
noname_merged = rbind(good_merged, noname)

# fix cities that changed counties over time ####

noname_merged[noname_merged$city == "camarillo", "county"] = "ventura"
noname_merged[noname_merged$city == "compton", "county"] = "los angeles"
noname_merged[noname_merged$city == "costa mesa", "county"] = "orange"
noname_merged[noname_merged$city == "el cajon", "county"] = "san diego"
noname_merged[noname_merged$city == "fullerton", "county"] = "orange"
noname_merged[noname_merged$city == "hayward", "county"] = "alameda"
noname_merged[noname_merged$city == "hoopa", "county"] = "humboldt"
noname_merged[noname_merged$city == "hopland", "county"] = "mendocino"
noname_merged[noname_merged$city == "klamath", "county"] = "del norte"
noname_merged[noname_merged$city == "mission viejo", "county"] = "orange"
noname_merged[noname_merged$city == "oakland", "county"] = "alameda"
noname_merged[noname_merged$city == "ontario", "county"] = "san bernardino"
noname_merged[noname_merged$city == "sacramento", "county"] = "sacramento"
noname_merged[noname_merged$city == "san francisco", "county"] = "san francisco"
noname_merged[noname_merged$city == "santa rosa", "county"] = "sonoma"
noname_merged[noname_merged$city == "west sacramento", "county"] = "yolo"
noname_merged[noname_merged$city == "yreka", "county"] = "siskiyou"

# fill in missing counties ####

# split out sheriff departments
sheriff_df = noname_merged[grepl("sheriff", noname_merged$name),]
police_df = noname_merged[!grepl("sheriff", noname_merged$name),]

# aggregate by county and year
county_revenue_df = by(county_revenue_raw, INDICES = list(county_revenue_raw$Fiscal.Year, county_revenue_raw$Entity.Name), FUN = function(x){
  
  #browser()
  
  df = data.frame("county" = x$Entity.Name[1],
                  "year" = x$Fiscal.Year[1],
                  "total_revenue" = sum(x$Values, na.rm = TRUE),
                  "revenue_na_count" = sum(is.na(x$Values)),
                  "estimated_population_rev" = x$Estimated.Population[1],
                  stringsAsFactors = FALSE)
  
  return(df)
})

# convert list back to dataframe
county_revenue_df = do.call(rbind, county_revenue_df)

# text pre-process on revenue
county_revenue_df$county = tolower(county_revenue_df$county)

# drop the revenue data from cities in sheriff sf
sheriff_df = sheriff_df[, !(colnames(sheriff_df) %in% c("total_revenue", "revenue_na_count", "estimated_population_rev"))]

# for sheriff, add county revenue
sheriff_df = merge(sheriff_df, county_revenue_df, by = c("county", "year"))

# merge police and sheriff
total_rev = rbind(police_df, sheriff_df)

# check for duplicates from merging ####

dup_check = total_rev[, c("city", "year", "name")]
dup_check = table(dup_check$city, dup_check$year, dup_check$name)
table(dup_check > 1)

# save total data ####
write.csv(total_rev, "./data/intermediate_data/4_rev_lemas_csllea.csv", row.names = FALSE)
