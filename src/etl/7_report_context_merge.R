# match report and crosswalk with context data

# setup ####

# library(fastLink) disable as merge is working for now

# data load
# report_Crosswalk
report_crosswalk_df = read.csv("./data/intermediate_data/6_report_crosswalk.csv", header = TRUE, stringsAsFactors = FALSE)
# load in contextual data on law enforcement agencies
context = read.csv("./data/intermediate_data/5_rates_rev_lemas_csllea.csv", header = TRUE, stringsAsFactors = FALSE)

# Make a total list of agencies from all sources and fill known 0s from reports ####

# make function to do so

zero_add = function(forf, zero_counties, county_key, year){
  
  # remove agencies with no counties
  county_key = county_key[!is.na(county_key$county),]
  
  # find those agencies in counties with 0 reported
  agency_0s = county_key[county_key$county %in% zero_counties,]
  
  # add back year
  agency_0s$year = year
  
  # get other data about agencies
  agency_0s = merge(agency_0s, forf, all.x = TRUE)
  
  # fill in AF NAs with 0s
  agency_0s[is.na(agency_0s$num_forfeitures), c("num_forfeitures", "amount_forfeitures", "mean_suspects", "mean_forfeitures", "median_forfeitures", "dispo_acquittal", "dispo_no_charge", "dispo_dropped", "dispo_jury_conviction", "dispo_plea", "dispo_other")] = 0
  
  # remove those from forf
  forf = dplyr::anti_join(forf, agency_0s, by = c("name", "county", "year"))
  
  # add back in with rbind
  forf = rbind(forf, agency_0s)
  
  # resort
  forf = forf[order(forf$name), ]
  
  # return
  return(forf)
}

# run for each year
county_key = unique(rbind(report_crosswalk_df[, c("name", "county")], context[, c("name", "county")]))

report_crosswalk_df = zero_add(report_crosswalk_df, c("alpine", "amador", "colusa", "del norte", "glenn", "mariposa", "san benito", "sierra"), county_key = county_key, year = 2002)
report_crosswalk_df = zero_add(report_crosswalk_df, c("alpine", "mariposa", "amador", "sierra", "fresno", "tulare", "inyo", "yuba"), county_key = county_key, year = 2003)
report_crosswalk_df = zero_add(report_crosswalk_df, c("alpine", "amador", "del norte", "fresno", "mariposa", "mono", "sierra", "trinity"), county_key = county_key, year = 2004)
report_crosswalk_df = zero_add(report_crosswalk_df, c("alpine", "amador", "mariposa", "modoc", "sierra"), county_key = county_key, year = 2005)
report_crosswalk_df = zero_add(report_crosswalk_df, c("alpine", "mariposa", "nevada", "san benito", "sierra"), county_key = county_key, year = 2006)
report_crosswalk_df = zero_add(report_crosswalk_df, c("alpine", "mariposa", "sierra"), county_key = county_key, year = 2007)
report_crosswalk_df = zero_add(report_crosswalk_df, c("del norte", "mariposa", "sierra"), county_key = county_key, year = 2008)
report_crosswalk_df = zero_add(report_crosswalk_df, c("alpine", "inyo", "mariposa", "modoc", "mono", "sierra"), county_key = county_key, year = 2009)
report_crosswalk_df = zero_add(report_crosswalk_df, c("alpine", "modoc", "amador", "plumas", "del norte", "sierra", "mariposa"), county_key = county_key, year = 2010)
report_crosswalk_df = zero_add(report_crosswalk_df, c("alpine", "calaveras", "lassen", "mariposa", "modoc", "nevada", "sierra"), county_key = county_key, year = 2011)
report_crosswalk_df = zero_add(report_crosswalk_df, c("alpine", "mariposa", "san benito"), county_key = county_key, year = 2012) # These three have NEVER been in the data, thus errors
report_crosswalk_df = zero_add(report_crosswalk_df, c("alpine", "inyo", "mono"), county_key = county_key, year = 2013)
report_crosswalk_df = zero_add(report_crosswalk_df, c("inyo", "mariposa", "mono", "sierra"), county_key = county_key, year = 2014)
report_crosswalk_df = zero_add(report_crosswalk_df, c("inyo", "modoc", "mono"), county_key = county_key, year = 2015)
report_crosswalk_df = zero_add(report_crosswalk_df, c("fresno", "inyo", "modoc", "mono"), county_key = county_key, year = 2016)
report_crosswalk_df = zero_add(report_crosswalk_df, c("inyo", "mono"), county_key = county_key, year = 2017)
report_crosswalk_df = zero_add(report_crosswalk_df, c("inyo", "mariposa", "modoc", "mono"), county_key = county_key, year = 2018)
# report_crosswalk_df = zero_add(report_crosswalk_df, c("alpine", "inyo", "sierra"), county_key = county_key, year = 2019) Not yet integrated

