
% size(usermat_completed_task,2)

function main_Holly_mod12_xiB(ID)

    load('usermat_completed_task.mat')
    data_fol = ('/home/mdubois/scripts/modeling_web/data/');
    
    fit_mod12_xiB(usermat_completed_task(ID), data_fol)

end

