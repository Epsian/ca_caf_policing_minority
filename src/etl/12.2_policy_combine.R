# to combine policy document data with the rest of the dataset

# setup ####

library(future)
library(future.apply)
library(stringdist)

# how to parallel?
plan(multisession, workers = 4)

# in/out ####

# get af data
forf = read.csv("./data/intermediate_data/11_full_data.csv", header = TRUE, stringsAsFactors = FALSE)
forf = unique(forf)

# get policy data
policy = read.csv("./data/all_policy.csv", header = TRUE, stringsAsFactors = FALSE)
# subset
policy = policy[, c("name", "policy_date", "lexipol_b", "af_dummy")]

# combine ####

## direct match fixes ####

# general fixes
policy$name = tolower(policy$name)
policy$name = gsub("department_of_public_safety", replacement = "police", policy$name)
policy$name = gsub("department", replacement = "", policy$name)
policy$name = gsub("office", replacement = "", policy$name)
policy$name = gsub("sheriff's", replacement = "sheriff", policy$name)
policy$name = gsub("county", replacement = "", policy$name)
policy$name = gsub("mt\\.", replacement = "mount", policy$name)
policy$name = gsub("\\b?cp?su\\b", " california state university ", policy$name)
policy$name = gsub("\\b?uc\\b", " university of california ", policy$name)

policy$name = gsub("_", replacement = " ", policy$name)
policy$name = gsub("\\s+", replacement = " ", policy$name)
policy$name = trimws(policy$name)

# specific fixes

policy[policy$name == "nappa sheriff", "name"] = "napa sheriff"
policy[policy$name == "	california state university northridge of police services", "name"] = "california state university northridge police"
policy[policy$name == "saint helena police", "name"] = "st helena police"
policy[policy$name == "union city", "name"] = "union city police"
policy[policy$name == "chaffey community college district police", "name"] = "chaffey college police"
policy[policy$name == "cuesta college of public safety", "name"] = "cuesta college police"
policy[policy$name == "el camino community college district police", "name"] = "el camino college police"
policy[policy$name == "santa ana unified school district police", "name"] = "santa ana school police"

# remove duplicates
policy = unique(policy)

## direct match those that can be ####

# direct match
direct_match = merge(forf, policy, by = "name")

# get those that did not match
no_match = policy[!(policy$name %in% forf$name), ]
# reindex
row.names(no_match) = 1:nrow(no_match)

## approximate match testing ####

# match viewer
match_viewer = forf[, c("county", "name")]
match_viewer$nomatch_name = no_match$name[amatch(forf$name, no_match$name, method = "jw")]
match_viewer = unique(match_viewer)
match_viewer = match_viewer[!(match_viewer$name %in% direct_match$name),]

# hand verified, no more matches possible

# final matches ####
all_matches = merge(forf, policy, by = "name", all.x = TRUE)

# check
if(nrow(all_matches) != nrow(forf)){stop("12.2: Duplicated agencies after matching policy variables!")}

# save ####

write.csv(all_matches, "./data/intermediate_data/12_dept_policy.csv", row.names = FALSE)




