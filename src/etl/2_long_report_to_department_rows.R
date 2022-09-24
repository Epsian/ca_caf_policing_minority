# to take the long form of reports and convert to one row per department

#### setup ####

.long_report_loc = "./data/report_data/report_long.csv"

.rec_year_out = "./data/report_data/rec_year_reports.csv"

#### data load ####

report = read.csv(.long_report_loc, header = TRUE, stringsAsFactors = FALSE)

#### aggregate by recipient ####

rec_agg = by(report, report$recipient, function(rec){
  
  # split again by year
  year_by = by(rec, rec$year, function(yrs){
    
    # make new dataframe row
    year_summary = data.frame("recipient" = yrs$recipient[1],
                              "year" = yrs$year[1],
                              "county" = NA,
                              "reporting_county" = NA,
                              "mean_suspects" = mean(yrs$suspects, na.rm = TRUE),
                              "num_forfeitures" = nrow(yrs),
                              "amount_forfeitures" = sum(yrs$amount),
                              "mean_forfeitures" = mean(yrs$amount),
                              "median_forfeitures" = median(yrs$amount),
                              "dispo_no_charge" = sum(yrs$disposition == "No Charge" | yrs$disposition == "No Charges", na.rm = TRUE),
                              "dispo_acquittal" = sum(yrs$disposition == "Acquittal", na.rm = TRUE),
                              "dispo_dropped" = sum(yrs$disposition == "Dropped charges" | yrs$disposition == "Dropped Charges", na.rm = TRUE),
                              "dispo_jury_conviction" = sum(yrs$disposition == "Jury conviction" | yrs$disposition == "Jury Conviction", na.rm = TRUE),
                              "dispo_plea" = sum(yrs$disposition == "Plea agreement" | yrs$disposition == "Plea Agreement", na.rm = TRUE),
                              "dispo_other" = sum(yrs$disposition == "Other", na.rm = TRUE),
                              stringsAsFactors = FALSE)
    
    # turn mean_suspects to NA if NaN
    if(is.nan(year_summary$mean_suspects)){year_summary$mean_suspects = NA}
    
    # if prior to 2017, set dispositions to NA
    if(as.numeric(year_summary$year) < 2017){year_summary[, c("dispo_no_charge", "dispo_acquittal", "dispo_dropped", "dispo_jury_conviction", "dispo_plea", "dispo_other")] = NA}
    
    # if all reporting counties are the same, keep
    if(all(yrs$county == yrs$county[1]) & !any(is.na(yrs$county))){year_summary$county = yrs$county[1]}
    # if all counties are the same, keep
    if(all(yrs$reporting_county == yrs$reporting_county[1]) & !any(is.na(yrs$county))){year_summary$reporting_county = yrs$reporting_county[1]}
    
    # return year summary row
    return(year_summary)
    
  })
    
  # bind year summaries
  year_df = do.call(rbind, year_by)
  
  # return
  return(year_df)
  
})

# combine data frames
rec_agg = do.call(rbind, rec_agg)
# reset row names
row.names(rec_agg) = 1:nrow(rec_agg)

#### save ####

write.csv(rec_agg, .rec_year_out, row.names = FALSE)







