# to get text data from department policy documents

# setup ####

library(pdftools)
library(cld2)
library(stringr)
library(future)
library(future.apply)
library(quanteda)
library(quanteda.textmodels)
library(quanteda.textstats)
library(spacyr)
library(stm)
library(stminsights)

# how to parallel?
plan(multisession, workers = 4)

# force re-extract text? (OCR takes a while)
.force_text_extract = FALSE

# in/out ####

# load in full data
forf = read.csv("./data/complete_data_interpolated.csv", stringsAsFactors = FALSE, header = TRUE)

# known no policies from email communication
.no_policy_email = c("University of Southern California police", "santa fe springs police", "university of california irvine police", "Snowline Joint Unified School District police", "Parlier Police", "Ventura County Community College District Police", "Santa Clara University police", "Ventura Port District police", "Exposition Park police", "Cerritos College Police", "Butte County Sheriff", "Danville police", "Claremont College police", "Oakland Housing Authority Police", "Stanford University police", "Occidental College police")

# no AF policies in the policy docs received, TRUE means lexipol policy
.no_policy_docs = c("antioch_police_department" = TRUE, "Alameda County Sheriff's Office" = FALSE, "alameda county district attorney" = FALSE, "alturas police department" = TRUE, "antioch police department" = TRUE, "bay area rapid transit police department" = TRUE, "beverly hills police department" = TRUE, "brawley police department" = TRUE, "Coast Community College District Police Department" = TRUE, "csu bakersfield university police department" = TRUE, "csu east bay university police department" = TRUE, "cuesta college department of public safety" = FALSE, "ferndale police department" = TRUE, "fresno police department" = FALSE, "humboldt state university" = TRUE, "los angeles city department of recreation and park park ranger division" = TRUE, 'marin community college district police department' = TRUE, "napa valley college police department" = TRUE, "ohlone community college district police department" = TRUE, "ross police department" = TRUE, "san benito county sheriff department" = TRUE, "san diego police department" = FALSE, "santa cruz county district attorney" = FALSE, "sebastopol police department" = TRUE, "sonoma state university police and parking services" = TRUE, "southwestern community college police department" = TRUE, "sutter county sheriff's department" = FALSE, "uc merced police department" = TRUE, "ventura county sheriff's department" = TRUE, "victor valley college police department" = FALSE, "west cities police communications center" = FALSE, "arcata police department" = TRUE, "atascadero_police_department" = TRUE, "Cal Poly University Police" = TRUE, "Cal State LA Police Department" = FALSE, "Citrus Community College District Department of Campus Safety" = FALSE, "Claremont Police Department" = FALSE, "Concord Police Department" = FALSE, "CSU Fresno University Police Department" = FALSE, "CSU Fullerton University Police Department" = FALSE, "CSU Long Beach University Police Department" = FALSE, "CSU Northridge Department of Police Services" = FALSE, "CSU San Bernardino University Police Department" = TRUE, "CSU San Jose University Police Department" = FALSE, "Davis Police Department" = FALSE, "El Segundo Police Department" = FALSE, "Eureka Police Department" = TRUE, "Fountain Valley Police Department" = FALSE, "Fremont Police Department" = TRUE, "Garden Grove Police Department" = FALSE, "Glendale Community College District Police Department" = FALSE, "Hermosa Beach Police Department" = FALSE, "Inglewood Police Department" = FALSE, "Kern County Sheriff's Department" = FALSE, "La Mesa Police Department" = TRUE, "Los Angeles Police Department" = FALSE, "Los Angeles World Airports Police Department" = FALSE, "Oakland Police Department" = TRUE, "Oceanside Police Department" = FALSE, "Orange County Sheriff's Department" = TRUE, "Palos Verdes Estates Police Department" = TRUE, "Pasadena City College District Police Department" = TRUE, "Paso Robles Police Department" = TRUE, "Placer County Sheriff's Department" = FALSE, "Riverside County Sheriff's Department" = TRUE, "Sacramento Police Department" = FALSE, "San Bernardino County Sheriff" = FALSE, "San Francisco County Sheriff's Department" = FALSE, "San Francisco Police Department" = FALSE, "San Jose Police Department" = FALSE, "Santa Rosa Junior College Police Department" = FALSE, "Sausalito Police Department" = TRUE, "Simi Valley Police Department" = TRUE, "Solano County Sheriff's Department" = TRUE, "Tehachapi Police Department" = TRUE, "UC Riverside Police Department" = TRUE, "UC San Diego Police Department" = FALSE, "UC San Francisco Police Department" = FALSE, "West Valley-Mission Community College District Police Department" = TRUE, "pasadena_city_college_district_police" = TRUE)

