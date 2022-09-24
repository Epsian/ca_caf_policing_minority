# to combine and clean all of the forfeiture report CSVs

#### setup ####

library(stringr)

# set report csv directory
.csv_dir = "./data/report_data/cleaned/"
# set save location for plain combined
.combined_out = "./data/report_data/report_combined.csv"
# set save location for by agency file
.report_long_out = "./data/report_data/report_long.csv"

# list of all CA counties
.counties = c("ALAMEDA", "ALPINE", "AMADOR", "BUTTE", "CALAVERAS", "COLUSA", "CONTRA COSTA", "DEL NORTE", "EL DORADO", "FRESNO", "GLENN", "HUMBOLDT", "IMPERIAL", "INYO", "KERN", "KINGS", "LAKE", "LASSEN", "LOS ANGELES", "MADERA", "MARIN", "MARIPOSA", "MENDOCINO", "MERCED", "MODOC", "MONO", "MONTEREY", "NAPA", "NEVADA", "ORANGE", "PLACER", "PLUMAS", "RIVERSIDE", "SACRAMENTO", "SAN BENITO", "SAN BERNARDINO", "SAN DIEGO", "SAN FRANCISCO", "SAN JOAQUIN", "SAN LUIS OBISPO", "SAN MATEO", "SANTA BARBARA", "SANTA CLARA", "SANTA CRUZ", "SHASTA", "SIERRA", "SISKIYOU", "SOLANO", "SONOMA", "STANISLAUS", "SUTTER", "TEHAMA", "TRINITY", "TULARE", "TUOLUMNE", "VENTURA", "YOLO", "YUBA")

#### data load ####

# read all report csvs
report_data = lapply(paste(.csv_dir, list.files(.csv_dir), sep = ""), read.csv, header = TRUE, stringsAsFactors = FALSE, )
# combine them
report_data = plyr::rbind.fill(report_data)

# change county column to "reporting_county"
colnames(report_data)[colnames(report_data) == "county"] = "reporting_county"

# save out the by forfeiture data
write.csv(report_data, .combined_out, row.names = FALSE)

#### transform ####
# convert wide to long (so each row is one recipient amount pair)

# by each row
r_list = apply(report_data, 1, function(rrow){
  # take every recipient and amount and make a new row
  
  # max number of recipients
  max_rec = sum(grepl("amt_*", names(rrow)))
  # make output df
  out = data.frame(admin_number = rrow["admin_number"],
                   docket_number = rrow["docket_number"],
                   date_disbursed = rrow["date_disbursed"],
                   reporting_county = rrow["reporting_county"],
                   year = rrow["year"],
                   city = rrow["city"],
                   suspects = rrow["suspects"],
                   offenses = rrow["offenses"],
                   disposition = rrow["disposition"],
                   recipient = unlist(rrow[paste("rec_", 1:max_rec, sep = "")]),
                   amount = unlist(rrow[paste("amt_", 1:max_rec, sep = "")]),
                   row.names = 1:max_rec)
  
  # remove rows with NA in recipients to save time on rbind later
  out = out[!is.na(out$amount), ]
  
  # return
  return(out)
  
})

# combine all dataframes
report_long = do.call(rbind, r_list)

#### make county of recipients ####

# make empty column
report_long$county = NA

# if the name of the county in is the recipient, copy to county
report_long$county = str_match(toupper(report_long$recipient), "(ALAMEDA|ALPINE|AMADOR|BUTTE|CALAVERAS|COLUSA|CONTRA COSTA|DEL NORTE|EL DORADO|FRESNO|GLENN|HUMBOLDT|IMPERIAL|INYO|KERN|KINGS|LAKE|LASSEN|LOS ANGELES|MADERA|MARIN|MARIPOSA|MENDOCINO|MERCED|MODOC|MONO|MONTEREY|NAPA|NEVADA|ORANGE|PLACER|PLUMAS|RIVERSIDE|SACRAMENTO|SAN BENITO|SAN BERNARDINO|SAN DIEGO|SAN FRANCISCO|SAN JOAQUIN|SAN LUIS OBISPO|SAN MATEO|SANTA BARBARA|SANTA CLARA|SANTA CRUZ|SHASTA|SIERRA|SISKIYOU|SOLANO|SONOMA|STANISLAUS|SUTTER|TEHAMA|TRINITY|TULARE|TUOLUMNE|VENTURA|YOLO|YUBA)")[, 2]

# make counties that are conditional on recipient_county data
conditional_counties = apply(report_long, 1, FUN = function(r_row){

  # make df for testing and output
  r_row_df = data.frame(t(data.frame(r_row, stringsAsFactors = FALSE)), stringsAsFactors = FALSE)
  
  
  
  # for each row, if recipient is DA OFFICE, copy reporting county to county
  if(r_row_df$recipient == "DA OFFICE" & !is.na(r_row_df$recipient)){r_row_df$county = r_row_df$reporting_county}
  if(r_row_df$recipient == "DA" & !is.na(r_row_df$recipient)){r_row_df$county = r_row_df$reporting_county}
  
  # return
  return(r_row_df)
  
})

# recombine df
report_long_counties = do.call(rbind, conditional_counties)

#### clean recipient names ####

# load in clean function
source("./src/etl/1.2_clean_long_report.R")

# run it
report_long_counties = clean_recipient_names(report_long_counties)

# for some reason these character will not work if in function, do in manually
report_long_counties$admin_number = gsub("â€”", "-", report_long_counties$admin_number)
report_long_counties$docket_number = gsub("â€”", "-", report_long_counties$docket_number)
report_long_counties$recipient = gsub("â€”", "-", report_long_counties$recipient)
report_long_counties$recipient = gsub("15% - 11489(â€˜DA A", "15% - 11489", report_long_counties$recipient, fixed = TRUE)
report_long_counties$recipient[report_long_counties$recipient == "15% - 11489(â€˜DA A"] = "15% - 11489"

#### save ####

# save this out so I don't have to run it again
write.csv(report_long_counties, .report_long_out, row.names = FALSE)
