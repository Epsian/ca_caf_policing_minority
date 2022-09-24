# to clean clearance rate data and create clearance ratio

# setup ####

# package load

library(fastLink)

# data load

# load in lemas, csllea, and revenue data
combined_data = read.csv("./data/intermediate_data/4_rev_lemas_csllea.csv", header = TRUE, stringsAsFactors = FALSE)
# load in clearance rate data
crdf = read.csv("./data/ca_open_justice/crimes_and_clearances/Crimes_and_Clearances_with_Arson-1985-2020.csv", header = TRUE, stringsAsFactors = FALSE)

# clean data ####

# remove any before 2000 (earliest data of interest)
crdf = crdf[crdf$Year >= 2000,]

# lowercase columns
crdf$County = tolower(crdf$County)
crdf$NCICCode = tolower(crdf$NCICCode)

# remove "county" from county column
crdf$County = gsub(" county", "", crdf$County)

# expand contractions
crdf$NCICCode = gsub("^csu ", "california state university ", crdf$NCICCode)
crdf$NCICCode = gsub("^uc ", "university of california ", crdf$NCICCode)
crdf$NCICCode = gsub("^ca ", "california ", crdf$NCICCode)

# remove unwanted words
crdf$NCICCode = gsub(" co\\. ", " ", crdf$NCICCode)
crdf$NCICCode = gsub("department", " ", crdf$NCICCode)
crdf$NCICCode = gsub("office", " ", crdf$NCICCode)

# reformat sherrif
crdf$NCICCode = gsub("sheriff's", "sheriff", crdf$NCICCode)

# add police to anything not sheriff or highway patrol
crdf[!(grepl("sheriff", crdf$NCICCode) | grepl("patrol", crdf$NCICCode)), "NCICCode"] = paste(crdf[!(grepl("sheriff", crdf$NCICCode) | grepl("patrol", crdf$NCICCode)), "NCICCode"], "police")

# create clearance ratio ####

# clearance rate = (number of clearances / number of reported) * 100

# violent crime
crdf$violent_cr = (crdf$ViolentClr_sum / crdf$Violent_sum) * 100

# property crime
crdf$property_cr = (crdf$PropertyClr_sum / crdf$Property_sum) * 100

# combine with previous data ####

# standardize column names
colnames(crdf)[colnames(crdf) == "Year"] = "year"
colnames(crdf)[colnames(crdf) == "NCICCode"] = "name"
colnames(crdf)[colnames(crdf) == "County"] = "county"

# drop raw numbers
crdf = crdf[, c("name", "county", "year", "violent_cr", "property_cr", "Violent_sum", "Property_sum")]

# block by year
year_blocks = blockData(combined_data, crdf, varnames = "year")
names(year_blocks)

## match within year blocks ####

year_block_list = list()

#View(combined_data[year_blocks$block.17$dfA.inds,])
#View(crdf[year_blocks$block.17$dfB.inds,])

for(.blockset in 1:length(year_blocks)){
  
  # subset data sets by block
  # combined_data
  comb_block = eval(parse(text = paste0("combined_data[year_blocks$block.", .blockset, "$dfA.inds,]")))
  # crdf
  crdf_block = eval(parse(text = paste0("crdf[year_blocks$block.", .blockset, "$dfB.inds,]")))
  
  # if one block has a blank matching column, skip
  if(all(is.na(comb_block$name))){next}
  if(all(is.na(crdf_block$name))){next}
  if(all(is.na(comb_block$county))){next}
  if(all(is.na(crdf_block$county))){next}
  
  # match
  match_object = fastLink(comb_block, crdf_block,
                          varnames = c("name", "county"),
                          stringdist.match = c("name", "county"), cut.a = 0.94, #0.94
                          partial.match = c("name"), cut.p = 0.84, #0.88
                          dedupe.matches = TRUE,
                          jw.weight	= .01, # 0.10
                          threshold.match = 0.0001
  )
  
  summary(match_object)
  
  block_matched = getMatches(comb_block, crdf_block, match_object, threshold.match = .70, combine.dfs = TRUE)
  
  year_block_list[[.blockset]] = block_matched
  
}

# combine together
total_df = do.call(rbind, year_block_list)

# remove the gamma and posterior columns
total_df = total_df[, !(colnames(total_df) %in% c("gamma.1", "gamma.2", "posterior"))]

# save out ####
write.csv(total_df, "./data/intermediate_data/5_rates_rev_lemas_csllea.csv", row.names = FALSE)
















