# To combine the Census of State and Local Law Enforcement Agencies (CSLLEA) data into one flat file, subset for california, and prepare for combination with LEMUS

#### setup ####

# read in data
d2000 = read.csv("./data/CSLLEA/RAW/2000/csllea_2000.tsv", header = TRUE, sep = "\t")
d2004 = read.csv("./data/CSLLEA/RAW/2004/csllea_2004.tsv", header = TRUE, sep = "\t")
d2008 = read.csv("./data/CSLLEA/RAW/2008/csllea_2008.tsv", header = TRUE, sep = "\t")

#### 2000 ####

# make new dataframe with varaibles of interest
d2000_clean = data.frame(
  "name" = d2000$V7,
  "state" = d2000$V1,
  "county" = d2000$V12,
  "city" = d2000$V8,
  "type" = d2000$V13,
  "gov_type" = d2000$V2,
  "website" = d2000$V17,
  "email" = d2000$V19,
  "started" = d2000$V34,
  "in_drug_taskforce" = d2000$V56,
  "drug_asset_forf_program" = d2000$V84,
  "drug_asset_forf_data_source" = d2000$V84F,
  "total_operating_budget" = d2000$V82,
  "budget_est" = d2000$V82F,
  "data_source" = d2000$V85,
  stringsAsFactors = FALSE)

# subset to CA
d2000_clean = d2000_clean[d2000_clean$state == "CA", ]

# recode variables
d2000_clean$type[d2000_clean$type == 01] = "sheriff"
d2000_clean$type[d2000_clean$type == 02] = "county police"
d2000_clean$type[d2000_clean$type == 03] = "municipal police"
d2000_clean$type[d2000_clean$type == 05] = "chp"
d2000_clean$type[d2000_clean$type == 06] = "special police"
d2000_clean$type[d2000_clean$type == 07] = "constable"
d2000_clean$type[d2000_clean$type == 08] = "tribal police"
d2000_clean$type[d2000_clean$type == 09] = "regional police"

d2000_clean$gov_type[d2000_clean$gov_type == 0] = "state"
d2000_clean$gov_type[d2000_clean$gov_type == 1] = "county"
d2000_clean$gov_type[d2000_clean$gov_type == 2] = "municipal"
d2000_clean$gov_type[d2000_clean$gov_type == 3] = "township"
d2000_clean$gov_type[d2000_clean$gov_type == 4] = "special district"
d2000_clean$gov_type[d2000_clean$gov_type == 5] = "school"
d2000_clean$gov_type[d2000_clean$gov_type == 7] = "tribal"

d2000_clean$started[d2000_clean$started == 9999] = NA

d2000_clean$in_drug_taskforce = as.logical(d2000_clean$in_drug_taskforce)

d2000_clean$total_operating_budget[d2000_clean$total_operating_budget == 9999999999] = NA

d2000_clean$drug_asset_forf_program[d2000_clean$drug_asset_forf_program == 9999999999] = NA
d2000_clean$drug_asset_forf_data_source[d2000_clean$drug_asset_forf_data_source == 0] = "Actual value reported by respondent"
d2000_clean$drug_asset_forf_data_source[d2000_clean$drug_asset_forf_data_source == 1] = "Estimated value reported by respondent"
d2000_clean$drug_asset_forf_data_source[d2000_clean$drug_asset_forf_data_source == 2] = "Corrected a keying error"
d2000_clean$drug_asset_forf_data_source[d2000_clean$drug_asset_forf_data_source == 3] = "Analyst adjustment, no contact with resp"
d2000_clean$drug_asset_forf_data_source[d2000_clean$drug_asset_forf_data_source == 4] = "Analyst adjustment, respondent contact -"
d2000_clean$drug_asset_forf_data_source[d2000_clean$drug_asset_forf_data_source == 5] = "Analyst adjustment, respondent contact -"
d2000_clean$drug_asset_forf_data_source[d2000_clean$drug_asset_forf_data_source == 6] = "Data accepted w respondent verification"
d2000_clean$drug_asset_forf_data_source[d2000_clean$drug_asset_forf_data_source == 7] = "Data accepted w o respondent verification"
d2000_clean$drug_asset_forf_data_source[d2000_clean$drug_asset_forf_data_source == 8] = NA
d2000_clean$drug_asset_forf_data_source[d2000_clean$drug_asset_forf_data_source == 9] = "Don't know"

