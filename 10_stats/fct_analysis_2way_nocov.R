# source and then on terminal ex: 
# s<-rm_anova_MF('freq_D_picked_shortH', 'freq_D_picked_longH')

# From example: https://www.datanovia.com/en/lessons/repeated-measures-anova-in-r/

rm_anova_MFweb_nocov <- function(x1, x2) {

  library(car)
  library(tidyverse)
  library(ggpubr)
  library(rstatix)
  library(readxl)
  library(lsr)
  library(effectsize)

  #x1<-'average_first_apple_SH'
  #x2<-'average_all_apple_LH'
  
  dataMFweb <- read_excel("~/MFweb/data_analysis/10_stats/web_data_completed.xlsx")    
  
  # Take only subset: concatenate the ones we want
  data_tmp_all <- subset(dataMFweb , select=c("User", "exclude", x1, x2))
  
  data_tmp <- subset(data_tmp_all, exclude!=1)
  
  # Change from wide to long format
  data_tmp <- data_tmp %>%
    gather(key = "hor", value = "freq", x1, x2) %>%
    convert_as_factor(User, hor)
  
  # Remove Nans
  #data_ = data_tmp[complete.cases(data_tmp), ]
  
  # Normality assumption (checks if his different than normal distrib)
  norm<- data_ %>%
    group_by(hor) %>%
    shapiro_test(freq)
  
  # Subset weight data with horizon 1
  before <- subset(data_,  hor == x1, freq,
                   drop = TRUE)
  
  # subset weight data with horizon 1
  after <- subset(data_,  hor == x2, freq,
                  drop = TRUE)
  
  # t-test
  res <- t.test(before, after, paired = TRUE)
  
  # wilcoxon-test (does not require normality assumption)
  # Wilcoxon signed rank test
  res_w <- wilcox.test(before, after, paired = TRUE, alternative = "two.sided", conf.int = TRUE, conf.level = 0.95)
  
  # Paired-samples wilcoxon effect size
  effect_wil_pwcH <- wilcox_effsize(freq ~ hor, data = data_, paired = TRUE)
  
  # Horizon effect size
  effect_pwcH <-cohens_d(freq ~ hor, data = data_, paired = TRUE, ci = 0.95)
  
  # replace small values with p<.001
  res_p <- round(res$p.value,3)
  if (res_p==0){
    res_p<-'p<.001'
  } else{
    res_p<-sub("^0+", "", res_p) # remove leading zero
    res_p<-paste('p=',res_p, sep="")
  }
  
  norm_p_1 <- round(norm$p[1],3)
  if (norm_p_1==0){
    norm_p_1<-'p<.001'
  } else{
    norm_p_1<-sub("^0+", "", norm_p_1) 
    norm_p_1<-paste('p=',norm_p_1, sep="")
  }
  
  norm_p_2 <- round(norm$p[2],3)
  if (norm_p_2==0){
    norm_p_2<-'p<.001'
  } else{
    norm_p_2<-sub("^0+", "", norm_p_2) 
    norm_p_2<-paste('p=',norm_p_2, sep="")
  }
  
  res_w_p <- round(res_w$p.value,3)
  if (res_w_p==0){
    res_w_p<-'p<.001'
  } else{
    res_w_p<-sub("^0+", "", res_w_p) 
    res_w_p<-paste('p=',res_w_p, sep="")
  }
  
  output_txt=paste(
    "shapiro test: ",norm_p_1,", ",norm_p_2, ",",
    " t(",res$parameter,")=",round(res$statistic,3),
    ", ",res_p, 
    ", 95%CI_M=[",round(res$conf.int[1],3),",",round(res$conf.int[2],3),"]",
    ", d=",round(effect_pwcH$Cohens_d,3),
    ", 95%CI_ES=[",round(effect_pwcH$CI_low,3),",",round(effect_pwcH$CI_high,3),"]", 
    ", wilcoxon signed rank test: V=",round(res_w$statistic,3),", ",res_w_p, 
    ", 95%CI_w=[",round(res_w$conf.int[1],3),",",round(res_w$conf.int[2],3),"]",
    ", dz=",round(effect_wil_pwcH$effsize,3), sep = "")
  
  return(output_txt)
}

