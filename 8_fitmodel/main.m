
load('../usermat.mat')
data_fol = ('../../data/');

for i=1:size(usermat,2)
    
    disp(['user' int2str(usermat(i))])
    
    fit_mod12_like_param_recovery_2sgm0_prior1normal(usermat(i), data_fol)
    
end