d2000_clean$budget_est[d2000_clean$budget_est == 0] = "Actual value reported by respondent"
d2000_clean$budget_est[d2000_clean$budget_est == 1] = "Estimated value reported by respondent"
d2000_clean$budget_est[d2000_clean$budget_est == 2] = "Corrected a keying error"
d2000_clean$budget_est[d2000_clean$budget_est == 3] = "Analyst adjustment, no contact with resp"
d2000_clean$budget_est[d2000_clean$budget_est == 4] = "Analyst adjustment, respondent contact -"
d2000_clean$budget_est[d2000_clean$budget_est == 5] = "Analyst adjustment, respondent contact -"
d2000_clean$budget_est[d2000_clean$budget_est == 6] = "Data accepted w respondent verification"
d2000_clean$budget_est[d2000_clean$budget_est == 7] = "Data accepted w o respondent verificatio"
d2000_clean$budget_est[d2000_clean$budget_est == 8] = NA
d2000_clean$budget_est[d2000_clean$budget_est == 9] = "Dont know"

d2000_clean$data_source[d2000_clean$data_source == 0] = "2000 Census"
d2000_clean$data_source[d2000_clean$data_source == 1] = "1996 Census"
d2000_clean$data_source[d2000_clean$data_source == 2] = "1997 LEMAS"
d2000_clean$data_source[d2000_clean$data_source == 3] = "1999 LEMAS"
d2000_clean$data_source[d2000_clean$data_source == 4] = "Phone call,Internet,etc"
d2000_clean$data_source[d2000_clean$data_source == 99] = "No 96 Census Data Available"

#### 2004 ####

# make new dataframe with varaibles of interest
d2004_clean = data.frame(
  "name" = d2004$AGCYNAME,
  "state" = d2004$STATE,
  "county" = d2004$CNTYNAME,
  "ZIP" = d2004$ZIP,
  "city" = d2004$CITY,
  "type" = d2004$AGCYTYPE,
  "gov_type" = d2004$GOVTYPE,
  "website" = NA,
  "email" = NA,
  "started" = NA,
  "in_drug_taskforce" = d2004$TASKFORC,
  "drug_asset_forf_program" = NA,
  "drug_asset_forf_data_source" = NA,
  "total_operating_budget" = d2004$BUDGET04,
  "budget_est" = d2004$Q3EST,
  stringsAsFactors = FALSE)

# subset to CA
d2004_clean = d2004_clean[d2004_clean$state == "CA", ]

# recode variables
d2004_clean$type[d2004_clean$type == 1] = "sheriff"
d2004_clean$type[d2004_clean$type == 3] = "local police"
d2004_clean$type[d2004_clean$type == 5] = "chp"
d2004_clean$type[d2004_clean$type == 6] = "special jurisdictions"
d2004_clean$type[d2004_clean$type == 7] = "constable or marshal"

d2004_clean$gov_type[d2004_clean$gov_type == 0] = "State"
d2004_clean$gov_type[d2004_clean$gov_type == 1] = "County"
d2004_clean$gov_type[d2004_clean$gov_type == 2] = "Municipal"
d2004_clean$gov_type[d2004_clean$gov_type == 7] = "Tribal"
d2004_clean$gov_type[d2004_clean$gov_type == 9] = "Regional/joint"
d2004_clean$gov_type[d2004_clean$gov_type == -9] = NA

d2004_clean$in_drug_taskforce = as.logical(d2004_clean$in_drug_taskforce)
d2004_clean$in_drug_taskforce[d2004_clean$in_drug_taskforce == 2] = FALSE
d2004_clean$in_drug_taskforce[d2004_clean$in_drug_taskforce == -9] = NA

d2004_clean$total_operating_budget[d2004_clean$total_operating_budget == -9] = NA

d2004_clean$budget_est[d2004_clean$budget_est == 1] = TRUE
d2004_clean$budget_est[d2004_clean$budget_est == 2] = FALSE
d2004_clean$budget_est[d2004_clean$budget_est == -9] = NA

#### 2008 ####

d2008_clean = data.frame(
  "CSLLEA08_ID" = d2008$CSLLEA08_ID,
  "name" = d2008$AGCYNAME,
  "state" = d2008$STATE,
  "county" = d2008$COUNTY,
  "ZIP" = d2008$ZIP,
  "city" = d2008$CITY,
  "address_comb" = paste(d2008$ADDR1, d2008$ADDR2),
  "type" = d2008$AGCYTYPE,
  "gov_type" = d2008$TRIBAL,
  "website" = NA,
  "email" = NA,
  "started" = NA,
  "in_drug_taskforce" = d2008$Q1G1,
  "drug_asset_forf_program" = NA,
  "drug_asset_forf_data_source" = NA,
  "total_operating_budget" = d2008$Q3,
  "budget_est" = d2008$Q3EST,
  stringsAsFactors = FALSE)

