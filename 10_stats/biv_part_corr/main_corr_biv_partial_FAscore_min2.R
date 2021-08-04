  source('~/MFweb/data_analysis/10_stats/make_string.R')

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
  
  
  data_demo_tmp <- read_excel("~/MFweb/data_analysis/10_stats/web_data_completed.xlsx")    
  data_demo_all <- subset(data_demo_tmp , select=c("User", "exclude", "IQscore"))
  data_demo <- subset(data_demo_all, exclude!=1)
  
  load(file = "~/MFweb/data_analysis/10_stats/FA/all_behav_and_FAscores_min2.Rdata")
  
  # Correlation
  my_data_tmp <- subset(data_tmp_all, select = -c(3:27))
  
  # add IQ
  my_data_tmp$IQscore = data_demo$IQscore
  
  # regorganise columns
  my_data <- my_data_tmp[, c(1:3,14,7:13,4:6)]
  
  res <- cor(my_data, use = "complete.obs")
  round(res, 2)
  
  # significance
  res2 <- rcorr(as.matrix(my_data))
  res2
  
  # correct for age and IQ
  my_data = my_data[complete.cases(my_data), ] # remove nans
  y_data=data.frame(my_data)
  
  # Factor 3 and tabula-rasa
  
  res=pcor.test(y_data$pickedD_mean,y_data$scores_f3,y_data[,c("age","IQscore")])
  res1p=make_string(res, 'F3', 'D_mean', 'partial')
  res <- cor.test(y_data$pickedD_mean, y_data$scores_f3,method = "pearson")
  res1b=make_string(res, 'F3', 'D_mean', 'bivariate')
  
  res=pcor.test(y_data$xi_mean,y_data$scores_f3,y_data[,c("age","IQscore")])
  res4p=make_string(res, 'F3', 'xi_mean', 'partial')
  res <- cor.test(y_data$xi_mean, y_data$scores_f3,method = "pearson")
  res4b=make_string(res, 'F3', 'xi_mean', 'bivariate')
  
  # Factor 1 and novel
  
  res=pcor.test(y_data$pickedC_mean,y_data$scores_f1,y_data[,c("age","IQscore")])
  res7p=make_string(res, 'F1', 'C_mean', 'partial')
  res <- cor.test(y_data$pickedC_mean, y_data$scores_f1, method = "pearson")
  res7b=make_string(res, 'F1', 'C_mean', 'bivariate')
  
  res=pcor.test(y_data$eta_mean,y_data$scores_f1,y_data[,c("age","IQscore")])
  res10p=make_string(res, 'F1', 'eta_mean', 'partial')
  res <- cor.test(y_data$eta_mean, y_data$scores_f1, method = "pearson")
  res10b=make_string(res, 'F1', 'eta_mean', 'bivariate')
  
  # Output
  
  output_txt2=c(res1b,'',res1p,'', res4b,'', res4p)
  
  output_txt3=c(res7b,'',res7p,'', res10b,'', res10p)
  
  output_txt4=c(res1b,'',res4b,'',res7b,'', res10b,'','',
                res1p,'',res4p,'',res7p,'', res10p, '')
    

  
  
  
