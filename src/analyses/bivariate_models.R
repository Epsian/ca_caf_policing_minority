# to run bivaraite models between number of seizures and all others

# setup ####

# packages
library(ggplot2)
library(gtsummary)
library(ggeffects)
library(ggpubr)
library(sandwich)
library(lmtest)
library(texreg)

options(scipen = 999)

# load in cleaned dataset
#af_data = read.csv("./data/complete_data.csv", stringsAsFactors = FALSE, header = TRUE)
af_data = read.csv("./data/complete_data_interpolated.csv", stringsAsFactors = FALSE, header = TRUE)

# set default model data
model_data = af_data

# set years to factor
model_data$year = as.factor(model_data$year)

# load in long dataset
af_long = read.csv("./data/report_data/report_long.csv", stringsAsFactors = FALSE, header = TRUE)

# for diagnostic, cases used in model
model_complete = af_data[, c("name", "num_forfeitures", "mean_forfeitures", "estimate.total_pop", "jur_perc_black", "jur_perc_hisp", "jur_race_quint_blau", "jur_perc_home_own", "jur_perc_foreign_born", "jur_perc_male_18_24", "jur_perc_pov", "revenue_r_10000", "property_r_10000", "drug_r_10000", "year")]

model_complete = model_complete[complete.cases(model_complete),]

# set model data #### ----------------------------------------------------------

# set default model data
final_data = af_data

# set years to factor
final_data$year = as.factor(final_data$year)

final_outliers = glm(num_forfeitures ~
                       I(log10(jur_perc_black)) +
                       jur_perc_hisp + I(jur_perc_hisp^2) +
                       I(log10(estimate.total_pop)) +
                       drug_r_10000 +
                       jur_perc_pov + 
                       jur_perc_male_18_24 +
                       jur_perc_home_own +
                       jur_perc_foreign_born +
                       revenue_r_10000 + jur_race_quint_blau +
                       I(log10(jur_perc_black)):jur_perc_pov + jur_perc_hisp:jur_perc_pov,
                     data = final_data, family = "poisson")

# find outliers
.outliers2 = car::outlierTest(final_outliers, n.max = 9999)

#remove
final_data_r = final_data[-as.numeric(names(.outliers2$rstudent))[.outliers2$bonf.p < .05],]

final_model_r = glm(num_forfeitures ~
                      I(log10(jur_perc_black)) +
                      jur_perc_hisp + I(jur_perc_hisp^2) +
                      I(log10(estimate.total_pop)) +
                      drug_r_10000 +
                      jur_perc_pov + 
                      jur_perc_male_18_24 +
                      jur_perc_home_own +
                      jur_perc_foreign_born +
                      revenue_r_10000 + jur_race_quint_blau +
                      I(log10(jur_perc_black)):jur_perc_pov + jur_perc_hisp:jur_perc_pov,
                    data = final_data_r, family = "poisson")

final_model_data = final_data_r[row.names(final_model_r$model), ]

# bivariate models #### --------------------------------------------------------

p_black = glm(num_forfeitures ~ I(log10(jur_perc_black)),
                     data = final_model_data, family = "poisson")

p_black_r = coeftest(p_black, vcov. = vcovCL, cluster = ~name + year)

p_latinx = glm(num_forfeitures ~ I(log10(jur_perc_hisp)),
              data = final_model_data, family = "poisson")

p_latinx_r = coeftest(p_latinx, vcov. = vcovCL, cluster = ~name + year)

p_pov = glm(num_forfeitures ~ jur_perc_pov,
              data = final_model_data, family = "poisson")

p_pov_r = coeftest(p_pov, vcov. = vcovCL, cluster = ~name + year)

p_drug = glm(num_forfeitures ~ drug_r_10000,
            data = final_model_data, family = "poisson")

p_drug_r = coeftest(p_drug, vcov. = vcovCL, cluster = ~name + year)

p_male = glm(num_forfeitures ~ jur_perc_male_18_24,
             data = final_model_data, family = "poisson")

p_male_r = coeftest(p_male, vcov. = vcovCL, cluster = ~name + year)

p_home = glm(num_forfeitures ~ jur_perc_home_own,
             data = final_model_data, family = "poisson")

p_home_r = coeftest(p_home, vcov. = vcovCL, cluster = ~name + year)

p_fb = glm(num_forfeitures ~ jur_perc_foreign_born,
             data = final_model_data, family = "poisson")

p_fb_r = coeftest(p_fb, vcov. = vcovCL, cluster = ~name + year)

p_rev = glm(num_forfeitures ~ revenue_r_10000,
           data = final_model_data, family = "poisson")

p_rev_r = coeftest(p_rev, vcov. = vcovCL, cluster = ~name + year)

p_blau = glm(num_forfeitures ~ jur_race_quint_blau,
            data = final_model_data, family = "poisson")

p_blau_r = coeftest(p_blau, vcov. = vcovCL, cluster = ~name + year)

p_viol = glm(num_forfeitures ~ violent_r_10000,
             data = final_model_data, family = "poisson")

p_viol_r = coeftest(p_viol, vcov. = vcovCL, cluster = ~name + year)

# output table #### ------------------------------------------------------------

htmlreg(list(p_black, p_latinx, p_pov, p_drug, p_male, p_home, p_fb, p_rev, p_blau, p_viol),
        custom.header = list("Number of Seizures" = 1:10),
        override.se = list(p_black_r[,2], p_latinx_r[,2], p_pov_r[,2], p_drug_r[,2], p_male_r[,2], p_home_r[,2], p_fb_r[,2], p_rev_r[,2], p_blau_r[,2], p_viol_r[,2]),
        override.pvalues = list(p_black_r[,4], p_latinx_r[,4], p_pov_r[,4], p_drug_r[,4], p_male_r[,4], p_home_r[,4], p_fb_r[,4], p_rev_r[,4], p_blau_r[,4], p_viol_r[,4]),
        file = "./documents/lsi_sub/tables/bivariate_models.html",
        custom.note = "%stars. Clustered standard errors in parentheses.")

