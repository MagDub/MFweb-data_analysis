
addpath('./holly/')
load('../usermat_completed.mat')
data_fol = ('../../data/');

 for i=1%:size(usermat_completed,2)
    
    disp(['user' int2str(usermat_completed(i))])
    
    fit_mod2(usermat_completed(i), data_fol)
    
end
