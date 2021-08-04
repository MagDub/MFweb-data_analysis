
source('~/MFweb/data_analysis/10_stats/fct_analysis_2way_nocov.R')

#### ALL GROUPS

all_text = c(
  
  '', '', 
  
  'HIGH VALUE ', '', rm_anova_MFweb_nocov('pickedhigh_SH', 'pickedhigh_LH'),'','', '',  
  'HIGH VALUE - is A ', '', rm_anova_MFweb_nocov('pickedhigh_Aexploit_SH', 'pickedhigh_Aexploit_LH'),'','', '',  
  'HIGH VALUE - is B  ', '', rm_anova_MFweb_nocov('pickedhigh_Bexploit_SH', 'pickedhigh_Bexploit_LH'),'','', '',  
  'LOW VALUE:', '',rm_anova_MFweb_nocov('pickedD_SH', 'pickedD_LH'),'','', '', 
  'NOVEL VALUE:', '',rm_anova_MFweb_nocov('pickedC_SH', 'pickedC_LH'),'','', '', 
  'BANDIT A:', '',rm_anova_MFweb_nocov('pickedA_SH', 'pickedA_LH'),'','', '', 
  'BANDIT B:', '',rm_anova_MFweb_nocov('pickedB_SH', 'pickedB_LH'),'','', '', 
  
  'CONSIST:','', rm_anova_MFweb_nocov('consistent_SH', 'consistent_LH'),'','', '', 
  'IG:','', rm_anova_MFweb_nocov('IS_SH', 'IS_LH'),'','', '', 
  'EV:','', rm_anova_MFweb_nocov('EV_SH', 'EV_LH'),'','', '', 
  
  'score 1st SH vs 1st LH:','', rm_anova_MFweb_nocov('average_first_apple_SH', 'average_first_apple_LH'),'','', '', 
  'score 1st LH vs all LH:','', rm_anova_MFweb_nocov('average_first_apple_LH', 'average_all_apple_LH'),'','', '', 
  'score 1st SH vs all LH::','', rm_anova_MFweb_nocov('average_first_apple_SH', 'average_all_apple_LH'),'','', '', 
  
  'Model thomp+eps+eta vs UCB+eps+eta:','', rm_anova_MFweb_nocov('BIC_thompson_eps_eta', 'BIC_UCB_eps_eta'),'','', '',  
  
  'Model thomp+eps+eta vs thomp:','', rm_anova_MFweb_nocov('BIC_thompson_eps_eta', 'BIC_thompson'),'','', '', 
  
  'SGM0:','', rm_anova_MFweb_nocov('sgm0_SH', 'sgm0_LH'),'','', '', 
  'EPSILON:', '',rm_anova_MFweb_nocov('xi_SH', 'xi_LH'),'','', '', 
  'NOV:', '',rm_anova_MFweb_nocov('eta_SH', 'eta_LH'),'','', '', 
  
  'MOD8 TAU:','', rm_anova_MFweb_nocov('mod8_tau_SH', 'mod8_tau_LH'),'','', '', 
  'MOD8 GAMMA:','', rm_anova_MFweb_nocov('mod8_gamma_SH', 'mod8_gamma_LH'),'','', '', 
  'MOD8 EPSILON:', '',rm_anova_MFweb_nocov('mod8_xi_SH', 'mod8_xi_LH'),'','', '', 
  'MOD8 NOV:', '',rm_anova_MFweb_nocov('mod8_eta_SH', 'mod8_eta_LH')
  
)

fileConn<-file("~/MFweb/data_analysis/10_stats/results_nocov.doc")
writeLines(all_text, fileConn)
close(fileConn)