# get all file locations for policy docs
policy = data.frame("name" = NA, "year" = NA, "path" = list.files("./data/department_policy/policy", pattern = ".+\\.pdf", recursive = TRUE, full.names = TRUE), stringsAsFactors = FALSE)

# metadata ####

# get the file name
policy$filename = unlist(future_lapply(strsplit(policy$path, split = "/"), FUN = function(path){path[length(path)]}))

# get the directory
policy$directory = unlist(future_lapply(strsplit(policy$path, split = "/"), FUN = function(path){path[5]}))

# set name as directory (for now, cleaned later)
policy$name = policy$directory

# get report text ####

# check for readable text
policy$has_text = future_sapply(policy$path, FUN = function(doc){nrow(suppressMessages(pdf_fonts(doc))) > 1}, future.seed = TRUE)

# get in raw data, using cache if exists
if(file.exists("./data/department_policy/policy_data_scrape.rds") & .force_text_extract == FALSE){
  raw_policy = readRDS("./data/department_policy/policy_data_scrape.rds")
} else {
  
  # get raw text of all documents
  raw_policy = future_apply(policy, 1, FUN = function(prow){
    
    # if there is good text, use pdf_text
    if(prow["has_text"] == TRUE){out = suppressMessages(pdf_text(prow["path"]))}
    
    # else use OCR
    else {out = pdf_ocr_text(prow["path"])}
    
    # output
    return(out)
    
  })
  
  # save out
  saveRDS(raw_policy, "./data/department_policy/policy_data_scrape.rds")
  
}

# save last used as backup
saveRDS(raw_policy, "./data/department_policy/.policy_data_scrape.rds.bac")

# get date from lexipol copyright

policy$policy_date = future_sapply(raw_policy, FUN = function(rplist){
  
  # get all dates from the lexipol copyrights
  cr_dates = str_match(rplist, "Copyright Lexipol, LLC (\\d{4}\\/\\d{1,2}\\/\\d{1,2}), All Rights Reserved.")[,2]
  
  # drop NAs
  cr_dates = cr_dates[!is.na(cr_dates)]
  
  # if they are all the same, output date
  if(length(unique(cr_dates)) == 1){
    
    # get date
    cr_date = unique(cr_dates)
    
    # set a warning if that one is an NA
    if(is.na(cr_date)){warning("!!! Date from lexipol corpyright is NA")}
    
    # return
    return(cr_date)
  } else if(length(cr_dates) == 0) {
    
    # no date found in this document, so just silently return NA
    return(NA)
    
  } else {
    
    # get counts of different dates
    dates_table = table(cr_dates)
    
    # get percentage of each
    dates_perc = dates_table / sum(dates_table)
    
    # if the most common date is over 95% previlent, use that, otherwise NA
    common_date = ifelse(max(dates_perc) >= .95, names(dates_perc)[which(dates_perc == max(dates_perc))], NA)
    
    if(is.na(common_date)){
      
      # give warning and return NA
      warning("!!! There are mutiple dates coming from the lexipol copyrights. Returning NA.")
      
      # return
      return(NA)
      
    } else {
      
      # if there is a date, return
      return(common_date)
      
    }
    
  }
  
})

# quality control ####

# test if output is gibberish (no language detected)

policy$gib_perc = future_sapply(raw_policy, FUN = function(plist){
  
  # run language detect over list of pages
  langs = detect_language(plist)
  
  # get number of NA percentage
  gib_perc = sum(is.na(langs)) / length(langs)
  
  # return
  return(gib_perc)
  
}, future.seed = TRUE) * 100

# detect lexipol

policy$lexipol = future_sapply(raw_policy, FUN = function(plist){
  
  # is lexipol in this document?
  return(sum(str_detect(plist, "[lL]exipol")))
  
})

# clean text - headers/footers ####

# make copy
clean_policy = raw_policy

