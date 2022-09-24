# to combine the LEMAS and CSLLEA data sets

# setup ####

# data load
lemas = read.csv("./data/LEMAS/lemas_comb.csv", header = TRUE, stringsAsFactors = FALSE)
csllea = read.csv("./data/CSLLEA/csllea_combined.csv", header = TRUE, stringsAsFactors = FALSE)

# data pre-process ####

# to lower columns that need it
lemas$TYPE = tolower(lemas$TYPE)
lemas$CITY = tolower(lemas$CITY)

# unify column names
colnames(lemas)[colnames(lemas) == "AGENCY"] = "name"
colnames(lemas)[colnames(lemas) == "CITY"] = "city"
colnames(lemas)[colnames(lemas) == "TYPE"] = "type"
colnames(lemas)[colnames(lemas) == "STATE"] = "state"

colnames(csllea)[colnames(csllea) == "total_operating_budget"] = "OPBUDGET"

# combine ####

## first deal with 2000 data s it is in both sources ####

lemas = lemas[lemas$year != 2000,]

# save for now as I am not using 2000 data yet

## subset out
#c2000 = csllea[csllea$year == 2000, ]
#l2000 = lemas[lemas$year == 2000,]
#
#test = merge(c2000, l2000, by = "name", all = TRUE)

## combine rest ####

comb = plyr::rbind.fill(lemas, csllea)

# name standardization ####

## general modifications ####

# remove words with no meaning
comb$name = gsub("department", " ", comb$name)
comb$name = gsub("county", " ", comb$name)
comb$name = gsub("of public safety", "police", comb$name)


# fix spaces
comb$name = gsub(pattern = "\\s+", replacement = " ", x = comb$name)
comb$name = trimws(comb$name)

## specific names ####

# butte college
comb$name[comb$name == "butte community college police"] = "butte college"
comb$name[comb$name == "butte glenn community college district police"] = "butte college"

# carmel police
comb$name[comb$name == "carmel by the sea police"] = "carmel police"

# contra costa sheriff
comb$name[comb$name == "contra costa sheriff /coroner"] = "contra costa sheriff"

# maywood police
comb$name[comb$name == "maywood cudahy police"] = "maywood police"

# monterey
comb$name[comb$name == "monterey"] = "monterey police"

# orange sheriff
comb$name[comb$name == "orange sheriff coroner"] = "orange sheriff"

# placer sheriff
comb$name[comb$name == "placer sheriff /coroner"] = "placer sheriff"

# san jose community college campus police
comb$name[comb$name == "san jose/evergreen community college district police"] = "san jose community college campus police"

# san mateo sheriff
comb$name[comb$name == "sheriff san mateo"] = "san mateo sheriff"

# seal beach police
comb$name[comb$name == "seal beach police beach police"] = "seal beach police"

# sonoma state university police
comb$name[comb$name == "sonoma state univeristy police"] = "sonoma state university police"

# st helena police
comb$name[comb$name == "st. helena police"] = "st helena police"
comb[comb$name == "st helena police", "city"] = "st helena"

# stanislaus sheriff
comb$name[comb$name == "stanislaus"] = "stanislaus sheriff"

# twin cities police
comb$name[comb$name == "twin cities police authority"] = "twin cities police"

## drop unwanted ####

# anything that ends in " fire", like fire departments
comb = comb[!grepl(" fire$", comb$name),]

# specifics
comb = comb[!(comb$name %in% c("of the sheriff")),]

# drop any that only show up once
comb = comb[!(comb$name %in% names(table(comb$name)[table(comb$name) == 1])), ]

# standardize agency types ####

comb$type[comb$type == "chp"] = "state law enforcement agency"

# fill in missing counties when possible ####

# make a list of unique name-county combos
county_key = data.frame("name" = comb$name, "county" = comb$county, stringsAsFactors = FALSE)
county_key = county_key[complete.cases(county_key),]
county_key[county_key$county == " ", "county"] = NA
county_key = county_key[complete.cases(county_key),]
county_key = unique(county_key)

# determine if any of the names have multiple counties
dup_check = by(county_key, county_key$name, FUN = function(x){nrow(x)})
dup_check = data.frame("name" = names(dup_check), "count" = as.numeric(dup_check), stringsAsFactors = FALSE)

county_key = unique(county_key)

# fix the errors
county_key[county_key$name == "university of california davis police", "county"] = "yolo"
county_key[county_key$name == "bart police", "county"] = "san francisco"
county_key[county_key$name == "south san francisco police", "county"] = "san mateo"

# fill in gaps in data, drop old county, add ned
comb = comb[, !(colnames(comb) %in% c("county"))]
comb = unique(merge(comb, county_key, by = "name", all.x = TRUE))

# save ####

# drop unwanted columns
# not enough years to reliably impute
comb = comb[, !(colnames(comb) %in% c("FTDRUGOFF", "PTDRUGOFF", "website", "email", "in_drug_taskforce", "drug_asset_forf_program", "drug_asset_forf_data_source", "budget_est", "data_source"))]

write.csv(comb, "./data/intermediate_data/3_csllea_lemas_comb.csv", row.names = FALSE)

#View(table(comb$name))

