# to create a data file with all the static elements of a LE department, like identification numbers

# setup ####

# load crosswalk
crosswalk = read.csv("./data/crosswalk/crosswalk.tsv", header = TRUE, stringsAsFactors = FALSE, sep = "\t")
# load in af report data
report_years = read.csv("./data/report_data/rec_year_reports.csv", header = TRUE, stringsAsFactors = FALSE)

# data prep ####

## subset data
# filter to just CA
crosswalk = crosswalk[crosswalk$ADDRESS_STATE == "CA", ]
# combine addresses in crosswalk
crosswalk$ADDRESS_COMB = paste(crosswalk$ADDRESS_STR1, crosswalk$ADDRESS_STR2, sep = " ")

## subset columns
# keep varaibles of interest
crosswalk = crosswalk[, c("ORI7", "ORI9", "CSLLEA08_ID", "NAME", "ADDRESS_STATE", "COUNTYNAME", "ADDRESS_CITY", "ADDRESS_ZIP", "ADDRESS_COMB")]

## unify column names
colnames(crosswalk)[colnames(crosswalk) == "NAME"] = "name"
colnames(crosswalk)[colnames(crosswalk) == "ADDRESS_STATE"] = "state"
colnames(crosswalk)[colnames(crosswalk) == "COUNTYNAME"] = "county"
colnames(crosswalk)[colnames(crosswalk) == "ADDRESS_CITY"] = "city"
colnames(crosswalk)[colnames(crosswalk) == "ADDRESS_ZIP"] = "ZIP"
colnames(crosswalk)[colnames(crosswalk) == "ADDRESS_COMB"] = "address_comb"

colnames(report_years)[colnames(report_years) == "recipient"] = "name"

## replace blanks with NAs
crosswalk[crosswalk == " "] = NA
crosswalk[crosswalk == "  "] = NA
crosswalk[crosswalk == "   "] = NA
crosswalk[crosswalk == -1] = NA

## basic text prep

# to lower everything
crosswalk$name = tolower(crosswalk$name)
crosswalk$county = tolower(crosswalk$county)
crosswalk$city = tolower(crosswalk$city)
crosswalk$address_comb = tolower(crosswalk$address_comb)

report_years$name = tolower(report_years$name)
report_years$county = tolower(report_years$county)

## expand contractions
crosswalk$name = gsub("\\bdept\\.?\\b", "department", crosswalk$name)
crosswalk$name = gsub("\\bpd\\b", "police department", crosswalk$name)
crosswalk$name = gsub(pattern = "\\buniv of ca\\b", replacement = "university of california -", x = crosswalk$name)
crosswalk$name = gsub(pattern = "\\bdist atty\\b", replacement = "district attorney", x = crosswalk$name)
crosswalk$name = gsub(pattern = "\\bdist aty\\b", replacement = "district attorney", x = crosswalk$name)
crosswalk$name = gsub(pattern = "bev\\.", replacement = "beverage", x = crosswalk$name)
crosswalk$name = trimws(crosswalk$name)

report_years$name = gsub("\\bpd\\b", "police department", report_years$name)
report_years$name = gsub("\\bco so\\b", "sheriff department", report_years$name)
report_years$name = gsub("\\bco da\\b", "district attorney", report_years$name)
report_years$name = gsub("^chp-?", "california highway patrol ", report_years$name)
report_years$name = gsub("^bne-?", "bureau of narcotic enforcement ", report_years$name)
report_years$name = gsub("ca doj-bne ", " bureau of narcotic enforcement ", report_years$name)
report_years$name = gsub("\\buc\\b", "university of california", report_years$name)
report_years$name = gsub(pattern = "\\bbev\\.?\\b", replacement = "beverage", x = report_years$name)
report_years$name = trimws(report_years$name)

# data cleaning ####

## remove bulk unwanted from crosswalk
# remove union pacific railroad from crosswalk
crosswalk = crosswalk[!startsWith(crosswalk$name, "uprr: "), ]
crosswalk = crosswalk[!startsWith(crosswalk$name, "uprr "), ]
crosswalk = crosswalk[!startsWith(crosswalk$name, "union pacific rr"), ]

# remove BNSF railway
crosswalk = crosswalk[!startsWith(crosswalk$name, "bnsf rwy:"), ]

