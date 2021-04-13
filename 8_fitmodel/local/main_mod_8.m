
addpath('./holly/')
load('../usermat_completed.mat')
data_fol = ('../../data/');

 for i=4:size(usermat_completed,2)
    
    disp(['user' int2str(usermat_completed(i))])
    
    fit_mod8_newB(usermat_completed(i), data_fol)
    
end
