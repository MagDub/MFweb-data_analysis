# source and then on terminal ex: 
# s<-rm_anova_MF('freq_D_picked_shortH', 'freq_D_picked_longH')

# From example: https://www.datanovia.com/en/lessons/repeated-measures-anova-in-r/

rm_anova_MFweb_F3_cov <- function(x1, x2) {

  library(car)
  library(tidyverse)
  library(ggpubr)
  library(rstatix)
  library(readxl)
  library(lsr)
  library(effectsize)

  #x1<-'pickedD_SH'
  #x2<-'pickedD_LH'
  
  dataMFweb <- read_excel("~/MFweb/data_analysis/10_stats/web_data_completed.xlsx")    
  
  # Take only subset: concatenate the ones we want
  data_demo_all <- subset(dataMFweb , select=c("User", "exclude", x1, x2))
  
  data_demo <- subset(data_demo_all, exclude!=1)
  
  # factor scores
  load(file = "~/MFweb/data_analysis/10_stats/FA/all_behav_and_FAscores.Rdata")
  data_demo$scores_f3=data_tmp_all$scores_f3
  
  # Change from wide to long format
  data_demo <- data_demo %>%
    gather(key = "hor", value = "freq", x1, x2) %>%
    convert_as_factor(User, hor)
  
  # Anova computation
  res.aov <- anova_test(
    data = data_demo, dv = freq, wid = User,
    within = hor,
    covariate = c(scores_f3),
    effect.size = "pes"
  )
 
  tab<-get_anova_table(res.aov)
  
  # Pairwise comparisons
  pwcH <- data_demo %>%
    pairwise_t_test(freq ~ hor, paired = TRUE, p.adjust.method = "none")

  # Horizon effect size
  effect_pwcH <-cohensD(freq ~ hor, data = data_demo, method = "paired")
  
  # Output
  sentence1=paste(
    "horizon main effect: F(", 
    tab$DFn[2],",",tab$DFd[2],")=",round(tab$F[2],3),", p=", round(tab$p[2],3), ", pes=", round(tab$pes[2],3), 
    "; F3 main effect: F(",
    tab$DFn[1],",",tab$DFd[1],")=",round(tab$F[1],3),", p=", round(tab$p[1],3), ", pes=", round(tab$pes[1],3),
    "; F3-by-horizon interaction: F(",
    tab$DFn[3],",",tab$DFd[3],")=",round(tab$F[3],3),", p=", round(tab$p[3],3), ", pes=", round(tab$pes[3],3), sep='') 
  
  sentence2=paste("Pairwise comparisons for horizon effect: t(",pwcH$n1,")=", round(pwcH$statistic,3),", p=", round(pwcH$p,3), ", d=", round(effect_pwcH,3), sep='') 
  
  mid=paste("-------------------------------------------------------")
  
  output_txt = c(sentence1,paste(""), mid, paste(""),sentence2,paste(""), mid)
  
  return(output_txt)
}

