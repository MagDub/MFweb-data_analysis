
library(Hmisc)
library(corrplot)
library(ggpubr)
library(ggplot2)
library(readxl)

cor_mat_BIS_param_partial <- function() {
  
  data_demo_tmp <- read_excel("~/MFweb/data_analysis/10_stats/web_data_completed.xlsx")    
  data_demo_all <- subset(data_demo_tmp , select=c("exclude", "age", "IQscore", "BIS11_TotalScore"))
  data_demo <- subset(data_demo_all, exclude!=1)
  
  load(file = "~/MFweb/data_analysis/10_stats/FA/all_behav_and_FAscores.Rdata")
  
  # keep only mean per horizon
  data_tmp_all <- subset(data_tmp_all, select = -c(3:29))
  
  # Choose which ones to keep
  data_all <- data_tmp_all[, c('xi_mean', 'eta_mean', 'sgm0_mean', 'Q0')]
  
  # Concatenate
  data_all[,ncol(data_all)+1] = data_demo[,'BIS11_TotalScore']
  
  # Corr mat
  cor_5 <- rcorr(as.matrix(data_all))
  M <- cor_5$r
  p_mat <- cor_5$P
  
  # select column of interest
  p_vec = p_mat["BIS11_TotalScore",]
  M_vec = M["BIS11_TotalScore",]
  
  # adjust R value (partial correlation)
  data_forpart <- subset(data_demo, select = c("age", "IQscore"))
  data_forpart$BIS11_TotalScore = data_all$BIS11_TotalScore
  data_forpart$xi_mean = data_all$xi_mean
  data_forpart$eta_mean = data_all$eta_mean
  data_forpart$sgm0_mean = data_all$sgm0_mean
  data_forpart$Q0 = data_all$Q0
  data_forpart = data_forpart[complete.cases(data_forpart), ] # remove nans
  y_data=data.frame(data_forpart)
  
  # same col names as M_vec
  M_vec_partial = M_vec
  M_vec_partial["xi_mean"]=pcor.test(y_data$BIS11_TotalScore, y_data$xi_mean, y_data[,c("age","IQscore")])$estimate
  M_vec_partial["eta_mean"]=pcor.test(y_data$BIS11_TotalScore, y_data$eta_mean, y_data[,c("age","IQscore")])$estimate
  M_vec_partial["sgm0_mean"]=pcor.test(y_data$BIS11_TotalScore, y_data$sgm0_mean, y_data[,c("age","IQscore")])$estimate
  M_vec_partial["Q0"]=pcor.test(y_data$BIS11_TotalScore, y_data$Q0, y_data[,c("age","IQscore")])$estimate
  
  # same col names as p_vec
  p_vec_partial = p_vec
  p_vec_partial["xi_mean"]=pcor.test(y_data$BIS11_TotalScore, y_data$xi_mean, y_data[,c("age","IQscore")])$p.value
  p_vec_partial["eta_mean"]=pcor.test(y_data$BIS11_TotalScore, y_data$eta_mean, y_data[,c("age","IQscore")])$p.value
  p_vec_partial["sgm0_mean"]=pcor.test(y_data$BIS11_TotalScore, y_data$sgm0_mean, y_data[,c("age","IQscore")])$p.value
  p_vec_partial["Q0"]=pcor.test(y_data$BIS11_TotalScore, y_data$Q0, y_data[,c("age","IQscore")])$p.value
  
  # adjust p value (bonferroni)
  p_vec_partial_adj <- p.adjust(p_vec_partial, method = "bonferroni", n = length(p_vec)-1)
  
  # df
  df_r = data.frame(t(M_vec_partial))
  
  df_p_u = data.frame(t(p_vec_partial)) # uncorrected
  df_p_c = data.frame(t(p_vec_partial_adj)) # corrected
  
  # output
  output=paste(
    "Bonferroni corrected (n=", length(p_vec)-1, ") partial (accounting for age and IQ) correlations for behaviour",
    ": BIS and epsilon: R=", 
    round(df_r$xi_mean,3),", p_c=", round(df_p_c$xi_mean,3),", p_u=", round(df_p_u$xi_mean,3),
    "; BIS and eta: R=", 
    round(df_r$eta_mean,3),", p_c=", round(df_p_c$eta_mean,3),", p_u=", round(df_p_u$eta_mean,3),
    "; BIS and sigma0: R=", 
    round(df_r$sgm0_mean,3),", p_c=", round(df_p_c$sgm0_mean,3),", p_u=", round(df_p_u$sgm0_mean,3),
    "; BIS and Q0: R=", 
    round(df_r$Q0,3),", p_c=", round(df_p_c$Q0,3),", p_u=", round(df_p_u$Q0,3), 
    sep='') 
  
  return(output)

}




