
library(Hmisc)
library(corrplot)
library(ggpubr)
library(ggplot2)
library(ppcor)
library(readxl)

cor_mat_ASRS_behav_3B_partial <- function() {
  
  data_demo_tmp <- read_excel("~/MFweb/data_analysis/10_stats/web_data_completed.xlsx")    
  data_demo_all <- subset(data_demo_tmp , select=c("exclude", "age", "IQscore", "ASRS_Sum"))
  data_demo <- subset(data_demo_all, exclude!=1)
  
  load(file = "~/MFweb/data_analysis/10_stats/FA/all_behav_and_FAscores.Rdata")
  
  # keep only mean per horizon
  data_tmp_all <- subset(data_tmp_all, select = -c(3:29))
  
  # Choose which ones to keep
  data_all <- data_tmp_all[, c('pickedD_mean', 'pickedC_mean', 'pickedhigh_mean')]
  
  # Concatenate
  data_all[,ncol(data_all)+1] = data_demo[,'ASRS_Sum']
  
  # Corr mat
  cor_5 <- rcorr(as.matrix(data_all))
  M <- cor_5$r
  p_mat <- cor_5$P
  
  # select column of interest
  p_vec = p_mat["ASRS_Sum",]
  M_vec = M["ASRS_Sum",]
  
  # adjust R value (partial correlation)
  data_forpart <- subset(data_demo, select = c("age", "IQscore"))
  data_forpart$ASRS_Sum = data_all$ASRS_Sum
  data_forpart$pickedD_mean = data_all$pickedD_mean
  data_forpart$pickedC_mean = data_all$pickedC_mean
  data_forpart$pickedhigh_mean = data_all$pickedhigh_mean
  data_forpart = data_forpart[complete.cases(data_forpart), ] # remove nans
  y_data=data.frame(data_forpart)
  
  # same col names as M_vec
  M_vec_partial = M_vec
  M_vec_partial["pickedD_mean"]=pcor.test(y_data$ASRS_Sum, y_data$pickedD_mean, y_data[,c("age","IQscore")])$estimate
  M_vec_partial["pickedC_mean"]=pcor.test(y_data$ASRS_Sum, y_data$pickedC_mean, y_data[,c("age","IQscore")])$estimate
  M_vec_partial["pickedhigh_mean"]=pcor.test(y_data$ASRS_Sum, y_data$pickedhigh_mean, y_data[,c("age","IQscore")])$estimate
  
  # same col names as p_vec
  p_vec_partial = p_vec
  p_vec_partial["pickedD_mean"]=pcor.test(y_data$ASRS_Sum, y_data$pickedD_mean, y_data[,c("age","IQscore")])$p.value
  p_vec_partial["pickedC_mean"]=pcor.test(y_data$ASRS_Sum, y_data$pickedC_mean, y_data[,c("age","IQscore")])$p.value
  p_vec_partial["pickedhigh_mean"]=pcor.test(y_data$ASRS_Sum, y_data$pickedhigh_mean, y_data[,c("age","IQscore")])$p.value

  # adjust p value (bonferroni)
  p_vec_partial_adj <- p.adjust(p_vec_partial, method = "bonferroni", n = length(p_vec)-1)
  
  # df
  df_r = data.frame(t(M_vec_partial))
  
  df_p_u = data.frame(t(p_vec_partial)) # uncorrected
  df_p_c = data.frame(t(p_vec_partial_adj)) # corrected

  # output
  output=paste(
    "Bonferroni corrected (n=", length(p_vec_partial_adj)-1, ") partial (accounting for age and IQ) correlations for behaviour",
    ": ASRS and low-value bandit: R=", 
    round(df_r$pickedD_mean,3),", p_c=", round(df_p_c$pickedD_mean,3),", p_u=", round(df_p_u$pickedD_mean,3), 
    "; ASRS and novel bandit: R=", 
    round(df_r$pickedC_mean,3),", p_c=", round(df_p_c$pickedC_mean,3),", p_u=", round(df_p_u$pickedC_mean,3),
    "; ASRS and high-value bandit: R=", 
    round(df_r$pickedhigh_mean,3),", p_c=", round(df_p_c$pickedhigh_mean,3),", p_u=", round(df_p_u$pickedhigh_mean,3), 
    sep='') 
  
  return(output)

}


