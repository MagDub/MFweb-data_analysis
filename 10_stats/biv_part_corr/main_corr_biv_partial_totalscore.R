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
  data_tmp_all <- subset(dataMFweb , select=c("User", "exclude", "age", "gender", "IQscore", "BIS11_TotalScore", "ASRS_Sum", "xi_SH", "xi_LH", "pickedD_SH", "pickedD_LH"))
  
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
  
  # BIS
  
  res=pcor.test(y.data$pickedD_mean,y.data$BIS11_TotalScore,y.data[,c("age","IQscore")])
  res1p=make_string(res, 'BIS', 'D_mean', 'partial')
  res <- cor.test(y.data$pickedD_mean, y.data$BIS11_TotalScore,method = "pearson")
  res1b=make_string(res, 'BIS', 'D_mean', 'bivariate')
  
  res=pcor.test(y.data$pickedD_SH,y.data$BIS11_TotalScore,y.data[,c("age","IQscore")])
  res2p=make_string(res, 'BIS', 'D_SH', 'partial')
  res <- cor.test(y.data$pickedD_SH, y.data$BIS11_TotalScore,method = "pearson")
  res2b=make_string(res, 'BIS', 'D_SH', 'bivariate')
  
  res=pcor.test(y.data$pickedD_LH,y.data$BIS11_TotalScore,y.data[,c("age","IQscore")])
  res3p=make_string(res, 'BIS', 'D_LH', 'partial')
  res <- cor.test(y.data$pickedD_LH, y.data$BIS11_TotalScore,method = "pearson")
  res3b=make_string(res, 'BIS', 'D_LH', 'bivariate')
  
  res=pcor.test(y.data$xi_mean,y.data$BIS11_TotalScore,y.data[,c("age","IQscore")])
  res4p=make_string(res, 'BIS', 'xi_mean', 'partial')
  res <- cor.test(y.data$xi_mean, y.data$BIS11_TotalScore,method = "pearson")
  res4b=make_string(res, 'BIS', 'xi_mean', 'bivariate')
  
  res=pcor.test(y.data$xi_SH,y.data$BIS11_TotalScore,y.data[,c("age","IQscore")])
  res5p=make_string(res, 'BIS', 'xi_SH', 'partial')
  res <- cor.test(y.data$xi_SH, y.data$BIS11_TotalScore,method = "pearson")
  res5b=make_string(res, 'BIS', 'xi_SH', 'bivariate')
  
  res=pcor.test(y.data$xi_LH,y.data$BIS11_TotalScore,y.data[,c("age","IQscore")])
  res6p=make_string(res, 'BIS', 'xi_LH', 'partial')
  res <- cor.test(y.data$xi_LH, y.data$BIS11_TotalScore,method = "pearson")
  res6b=make_string(res, 'BIS', 'xi_LH', 'bivariate')
  
  # ASRS
  
  res=pcor.test(y.data$pickedD_mean,y.data$ASRS_Sum,y.data[,c("age","IQscore")])
  res7p=make_string(res, 'ASRS', 'D_mean', 'partial')
  res <- cor.test(y.data$pickedD_mean, y.data$ASRS_Sum, method = "pearson")
  res7b=make_string(res, 'ASRS', 'D_mean', 'bivariate')

  res=pcor.test(y.data$pickedD_SH,y.data$ASRS_Sum,y.data[,c("age","IQscore")])
  res8p=make_string(res, 'ASRS', 'D_SH', 'partial')
  res <- cor.test(y.data$pickedD_SH, y.data$ASRS_Sum, method = "pearson")
  res8b=make_string(res, 'ASRS', 'D_SH', 'bivariate')
  
  res=pcor.test(y.data$pickedD_LH,y.data$ASRS_Sum,y.data[,c("age","IQscore")])
  res9p=make_string(res, 'ASRS', 'D_LH', 'partial')
  res <- cor.test(y.data$pickedD_LH, y.data$ASRS_Sum, method = "pearson")
  res9b=make_string(res, 'ASRS', 'D_LH', 'bivariate')
  
  res=pcor.test(y.data$xi_mean,y.data$ASRS_Sum,y.data[,c("age","IQscore")])
  res10p=make_string(res, 'ASRS', 'xi_mean', 'partial')
  res <- cor.test(y.data$xi_mean, y.data$ASRS_Sum, method = "pearson")
  res10b=make_string(res, 'ASRS', 'xi_mean', 'bivariate')
  
  res=pcor.test(y.data$xi_SH,y.data$ASRS_Sum,y.data[,c("age","IQscore")])
  res11p=make_string(res, 'ASRS', 'xi_SH', 'partial')
  res <- cor.test(y.data$xi_SH, y.data$ASRS_Sum, method = "pearson")
  res11b=make_string(res, 'ASRS', 'xi_SH', 'bivariate')
  
  res=pcor.test(y.data$xi_LH,y.data$ASRS_Sum,y.data[,c("age","IQscore")])
  res12p=make_string(res, 'ASRS', 'xi_LH', 'partial')
  res <- cor.test(y.data$xi_LH, y.data$ASRS_Sum, method = "pearson")
  res12b=make_string(res, 'ASRS', 'xi_LH', 'bivariate')
  
  #output_txt1=c(res1b,'',res2b,'',res3b,'', res4b,'',res5b,'',res6b,'', res7b,'',res8b,'',res9b,'', res10b,'',res11b,'',res12b,'','',
               #res1p,'',res2p,'',res3p,'', res4p,'',res5p,'',res6p,'', res7p,'',res8p,'',res9p,'', res10p,'',res11p,'',res12p,'')
  
  output_txt_BIS=c(res1b,'',res1p,'', res4b,'', res4p)
  
  output_txt_ASRS=c(res7b,'',res7p,'', res10b,'', res10p)
  
  #output_txt4=c(res1b,'',res4b,'',res7b,'', res10b,'','',
                #res1p,'',res4p,'',res7p,'', res10p, '')
  
  all_text = c(
    
    '', '', 
    
    'BIS total score:','', output_txt_BIS,'','', '', 
    'ASRS total score:','', output_txt_ASRS
    
  )
    
  fileConn<-file("~/MFweb/data_analysis/10_stats/biv_part_corr/results_totalscales.doc")
  writeLines(all_text, fileConn)
  close(fileConn)
  
  
  