# subset to CA
d2008_clean = d2008_clean[d2008_clean$state == "CA", ]

# recode variables
d2008_clean$type[d2008_clean$type == 0] = "local police"
d2008_clean$type[d2008_clean$type == 1] = "sheriff"
d2008_clean$type[d2008_clean$type == 5] = "chp"
d2008_clean$type[d2008_clean$type == 6] = "special jurisdictions"
d2008_clean$type[d2008_clean$type == 7] = "constable or marshal"

d2008_clean$gov_type[d2008_clean$gov_type == 0] = NA
d2008_clean$gov_type[d2008_clean$gov_type == 1] = "tribal"

d2008_clean$in_drug_taskforce[d2008_clean$in_drug_taskforce == -9] = NA
d2008_clean$in_drug_taskforce = as.logical(d2008_clean$in_drug_taskforce)

d2008_clean$total_operating_budget[d2008_clean$total_operating_budget == -9] = NA

d2008_clean$budget_est[d2008_clean$budget_est == -2] = "Don't know"
d2008_clean$budget_est[d2008_clean$budget_est == 1] = TRUE
d2008_clean$budget_est[d2008_clean$budget_est == 2] = FALSE
d2008_clean$budget_est[d2008_clean$budget_est == -9] = NA

#### combine ####

# add years
d2000_clean$year = "2000"
d2004_clean$year = "2004"
d2008_clean$year = "2008"

# combine
combined = plyr::rbind.fill(d2000_clean, d2004_clean, d2008_clean)

# basic text cleaning
## to lower
combined$name = tolower(combined$name)
combined$county = tolower(combined$county)
combined$city = tolower(combined$city)

## clean white space
combined$name = trimws(combined$name)

## expand contractions
combined$name = gsub("\\bdept\\.\\b", " department ", combined$name)
combined$name = gsub("\\bdept\\b", " department ", combined$name)
combined$name = gsub("\\bdist\\b", " district ", combined$name)
combined$name = gsub(" . ", " ", combined$name)
combined$name = gsub(pattern = "univ of calif-", replacement = "university of california - ", x = combined$name)
combined$name = gsub(pattern = "california state univ-", replacement = "california state university - ", x = combined$name)
combined$name = gsub(pattern = "u of california", replacement = "university of california ", x = combined$name)

## remove dashes
combined$name = gsub("-", " ", combined$name)

## turn all multiple spaces into one
combined$name = gsub(pattern = "\\s+", replacement = " ", x = combined$name)
## clean white space
combined$name = trimws(combined$name)

# standardize sheriff
combined$name = gsub(pattern = "sheriff's department", replacement = "sheriff department", x = combined$name)
combined$name = gsub(pattern = "sheriffs department", replacement = "sheriff department", x = combined$name)
combined$name = gsub(pattern = "sheriff's office", replacement = "sheriff department", x = combined$name)
combined$name = gsub(pattern = "sheriffs office", replacement = "sheriff department", x = combined$name)
combined$name = gsub(pattern = "sheriff office", replacement = " sheriff department ", x = combined$name)

