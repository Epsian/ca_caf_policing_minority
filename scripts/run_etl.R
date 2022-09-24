# run the etl process

# this code will run all steps of the ETL from scratch.
source("./scripts/csllea_combine.R", echo = TRUE)
source("./scripts/lemas_combine.R", echo = TRUE)
source("./scripts/raw_census_download.R", echo = TRUE)

source("./src/etl/1.1_combine_report_data.R", echo = TRUE)
source("./src/etl/2_long_report_to_department_rows.R", echo = TRUE)
source("./src/etl/3_combine_lemas_csllea.R", echo = TRUE)
source("./src/etl/4_revenue_add.R", echo = TRUE)
source("./src/etl/5_create_clearance_ratios.R", echo = TRUE)
source("./src/etl/6_report_crosswalk_merge.R", echo = TRUE)
source("./src/etl/7_report_context_merge.R", echo = TRUE)
source("./src/etl/8_census_combine.R", echo = TRUE)
source("./src/etl/9_census_match.R", echo = TRUE)
source("./src/etl/10_drug_arrests.R", echo = TRUE)
source("./src/etl/11_logic_fill.R", echo = TRUE)
source("./src/etl/12.1_policy_text.R", echo = TRUE)
source("./src/etl/12.2_policy_combine.R", echo = TRUE)
source("./src/etl/13_data_transform.R", echo = TRUE)
