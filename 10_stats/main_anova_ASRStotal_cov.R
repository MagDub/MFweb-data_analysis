
source('~/MFweb/data_analysis/10_stats/fct_analysis_2way_ASRStotal_cov.R')

#### ALL GROUPS

all_text = c(
  
  '', '', 
  
  'HIGH VALUE ', '', rm_anova_MFweb_ASRStotal_cov('pickedhigh_SH', 'pickedhigh_LH'),'','', '',  
  'HIGH VALUE - is A ', '', rm_anova_MFweb_ASRStotal_cov('pickedhigh_Aexploit_SH', 'pickedhigh_Aexploit_LH'),'','', '',  
  'HIGH VALUE - is B  ', '', rm_anova_MFweb_ASRStotal_cov('pickedhigh_Bexploit_SH', 'pickedhigh_Bexploit_LH'),'','', '',  
  'LOW VALUE:', '',rm_anova_MFweb_ASRStotal_cov('pickedD_SH', 'pickedD_LH'),'','', '', 
  'NOVEL VALUE:', '',rm_anova_MFweb_ASRStotal_cov('pickedC_SH', 'pickedC_LH'),'','', '', 
  'BANDIT A:', '',rm_anova_MFweb_ASRStotal_cov('pickedA_SH', 'pickedA_LH'),'','', '', 
  'BANDIT B:', '',rm_anova_MFweb_ASRStotal_cov('pickedB_SH', 'pickedB_LH'),'','', '', 
  
  'CONSIST:','', rm_anova_MFweb_ASRStotal_cov('consistent_SH', 'consistent_LH'),'','', '', 
  'IG:','', rm_anova_MFweb_ASRStotal_cov('IS_SH', 'IS_LH'),'','', '', 
  'EV:','', rm_anova_MFweb_ASRStotal_cov('EV_SH', 'EV_LH'),'','', '', 
  
  'score 1st SH vs 1st LH:','', rm_anova_MFweb_ASRStotal_cov('average_first_apple_SH', 'average_first_apple_LH'),'','', '', 
  'score 1st LH vs all LH:','', rm_anova_MFweb_ASRStotal_cov('average_first_apple_LH', 'average_all_apple_LH'),'','', '', 
  'score 1st SH vs all LH::','', rm_anova_MFweb_ASRStotal_cov('average_first_apple_SH', 'average_all_apple_LH'),'','', '', 
  
  'Model thomp+eps+eta vs UCB+eps+eta:','', rm_anova_MFweb_ASRStotal_cov('BIC_thompson_eps_eta', 'BIC_UCB_eps_eta'),'','', '',  
  
  'Model thomp+eps+eta vs thomp:','', rm_anova_MFweb_ASRStotal_cov('BIC_thompson_eps_eta', 'BIC_thompson'),'','', '', 
  
  'SGM0:','', rm_anova_MFweb_ASRStotal_cov('sgm0_SH', 'sgm0_LH'),'','', '', 
  'EPSILON:', '',rm_anova_MFweb_ASRStotal_cov('xi_SH', 'xi_LH'),'','', '', 
  'NOV:', '',rm_anova_MFweb_ASRStotal_cov('eta_SH', 'eta_LH'),'','', '', 
  
  'MOD8 TAU:','', rm_anova_MFweb_ASRStotal_cov('mod8_tau_SH', 'mod8_tau_LH'),'','', '', 
  'MOD8 GAMMA:','', rm_anova_MFweb_ASRStotal_cov('mod8_gamma_SH', 'mod8_gamma_LH'),'','', '', 
  'MOD8 EPSILON:', '',rm_anova_MFweb_ASRStotal_cov('mod8_xi_SH', 'mod8_xi_LH'),'','', '', 
  'MOD8 NOV:', '',rm_anova_MFweb_ASRStotal_cov('mod8_eta_SH', 'mod8_eta_LH')
  
)

fileConn<-file("~/MFweb/data_analysis/10_stats/results_ASRStotal_cov.doc")
writeLines(all_text, fileConn)
close(fileConn)
