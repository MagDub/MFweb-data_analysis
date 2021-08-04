  source('~/MFweb/data_analysis/10_stats/make_string.R')
  source('~/MFweb/data_analysis/10_stats/make_pval_c.R')
  source('~/MFweb/data_analysis/10_stats/make_pval_u.R')

  library(car)
  library(tidyverse)
  library(ggpubr)
  library(rstatix)
  library(readxl)
  library(lsr)
  library(effectsize)
  library(Hmisc)
  library("PerformanceAnalytics")
  library(ppcor)
  library(psych)
  
  dataMFweb <- read_excel("~/MFweb/data_analysis/10_stats/web_data_completed.xlsx")    
  
  # Take only subset: concatenate the ones we want
  data_tmp_all <- subset(dataMFweb , select=c("User", "exclude", "age", "gender", "IQscore", "xi_SH", "xi_LH", "pickedD_SH", "pickedD_LH", "ASRS_SumInattention", "ASRS_SumHyperImpuls", "BIS11_Attentional", "BIS11_Motor", "BIS11_NonPlanning"))
  
  data_tmp <- subset(data_tmp_all, exclude!=1)
  
  # Compute mean
  data_tmp$xi_mean = (data_tmp$xi_SH + data_tmp$xi_LH)/2
  data_tmp$pickedD_mean = (data_tmp$pickedD_SH + data_tmp$pickedD_LH)/2
  
  # Correlation
  my_data <- data_tmp[, c(3,5,6,7,8,9,10,11,12,13,14,15,16)]

  # remove nans
  my_data = my_data[complete.cases(my_data), ] 
  y_data <- data.frame(my_data)
  
  ### Bivariate correlation bonferroni corrected
  
  # ASRS
  res_D_A_u <- corr.test(y_data[c("pickedD_mean")], y_data[c("ASRS_SumHyperImpuls","ASRS_SumInattention")], method = "pearson", adjust="none", alpha=.05)
  res_xi_A_u <- corr.test(y_data[c("xi_mean")], y_data[c("ASRS_SumHyperImpuls","ASRS_SumInattention")], method = "pearson", adjust="none", alpha=.05)
  
  res_D_A_c <- corr.test(y_data[c("pickedD_mean")], y_data[c("ASRS_SumHyperImpuls","ASRS_SumInattention")], method = "pearson", adjust="bonferroni", alpha=.05)
  res_xi_A_c <- corr.test(y_data[c("xi_mean")], y_data[c("ASRS_SumHyperImpuls","ASRS_SumInattention")], method = "pearson", adjust="bonferroni", alpha=.05)

  out1=paste("pickedD_mean vs ASRS_SumHyperImpuls: Bonferroni corrected (n=2) correlation: pearson r=",round(res_D_A_c$r[1],3),", ",make_pval_c(res_D_A_c$p[1]),", ", make_pval_u(res_D_A_u$p[1]), sep = "")
  out2=paste("pickedD_mean vs ASRS_SumInattention: Bonferroni corrected (n=2) correlation: pearson r=",round(res_D_A_c$r[2],3),", ",make_pval_c(res_D_A_c$p[2]),", ", make_pval_u(res_D_A_u$p[2]), sep = "")
  out3=paste("xi_mean vs ASRS_SumHyperImpuls: Bonferroni corrected (n=2) correlation: pearson r=",round(res_xi_A_c$r[1],3),", ",make_pval_c(res_xi_A_c$p[1]),", ", make_pval_u(res_xi_A_u$p[1]), sep = "")
  out4=paste("xi_mean vs ASRS_SumInattention: Bonferroni corrected (n=2) correlation: pearson r=",round(res_xi_A_c$r[2],3),", ",make_pval_c(res_xi_A_c$p[2]),", ", make_pval_u(res_xi_A_u$p[2]), sep = "")
  
  output_ASRS=c(out1,out3,out2,out4)
  
  # BIS
  res_D_B_u <- corr.test(y_data[c("pickedD_mean")], y_data[c("BIS11_Attentional","BIS11_Motor", "BIS11_NonPlanning")], method = "pearson", adjust="none", alpha=.05)
  res_xi_B_u <- corr.test(y_data[c("xi_mean")], y_data[c("BIS11_Attentional","BIS11_Motor", "BIS11_NonPlanning")], method = "pearson", adjust="none", alpha=.05)
  
  res_D_B_c <- corr.test(y_data[c("pickedD_mean")], y_data[c("BIS11_Attentional","BIS11_Motor", "BIS11_NonPlanning")], method = "pearson", adjust="bonferroni", alpha=.05)
  res_xi_B_c <- corr.test(y_data[c("xi_mean")], y_data[c("BIS11_Attentional","BIS11_Motor", "BIS11_NonPlanning")], method = "pearson", adjust="bonferroni", alpha=.05)
  
  out5=paste("pickedD_mean vs BIS11_Attentional: Bonferroni corrected (n=3) correlation: pearson r=",round(res_D_B_c$r[1],3),", ",make_pval_c(res_D_B_c$p[1]),", ", make_pval_u(res_D_B_u$p[1]), sep = "")
  out6=paste("pickedD_mean vs BIS11_Motor: Bonferroni corrected (n=3) correlation: pearson r=",round(res_D_B_c$r[2],3),", ",make_pval_c(res_D_B_c$p[2]),", ", make_pval_u(res_D_B_u$p[2]), sep = "")
  out7=paste("pickedD_mean vs BIS11_NonPlanning: Bonferroni corrected (n=3) correlation: pearson r=",round(res_D_B_c$r[3],3),", ",make_pval_c(res_D_B_c$p[3]),", ", make_pval_u(res_D_B_u$p[3]), sep = "")
  
  out8=paste("xi_mean vs BIS11_Attentional: Bonferroni corrected (n=3) correlation: pearson r=",round(res_xi_B_c$r[1],3),", ",make_pval_c(res_xi_B_c$p[1]),", ", make_pval_u(res_xi_B_u$p[1]), sep = "")
  out9=paste("xi_mean vs BIS11_Motor: Bonferroni corrected (n=3) correlation: pearson r=",round(res_xi_B_c$r[2],3),", ",make_pval_c(res_xi_B_c$p[2]),", ", make_pval_u(res_xi_B_u$p[2]), sep = "")
  out10=paste("xi_mean vs BIS11_NonPlanning: Bonferroni corrected (n=3) correlation: pearson r=",round(res_xi_B_c$r[3],3),", ",make_pval_c(res_xi_B_c$p[3]),", ", make_pval_u(res_xi_B_u$p[3]), sep = "")
  
  output_BIS=c(out5,out8,out6, out9, out7, out10)

  
  ### Partial
  
  # ASRS
  
  par.r=partial.r(y_data[c("pickedD_mean", "ASRS_SumHyperImpuls", "ASRS_SumInattention", "age","IQscore")], c(1,2,3), c(4,5))
  cpAD_c <- corr.p(par.r,n=nrow(y_data)-2,adjust="bonferroni",alpha=.05)
  cpAD_u <- corr.p(par.r,n=nrow(y_data)-2,adjust="none",alpha=.05)
  
  par.r=partial.r(y_data[c("xi_mean", "ASRS_SumHyperImpuls", "ASRS_SumInattention", "age","IQscore")], c(1,2,3), c(4,5))
  cpAX_c <- corr.p(par.r,n=nrow(y_data)-2,adjust="bonferroni",alpha=.05)
  cpAX_u <- corr.p(par.r,n=nrow(y_data)-2,adjust="none",alpha=.05)
  
  # BIS
  
  par.r=partial.r(y_data[c("pickedD_mean", "BIS11_NonPlanning", "BIS11_Motor", "BIS11_Attentional", "age","IQscore")], c(1,2,3,4), c(5,6))
  cpBD_c <- corr.p(par.r,n=nrow(y_data)-3,adjust="bonferroni",alpha=.05)
  cpBD_u <- corr.p(par.r,n=nrow(y_data)-3,adjust="none",alpha=.05)
  
  par.r=partial.r(y_data[c("xi_mean", "BIS11_NonPlanning", "BIS11_Motor", "BIS11_Attentional", "age","IQscore")], c(1,2,3,4), c(5,6))
  cpBX_c <- corr.p(par.r,n=nrow(y_data)-3,adjust="bonferroni",alpha=.05)
  cpBX_u <- corr.p(par.r,n=nrow(y_data)-3,adjust="none",alpha=.05)
  
  
  # TODO make nice outputs
  
  ###### BIS
  
  ### motor
  
  # D
  cpBD_c_M_r=cpBD_c$r[1,3] 
  cpBD_c_M_p=cpBD_u$p[1,3]*3 
  cpBD_u_M_p=cpBD_u$p[1,3]
  
  # xi
  cpBX_c_M_r=cpBX_c$r[1,3] 
  cpBX_c_M_p=cpBX_u$p[1,3]*3 
  cpBX_u_M_p=cpBX_u$p[1,3]
  
  output_BIS_1=paste('BIS motor: low-value bandit: r=', round(cpBD_c_M_r,3), ', p_c=', round(cpBD_c_M_p,3), ', p_u=', round(cpBD_u_M_p,3), 
                                 ', epsilon-greedy: r=', round(cpBX_c_M_r,3), ', p_c=', round(cpBX_c_M_p,3), ', p_u=', round(cpBX_u_M_p,3),
                     sep = "")
  
  ### non planning
  
  # D
  cpBD_c_nonP_r=cpBD_c$r[1,2] 
  cpBD_c_nonP_p=cpBD_u$p[1,2]*3
  cpBD_u_nonP_p=cpBD_u$p[1,2]
  
  # xi
  cpBX_c_nonP_r=cpBX_c$r[1,2] 
  cpBX_c_nonP_p=cpBX_u$p[1,2]*3
  cpBX_u_nonP_p=cpBX_u$p[1,2]
  
  output_BIS_2=paste('BIS non-planning: low-value bandit: r=', round(cpBD_c_nonP_r,3), ', p_c=', round(cpBD_c_nonP_p,3), ', p_u=', round(cpBD_u_nonP_p,3),
                     ', epsilon-greedy: r=', round(cpBX_c_nonP_r,3), ', p_c=', round(cpBX_c_nonP_p,3), ', p_u=', round(cpBX_u_nonP_p,3),  
                     sep = "")
  
  ### attentional
  
  # D
  cpBD_c_A_r=cpBD_c$r[1,4] 
  cpBD_c_A_p=cpBD_u$p[1,4]*3
  cpBD_u_A_p=cpBD_u$p[1,4]
  
  # xi
  cpBX_c_A_r=cpBX_c$r[1,4] 
  cpBX_c_A_p=cpBX_u$p[1,4]*3
  cpBX_u_A_p=cpBX_u$p[1,4]
  
  output_BIS_3=paste('BIS attentional: low-value bandit: r=', round(cpBD_c_A_r,3), ', p_c=', round(cpBD_c_A_p,3), ', p_u=', round(cpBD_u_A_p,3), 
                     ', epsilon-greedy: r=', round(cpBX_c_A_r,3), ', p_c=', round(cpBX_c_A_p,3), ', p_u=', round(cpBX_u_A_p,3), 
                     sep = "")
  
  ###### ASRS
  
  ### hyper-impuls
  
  # D
  cpAD_c_H_r=cpAD_c$r[1,2] 
  cpAD_c_H_p=cpAD_u$p[1,2]*2
  cpAD_u_H_p=cpAD_u$p[1,2]
  
  # X
  cpAX_c_H_r=cpAX_c$r[1,2] 
  cpAX_c_H_p=cpAX_u$p[1,2]*2
  cpAX_u_H_p=cpAX_u$p[1,2]
  
  output_ASRS_1=paste('ASRS hyper-impuls: low-value bandit: r=', round(cpAD_c_H_r,3), ', p_c=', round(cpAD_c_H_p,3), ', p_c=', round(cpAD_u_H_p,3), 
                     ', epsilon-greedy: r=', round(cpAX_c_H_r,3), ', p_c=', round(cpAX_c_H_p,3), ', p_u=', round(cpAX_u_H_p,3), 
                     sep = "")
  
  ### inattention
  
  # D
  cpAD_c_I_r=cpAD_c$r[1,3] 
  cpAD_c_I_p=cpAD_u$p[1,3]*2
  cpAD_u_I_p=cpAD_u$p[1,3]
  
  # X
  cpAX_c_I_r=cpAX_c$r[1,3] 
  cpAX_c_I_p=cpAX_u$p[1,3]*2
  cpAX_u_I_p=cpAX_u$p[1,3]
  
  output_ASRS_2=paste('ASRS inattention: low-value bandit: r=', round(cpAD_c_I_r,3), ', p_c=', round(cpAD_c_I_p,3), ', p_u=', round(cpAD_u_I_p,3),  
                      ', epsilon-greedy: r=', round(cpAX_c_I_r,3), ', p_c=', round(cpAX_c_I_p,3), ', p_u=', round(cpAX_u_I_p,3), 
                      sep = "")
  
  

  ### Print
  
  # bivariate
  output_BIS
  output_ASRS
  
  # partial
  output_BIS_1
  output_BIS_2
  output_BIS_3
  
  output_ASRS_1
  output_ASRS_2
  
  
  all_text = c(
    
    '', '', 
    
    'BIS subscales bivariate :','', output_BIS,'','', '', 
    'BIS subscales partial :','', output_BIS_1,output_BIS_2, output_BIS_3,'','', '', 
    'ASRS subscales bivariate :','', output_ASRS,'','', '', 
    'ASRS subscales partial :','', output_ASRS_1,output_ASRS_2 
    
  )
  
  fileConn<-file("~/MFweb/data_analysis/10_stats/biv_part_corr/results_subscales.doc")
  writeLines(all_text, fileConn)
  close(fileConn)
