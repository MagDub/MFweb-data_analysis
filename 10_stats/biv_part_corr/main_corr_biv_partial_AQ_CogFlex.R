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
  
  dataMFweb <- read_excel("~/MFweb/data_analysis/10_stats/web_data_completed.xlsx")    
  
  # Take only subset: concatenate the ones we want
  data_tmp_all <- subset(dataMFweb , select=c("User", "exclude", "age", "gender", "IQscore", "AQ10_TotalScore", "CFS_TotalScore", "xi_SH", "xi_LH", "pickedD_SH", "pickedD_LH"))
  
  data_tmp <- subset(data_tmp_all, exclude!=1)
  
  # Compute mean
  data_tmp$xi_mean = (data_tmp$xi_SH + data_tmp$xi_LH)/2
  data_tmp$pickedD_mean = (data_tmp$pickedD_SH + data_tmp$pickedD_LH)/2
  
  # Remove Nans
  # data_ = data_tmp[complete.cases(data_tmp), ]
  
  # Correlation
  my_data <- data_tmp[, c(3,5,6,7,8,9,10,11,12,13)]
  res <- cor(my_data, use = "complete.obs")
  round(res, 2)
  
  # significance
  res2 <- rcorr(as.matrix(my_data))
  res2
  
  # matrix
  chart.Correlation(my_data, histogram=TRUE, pch=19)
  
  # correct for age and IQ
  my_data = my_data[complete.cases(my_data), ] # remove nans
  y.data=data.frame(my_data)
  
  # AQ10
  
  res=pcor.test(y.data$pickedD_mean,y.data$AQ10_TotalScore,y.data[,c("age","IQscore")])
  res1p=make_string(res, 'AQ10', 'D_mean', 'partial')
  res <- cor.test(y.data$pickedD_mean, y.data$AQ10_TotalScore,method = "pearson")
  res1b=make_string(res, 'AQ10', 'D_mean', 'bivariate')
  
  res=pcor.test(y.data$pickedD_SH,y.data$AQ10_TotalScore,y.data[,c("age","IQscore")])
  res2p=make_string(res, 'AQ10', 'D_SH', 'partial')
  res <- cor.test(y.data$pickedD_SH, y.data$AQ10_TotalScore,method = "pearson")
  res2b=make_string(res, 'AQ10', 'D_SH', 'bivariate')
  
  res=pcor.test(y.data$pickedD_LH,y.data$AQ10_TotalScore,y.data[,c("age","IQscore")])
  res3p=make_string(res, 'AQ10', 'D_LH', 'partial')
  res <- cor.test(y.data$pickedD_LH, y.data$AQ10_TotalScore,method = "pearson")
  res3b=make_string(res, 'AQ10', 'D_LH', 'bivariate')
  
  res=pcor.test(y.data$xi_mean,y.data$AQ10_TotalScore,y.data[,c("age","IQscore")])
  res4p=make_string(res, 'AQ10', 'xi_mean', 'partial')
  res <- cor.test(y.data$xi_mean, y.data$AQ10_TotalScore,method = "pearson")
  res4b=make_string(res, 'AQ10', 'xi_mean', 'bivariate')
  
  res=pcor.test(y.data$xi_SH,y.data$AQ10_TotalScore,y.data[,c("age","IQscore")])
  res5p=make_string(res, 'AQ10', 'xi_SH', 'partial')
  res <- cor.test(y.data$xi_SH, y.data$AQ10_TotalScore,method = "pearson")
  res5b=make_string(res, 'AQ10', 'xi_SH', 'bivariate')
  
  res=pcor.test(y.data$xi_LH,y.data$AQ10_TotalScore,y.data[,c("age","IQscore")])
  res6p=make_string(res, 'AQ10', 'xi_LH', 'partial')
  res <- cor.test(y.data$xi_LH, y.data$AQ10_TotalScore,method = "pearson")
  res6b=make_string(res, 'AQ10', 'xi_LH', 'bivariate')
  
  # CFS
  
  res=pcor.test(y.data$pickedD_mean,y.data$CFS_TotalScore,y.data[,c("age","IQscore")])
  res7p=make_string(res, 'CFS', 'D_mean', 'partial')
  res <- cor.test(y.data$pickedD_mean, y.data$CFS_TotalScore, method = "pearson")
  res7b=make_string(res, 'CFS', 'D_mean', 'bivariate')

  res=pcor.test(y.data$pickedD_SH,y.data$CFS_TotalScore,y.data[,c("age","IQscore")])
  res8p=make_string(res, 'CFS', 'D_SH', 'partial')
  res <- cor.test(y.data$pickedD_SH, y.data$CFS_TotalScore, method = "pearson")
  res8b=make_string(res, 'CFS', 'D_SH', 'bivariate')
  
  res=pcor.test(y.data$pickedD_LH,y.data$CFS_TotalScore,y.data[,c("age","IQscore")])
  res9p=make_string(res, 'CFS', 'D_LH', 'partial')
  res <- cor.test(y.data$pickedD_LH, y.data$CFS_TotalScore, method = "pearson")
  res9b=make_string(res, 'CFS', 'D_LH', 'bivariate')
  
  res=pcor.test(y.data$xi_mean,y.data$CFS_TotalScore,y.data[,c("age","IQscore")])
  res10p=make_string(res, 'CFS', 'xi_mean', 'partial')
  res <- cor.test(y.data$xi_mean, y.data$CFS_TotalScore, method = "pearson")
  res10b=make_string(res, 'CFS', 'xi_mean', 'bivariate')
  
  res=pcor.test(y.data$xi_SH,y.data$CFS_TotalScore,y.data[,c("age","IQscore")])
  res11p=make_string(res, 'CFS', 'xi_SH', 'partial')
  res <- cor.test(y.data$xi_SH, y.data$CFS_TotalScore, method = "pearson")
  res11b=make_string(res, 'CFS', 'xi_SH', 'bivariate')
  
  res=pcor.test(y.data$xi_LH,y.data$CFS_TotalScore,y.data[,c("age","IQscore")])
  res12p=make_string(res, 'CFS', 'xi_LH', 'partial')
  res <- cor.test(y.data$xi_LH, y.data$CFS_TotalScore, method = "pearson")
  res12b=make_string(res, 'CFS', 'xi_LH', 'bivariate')
  
  output_txt1=c(res1b,'',res2b,'',res3b,'', res4b,'',res5b,'',res6b,'', res7b,'',res8b,'',res9b,'', res10b,'',res11b,'',res12b,'','',
               res1p,'',res2p,'',res3p,'', res4p,'',res5p,'',res6p,'', res7p,'',res8p,'',res9p,'', res10p,'',res11p,'',res12p,'')
  
  output_txt2=c(res1b,'',res1p,'', res4b,'', res4p)
  
  output_txt3=c(res7b,'',res7p,'', res10b,'', res10p)
  
  output_txt4=c(res1b,'',res4b,'',res7b,'', res10b,'','',
                res1p,'',res4p,'',res7p,'', res10p, '')
    

  
  
  