# combine report data with the context data ####

# drop unneeded context
context = context[!(context$name == "los angeles sheriff" & context$city == "lynwood"),]
context = context[!(context$name == "monterey police" & context$city == "salinas"),]
context = context[!(context$name == "solano community college police" & context$city == "suisun city"),]

# fix sf
context = context[!(context$name == "south san francisco police" & context$city == "san francisco" & context$year == 2004),]
context = context[!(context$name == "south san francisco police" & context$city == "san francisco" & context$year == 2008),]
context[context$name == "south san francisco police" & context$city == "san francisco", "city"] = "south san francisco"

## do exact name year pairs first ####

# do match
name_match = merge(context, report_crosswalk_df, by = c("name", "year"), all = TRUE)

# how many name-year pairs appear more than once
table(table(name_match$name, name_match$year) > 1)

# figure out which ones
table(paste0(name_match$name, name_match$year))[table(paste0(name_match$name, name_match$year)) > 1]

# fill in NAs in report_crosswalk_df with data from context if there is an NA
fill_missing_clean = function(df_input, dup_vars){
  
  for(duped in dup_vars){
    df_input[ , duped] <- ifelse(is.na(df_input[ , paste0(duped, ".x")]), df_input[ , paste0(duped, ".y")], df_input[ , paste0(duped, ".x")])
    df_input <- df_input[,-c(match(paste0(duped, ".x"), names(df_input)),match(paste0(duped, ".y"), names(df_input)))]
  }
  return(df_input)
}

name_match = fill_missing_clean(name_match, c("city", "county", "state", "ZIP", "address_comb", "ORI7", "ORI9", "CSLLEA08_ID"))

# fill in missing counties ####

# fill in NAs in post-merge dfs with info from key dfs
fill_missing_clean = function(df_input, dup_vars){
  
  for(duped in dup_vars){
    df_input[ , duped] <- ifelse(is.na(df_input[ , paste0(duped, ".x")]), df_input[ , paste0(duped, ".y")], df_input[ , paste0(duped, ".x")])
    df_input <- df_input[,-c(match(paste0(duped, ".x"), names(df_input)),match(paste0(duped, ".y"), names(df_input)))]
  }
  return(df_input)
}

# fix known errors
name_match[name_match$name == "mammoth lakes police", "county"] = "mono"
name_match[name_match$name == "marina police", "county"] = "monterey"
name_match[name_match$name == "monterey park police", "county"] = "los angeles"
name_match[name_match$name == "placerville police", "county"] = "el dorado"
name_match[name_match$name == "san marino police", "county"] = "los angeles"
name_match[name_match$name == "sierra madre police", "county"] = "los angeles"
name_match[name_match$name == "south san francisco police", "county"] = "san mateo"
name_match[name_match$name == "south lake tahoe police", "county"] = "el dorado"
name_match[name_match$name == "sutter creek police", "county"] = "amador"
name_match[name_match$name == "california state university channel islands police", "county"] = "ventura"
name_match[name_match$name == "california state university fullerton police", "county"] = "orange"


# find all unique combos of name and county
county_key = unique(data.frame(name = name_match$name, county = name_match$county, stringsAsFactors = FALSE))
# drop those with type == NA
county_key = county_key[!is.na(county_key$county), ]

# which ones have more than 1 county?
.multitype_test = table(county_key$name, county_key$county)
rowSums(.multitype_test)[rowSums(.multitype_test) > 1]

# check
if(length(rowSums(.multitype_test)[rowSums(.multitype_test) > 1]) > 0){stop("Agencies have more than one county!")}

# make sure unique
county_key = unique(county_key)

# fill in blanks with clean key

