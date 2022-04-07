
source('~/MFweb/data_analysis/10_stats/make_pval_u_.R')

library(Hmisc)
library(corrplot)
library(ggpubr)
library(ggplot2)

cor_mat_allQ_param <- function() {
  
  load(file = "~/MFweb/data_analysis/10_stats/FA/all_behav_and_FAscores.Rdata")
  
  # keep only mean per horizon
  data_tmp_all <- subset(data_tmp_all, select = -c(3:29))
  
  # Choose which ones to keep
  data_all <- data_tmp_all[, c('xi_mean', 'eta_mean', 'sgm0_mean', 'Q0')]
  
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
  p_mat_small = p_mat_all[quest_newnames,c("xi_mean", "eta_mean", "sgm0_mean", "Q0")]
  r_mat_small = r_mat_all[quest_newnames,c("xi_mean", "eta_mean", "sgm0_mean", "Q0")]
  
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
  
  write.csv(df_p_c,"~/MFweb/data_analysis/10_stats/corr_bonferroni/corr_allQ/param_pval_corr.csv", row.names = FALSE)
  write.csv(df_p_u,"~/MFweb/data_analysis/10_stats/corr_bonferroni/corr_allQ/param_pval_uncorr.csv", row.names = FALSE)
  write.csv(df_r,"~/MFweb/data_analysis/10_stats/corr_bonferroni/corr_allQ/param_r.csv", row.names = FALSE)
  
  
  # output
  output=paste(
    "Bonferroni corrected (n=", length(vec_p), ") correlations for behaviour",
    ": BIS and epsilon: R=", 
    round(df_r['BIS',]$xi_mean,3),", p_c=", round(df_p_c['BIS',]$xi_mean,3),", p_u=", make_pval_u_(df_p_u['BIS',]$xi_mean), 
    "; BIS and eta: R=", 
    round(df_r['BIS',]$eta_mean,3),", p_c=", round(df_p_c['BIS',]$eta_mean,3),", p_u=", make_pval_u_(df_p_u['BIS',]$eta_mean), 
    "; BIS and sigma0: R=", 
    round(df_r['BIS',]$sgm0_mean,3),", p_c=", round(df_p_c['BIS',]$sgm0_mean,3),", ", make_pval_u_(df_p_u['BIS',]$sgm0_mean), 
    "; BIS and Q0: R=", 
    round(df_r['BIS',]$Q0,3),", p_c=", round(df_p_c['BIS',]$Q0,3),", ", make_pval_u_(df_p_u['BIS',]$Q0), 
    "; ASRS and epsilon: R=", 
    round(df_r['ASRS',]$xi_mean,3),", p_c=", round(df_p_c['ASRS',]$xi_mean,3),", ", make_pval_u_(df_p_u['ASRS',]$xi_mean), 
    "; ASRS and eta: R=", 
    round(df_r['ASRS',]$eta_mean,3),", p_c=", round(df_p_c['ASRS',]$eta_mean,3),", ", make_pval_u_(df_p_u['ASRS',]$eta_mean), 
    "; ASRS and sigma0: R=", 
    round(df_r['ASRS',]$sgm0_mean,3),", p_c=", round(df_p_c['ASRS',]$sgm0_mean,3),", ", make_pval_u_(df_p_u['ASRS',]$sgm0_mean), 
    "; ASRS and Q0: R=", 
    round(df_r['ASRS',]$Q0,3),", p_c=", round(df_p_c['ASRS',]$Q0,3),", ", make_pval_u_(df_p_u['ASRS',]$Q0), 
    "; AQ10 and epsilon: R=", 
    round(df_r['AQ10',]$xi_mean,3),", p_c=", round(df_p_c['AQ10',]$xi_mean,3), ", ", make_pval_u_(df_p_u['AQ10',]$xi_mean), 
    "; AQ10 and eta: R=", 
    round(df_r['AQ10',]$eta_mean,3),", p_c=", round(df_p_c['AQ10',]$eta_mean,3),", ", make_pval_u_(df_p_u['AQ10',]$eta_mean), 
    "; AQ10 and sigma0: R=", 
    round(df_r['AQ10',]$sgm0_mean,3),", p_c=", round(df_p_c['AQ10',]$sgm0_mean,3),", ", make_pval_u_(df_p_u['AQ10',]$sgm0_mean),  
    "; AQ10 and Q0: R=", 
    round(df_r['AQ10',]$Q0,3),", p_c=", round(df_p_c['AQ10',]$Q0,3),", ", make_pval_u_(df_p_u['AQ10',]$Q0), 
    "; CFS and epsilon: R=", 
    round(df_r['CFS',]$xi_mean,3),", p_c=", round(df_p_c['CFS',]$xi_mean,3), ", ", make_pval_u_(df_p_u['CFS',]$xi_mean), 
    "; CFS and eta: R=", 
    round(df_r['CFS',]$eta_mean,3),", p_c=", round(df_p_c['CFS',]$eta_mean,3),", ", make_pval_u_(df_p_u['CFS',]$eta_mean), 
    "; CFS and sigma0: R=", 
    round(df_r['CFS',]$sgm0_mean,3),", p_c=", round(df_p_c['CFS',]$sgm0_mean,3),", ", make_pval_u_(df_p_u['CFS',]$sgm0_mean),  
    "; CFS and Q0: R=", 
    round(df_r['CFS',]$Q0,3),", p_c=", round(df_p_c['CFS',]$Q0,3),", ", make_pval_u_(df_p_u['CFS',]$Q0), 
    "; OCIR and epsilon: R=", 
    round(df_r['OCIR',]$xi_mean,3),", p_c=", round(df_p_c['OCIR',]$xi_mean,3), ", ", make_pval_u_(df_p_u['OCIR',]$xi_mean), 
    "; OCIR and eta: R=", 
    round(df_r['OCIR',]$eta_mean,3),", p_c=", round(df_p_c['OCIR',]$eta_mean,3),", ", make_pval_u_(df_p_u['OCIR',]$eta_mean), 
    "; OCIR and sigma0: R=", 
    round(df_r['OCIR',]$sgm0_mean,3),", p_c=", round(df_p_c['OCIR',]$sgm0_mean,3),", ", make_pval_u_(df_p_u['OCIR',]$sgm0_mean),  
    "; OCIR and Q0: R=", 
    round(df_r['OCIR',]$Q0,3),", p_c=", round(df_p_c['OCIR',]$Q0,3),", ", make_pval_u_(df_p_u['OCIR',]$Q0), 
    "; STAI and epsilon: R=", 
    round(df_r['STAI',]$xi_mean,3),", p_c=", round(df_p_c['STAI',]$xi_mean,3), ", ", make_pval_u_(df_p_u['STAI',]$xi_mean), 
    "; STAI and eta: R=", 
    round(df_r['STAI',]$eta_mean,3),", p_c=", round(df_p_c['STAI',]$eta_mean,3),", ", make_pval_u_(df_p_u['STAI',]$eta_mean), 
    "; STAI and sigma0: R=", 
    round(df_r['STAI',]$sgm0_mean,3),", p_c=", round(df_p_c['STAI',]$sgm0_mean,3),", ", make_pval_u_(df_p_u['STAI',]$sgm0_mean),  
    "; STAI and Q0: R=", 
    round(df_r['STAI',]$Q0,3),", p_c=", round(df_p_c['STAI',]$Q0,3),", ", make_pval_u_(df_p_u['STAI',]$Q0), 
    "; IUS and epsilon: R=", 
    round(df_r['IUS',]$xi_mean,3),", p_c=", round(df_p_c['IUS',]$xi_mean,3), ", ", make_pval_u_(df_p_u['IUS',]$xi_mean), 
    "; IUS and eta: R=", 
    round(df_r['IUS',]$eta_mean,3),", p_c=", round(df_p_c['IUS',]$eta_mean,3),", ", make_pval_u_(df_p_u['IUS',]$eta_mean), 
    "; IUS and sigma0: R=", 
    round(df_r['IUS',]$sgm0_mean,3),", p_c=", round(df_p_c['IUS',]$sgm0_mean,3),", ", make_pval_u_(df_p_u['IUS',]$sgm0_mean),  
    "; IUS and Q0: R=", 
    round(df_r['IUS',]$Q0,3),", p_c=", round(df_p_c['IUS',]$Q0,3),", ", make_pval_u_(df_p_u['IUS',]$Q0), 
    "; SDS and epsilon: R=", 
    round(df_r['SDS',]$xi_mean,3),", p_c=", round(df_p_c['SDS',]$xi_mean,3), ", ", make_pval_u_(df_p_u['SDS',]$xi_mean), 
    "; SDS and eta: R=", 
    round(df_r['SDS',]$eta_mean,3),", p_c=", round(df_p_c['SDS',]$eta_mean,3),", ", make_pval_u_(df_p_u['SDS',]$eta_mean), 
    "; SDS and sigma0: R=", 
    round(df_r['SDS',]$sgm0_mean,3),", p_c=", round(df_p_c['SDS',]$sgm0_mean,3),", ", make_pval_u_(df_p_u['SDS',]$sgm0_mean),  
    "; SDS and Q0: R=", 
    round(df_r['SDS',]$Q0,3),", p_c=", round(df_p_c['SDS',]$Q0,3),", ", make_pval_u_(df_p_u['SDS',]$Q0), 
    "; LSAS and epsilon: R=", 
    round(df_r['LSAS',]$xi_mean,3),", p_c=", round(df_p_c['LSAS',]$xi_mean,3), ", ", make_pval_u_(df_p_u['LSAS',]$xi_mean), 
    "; LSAS and eta: R=", 
    round(df_r['LSAS',]$eta_mean,3),", p_c=", round(df_p_c['LSAS',]$eta_mean,3),", ", make_pval_u_(df_p_u['LSAS',]$eta_mean), 
    "; LSAS and sigma0: R=", 
    round(df_r['LSAS',]$sgm0_mean,3),", p_c=", round(df_p_c['LSAS',]$sgm0_mean,3),", ", make_pval_u_(df_p_u['LSAS',]$sgm0_mean),  
    "; LSAS and Q0: R=", 
    round(df_r['LSAS',]$Q0,3),", p_c=", round(df_p_c['LSAS',]$Q0,3),", ", make_pval_u_(df_p_u['LSAS',]$Q0), 
    sep='') 
  
  return(output)

}


