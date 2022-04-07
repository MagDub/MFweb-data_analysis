
library(Hmisc)

data_demo_tmp <- read_excel("../web_data_completed.xlsx")    
data_demo_all <- subset(data_demo_tmp , select=c("User", "exclude", "IQscore", 
                                                 "reward_SH_diff_low", "reward_LHlast_diff_low", 
                                                 "average_first_apple_SH", "average_first_apple_LH", "average_all_apple_LH"))

data_demo <- subset(data_demo_all, exclude!=1)

load(file = "../FA/all_behav_and_FAscores.Rdata")

#### Correlation
my_data <- subset(data_tmp_all, select = c("age", "gender", "xi_mean", "eta_mean", "scores_f1", "scores_f3"))

#### add IQ
my_data$IQscore = data_demo$IQscore
my_data$reward_SH_diff_low = data_demo$reward_SH_diff_low
my_data$reward_LHlast_diff_low = data_demo$reward_LHlast_diff_low
my_data$average_first_apple_SH = data_demo$average_first_apple_SH
my_data$average_first_apple_LH = data_demo$average_first_apple_LH
my_data$average_all_apple_LH = data_demo$average_all_apple_LH

#### corr
res <- cor(my_data, use = "complete.obs")
round(res, 2)

#### significance
res2 <- rcorr(as.matrix(my_data))
res2


#### correct for age and IQ
my_data = my_data[complete.cases(my_data), ] # remove nans
y_data=data.frame(my_data)

# Xi and SH_diff_low
res=pcor.test(y_data$xi_mean,y_data$reward_SH_diff_low,y_data[,c("age","IQscore")])
res1p=make_string(res, 'score_SH_diff_low', 'xi_mean', 'partial')
res <- cor.test(y_data$xi_mean, y_data$reward_SH_diff_low,method = "pearson")
res1b=make_string(res, 'score_SH_diff_low', 'xi_mean', 'bivariate')

# Xi and SH_first
res=pcor.test(y_data$xi_mean,y_data$average_first_apple_SH,y_data[,c("age","IQscore")])
res2p=make_string(res, 'score_SH_first', 'xi_mean', 'partial')
res <- cor.test(y_data$xi_mean, y_data$average_first_apple_SH,method = "pearson")
res2b=make_string(res, 'score_SH_first', 'xi_mean', 'bivariate')


output_xi_score_SH=c(res1b,res1p, '', res2b,res2p)


# Xi and LH_diff_low
res=pcor.test(y_data$xi_mean,y_data$reward_LHlast_diff_low,y_data[,c("age","IQscore")])
res1p=make_string(res, 'score_LH_diff_low', 'xi_mean', 'partial')
res <- cor.test(y_data$xi_mean, y_data$reward_LHlast_diff_low,method = "pearson")
res1b=make_string(res, 'score_LH_diff_low', 'xi_mean', 'bivariate')

# Xi and LH_first
res=pcor.test(y_data$xi_mean,y_data$average_first_apple_LH,y_data[,c("age","IQscore")])
res2p=make_string(res, 'score_LH_first', 'xi_mean', 'partial')
res <- cor.test(y_data$xi_mean, y_data$average_first_apple_LH,method = "pearson")
res2b=make_string(res, 'score_LH_first', 'xi_mean', 'bivariate')

# Xi and LH_average
res=pcor.test(y_data$xi_mean,y_data$average_all_apple_LH,y_data[,c("age","IQscore")])
res3p=make_string(res, 'score_LH_all', 'xi_mean', 'partial')
res <- cor.test(y_data$xi_mean, y_data$average_all_apple_LH,method = "pearson")
res3b=make_string(res, 'score_LH_all', 'xi_mean', 'bivariate')


output_xi_score_LH=c(res1b,res1p, '', res2b,res2p, '', res3b,res3p)


# Impuls and SH_diff_low
res=pcor.test(y_data$scores_f3,y_data$reward_SH_diff_low,y_data[,c("age","IQscore")])
res1p=make_string(res, 'score_SH_diff_low', 'Impulsivity', 'partial')
res <- cor.test(y_data$scores_f3, y_data$reward_SH_diff_low,method = "pearson")
res1b=make_string(res, 'score_SH_diff_low', 'Impulsivity', 'bivariate')

# Impuls and SH_first
res=pcor.test(y_data$scores_f3,y_data$average_first_apple_SH,y_data[,c("age","IQscore")])
res2p=make_string(res, 'score_SH_first', 'Impulsivity', 'partial')
res <- cor.test(y_data$scores_f3, y_data$average_first_apple_SH,method = "pearson")
res2b=make_string(res, 'score_SH_first', 'Impulsivity', 'bivariate')

output_imp_score_SH=c(res1b,res1p, '', res2b,res2p)