# phrases to remove
.phrases_to_drop = c("Copyright Lexipol, LLC \\d{4}/\\d{2}/\\d{2}, All Rights Reserved\\.", "Published with permission by .+$", "\\([a-z]\\)")

# cleaning function
# most obsolete with subsetting of just asset forfeiture sections, but does not hurt
clean_headers_footers = function(raw_policy_string){
  
  # find table of contents pages and replace with NA
  # look for at least 10 periods in a row, with or without spaces between them
  cleaned_string = ifelse(str_count(raw_policy_string, "\\.\\s?\\.") >= 5, NA, raw_policy_string)
  
  # remove new lines
  cleaned_string = str_replace_all(cleaned_string, pattern = "\n", " ")
  
  # remove headers
  cleaned_string = str_replace_all(cleaned_string, pattern = ".+\\n\\n\\n", " ")
  
  # remove phrases
  for(phrase in .phrases_to_drop){
    cleaned_string = str_replace_all(cleaned_string, phrase, " ")
  }
  
  # remove policy symbol
  cleaned_string = str_replace_all(cleaned_string, pattern = "§", " ")
  
  # remove numbers
  cleaned_string = str_replace_all(cleaned_string, pattern = "[+-]?([0-9]*[.])?[0-9]+", " ")
  
  # collapse spaces
  cleaned_string = str_replace_all(cleaned_string, pattern = "\\s+", " ")
  
  # trim ws
  cleaned_string = trimws(cleaned_string)
  
  # remove page numbers if they are the very last text on the page
  cleaned_string = str_remove_all(cleaned_string, pattern = "\\d{1,3}$")
  
  # trim ws
  cleaned_string = trimws(cleaned_string)
  
  # return
  return(cleaned_string)
  
}

## apply to raw policies ####
striped_policy = future_lapply(clean_policy, FUN = clean_headers_footers)

## create text blobs ####

# remove NAs
striped_policy = lapply(striped_policy, FUN = function(cpol){cpol[!is.na(cpol)]})

# blob-ify
policy_blobs = unlist(future_lapply(striped_policy, paste0, collapse = " "))

# spacy entity recognition ####

# start spacy
spacy_initialize(model = "en_core_web_lg")

# parse blobs
spacy_text = spacy_parse(policy_blobs, tag = FALSE, lemma = FALSE, entity = TRUE, nounphrase = FALSE)

# concatenate entities together
spacy_text_c = entity_consolidate(spacy_text)

# close spacy
spacy_finalize()

# turn back into blobs
policy_blobs_c = as.list(by(spacy_text_c, INDICES = list(spacy_text_c$doc_id), FUN = function(text_rows){
  cat_text = paste(text_rows$token, collapse = " ")
  return(cat_text)
}))

# fix order of list elements
.buffer = str_replace_all(names(policy_blobs_c), pattern = "text", replacement = "00")
names(policy_blobs_c) = str_extract_all(.buffer, "\\d{3}$", simplify = TRUE)
policy_blobs_c = policy_blobs_c[order(names(policy_blobs_c))]

# unlist
policy_blobs_c = unlist(policy_blobs_c)

## create cleaning function ####

# cleaning function
# most obsolete with subsetting of just asset forfeiture sections, but does not hurt
clean_raw_policy = function(raw_policy_string){
  
  # concat 'los'/'san'
  cleaned_string = str_replace_all(raw_policy_string, pattern = "los\\s{1,3}", "los_")
  cleaned_string = str_replace_all(cleaned_string, pattern = "san\\s{1,3}", "san_")
  
  # collapse spaces
  cleaned_string = str_replace_all(cleaned_string, pattern = "\\s+", " ")
  
  # trim ws
  cleaned_string = trimws(cleaned_string)
  
  # return
  return(cleaned_string)
  
}

## apply to raw policies ####
clean_policy = future_lapply(policy_blobs_c, FUN = clean_raw_policy)

### lematization ####

policy_blobs = textstem::lemmatize_strings(clean_policy)
policy_blobs = str_replace_all(policy_blobs, " _ ", "_")

# Text processing ####

## to lower ####

policy_blobs = tolower(policy_blobs)

### stopwords ####

