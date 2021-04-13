
addpath('./holly/')
load('../usermat_completed_task.mat')
data_fol = ('../../data/');

for i=1 %:size(usermat_completed_task,2)
    
    ID=usermat_completed_task(i);

    disp(['user' int2str(ID)])
        
    for block_ = 1:4

        fit_mod12_perblock(ID, data_fol, block_)
        
    end
    
end