# Impuls and LH_diff_low
res=pcor.test(y_data$scores_f3,y_data$reward_LHlast_diff_low, y_data[,c("age","IQscore")])
res1p=make_string(res, 'score_LH_diff_low', 'Impulsivity', 'partial')
res <- cor.test(y_data$scores_f3, y_data$reward_LHlast_diff_low, method = "pearson")
res1b=make_string(res, 'score_LH_diff_low', 'Impulsivity', 'bivariate')

# Impuls and LH_first
res=pcor.test(y_data$scores_f3,y_data$average_first_apple_LH,y_data[,c("age","IQscore")])
res2p=make_string(res, 'score_LH_first', 'Impulsivity', 'partial')
res <- cor.test(y_data$scores_f3, y_data$average_first_apple_LH,method = "pearson")
res2b=make_string(res, 'score_LH_first', 'Impulsivity', 'bivariate')

# Impuls and LH_average
res=pcor.test(y_data$scores_f3,y_data$average_all_apple_LH,y_data[,c("age","IQscore")])
res3p=make_string(res, 'score_LH_all', 'Impulsivity', 'partial')
res <- cor.test(y_data$scores_f3, y_data$average_all_apple_LH,method = "pearson")
res3b=make_string(res, 'score_LH_all', 'Impulsivity', 'bivariate')


output_imp_score_LH=c(res1b,res1p, '', res2b,res2p, '', res3b,res3p)


# AnxDep and SH_diff_low
res=pcor.test(y_data$scores_f1,y_data$reward_SH_diff_low,y_data[,c("age","IQscore")])
res1p=make_string(res, 'score_SH_diff_low', 'AnxDep', 'partial')
res <- cor.test(y_data$scores_f1, y_data$reward_SH_diff_low,method = "pearson")
res1b=make_string(res, 'score_SH_diff_low', 'AnxDep', 'bivariate')

# AnxDep and SH_first
res=pcor.test(y_data$scores_f1,y_data$average_first_apple_SH,y_data[,c("age","IQscore")])
res2p=make_string(res, 'score_SH_first', 'AnxDep', 'partial')
res <- cor.test(y_data$scores_f1, y_data$average_first_apple_SH,method = "pearson")
res2b=make_string(res, 'score_SH_first', 'AnxDep', 'bivariate')

output_anxdep_score_SH=c(res1b,res1p, '', res2b,res2p)

# AnxDep and LH_diff_low
res=pcor.test(y_data$scores_f1,y_data$reward_LHlast_diff_low, y_data[,c("age","IQscore")])
res1p=make_string(res, 'score_LH_diff_low', 'AnxDep', 'partial')
res <- cor.test(y_data$scores_f1, y_data$reward_LHlast_diff_low, method = "pearson")
res1b=make_string(res, 'score_LH_diff_low', 'AnxDep', 'bivariate')

# AnxDep and LH_first
res=pcor.test(y_data$scores_f1,y_data$average_first_apple_LH,y_data[,c("age","IQscore")])
res2p=make_string(res, 'score_LH_first', 'AnxDep', 'partial')
res <- cor.test(y_data$scores_f3, y_data$average_first_apple_LH,method = "pearson")
res2b=make_string(res, 'score_LH_first', 'AnxDep', 'bivariate')

# AnxDep and LH_average
res=pcor.test(y_data$scores_f1,y_data$average_all_apple_LH,y_data[,c("age","IQscore")])
res3p=make_string(res, 'score_LH_all', 'AnxDep', 'partial')
res <- cor.test(y_data$scores_f3, y_data$average_all_apple_LH,method = "pearson")
res3b=make_string(res, 'score_LH_all', 'AnxDep', 'bivariate')


output_anxdep_score_LH=c(res1b,res1p, '', res2b,res2p, '', res3b,res3p)



# Eta and SH_first
res=pcor.test(y_data$eta_mean,y_data$average_first_apple_SH,y_data[,c("age","IQscore")])
res2p=make_string(res, 'score_SH_first', 'eta_mean', 'partial')
res <- cor.test(y_data$eta_mean, y_data$average_first_apple_SH,method = "pearson")
res2b=make_string(res, 'score_SH_first', 'eta_mean', 'bivariate')


output_eta_score_SH=c(res2b,res2p)


# Eta and LH_first
res=pcor.test(y_data$eta_mean,y_data$average_first_apple_LH,y_data[,c("age","IQscore")])
res2p=make_string(res, 'score_LH_first', 'eta_mean', 'partial')
res <- cor.test(y_data$eta_mean, y_data$average_first_apple_LH,method = "pearson")
res2b=make_string(res, 'score_LH_first', 'eta_mean', 'bivariate')

# Eta and LH_average
res=pcor.test(y_data$eta_mean,y_data$average_all_apple_LH,y_data[,c("age","IQscore")])
res3p=make_string(res, 'score_LH_all', 'eta_mean', 'partial')
res <- cor.test(y_data$eta_mean, y_data$average_all_apple_LH,method = "pearson")
res3b=make_string(res, 'score_LH_all', 'eta_mean', 'bivariate')


output_eta_score_LH=c(res2b,res2p, '', res3b,res3p)

