
library(readxl)
library(nFactors)

# Load data
data_tmp <- read_excel("~/MFweb/data_analysis/10_stats/web_data_completed.xlsx")   

# Remove excluded
data <- subset(data_tmp, exclude!=1)

# Take only questionnaire scores
data_quest <- subset(data , select=c("BIS11_TotalScore", "AQ10_TotalScore", "ASRS_Sum", 
                                     "CFS_TotalScore", "OCIR_TotalScore", "STAI_TotalScore", "IUS_TotalScore", 
                                     "SDS_TotalScore", "LSAS_TotalScore"))

# Establish number of factors
cor_mat <- cor(data_quest)
results <- nCng(cor_mat, cor = TRUE, details=TRUE)

# Factor analysis
quest_fa <- factanal(data_quest, factors = 3)

load <- quest_fa$loadings[,1:3] 

barplot(load, legend = rownames(load), horiz=TRUE)
#barplot(load, horiz=TRUE)