# remove Street Psychiatry Teams
crosswalk = crosswalk[!startsWith(crosswalk$name, "spt "), ]

# remove state lottery
crosswalk = crosswalk[!startsWith(crosswalk$name, "ca state lottery sec div "), ]

# remove DPR
crosswalk = crosswalk[!startsWith(crosswalk$name, "dpr "), ]

# remove satellite DMV offices (leave main)
crosswalk = crosswalk[!startsWith(crosswalk$name, "dmv "), ]
crosswalk = crosswalk[!startsWith(crosswalk$name, "ca dmv "), ]

# remove welfare offices
crosswalk = crosswalk[!grepl("\\bwelfare\\b", crosswalk$name), ]

# remove marshals
crosswalk = crosswalk[!grepl("marshal", crosswalk$name), ]

# remove the word "county" from names
crosswalk$name = gsub("\\bcounty\\b", " ", crosswalk$name)

# remove possessive from sheriff
crosswalk$name = gsub("sheriff's", "sheriff", crosswalk$name)

## remove words without semantic meaning
crosswalk$name = gsub("\\bdepartment of\\b", " ", crosswalk$name)
crosswalk$name = gsub("\\bdepartment\\b", " ", crosswalk$name)
crosswalk$name = gsub("\\boffice\\b", " ", crosswalk$name)
crosswalk$name = gsub("california\\s+.\\s+of", " ", crosswalk$name)
crosswalk$name = gsub(" - ", " ", crosswalk$name)

report_years$name = gsub("\\bdepartment of\\b", " ", report_years$name)
report_years$name = gsub("\\bdepartment\\b", " ", report_years$name)
report_years$name = gsub("\\boffice\\b", " ", report_years$name)

## collapse spaces and trim whitespace
crosswalk$name = gsub("\\s+", " ", crosswalk$name)
crosswalk$name = trimws(crosswalk$name)

report_years$name = gsub("\\s+", " ", report_years$name)
report_years$name = trimws(report_years$name)

## hand corrections ####

## drop duplicates
crosswalk = crosswalk[crosswalk$ORI9 != "CA0014000", ]
crosswalk = crosswalk[crosswalk$ORI9 != "CA0562300", ]
crosswalk = crosswalk[crosswalk$ORI9 != "CA0382000", ]
crosswalk = crosswalk[crosswalk$ORI9 != "CA0152600", ]

## names

# crosswalk
crosswalk$name[crosswalk$name == "apple valley"] = "apple valley police"
crosswalk$name[crosswalk$name == "alcoholic bev cont enf sect sacramento"] = "alcohol beverage control"
crosswalk$name[crosswalk$name == "butte county sheriff"] = "butte sheriff"
crosswalk$name[crosswalk$name == "ceres public safety"] = "ceres police"
crosswalk$name[crosswalk$name == "ca alcohol beverage control"] = "concord alcohol beverage control"
crosswalk$name[crosswalk$name == "chino hills"] = "chino hills police"
crosswalk$name[crosswalk$name == "hesperia"] = "hesperia police"
crosswalk$name[crosswalk$name == "highland"] = "highland police"
crosswalk$name[crosswalk$name == "lindsay public safety"] = "lindsay police"
crosswalk$name[crosswalk$name == "oakley"] = "oakley police"
crosswalk$name[crosswalk$name == "patterson police services"] = "patterson police"
crosswalk$name[crosswalk$name == "rohnert park public safety"] = "rohnert park police"
crosswalk$name[crosswalk$name == "sunnyvale public safety"] = "sunnyvale police"
crosswalk$name[crosswalk$name == "tehama county sheriff"] = "tehama sheriff"
crosswalk$name[crosswalk$name == "twentynine palms"] = "twenty nine palms police"
crosswalk$name[crosswalk$name == "visalia public safety"] = "visalia police"
crosswalk$name[crosswalk$name == "yucca valley"] = "yucca valley police"
crosswalk$name[crosswalk$name == "yucaipa"] = "yucaipa police"

# report
report_years[report_years$name == "alcohol beverage. control", "name"] = "alcohol beverage control"
report_years[report_years$name == "san diego state univ police", "name"] = "san diego state police"

## counties

