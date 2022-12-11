# marginal effect plot

# packages
library(ggplot2)
library(gtsummary)
library(ggeffects)
library(ggpubr)
library(sandwich)
library(lmtest)
library(texreg)
library(flextable)

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

final_data$log_black = log10(final_data$jur_perc_black)

final_outliers = glm(num_forfeitures ~
                       log_black +
                       I(log10(jur_perc_hisp)) +
                       jur_perc_pov +
                       jur_perc_male_18_24 +
                       jur_perc_home_own +
                       jur_perc_foreign_born +
                       drug_r_10000 +
                       violent_r_10000 +
                       revenue_r_10000 + jur_race_quint_blau +
                       I(scale(jur_perc_black, scale = FALSE)):I(scale(jur_perc_pov, scale = FALSE)),
                     data = final_data, family = "poisson")

# find outliers
.outliers2 = car::outlierTest(final_outliers, n.max = 9999)

#remove
final_data_r = final_data[-as.numeric(names(.outliers2$rstudent))[.outliers2$bonf.p < .05],]

final_model_r = glm(num_forfeitures ~
                      log_black +
                      I(log10(jur_perc_hisp)) +
                      jur_perc_pov +
                      jur_perc_male_18_24 +
                      jur_perc_home_own +
                      jur_perc_foreign_born +
                      drug_r_10000 +
                      violent_r_10000 + 
                      revenue_r_10000 + jur_race_quint_blau +
                      I(scale(jur_perc_black, scale = FALSE)):I(scale(jur_perc_pov, scale = FALSE)),
                    data = final_data_r, family = "poisson")

final_model_data = final_data_r[row.names(final_model_r$model), ]

# run models ####

n1p = glm(num_forfeitures ~
            log_black +
            I(log10(jur_perc_hisp)) +
            jur_perc_pov +
            jur_perc_male_18_24 +
            jur_perc_foreign_born +
            drug_r_10000 +
            violent_r_10000 +
            revenue_r_10000 + jur_race_quint_blau,
          data = final_data, family = "poisson")

n1p_r = coeftest(n1p, vcov. = vcovCL, cluster = ~name + year)

n2p = glm(num_forfeitures ~
            log_black +
            I(log10(jur_perc_hisp)) +
            jur_perc_pov +
            jur_perc_male_18_24 +
            jur_perc_home_own +
            jur_perc_foreign_born +
            drug_r_10000 +
            violent_r_10000 +
            revenue_r_10000 + jur_race_quint_blau +
            I(scale(jur_perc_black, scale = FALSE)):I(scale(jur_perc_pov, scale = FALSE)),
          data = final_data, family = "poisson")

n2p_r = coeftest(n2p, vcov. = vcovCL, cluster = ~name + year)

# plot

# get predicted probabilities for number models
e_num_black = ggpredict(n2p, "log_black[by=0.01")
e_num_fb = ggpredict(n2p, "jur_perc_foreign_born[0:50 by=1]")

# make plots
num_plots = ggarrange(
  plot(e_num_black, limits = c(0, 30), show.title = FALSE) + xlab("Logged % Black") + ylab("Number of Seizures") + scale_x_continuous(limits = c(0, 2)),
  plot(e_num_fb,  limits = c(0, 30), show.title = FALSE) + xlab("% Foreign Born") + ylab("Number of Seizures"),
  nrow = 1, ncol = 2
)


# arrange plots
num_plots

