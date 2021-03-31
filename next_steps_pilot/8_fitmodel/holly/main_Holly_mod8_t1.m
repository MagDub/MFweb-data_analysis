
% size(usermat_completed_task,2)

function main_Holly_mod8_t1(ID)

    load('usermat_completed_task.mat')
    data_fol = ('/data/mdubois/scripts/modeling_web/data/');

    fit_mod8_t1(usermat_completed_task(ID), data_fol)

end