# report_years
report_years[report_years$name == "apple valley police", "county"] = "san bernardino"
report_years[report_years$name == "oakdale police", "county"] = "stanislaus"
report_years[report_years$name == "willits police", "county"] = "mendocino"
report_years[report_years$name == "west sacramento police", "county"] = "yolo"
report_years[report_years$name == "woodlake police", "county"] = "tulare"

## add counties to report data using available years ####

# make a key of all unique name, county combos
county_key = data.frame("name" = report_years$name, "county" = report_years$county, stringsAsFactors = FALSE)
county_key = county_key[complete.cases(county_key),]
county_key = unique(county_key)

# check if some cities have multiple counties
table(county_key$name)[table(county_key$name) > 1]

# fill in missing counties given known counties
# take out all the already good merges, leaving only those with no counties
good_report = report_years[!is.na(report_years$county),]
report_years = report_years[is.na(report_years$county),]

# try to fill in counties
county_fill = merge(report_years[, !(colnames(report_years) %in% c("county"))], county_key, by = "name", all.x = TRUE)

# put back together
report_years = rbind(good_report, county_fill)

rm(good_report, county_fill, county_key)

## date type checks ####

# years
report_years$year = as.numeric(report_years$year)

## find duplicated name-year pairs ####

# how many name-year pairs appear more than once
table(table(report_years$name, report_years$year) > 1)

# figure out which ones
table(paste0(report_years$name, report_years$year))[table(paste0(report_years$name, report_years$year)) > 1]

## do exact name year pairs first ####

# do match by exact name only
name_match = merge(report_years, crosswalk, by = "name", all.x = TRUE)

# how many name-year pairs appear more than once
table(table(name_match$name, name_match$year) > 1)

# figure out which ones
table(paste0(name_match$name, name_match$year))[table(paste0(name_match$name, name_match$year)) > 1]

# fill in county x with county y if NA and remove
name_match[,"county"] <- ifelse(is.na(name_match[,"county.x"]), name_match[,"county.y"], name_match[,"county.x"])
name_match = name_match[,-c(match("county.x", names(name_match)),match("county.y", names(name_match)))]

# remove these matches from the dataframes prior to using fastLink
report_years = report_years[!(paste0(report_years$year, report_years$name) %in% paste0(name_match$year, name_match$name)), ]
crosswalk = crosswalk[!(paste0(crosswalk$year, crosswalk$name) %in% paste0(name_match$year, name_match$name)), ]

# save out ####
write.csv(name_match, "./data/intermediate_data/6_report_crosswalk.csv", row.names = FALSE)

# go back to prob matching later


## fastlink combine crosswalk and reports ####
#
## for debugging, include a copy of name on each, disable once matches look good
#crosswalk$name_cross = crosswalk$name
#report_years$name_report = report_years$name
#
#crosswalk$county_cross = crosswalk$county
#report_years$county_report = report_years$county
#
## join reports and crosswalk
#report_crosswalk = fastLink(
#  dfA = report_years, dfB = crosswalk,
#  varnames = c("name", "county"),
#  stringdist.match = c("name", "county"), cut.a = 0.90, #0.94
#  partial.match = c("name"), cut.p = 0.80, #0.88
#  dedupe.matches = TRUE,
#  jw.weight	= .01, # 0.10
#  threshold.match = 0.0001
#)
#
#summary(report_crosswalk)
#
#report_crosswalk_df = getMatches(report_years, crosswalk, report_crosswalk, threshold.match = .75, combine.dfs = TRUE)
#
## run this to see "good" matches by name to compare for errors (only if included above)
#good_check = report_crosswalk_df[, c("name", "name_report", "name_cross", "county_report", "county_cross", "posterior")]
#good_check$all_good = apply(good_check, 1, FUN = function(good_row){all_good = good_row["name"] == good_row["name_report"] & good_row["name"] == good_row["name_cross"]; return(all_good)}#)
#
## Run this to see what was not matched - sort out corrections
#View(report_years[!(report_years$name %in% report_crosswalk_df$name),])
#
#
#
## clear out matching helpers
#report_crosswalk_df = report_crosswalk_df[, !(colnames(report_crosswalk_df) %in% c("name_cross", "name_report", "county_cross", "county_report", "gamma.1", "gamma.2", "posterior"))]
#rm(good_check)


