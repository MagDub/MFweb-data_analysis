
addpath('./holly/')
load('../usermat_completed_attentive.mat')
data_fol = ('../../data/');

for i=5:size(usermat_completed_attentive,2)
    
    disp(['user' int2str(usermat_completed_attentive(i))])
    
    fit_mod12_like_param_recovery_2sgm0_prior1normal(usermat_completed_attentive(i), data_fol)
    
end
