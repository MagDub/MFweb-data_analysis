
library(Hmisc)
library(corrplot)
library(ggpubr)
library(ggplot2)

cor_mat_allQ_behav_3B <- function() {
  
  load(file = "~/MFweb/data_analysis/10_stats/FA/all_behav_and_FAscores.Rdata")
  
  # keep only mean per horizon
  data_tmp_all <- subset(data_tmp_all, select = -c(3:29))
  
  # Choose which ones to keep
  data_all <- data_tmp_all[, c('pickedD_mean', 'pickedC_mean', 'pickedhigh_mean')]
  
  # Questionnaires
  quest_names = c('BIS11_TotalScore', 'ASRS_Sum', 'AQ10_TotalScore', 'CFS_TotalScore', 'OCIR_TotalScore', 'STAI_TotalScore', 'IUS_TotalScore', 'SDS_TotalScore', 'LSAS_TotalScore')
  quest_newnames = c('BIS11', 'ASRS', 'AQ10', 'CFS', 'OCIR', 'STAI', 'IUS', 'SDS', 'LSAS')
  dataMFweb <- read_excel("~/MFweb/data_analysis/10_stats/web_data_completed.xlsx")
  dataMFweb <- subset(dataMFweb, exclude!=1)
  data_quest <- dataMFweb[, quest_names]
  names(data_quest) = c('BIS11', 'ASRS', 'AQ10', 'CFS', 'OCIR', 'STAI', 'IUS', 'SDS', 'LSAS')
  for (i in 1:9){
    data_all[,ncol(data_all)+1] = data_quest[,i] # Concatenate 
  }
  
  # Corr mat
  cor_5 <- rcorr(as.matrix(data_all))
  r_mat_all <- cor_5$r
  p_mat_all <- cor_5$P
  
  # select column of interest
  p_mat_small = p_mat_all[quest_newnames,c("pickedD_mean", "pickedC_mean", "pickedhigh_mean")]
  r_mat_small = r_mat_all[quest_newnames,c("pickedD_mean", "pickedC_mean", "pickedhigh_mean")]
  
  # convert
  vec_p = c(p_mat_small)

  # adjust
  p_vec_adj <- p.adjust(vec_p, method = "bonferroni", n = length(vec_p))

  # convert back
  p_mat = matrix(p_vec_adj,nrow = dim(p_mat_small)[1],ncol = dim(p_mat_small)[2], dimnames=list(rownames(p_mat_small), colnames(p_mat_small)))
  r_mat = r_mat_small
  
  # make df
  df_r=as.data.frame(r_mat)
  
  df_p_c=as.data.frame(p_mat)
  df_p_u=as.data.frame(p_mat_small)
  
  write.csv(df_p_c,"~/MFweb/data_analysis/10_stats/corr_bonferroni/corr_allQ/behav_pval_corr.csv", row.names = FALSE)
  write.csv(df_p_u,"~/MFweb/data_analysis/10_stats/corr_bonferroni/corr_allQ/behav_pval_uncorr.csv", row.names = FALSE)
  write.csv(df_r,"~/MFweb/data_analysis/10_stats/corr_bonferroni/corr_allQ/behav_r.csv", row.names = FALSE)
  
  # output
  output=paste(
    "Bonferroni corrected (n=", length(vec_p), ") correlations for behaviour",
    ": BIS and low-value bandit: R=", 
    round(df_r['BIS',]$pickedD_mean,3),", p_c=", round(df_p_c['BIS',]$pickedD_mean,3),", p_u=", make_pval_u_(df_p_u['BIS',]$pickedD_mean), 
    "; BIS and novel bandit: R=", 
    round(df_r['BIS',]$pickedC_mean,3),", p_c=", round(df_p_c['BIS',]$pickedC_mean,3),", p_u=", make_pval_u_(df_p_u['BIS',]$pickedC_mean),
    "; BIS and high-value bandit: R=", 
    round(df_r['BIS',]$pickedhigh_mean,3),", p_c=", round(df_p_c['BIS',]$pickedhigh_mean,3),", ", make_pval_u_(df_p_u['BIS',]$pickedhigh_mean), 
    "; ASRS and low-value bandit: R=", 
    round(df_r['ASRS',]$pickedD_mean,3),", p_c=", round(df_p_c['ASRS',]$pickedD_mean,3),", ", make_pval_u_(df_p_u['ASRS',]$pickedD_mean), 
    "; ASRS and novel bandit: R=", 
    round(df_r['ASRS',]$pickedC_mean,3),", p_c=", round(df_p_c['ASRS',]$pickedC_mean,3),", ", make_pval_u_(df_p_u['ASRS',]$pickedC_mean), 
    "; ASRS and high-value bandit: R=", 
    round(df_r['ASRS',]$pickedhigh_mean,3),", p_c=", round(df_p_c['ASRS',]$pickedhigh_mean,3),", ", make_pval_u_(df_p_u['ASRS',]$pickedhigh_mean), 
    "; AQ10 and low-value bandit: R=", 
    round(df_r['AQ10',]$pickedD_mean,3),", p_c=", round(df_p_c['AQ10',]$pickedD_mean,3), ", ", make_pval_u_(df_p_u['AQ10',]$pickedD_mean), 
    "; AQ10 and novel bandit: R=", 
    round(df_r['AQ10',]$pickedC_mean,3),", p_c=", round(df_p_c['AQ10',]$pickedC_mean,3),", ", make_pval_u_(df_p_u['AQ10',]$pickedC_mean), 
    "; AQ10 and high-value bandit: R=", 
    round(df_r['AQ10',]$pickedhigh_mean,3),", p_c=", round(df_p_c['AQ10',]$pickedhigh_mean,3),", ", make_pval_u_(df_p_u['AQ10',]$pickedhigh_mean),  
    "; CFS and low-value bandit: R=", 
    round(df_r['CFS',]$pickedD_mean,3),", p_c=", round(df_p_c['CFS',]$pickedD_mean,3), ", ", make_pval_u_(df_p_u['CFS',]$pickedD_mean), 
    "; CFS and novel bandit: R=", 
    round(df_r['CFS',]$pickedC_mean,3),", p_c=", round(df_p_c['CFS',]$pickedC_mean,3),", ", make_pval_u_(df_p_u['CFS',]$pickedC_mean), 
    "; CFS and high-value bandit: R=", 
    round(df_r['CFS',]$pickedhigh_mean,3),", p_c=", round(df_p_c['CFS',]$pickedhigh_mean,3),", ", make_pval_u_(df_p_u['CFS',]$pickedhigh_mean),  
    "; OCIR and low-value bandit: R=", 
    round(df_r['OCIR',]$pickedD_mean,3),", p_c=", round(df_p_c['OCIR',]$pickedD_mean,3), ", ", make_pval_u_(df_p_u['OCIR',]$pickedD_mean), 
    "; OCIR and novel bandit: R=", 
    round(df_r['OCIR',]$pickedC_mean,3),", p_c=", round(df_p_c['OCIR',]$pickedC_mean,3),", ", make_pval_u_(df_p_u['OCIR',]$pickedC_mean), 
    "; OCIR and high-value bandit: R=", 
    round(df_r['OCIR',]$pickedhigh_mean,3),", p_c=", round(df_p_c['OCIR',]$pickedhigh_mean,3),", ", make_pval_u_(df_p_u['OCIR',]$pickedhigh_mean),  
    "; STAI and low-value bandit: R=", 
    round(df_r['STAI',]$pickedD_mean,3),", p_c=", round(df_p_c['STAI',]$pickedD_mean,3), ", ", make_pval_u_(df_p_u['STAI',]$pickedD_mean), 
    "; STAI and novel bandit: R=", 
    round(df_r['STAI',]$pickedC_mean,3),", p_c=", round(df_p_c['STAI',]$pickedC_mean,3),", ", make_pval_u_(df_p_u['STAI',]$pickedC_mean), 
    "; STAI and high-value bandit: R=", 
    round(df_r['STAI',]$pickedhigh_mean,3),", p_c=", round(df_p_c['STAI',]$pickedhigh_mean,3),", ", make_pval_u_(df_p_u['STAI',]$pickedhigh_mean),  
    "; IUS and low-value bandit: R=", 
    round(df_r['IUS',]$pickedD_mean,3),", p_c=", round(df_p_c['IUS',]$pickedD_mean,3), ", ", make_pval_u_(df_p_u['IUS',]$pickedD_mean), 
    "; IUS and novel bandit: R=", 
    round(df_r['IUS',]$pickedC_mean,3),", p_c=", round(df_p_c['IUS',]$pickedC_mean,3),", ", make_pval_u_(df_p_u['IUS',]$pickedC_mean), 
    "; IUS and high-value bandit: R=", 
    round(df_r['IUS',]$pickedhigh_mean,3),", p_c=", round(df_p_c['IUS',]$pickedhigh_mean,3),", ", make_pval_u_(df_p_u['IUS',]$pickedhigh_mean),  
    "; SDS and low-value bandit: R=", 
    round(df_r['SDS',]$pickedD_mean,3),", p_c=", round(df_p_c['SDS',]$pickedD_mean,3), ", ", make_pval_u_(df_p_u['SDS',]$pickedD_mean), 
    "; SDS and novel bandit: R=", 
    round(df_r['SDS',]$pickedC_mean,3),", p_c=", round(df_p_c['SDS',]$pickedC_mean,3),", ", make_pval_u_(df_p_u['SDS',]$pickedC_mean), 
    "; SDS and high-value bandit: R=", 
    round(df_r['SDS',]$pickedhigh_mean,3),", p_c=", round(df_p_c['SDS',]$pickedhigh_mean,3),", ", make_pval_u_(df_p_u['SDS',]$pickedhigh_mean),  
    "; LSAS and low-value bandit: R=", 
    round(df_r['LSAS',]$pickedD_mean,3),", p_c=", round(df_p_c['LSAS',]$pickedD_mean,3), ", ", make_pval_u_(df_p_u['LSAS',]$pickedD_mean), 
    "; LSAS and novel bandit: R=", 
    round(df_r['LSAS',]$pickedC_mean,3),", p_c=", round(df_p_c['LSAS',]$pickedC_mean,3),", ", make_pval_u_(df_p_u['LSAS',]$pickedC_mean), 
    "; LSAS and high-value bandit: R=", 
    round(df_r['LSAS',]$pickedhigh_mean,3),", p_c=", round(df_p_c['LSAS',]$pickedhigh_mean,3),", ", make_pval_u_(df_p_u['LSAS',]$pickedhigh_mean),  
    sep='') 
  
  return(output)

}