# merge forfeiture data with key of known agencies and their types
forf = merge(name_match, county_key, by = "name", all.x = TRUE)
# de-duplicate columns by filling in NAs with those from key
forf = fill_missing_clean(forf, c("county"))

# save out ####
write.csv(forf, "./data/intermediate_data/7_report_context.csv", row.names = FALSE)





# remove these matches from the dataframes prior to using fastLink
# report_crosswalk_df = report_crosswalk_df[!(paste0(report_crosswalk_df$year, report_crosswalk_df$name) %in% paste0(name_match$year, name_match$name)), ]
# context = context[!(paste0(context$year, context$name) %in% paste0(name_match$year, name_match$name)), ]



## disable fastlink for now.
#
### fastlink matches ####
#
## block by year
#year_blocks = blockData(report_crosswalk_df, context, varnames = "year")
#names(year_blocks)
#
## create empty output
## I know lapply would be faster. I only have 17 chunks and this is easier.
#year_block_list = list()
#
## code to test the blocks
##View(report_crosswalk_df[year_blocks$block.17$dfA.inds,])
##View(context[year_blocks$block.17$dfB.inds,])
#
## loop through blocks and match within year
#for(.blockset in 1:length(year_blocks)){
#  
#  # subset data sets by block
#  # combined_data
#  report_block = eval(parse(text = paste0("report_crosswalk_df[year_blocks$block.", .blockset, "$dfA.inds,]")))
#  # crdf
#  context_block = eval(parse(text = paste0("context[year_blocks$block.", .blockset, "$dfB.inds,]")))
#  
#  # add names for debugging
#  report_block$report_name = report_block$name
#  context_block$context_name = context_block$name
#  
#  # make list of ideal columns to use
#  .varnames_full = c("name", "county", "city", "ZIP", "ORI7", "ORI9", "CSLLEA08_ID", "address_comb")
#  .stringdist.match_full = c("name", "county", "city", "ZIP", "ORI7", "ORI9", "CSLLEA08_ID", "address_comb")
#  .partial.match_full = c("name", "address_comb")
#  
#  # for this block, find if any columns are all NAs
#  report_block_nas = apply(report_block, 2, FUN = function(x){all(is.na(x))})
#  report_block_nas = names(report_block_nas[report_block_nas])
#  context_block_nas = apply(context_block, 2, FUN = function(x){all(is.na(x))})
#  context_block_nas = names(context_block_nas[context_block_nas])
#  
#  # remove those columns from block if it is all NA in either df
#  na_columns = c(report_block_nas, context_block_nas)
#  
#  .varnames_full = .varnames_full[!(.varnames_full %in% na_columns)]
#  .stringdist.match_full = .stringdist.match_full[!(.stringdist.match_full %in% na_columns)]
#  .partial.match_full = .partial.match_full[!(.partial.match_full %in% na_columns)]
#  
#  # match
#  match_object = fastLink(report_block, context_block,
#                          varnames = .varnames_full,
#                          stringdist.match = .stringdist.match_full, cut.a = 0.97, #0.94
#                          partial.match = .partial.match_full, cut.p = 0.90, #0.88
#                          dedupe.matches = TRUE,
#                          jw.weight	= .1, # 0.10
#                          threshold.match = 0.0001
#  )
#  
#  summary(match_object)
#  
#  block_matched = getMatches(report_block, context_block, match_object, threshold.match = .70, combine.dfs = TRUE)
#  
#  year_block_list[[.blockset]] = block_matched
#  
#}
#
## combine together
#total_df = plyr::rbind.fill(year_block_list)
#
## run this to see "good" matches by name to compare for errors (only if included above)
#good_check = total_df[, c("year", "name", "report_name", "context_name", "posterior")]
#good_check$all_good = apply(good_check, 1, FUN = function(good_row){all_good = good_row["name"] == good_row["report_name"] & good_row["name"] == good_row["context_name"]; return(all_good#)})
#
## Run this to see what was not matched - sort out corrections
#View(report_crosswalk_df[!(report_crosswalk_df$name %in% total_df$name),])
#
## clear out matching helpers
#total_df = total_df[, !(colnames(total_df) %in% c("report_name", "context_name", "gamma.1", "gamma.2", "posterior"))]
#rm(good_check)



