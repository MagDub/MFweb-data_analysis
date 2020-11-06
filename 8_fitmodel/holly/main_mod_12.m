
load('../../usermat_completed_task.mat')
data_fol = ('../../../data/');

 for i=1%:size(usermat_completed_task,2)
    
    disp(['user' int2str(usermat_completed_task(i))])
    
    fit_mod12_xiB(usermat_completed_task(i), data_fol)
    
end
