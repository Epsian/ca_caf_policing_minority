# Descriptive table of dataset

# setup ####

library(flextable)
library(skimr)

options(scipen = 999)

source("./documents/lsi_sub/multivariate_models.R")

# table ####

table_meta = final_data[row.names(n2p$model), c("name", "year", "num_forfeitures", "jur_perc_black", "jur_perc_hisp", "jur_perc_pov", "jur_perc_home_own", "jur_perc_foreign_born", "jur_perc_male_18_24", "drug_r_10000", "violent_r_10000", "revenue_r_10000", "jur_race_quint_blau")]

table_data = final_data[row.names(n2p$model), c("num_forfeitures", "jur_perc_black", "jur_perc_hisp", "jur_perc_pov", "jur_perc_home_own", "jur_perc_foreign_born", "jur_perc_male_18_24", "drug_r_10000", "violent_r_10000", "revenue_r_10000", "jur_race_quint_blau")]

colnames(table_data) = c("Number of Forfeitures", "% Black", "% LatinX", "% Poverty", "% Own Home", "% Foreign Born", "% Male 18-24", "Drug Crime (/10,000)", "Violent Crime (/10,000)", "Revenue (/10,000)", "Blau's Index")

#table_data = table_data[complete.cases(table_data), ]

my_skim = skim_with(numeric = sfl(mean = ~mean(., na.rm = TRUE), median = ~median(., na.rm = TRUE), minimum = ~min(., na.rm = TRUE), maximum = ~max(., na.rm = TRUE)))

sum_stats = my_skim(table_data)

sum_stats = as.data.frame(sum_stats[,c("skim_variable", "numeric.mean", "numeric.sd", "numeric.median", "numeric.minimum", "numeric.maximum")])

sum_stats[,-1] = round(sum_stats[,-1], digits = 2)

sum_stats$data_col = apply(table_data, 2, FUN = function(x){
  x = x[!is.na(x)]
  x = list(unname(x))
  return(x)
  })

sum_stats$data_col = unlist(sum_stats$data_col, recursive = FALSE)

out_table = flextable(sum_stats) %>%
  compose(j = "data_col", value = as_paragraph(
    plot_chunk(value = data_col, type = "dens", col = "black", 
               width = 1, height = .4, free_scale = TRUE)
  )) %>%
  set_header_labels(skim_variable = "Variable", numeric.mean = "Mean", numeric.sd = "SD", numeric.median = "Median", numeric.minimum = "Minimum", numeric.maximum = "Maximum", data_col = "Density") %>%
  theme_booktabs() %>%
  set_table_properties(layout = "autofit", width = 1)

flextable::save_as_docx(out_table, path = "./documents/lsi_sub/tables/descriptive_table.docx")
