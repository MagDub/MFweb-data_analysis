
source('D:/MFweb/data_analysis/10_stats/make_pval_u_.R')
source('D:/MFweb/data_analysis/10_stats/make_pval_c.R')

library(Hmisc)
library(corrplot)
library(ggpubr)
library(ggplot2)
library(ppcor)

fct_cor_mat_param_LH <- function() {
  
  load(file = "./all_data.Rdata")
  
  # Choose which ones to keep
  data_ <- data_all[, c('xi_LH', 'eta_LH', 'sgm0_LH', 'Q0', 'average_first_apple_LH')]
  
  # Corr mat
  cor_5 <- rcorr(as.matrix(data_))
  r_mat_all <- cor_5$r
  p_mat_all <- cor_5$P
  
  # select column of interest
  p_mat_biv = p_mat_all[c("average_first_apple_LH"),c("xi_LH", "eta_LH", "sgm0_LH", "Q0")]
  r_mat_biv = r_mat_all[c("average_first_apple_LH"),c("xi_LH", "eta_LH", "sgm0_LH", "Q0")]
  
  
  ## Bivariate
  
  # make df with r
  df_r_biv=as.data.frame(r_mat_biv)
  p_mat_biv_bon = matrix(p.adjust(c(p_mat_biv), method = "bonferroni", n = length(c(p_mat_biv))), 
                         dimnames=list(rownames(df_r_biv), colnames(df_r_biv)))
  df_p_c=as.data.frame(p_mat_biv_bon)
  df_p_u=as.data.frame(p_mat_biv)
  
  # output
  output_biv=paste(
    "Bonferroni corrected (n=", length(c(p_mat_biv)), ") correlations for parameters",
    ": average_first_apple_LH and LH_epsilon: R=", 
    round(df_r_biv['xi_LH',],3),", ", make_pval_c(df_p_c['xi_LH',]),", ", make_pval_u_(df_p_u['xi_LH',]), 
    "; average_first_apple_LH and LH_eta: R=", 
    round(df_r_biv['eta_LH',],3),", ", make_pval_c(df_p_c['eta_LH',]),", ", make_pval_u_(df_p_u['eta_LH',]), 
    "; average_first_apple_LH and LH_sgm0: R=", 
    round(df_r_biv['sgm0_LH',],3),", ", make_pval_c(df_p_c['sgm0_LH',]),", ", make_pval_u_(df_p_u['sgm0_LH',]), 
    "; average_first_apple_LH and Q0: R=", 
    round(df_r_biv['Q0',],3),", ", make_pval_c(df_p_c['Q0',]),", ", make_pval_u_(df_p_u['Q0',]), 
    sep='') 
  
  
  ## Partial
  
  # adjust R value (partial correlation)
  data_part_ <- data_all[, c('xi_LH', 'eta_LH', 'sgm0_LH', 'Q0', 'average_first_apple_LH', 'age', 'IQscore')]
  y_data=data.frame(data_part_[complete.cases(data_part_), ]) # remove nans and convert to df
  
  # same col names as r_mat_biv
  r_mat_partial = r_mat_biv
  r_mat_partial['xi_LH']=pcor.test(y_data$average_first_apple_LH, y_data$xi_LH, y_data[,c("age","IQscore")])$estimate
  r_mat_partial['eta_LH']=pcor.test(y_data$average_first_apple_LH, y_data$eta_LH, y_data[,c("age","IQscore")])$estimate
  r_mat_partial['sgm0_LH']=pcor.test(y_data$average_first_apple_LH, y_data$sgm0_LH, y_data[,c("age","IQscore")])$estimate
  r_mat_partial['Q0']=pcor.test(y_data$average_first_apple_LH, y_data$Q0, y_data[,c("age","IQscore")])$estimate
  
  # same col names as p_mat_biv
  p_mat_partial = p_mat_biv
  p_mat_partial['xi_LH']=pcor.test(y_data$average_first_apple_LH, y_data$xi_LH, y_data[,c("age","IQscore")])$p.value
  p_mat_partial['eta_LH']=pcor.test(y_data$average_first_apple_LH, y_data$eta_LH, y_data[,c("age","IQscore")])$p.value
  p_mat_partial['sgm0_LH']=pcor.test(y_data$average_first_apple_LH, y_data$sgm0_LH, y_data[,c("age","IQscore")])$p.value
  p_mat_partial['Q0']=pcor.test(y_data$average_first_apple_LH, y_data$Q0, y_data[,c("age","IQscore")])$p.value
  
  # make df with r
  df_r_partial=as.data.frame(r_mat_partial)
  p_mat_partial_bon = matrix(p.adjust(c(p_mat_partial), method = "bonferroni", n = length(c(p_mat_partial))),
                             dimnames=list(rownames(df_r_partial), colnames(df_r_partial)))
  df_p_c=as.data.frame(p_mat_partial_bon)
  df_p_u=as.data.frame(p_mat_partial)
  
  # output
  output_part=paste(
    "Bonferroni corrected (n=", length(c(p_mat_partial)), ") correlations for parameters",
    ": average_first_apple_LH and LH_epsilon: R=", 
    round(df_r_partial['xi_LH',],3),", ", make_pval_c(df_p_c['xi_LH',]),", ", make_pval_u_(df_p_u['xi_LH',]), 
    "; average_first_apple_LH and LH_eta: R=", 
    round(df_r_partial['eta_LH',],3),", ", make_pval_c(df_p_c['eta_LH',]),", ", make_pval_u_(df_p_u['eta_LH',]), 
    "; average_first_apple_LH and LH_sgm0: R=", 
    round(df_r_partial['sgm0_LH',],3),", ", make_pval_c(df_p_c['sgm0_LH',]),", ", make_pval_u_(df_p_u['sgm0_LH',]), 
    "; average_first_apple_LH and Q0: R=", 
    round(df_r_partial['Q0',],3),", ", make_pval_c(df_p_c['Q0',]),", ", make_pval_u_(df_p_u['Q0',]), 
    sep='')  
  
  
  
  ## Concatenate
  
  output = c('', '',  
             
             'BIVARIATE:', output_biv, '', '',
             'PARTIAL (corrected for age and IQ):', output_part
             )
    
  
  return(output)

}