#### unify names ####
combined$name[combined$name == "allan hancock college security"] = "allan hancock college police"
combined$name[combined$name == "allan hancock college"] = "allan hancock college police"
combined$name[combined$name == "bay area rapid transit police"] = "bart police department"
combined$name[combined$name == "butte college police department"] = "butte community college police"
combined$name[combined$name == "ca dmv office of investigations audits"] = "calfornia dmv, investigations division"
combined$name[combined$name == "california department of fish and game protection"] = "california department of fish and game law enforcement"
combined$name[combined$name == "california polytechnic state university san luis obispo"] = "california polytechnic state university san luis obispo police"
combined$name[combined$name == "california state polytechnic university pomona"] = "california state polytechnic university pomona police"
combined$name[combined$name == "california state university bakersfield"] = "california state university bakersfield police"
combined$name[combined$name == "california state university channel islands"] = "california state university channel islands police"
combined$name[combined$name == "california state university chico"] = "california state university chico police"
combined$name[combined$name == "california state university dominguez hills"] = "california state university dominguez hills police"
combined$name[combined$name == "california state university fresno"] = "california state university fresno police"
combined$name[combined$name == "california state university fullerton"] = "california state university fullerton police"
combined$name[combined$name == "california state university hayward"] = "california state university hayward police"
combined$name[combined$name == "california state university long beach"] = "california state university long beach police"
combined$name[combined$name == "california state university los angeles"] = "california state university los angeles police"
combined$name[combined$name == "california state university monterey bay"] = "california state university monterey bay police"
combined$name[combined$name == "california state university northridge"] = "california state university northridge police"
combined$name[combined$name == "california state university sacramento"] = "california state university sacramento police"
combined$name[combined$name == "california state university san bernardino"] = "california state university san bernardino police"
combined$name[combined$name == "california state university san marcos"] = "california state university san marcos police"
combined$name[combined$name == "california state university stanislaus"] = "california state university stanislaus police"
combined$name[combined$name == "carmel police department"] = "carmel by the sea police department"
combined$name[combined$name == "cerritos college"] = "cerritos community college police"
combined$name[combined$name == "cerritos community college"] = "cerritos community college police"
combined$name[combined$name == "chaffey college security"] = "chaffey college police"
combined$name[combined$name == "chaffey college"] = "chaffey college police"
combined$name[combined$name == "coast community college district"] = "coast community college district police"
combined$name[combined$name == "college of marin"] = "college of marin police"
combined$name[combined$name == "college of the sequoias"] = "college of the sequoias police"
combined$name[combined$name == "contra costa community college district"] = "contra costa community college district police"
combined$name[combined$name == "cuesta college"] = "cuesta college police"
combined$name[combined$name == "east bay regional park police"] = "east bay regional parks police"
combined$name[combined$name == "east bay regional parks district department of public safety"] = "east bay regional parks police"
combined$name[combined$name == "el camino college"] = "el camino college police"
combined$name[combined$name == "fontana unified school district security"] = "fontana unified school district police department"
combined$name[combined$name == "foothill de anza community college district"] = "foothill de anza community college district police"
combined$name[combined$name == "foothill deanza community college district police"] = "foothill de anza community college district police"
combined$name[combined$name == "fresno yosemite international airport police"] = "fresno airport police"
combined$name[combined$name == "gilroy department of public safety"] = "gilroy police department"
combined$name[combined$name == "glendale community college"] = "glendale community college police"
combined$name[combined$name == "grossmont cuyamaca community college district"] = "grossmont cuyamaca community college district police"
combined$name[combined$name == "grossmount/cuyamaca community college dist"] = "grossmont cuyamaca community college district police"
combined$name[combined$name == "grossmount/cuyamaca community college district"] = "grossmont cuyamaca community college district police"
combined$name[combined$name == "hesperia unified school district security"] = "hesperia unified school district police department"
combined$name[combined$name == "hoopa tribal department of public safety"] = "hoopa valley tribal police"
combined$name[combined$name == "humboldt state university"] = "humboldt state university police"
combined$name[combined$name == "kern county school district security guards"] = "kern high school district police department"
combined$name[combined$name == "lake shastina district police department"] = "lake shastina police department"
combined$name[combined$name == "lamesa police department"] = "la mesa police department"
combined$name[combined$name == "lindsay department of public safety"] = "lindsay police department"
combined$name[combined$name == "los angeles unified school district police"] = "los angeles school police department"
combined$name[combined$name == "los angeles world airports police"] = "los angeles airport police"
combined$name[combined$name == "los banos department of public safety"] = "los banos police department"
combined$name[combined$name == "los gatos/monte sereno police department"] = "los gatos police department"
combined$name[combined$name == "los rios community college district"] = "los rios community college district police"
combined$name[combined$name == "marina department of public safety"] = "marina police department"
combined$name[combined$name == "miracosta college department of public safety"] = "miracosta college police"
combined$name[combined$name == "miracosta college"] = "miracosta college police"
combined$name[combined$name == "montebello unified school district police department"] = "montebello unified school district police"
combined$name[combined$name == "monterey peninsula airport district police"] = "monterey airport district police"
combined$name[combined$name == "mt. san jacinto college"] = "mt. san jacinto college police"
combined$name[combined$name == "napa valley comm college department"] = "napa valley college police department"
combined$name[combined$name == "ontario int'l airport authority"] = "ontario international airport authority"
combined$name[combined$name == "orange county sheriff coroner department"] = "orange county sheriff department"
combined$name[combined$name == "palomar college campus police"] = "palomar college police"
combined$name[combined$name == "palomar college"] = "palomar college police"
combined$name[combined$name == "pasadena city college"] = "pasadena city college police"
combined$name[combined$name == "pasadena unified school district security"] = "pasadena unified school district police"
combined$name[combined$name == "port hueneme city police department"] = "port hueneme police department"
combined$name[combined$name == "port of los angeles police"] = "los angeles port police"
combined$name[combined$name == "riverside city college (riverside district)"] = "riverside community college district police"
combined$name[combined$name == "riverside community college public safety"] = "riverside community college district police"
combined$name[combined$name == "san bernadino city unified school dist police"] = "san bernardino city unified school district police department"
combined$name[combined$name == "san bernadino city unified school district police"] = "san bernardino city unified school district police department"
combined$name[combined$name == "san bernardino city usd police department"] = "san bernardino city unified school district police department"
combined$name[combined$name == "san bernardino valley college"] = "san bernardino college district police"
combined$name[combined$name == "san diego community college district"] = "san diego community college district police"
combined$name[combined$name == "san diego unified school district police"] = "san diego city schools police department"
combined$name[combined$name == "san francisco community college district"] = "san francisco community college police"
combined$name[combined$name == "san francisco sheriff's department"] = "san francisco sheriffs department"
combined$name[combined$name == "san francisco state university"] = "san francisco state university police"
combined$name[combined$name == "san joaquin delta college"] = "san joaquin delta college police"
combined$name[combined$name == "san jose/evergreen community college district"] = "san jose/evergreen community college district police"
combined$name[combined$name == "santa ana unified school district police depart."] = "santa ana unified school district police department"
combined$name[combined$name == "santa ana unified school district securty"] = "santa ana unified school district police department"
combined$name[combined$name == "santa barbara airport patrol"] = "santa barbara city airport authority police"
combined$name[combined$name == "santa monica college"] = "santa monica college police"
combined$name[combined$name == "seal beach police beach police"] = "seal beach police department"
combined$name[combined$name == "seal beach police beach"] = "seal beach police beach police"
combined$name[combined$name == "sierra college"] = "sierra community college police"
combined$name[combined$name == "solano county community college district police"] = "solano community college police"
combined$name[combined$name == "solano county community college district"] = "solano community college police"
combined$name[combined$name == "sonoma county junior college district"] = "sonoma county junior college district police"
combined$name[combined$name == "sonoma state univeristy police"] = "sonoma state university police"
combined$name[combined$name == "sonoma state univeristy"] = "sonoma state univeristy police"
combined$name[combined$name == "south orange county community college district"] = "south orange county community college district police"
combined$name[combined$name == "southwestern college"] = "southwestern college police"
combined$name[combined$name == "st helena police department"] = "st. helena police department"
combined$name[combined$name == "stallion police department"] = "stallion springs police department"
combined$name[combined$name == "state center community college district"] = "state center community college district police"
combined$name[combined$name == "stockton unified school district security"] = "stockton unified school district police department"
combined$name[combined$name == "table mountain rancheria tribal police department"] = "table mountain tribal police department"
combined$name[combined$name == "table mountain rancheria tribal police"] = "table mountain tribal police department"
combined$name[combined$name == "turlock police services"] = "turlock police department"
combined$name[combined$name == "university of california berkeley"] = "university of california berkeley police"
combined$name[combined$name == "university of california davis and medical school police"] = "university of california davis police"
combined$name[combined$name == "university of california davis"] = "university of california davis police"
combined$name[combined$name == "university of california hastings college of law"] = "university of california hastings college of law police"
combined$name[combined$name == "university of california irvine"] = "university of california irvine police"
combined$name[combined$name == "university of california los angeles"] = "university of california los angeles police"
combined$name[combined$name == "university of california riverside"] = "university of california riverside police"
combined$name[combined$name == "university of california san diego"] = "university of california san diego police"
combined$name[combined$name == "university of california san francisco"] = "university of california san francisco police"
combined$name[combined$name == "university of california santa barbara"] = "university of california santa barbara police"
combined$name[combined$name == "university of california santa cruz"] = "university of california santa cruz police"
combined$name[combined$name == "ventura co community college district police"] = "ventura college police"
combined$name[combined$name == "ventura college"] = "ventura college police"
combined$name[combined$name == "victor valley college"] = "victor valley community college police"
combined$name[combined$name == "visalia department of public safety"] = "visalia police department"
combined$name[combined$name == "volo port district police"] = "sacramento yolo port district police"
combined$name[combined$name == "west valley mission comm college district police"] = "west valley mission community college district police"
combined$name[combined$name == "west valley mission community college district"] = "west valley mission community college district police"
combined$name[combined$name == "yuba college"] = "yuba college police"
combined$name[combined$name == "carslbad police department"] = "carlsbad police department"

#### save ####

# final space fixes
## turn all multiple spaces into one
combined$name = gsub(pattern = "\\s+", replacement = " ", x = combined$name)
## clean white space
combined$name = trimws(combined$name)

# save combined csllea file
write.csv(combined, "./data/CSLLEA/csllea_combined.csv", row.names = FALSE)









