
addpath('./holly/')
load('../usermat_completed_task.mat')
data_fol = ('../../data/');

 for i=3:size(usermat_completed_task,2)
    
    disp(['user' int2str(usermat_completed_task(i))])
    
    fit_mod5_g1(usermat_completed_task(i), data_fol)
    
end
