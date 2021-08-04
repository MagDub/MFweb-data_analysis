
library(Hmisc)
library(corrplot)
library(ggpubr)
library(ggplot2)

cor_mat_allf_param_partial <- function() {
  
  data_demo_tmp <- read_excel("~/MFweb/data_analysis/10_stats/web_data_completed.xlsx")    
  data_demo_all <- subset(data_demo_tmp , select=c("exclude", "age", "IQscore"))
  data_demo <- subset(data_demo_all, exclude!=1)
  
  load(file = "~/MFweb/data_analysis/10_stats/FA/all_behav_and_FAscores.Rdata")
  
  # keep only mean per horizon
  data_tmp_all <- subset(data_tmp_all, select = -c(3:29))
  
  # Choose which ones to keep
  data_all <- data_tmp_all[, c('xi_mean', 'eta_mean', 'sgm0_mean', 'Q0', 'scores_f1', 'scores_f2', 'scores_f3')]
  
  # Corr mat
  cor_5 <- rcorr(as.matrix(data_all))
  r_mat_all <- cor_5$r
  p_mat_all <- cor_5$P
  
  # select column of interest
  p_mat_small = p_mat_all[c("scores_f1", "scores_f2", "scores_f3"),c("xi_mean", "eta_mean", "sgm0_mean", "Q0")]
  r_mat_small = r_mat_all[c("scores_f1", "scores_f2", "scores_f3"),c("xi_mean", "eta_mean", "sgm0_mean", "Q0")]
  
  # adjust R value (partial correlation)
  data_forpart <- subset(data_demo, select = c("age", "IQscore"))
  data_forpart$scores_f1 = data_all$scores_f1
  data_forpart$scores_f2 = data_all$scores_f2
  data_forpart$scores_f3 = data_all$scores_f3
  data_forpart$xi_mean = data_all$xi_mean
  data_forpart$eta_mean = data_all$eta_mean
  data_forpart$sgm0_mean = data_all$sgm0_mean
  data_forpart$Q0 = data_all$Q0
  data_forpart = data_forpart[complete.cases(data_forpart), ] # remove nans
  y_data=data.frame(data_forpart)
  
  # same col names as r_mat_small
  r_mat_smal_partial = r_mat_small
  r_mat_smal_partial["scores_f1","xi_mean"]=pcor.test(y_data$scores_f1, y_data$xi_mean, y_data[,c("age","IQscore")])$estimate
  r_mat_smal_partial["scores_f1","eta_mean"]=pcor.test(y_data$scores_f1, y_data$eta_mean, y_data[,c("age","IQscore")])$estimate
  r_mat_smal_partial["scores_f1","sgm0_mean"]=pcor.test(y_data$scores_f1, y_data$sgm0_mean, y_data[,c("age","IQscore")])$estimate
  r_mat_smal_partial["scores_f1","Q0"]=pcor.test(y_data$scores_f1, y_data$Q0, y_data[,c("age","IQscore")])$estimate
  
  r_mat_smal_partial["scores_f2","xi_mean"]=pcor.test(y_data$scores_f2, y_data$xi_mean, y_data[,c("age","IQscore")])$estimate
  r_mat_smal_partial["scores_f2","eta_mean"]=pcor.test(y_data$scores_f2, y_data$eta_mean, y_data[,c("age","IQscore")])$estimate
  r_mat_smal_partial["scores_f2","sgm0_mean"]=pcor.test(y_data$scores_f2, y_data$sgm0_mean, y_data[,c("age","IQscore")])$estimate
  r_mat_smal_partial["scores_f2","Q0"]=pcor.test(y_data$scores_f2, y_data$Q0, y_data[,c("age","IQscore")])$estimate
  
  r_mat_smal_partial["scores_f3","xi_mean"]=pcor.test(y_data$scores_f3, y_data$xi_mean, y_data[,c("age","IQscore")])$estimate
  r_mat_smal_partial["scores_f3","eta_mean"]=pcor.test(y_data$scores_f3, y_data$eta_mean, y_data[,c("age","IQscore")])$estimate
  r_mat_smal_partial["scores_f3","sgm0_mean"]=pcor.test(y_data$scores_f3, y_data$sgm0_mean, y_data[,c("age","IQscore")])$estimate
  r_mat_smal_partial["scores_f3","Q0"]=pcor.test(y_data$scores_f3, y_data$Q0, y_data[,c("age","IQscore")])$estimate
  
  # same col names as p_mat_small
  p_mat_smal_partial = p_mat_small
  p_mat_smal_partial["scores_f1","xi_mean"]=pcor.test(y_data$scores_f1, y_data$xi_mean, y_data[,c("age","IQscore")])$p.value
  p_mat_smal_partial["scores_f1","eta_mean"]=pcor.test(y_data$scores_f1, y_data$eta_mean, y_data[,c("age","IQscore")])$p.value
  p_mat_smal_partial["scores_f1","sgm0_mean"]=pcor.test(y_data$scores_f1, y_data$sgm0_mean, y_data[,c("age","IQscore")])$p.value
  p_mat_smal_partial["scores_f1","Q0"]=pcor.test(y_data$scores_f1, y_data$Q0, y_data[,c("age","IQscore")])$p.value
  
  p_mat_smal_partial["scores_f2","xi_mean"]=pcor.test(y_data$scores_f2, y_data$xi_mean, y_data[,c("age","IQscore")])$p.value
  p_mat_smal_partial["scores_f2","eta_mean"]=pcor.test(y_data$scores_f2, y_data$eta_mean, y_data[,c("age","IQscore")])$p.value
  p_mat_smal_partial["scores_f2","sgm0_mean"]=pcor.test(y_data$scores_f2, y_data$sgm0_mean, y_data[,c("age","IQscore")])$p.value
  p_mat_smal_partial["scores_f2","Q0"]=pcor.test(y_data$scores_f2, y_data$Q0, y_data[,c("age","IQscore")])$p.value
  
  p_mat_smal_partial["scores_f3","xi_mean"]=pcor.test(y_data$scores_f3, y_data$xi_mean, y_data[,c("age","IQscore")])$p.value
  p_mat_smal_partial["scores_f3","eta_mean"]=pcor.test(y_data$scores_f3, y_data$eta_mean, y_data[,c("age","IQscore")])$p.value
  p_mat_smal_partial["scores_f3","sgm0_mean"]=pcor.test(y_data$scores_f3, y_data$sgm0_mean, y_data[,c("age","IQscore")])$p.value
  p_mat_smal_partial["scores_f3","Q0"]=pcor.test(y_data$scores_f3, y_data$Q0, y_data[,c("age","IQscore")])$p.value
  
  
  # convert
  vec_p = c(p_mat_smal_partial)

  # adjust
  p_vec_adj <- p.adjust(vec_p, method = "bonferroni", n = length(vec_p))

  # convert back
  p_mat = matrix(p_vec_adj,nrow = dim(p_mat_smal_partial)[1],ncol = dim(p_mat_smal_partial)[2], dimnames=list(rownames(p_mat_smal_partial), colnames(p_mat_smal_partial)))
  r_mat = r_mat_smal_partial
  
  # make df
  df_r=as.data.frame(r_mat)
  
  df_p_c=as.data.frame(p_mat)
  df_p_u=as.data.frame(p_mat_smal_partial)
  
  # output
  output=paste(
    "Bonferroni corrected (n=", length(vec_p), ") partial (accounting for age and IQ) correlations for behaviour",
    ": F1 and epsilon: R=", 
    round(df_r['scores_f1',]$xi_mean,3),", p_c=", round(df_p_c['scores_f1',]$xi_mean,3),", p_u=", round(df_p_u['scores_f1',]$xi_mean,3),  
    "; F1 and eta: R=", 
    round(df_r['scores_f1',]$eta_mean,3),", p_c=", round(df_p_c['scores_f1',]$eta_mean,3),", p_u=", round(df_p_u['scores_f1',]$eta_mean,3),  
    "; F1 and sigma0: R=", 
    round(df_r['scores_f1',]$sgm0_mean,3),", p_c=", round(df_p_c['scores_f1',]$sgm0_mean,3),", p_u=", round(df_p_u['scores_f1',]$sgm0_mean,3),  
    "; F1 and Q0: R=", 
    round(df_r['scores_f1',]$Q0,3),", p_c=", round(df_p_c['scores_f1',]$Q0,3),", p_u=", round(df_p_u['scores_f1',]$Q0,3),  
    "; F2 and epsilon: R=", 
    round(df_r['scores_f2',]$xi_mean,3),", p_c=", round(df_p_c['scores_f2',]$xi_mean,3),", p_u=", round(df_p_u['scores_f2',]$xi_mean,3),  
    "; F2 and eta: R=", 
    round(df_r['scores_f2',]$eta_mean,3),", p_c=", round(df_p_c['scores_f2',]$eta_mean,3),", p_u=", round(df_p_u['scores_f2',]$eta_mean,3),  
    "; F2 and sigma0: R=", 
    round(df_r['scores_f2',]$sgm0_mean,3),", p_c=", round(df_p_c['scores_f2',]$sgm0_mean,3),", p_u=", round(df_p_u['scores_f2',]$sgm0_mean,3),  
    "; F2 and Q0: R=", 
    round(df_r['scores_f2',]$Q0,3),", p_c=", round(df_p_c['scores_f2',]$Q0,3),", p_u=", round(df_p_u['scores_f2',]$Q0,3),  
    "; F3 and epsilon: R=", 
    round(df_r['scores_f3',]$xi_mean,3),", p_c=", round(df_p_c['scores_f3',]$xi_mean,3),", p_u=", round(df_p_u['scores_f3',]$xi_mean,3),  
    "; F3 and eta: R=", 
    round(df_r['scores_f3',]$eta_mean,3),", p_c=", round(df_p_c['scores_f3',]$eta_mean,3),", p_u=", round(df_p_u['scores_f3',]$eta_mean,3),  
    "; F3 and sigma0: R=", 
    round(df_r['scores_f3',]$sgm0_mean,3),", p_c=", round(df_p_c['scores_f3',]$sgm0_mean,3),", p_u=", round(df_p_u['scores_f3',]$sgm0_mean,3),   
    "; F3 and Q0: R=", 
    round(df_r['scores_f3',]$Q0,3),", p_c=", round(df_p_c['scores_f3',]$Q0,3),", p_u=", round(df_p_u['scores_f3',]$Q0,3),  
    sep='') 
  
  return(output)

}


