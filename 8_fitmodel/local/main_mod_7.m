
addpath('../holly/')
load('../../usermat_completed.mat')
data_fol = ('../../../data/');

parfor i=1:size(usermat_completed,2)
    
    disp(['user' int2str(usermat_completed(i))])
    
    fit_mod7(usermat_completed(i), data_fol)
    
end