policy_blobs = unlist(lapply(policy_blobs, FUN = function(blob){
  
  # remove stopwords
  clean_blobs = tm::removeWords(blob, stopwords())
  
  # collapse spaces
  clean_blobs = str_replace_all(clean_blobs, pattern = "\\s+", " ")
  
  # trim ws
  clean_blobs = trimws(clean_blobs)
  
  return(clean_blobs)
  
}))

# text corpus ####

# make corpus
pcor = corpus(policy_blobs, docnames = policy$name)

# add metadata
docvars(pcor, "lexipol") = policy$lexipol > 0
docvars(pcor, "date") = policy$policy_date

# make tokens object
pdfm = tokens(pcor, remove_punct = TRUE, remove_symbols = TRUE, remove_numbers = TRUE, remove_separators = TRUE) %>% dfm()

# see document similarities
doc_sim = textstat_simil(pdfm, method= "cosine", margin = "documents", min_simil = 0.2)

# topic models - Asset forfeiture only ####

## disabled due to low variation in policy documents !!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
## add lexipol dummy to policy df
#policy$lexipol_b = ifelse(policy$lexipol > 0, "TRUE", "FALSE")
#
## process text
#stm_text = textProcessor(policy_blobs_c,
#                         metadata = policy,
#                         lowercase = TRUE,
#                         removestopwords = TRUE,
#                         removenumbers = TRUE,
#                         removepunctuation = TRUE,
#                         stem = FALSE,
#                         customstopwords = c("forfeiture", "seize", "seizure", "asset", "property", "policy"))
#
## prep documents
#stm_docs = prepDocuments(stm_text$documents, stm_text$vocab, stm_text$meta, lower.thresh = 5)
#
## find best k
#stm_K = searchK(documents = stm_docs$documents, vocab = stm_docs$vocab, K = c(5,7,9,11,13,15,17,19), init.type = "Spectral")
#
#plot(stm_K)
#
## help find model
#stm_select = selectModel(documents = stm_docs$documents, vocab = stm_docs$vocab,
#                         K = 15, data = stm_docs$meta, runs = 50,
#                         prevalence = ~lexipol_b,
#                         init.type = "Spectral")
#
#plotModels(stm_select)
#
## pick the best model run
#stm_model = stm_select$runout[[6]]
#
## plot model
#plot(stm_model)
#plot(stm_model, type="labels")
#sageLabels(stm_model)
#plot(stm_model, type="hist")
#plot(stm_model, type="perspectives", topics = c(7, 11))
#
#labelTopics(stm_model)
#topicQuality(model = stm_model, documents = stm_docs$documents)
#
#findThoughts(stm_model, texts = policy_blobs_c)
#
#stm_est = estimateEffect(formula = ~lexipol_b, stm_model, metadata = stm_docs$meta)
#
#plot.estimateEffect(stm_est, stm_model, topics = c(1:15), covariate="lexipol_b",
#                    method = "difference", cov.value1 = "TRUE", cov.value2 = "FALSE",
#                    main = "test")
#
#plot(topicCorr(stm_model))
#
## viewer
#
#out = list(documents = stm_docs$documents, vocab = stm_docs$vocab, meta = stm_docs$meta)
#
#save.image("./stm_test.RData")
#
#stminsights::run_stminsights()



# After text analyses -------------------------------------------------------------------------------------------------------------------------------------------

# add info vars
policy$lexipol_b = ifelse(policy$lexipol > 0, "TRUE", "FALSE")
policy$af_dummy = TRUE
policy$year = lubridate::year(policy$policy_date)

# add those with no known policy ####

# make dataframe of no policies from emails
no_policy_1 = data.frame("name" = .no_policy_email, "year" = NA, "af_dummy" = FALSE, "lexipol_b" = NA, stringsAsFactors = FALSE)

# make dataframe of no af policy for docs
no_policy_2 = data.frame("name" = names(.no_policy_docs), "year" = NA, "af_dummy" = FALSE, "lexipol_b" = .no_policy_docs, stringsAsFactors = FALSE)

# bind together
no_policy = rbind(no_policy_1, no_policy_2)
rm(no_policy_1, no_policy_2)

row.names(no_policy) = 1:nrow(no_policy)

# bind together with those with policies
all_policy = plyr::rbind.fill(policy, no_policy)

# save ####

# policy doc
write.csv(all_policy, "./data/all_policy.csv", row.names = FALSE)

# policy dfm
saveRDS(pdfm, "./data/af_pol_dfm.rds")






