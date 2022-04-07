
setwd("D:/MFweb/data_analysis/10_stats/additional_analyses")

source("D:/MFweb/data_analysis/10_stats/make_pval.R")

library(tidyverse)
library(readxl)
library(rstatix)
library(data.table)
library(tidyr)
library(lsr)
library(ppcor)

rm_anova_MFweb_F1_cov <- function(x1, x2) {

dataMFweb <- read_excel("../web_data_completed.xlsx", sheet = 'Sheet1') 

# Take only subset: concatenate the ones we want
data_tmp_ <- subset(dataMFweb , select=c("User", "exclude", "age", "IQscore", x1, x2))

# Exclude
data_tmp <- subset(data_tmp_, exclude!=1)

# Compute t-test
res <- t.test(data_tmp[[x1]], data_tmp[[x2]], paired = TRUE)
eff <- cohensD(data_tmp[[x1]], data_tmp[[x2]], method = "paired")

# Output
output = paste('t(',res$parameter[['df']],')=', round(res$statistic[['t']],3),', ' ,make_pval(res$p.value), ', d=',round(eff,3), 
               sep="")

return(output)

}