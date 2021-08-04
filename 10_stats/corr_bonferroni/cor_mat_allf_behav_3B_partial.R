
library(Hmisc)
library(corrplot)
library(ggpubr)
library(ggplot2)

cor_mat_allf_behav_3B_partial <- function() {
  
  data_demo_tmp <- read_excel("~/MFweb/data_analysis/10_stats/web_data_completed.xlsx")    
  data_demo_all <- subset(data_demo_tmp , select=c("exclude", "age", "IQscore"))
  data_demo <- subset(data_demo_all, exclude!=1)
  
  load(file = "~/MFweb/data_analysis/10_stats/FA/all_behav_and_FAscores.Rdata")
  
  # keep only mean per horizon
  data_tmp_all <- subset(data_tmp_all, select = -c(3:29))
  
  # Choose which ones to keep
  data_all <- data_tmp_all[, c('pickedD_mean', 'pickedC_mean', 'pickedhigh_mean', 'scores_f1', 'scores_f2', 'scores_f3')]
  
  # Corr mat
  cor_5 <- rcorr(as.matrix(data_all))
  r_mat_all <- cor_5$r
  p_mat_all <- cor_5$P
  
  # select column of interest
  p_mat_small = p_mat_all[c("scores_f1", "scores_f2", "scores_f3"),c("pickedD_mean", "pickedC_mean", "pickedhigh_mean")]
  r_mat_small = r_mat_all[c("scores_f1", "scores_f2", "scores_f3"),c("pickedD_mean", "pickedC_mean", "pickedhigh_mean")]
  
  # adjust R value (partial correlation)
  data_forpart <- subset(data_demo, select = c("age", "IQscore"))
  data_forpart$scores_f1 = data_all$scores_f1
  data_forpart$scores_f2 = data_all$scores_f2
  data_forpart$scores_f3 = data_all$scores_f3
  data_forpart$pickedD_mean = data_all$pickedD_mean
  data_forpart$pickedC_mean = data_all$pickedC_mean
  data_forpart$pickedhigh_mean = data_all$pickedhigh_mean
  data_forpart = data_forpart[complete.cases(data_forpart), ] # remove nans
  y_data=data.frame(data_forpart)
  
  # same col names as r_mat_small
  r_mat_smal_partial = r_mat_small
  r_mat_smal_partial["scores_f1","pickedD_mean"]=pcor.test(y_data$scores_f1, y_data$pickedD_mean, y_data[,c("age","IQscore")])$estimate
  r_mat_smal_partial["scores_f1","pickedC_mean"]=pcor.test(y_data$scores_f1, y_data$pickedC_mean, y_data[,c("age","IQscore")])$estimate
  r_mat_smal_partial["scores_f1","pickedhigh_mean"]=pcor.test(y_data$scores_f1, y_data$pickedhigh_mean, y_data[,c("age","IQscore")])$estimate
  
  r_mat_smal_partial["scores_f2","pickedD_mean"]=pcor.test(y_data$scores_f2, y_data$pickedD_mean, y_data[,c("age","IQscore")])$estimate
  r_mat_smal_partial["scores_f2","pickedC_mean"]=pcor.test(y_data$scores_f2, y_data$pickedC_mean, y_data[,c("age","IQscore")])$estimate
  r_mat_smal_partial["scores_f2","pickedhigh_mean"]=pcor.test(y_data$scores_f2, y_data$pickedhigh_mean, y_data[,c("age","IQscore")])$estimate
  
  r_mat_smal_partial["scores_f3","pickedD_mean"]=pcor.test(y_data$scores_f3, y_data$pickedD_mean, y_data[,c("age","IQscore")])$estimate
  r_mat_smal_partial["scores_f3","pickedC_mean"]=pcor.test(y_data$scores_f3, y_data$pickedC_mean, y_data[,c("age","IQscore")])$estimate
  r_mat_smal_partial["scores_f3","pickedhigh_mean"]=pcor.test(y_data$scores_f3, y_data$pickedhigh_mean, y_data[,c("age","IQscore")])$estimate
  
  # same col names as p_mat_small
  p_mat_smal_partial = p_mat_small
  p_mat_smal_partial["scores_f1","pickedD_mean"]=pcor.test(y_data$scores_f1, y_data$pickedD_mean, y_data[,c("age","IQscore")])$p.value
  p_mat_smal_partial["scores_f1","pickedC_mean"]=pcor.test(y_data$scores_f1, y_data$pickedC_mean, y_data[,c("age","IQscore")])$p.value
  p_mat_smal_partial["scores_f1","pickedhigh_mean"]=pcor.test(y_data$scores_f1, y_data$pickedhigh_mean, y_data[,c("age","IQscore")])$p.value
  
  p_mat_smal_partial["scores_f2","pickedD_mean"]=pcor.test(y_data$scores_f2, y_data$pickedD_mean, y_data[,c("age","IQscore")])$p.value
  p_mat_smal_partial["scores_f2","pickedC_mean"]=pcor.test(y_data$scores_f2, y_data$pickedC_mean, y_data[,c("age","IQscore")])$p.value
  p_mat_smal_partial["scores_f2","pickedhigh_mean"]=pcor.test(y_data$scores_f2, y_data$pickedhigh_mean, y_data[,c("age","IQscore")])$p.value

  p_mat_smal_partial["scores_f3","pickedD_mean"]=pcor.test(y_data$scores_f3, y_data$pickedD_mean, y_data[,c("age","IQscore")])$p.value
  p_mat_smal_partial["scores_f3","pickedC_mean"]=pcor.test(y_data$scores_f3, y_data$pickedC_mean, y_data[,c("age","IQscore")])$p.value
  p_mat_smal_partial["scores_f3","pickedhigh_mean"]=pcor.test(y_data$scores_f3, y_data$pickedhigh_mean, y_data[,c("age","IQscore")])$p.value
  
  
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
    ": F1 and low-value bandit: R=", 
    round(df_r['scores_f1',]$pickedD_mean,3),", p_c=", round(df_p_c['scores_f1',]$pickedD_mean,3),", p_u=", round(df_p_u['scores_f1',]$pickedD_mean,3), 
    "; F1 and novel bandit: R=", 
    round(df_r['scores_f1',]$pickedC_mean,3),", p_c=", round(df_p_c['scores_f1',]$pickedC_mean,3),", p_u=", round(df_p_u['scores_f1',]$pickedC_mean,3), 
    "; F1 and high-value bandit: R=", 
    round(df_r['scores_f1',]$pickedhigh_mean,3),", p_c=", round(df_p_c['scores_f1',]$pickedhigh_mean,3),", p_u=", round(df_p_u['scores_f1',]$pickedhigh_mean,3), 
    "; F2 and low-value bandit: R=", 
    round(df_r['scores_f2',]$pickedD_mean,3),", p_c=", round(df_p_c['scores_f2',]$pickedD_mean,3),", p_u=", round(df_p_u['scores_f2',]$pickedD_mean,3), 
    "; F2 and novel bandit: R=", 
    round(df_r['scores_f2',]$pickedC_mean,3),", p_c=", round(df_p_c['scores_f2',]$pickedC_mean,3),", p_u=", round(df_p_u['scores_f2',]$pickedC_mean,3), 
    "; F2 and high-value bandit: R=", 
    round(df_r['scores_f2',]$pickedhigh_mean,3),", p_c=", round(df_p_c['scores_f2',]$pickedhigh_mean,3),", p_u=", round(df_p_u['scores_f2',]$pickedhigh_mean,3), 
    "; F3 and low-value bandit: R=", 
    round(df_r['scores_f3',]$pickedD_mean,3),", p_c=", round(df_p_c['scores_f3',]$pickedD_mean,3),", p_u=", round(df_p_u['scores_f3',]$pickedD_mean,3), 
    "; F3 and novel bandit: R=", 
    round(df_r['scores_f3',]$pickedC_mean,3),", p_c=", round(df_p_c['scores_f3',]$pickedC_mean,3),", p_u=", round(df_p_u['scores_f3',]$pickedC_mean,3), 
    "; F3 and high-value bandit: R=", 
    round(df_r['scores_f3',]$pickedhigh_mean,3),", p_c=", round(df_p_c['scores_f3',]$pickedhigh_mean,3),", p_u=", round(df_p_u['scores_f3',]$pickedhigh_mean,3),  
    sep='') 
  
  return(output)

}


