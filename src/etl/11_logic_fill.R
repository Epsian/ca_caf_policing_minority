# to fill in the missing data than can be logically filled

# setup ####

# data load 
forf = read.csv("./data/intermediate_data/10_drug_data.csv", header = TRUE, stringsAsFactors = FALSE)

# fill in NAs in post-merge dfs with info from key dfs
fill_missing_clean = function(df_input, dup_vars){
  
  for(duped in dup_vars){
    df_input[ , duped] <- ifelse(is.na(df_input[ , paste0(duped, ".x")]), df_input[ , paste0(duped, ".y")], df_input[ , paste0(duped, ".x")])
    df_input <- df_input[,-c(match(paste0(duped, ".x"), names(df_input)),match(paste0(duped, ".y"), names(df_input)))]
  }
  return(df_input)
}

# fill in state ####

# I would hope this makes sense
forf$state = "CA"

# Fill in type column ####

# apply known fixes
# change "municipal police" to "local police"
forf$type = gsub("^municipal police$", "local police", forf$type)
# change "special police" to "special jurisdictions"
forf$type = gsub("^special police$", "special jurisdictions", forf$type)
# fix lake shasta
forf[forf$name == "lake shastina police", "type"] = "local police"

# find all unique combos of name and type
type_key = unique(data.frame(name = forf$name, type = forf$type, stringsAsFactors = FALSE))
# drop those with type == NA
type_key = type_key[!is.na(type_key$type), ]

# which ones have more than 1 type?
.multitype_test = table(type_key$name, type_key$type)
rowSums(.multitype_test)[rowSums(.multitype_test) > 1]

# fill in blanks with clean key

# merge forfeiture data with key of known agencies and their types
forf = merge(forf, type_key, by = "name", all.x = TRUE)
# de-duplicate columns by filling in NAs with those from key
forf = fill_missing_clean(forf, c("type"))

# remove type cleaning tools
rm(type_key, .multitype_test)

# fill in ori7 column ####

# apply known fixes
# for el cerrito police use the newer and more common ORI7
forf[forf$name == "el cerrito police", "ORI7"] = "CA00705"

# find all unique combos of name and type
ori7_key = unique(data.frame(name = forf$name, ORI7 = forf$ORI7, stringsAsFactors = FALSE))
# drop those with type == NA
ori7_key = ori7_key[!is.na(ori7_key$ORI7), ]

# which ones have more than 1 type?
.multitype_test = table(ori7_key$name, ori7_key$ORI7)
rowSums(.multitype_test)[rowSums(.multitype_test) > 1]

# fill in blanks with clean key

# merge forfeiture data with key of known agencies and their types
forf = merge(forf, ori7_key, by = "name", all.x = TRUE)
# de-duplicate columns by filling in NAs with those from key
forf = fill_missing_clean(forf, c("ORI7"))

# remove type cleaning tools
rm(ori7_key, .multitype_test)

# fill in ori9 column ####

# apply known fixes
# fix orange county sheriff in 2007
forf[forf$name == "orange sheriff", "ORI9"] = "CA0305100"

# find all unique combos of name and type
ori9_key = unique(data.frame(name = forf$name, ORI9 = forf$ORI9, stringsAsFactors = FALSE))
# drop those with type == NA
ori9_key = ori9_key[!is.na(ori9_key$ORI9), ]

# which ones have more than 1 type?
.multitype_test = table(ori9_key$name, ori9_key$ORI9)
rowSums(.multitype_test)[rowSums(.multitype_test) > 1]

# fill in blanks with clean key

# merge forfeiture data with key of known agencies and their types
forf = merge(forf, ori9_key, by = "name", all.x = TRUE)
# de-duplicate columns by filling in NAs with those from key
forf = fill_missing_clean(forf, c("ORI9"))

# remove type cleaning tools
rm(ori9_key, .multitype_test)

# fill CSLLEA08_ID ####

# find all unique combos of name and type
CSLLEA08_ID_key = unique(data.frame(name = forf$name, CSLLEA08_ID = forf$CSLLEA08_ID, stringsAsFactors = FALSE))
# drop those with type == NA
CSLLEA08_ID_key = CSLLEA08_ID_key[!is.na(CSLLEA08_ID_key$CSLLEA08_ID), ]

# which ones have more than 1 type?
.multitype_test = table(CSLLEA08_ID_key$name, CSLLEA08_ID_key$CSLLEA08_ID)
rowSums(.multitype_test)[rowSums(.multitype_test) > 1]

# fill in blanks with clean key

# merge forfeiture data with key of known agencies and their types
forf = merge(forf, CSLLEA08_ID_key, by = "name", all.x = TRUE)
# de-duplicate columns by filling in NAs with those from key
forf = fill_missing_clean(forf, c("CSLLEA08_ID"))

# remove type cleaning tools
rm(CSLLEA08_ID_key, .multitype_test)

## fill GEOID ####
# not used so disabled
#
## find all unique combos of name and type
#GEOID_key = unique(data.frame(name = forf$name, GEOID = forf$GEOID, stringsAsFactors = FALSE))
## drop those with type == NA
#GEOID_key = GEOID_key[!is.na(GEOID_key$GEOID), ]
#
## which ones have more than 1 type?
#.multitype_test = table(GEOID_key$name, GEOID_key$GEOID)
#rowSums(.multitype_test)[rowSums(.multitype_test) > 1]
#
## fill in blanks with clean key
#
## merge forfeiture data with key of known agencies and their types
#forf = merge(forf, GEOID_key, by = "name", all.x = TRUE)
## de-duplicate columns by filling in NAs with those from key
#forf = fill_missing_clean(forf, c("GEOID"))
#
## remove type cleaning tools
#rm(GEOID_key, .multitype_test)

# fill in city ####

# apply known fixes
# fix spelling of arcadia police
forf[forf$name == "arcadia police", "city"] = "arcadia"
# for the sake of analysis, put broadmoor police is broadmoor
forf[forf$name == "broadmoor police", "city"] = "broadmoor"
# current website for california state university channel islands police puts them in camarillo
forf[forf$name == "california state university channel islands police", "city"] = "camarillo"
# current website for california state university fullerton police puts them in fullerton 
forf[forf$name == "california state university fullerton police", "city"] = "fullerton"
# fix mt shasta name aberviation
forf[forf$name == "mount shasta police", "city"] = "mount shasta"
# current website for south san francisco police puts them in south san francisco 
forf[forf$name == "south san francisco police", "city"] = "south san francisco"
# thanks uc davis. You're in Davis. The med center dosn't help here.
forf[forf$name == "university of california davis police", "city"] = "davis"

# find all unique combos of name and type
city_key = unique(data.frame(name = forf$name, city = forf$city, stringsAsFactors = FALSE))
# drop those with type == NA
city_key = city_key[!is.na(city_key$city), ]

# which ones have more than 1 type?
.multitype_test = table(city_key$name, city_key$city)
rowSums(.multitype_test)[rowSums(.multitype_test) > 1]

# fill in blanks with clean key

# merge forfeiture data with key of known agencies and their types
forf = merge(forf, city_key, by = "name", all.x = TRUE)
# de-duplicate columns by filling in NAs with those from key
forf = fill_missing_clean(forf, c("city"))

# remove type cleaning tools
rm(city_key, .multitype_test)

# save out ####
write.csv(forf, "./data/intermediate_data/11_full_data.csv", row.names = FALSE)



