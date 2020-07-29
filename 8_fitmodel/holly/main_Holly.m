
% size(usermat_completed_task,2)

function main_Holly(ID)

    load('usermat_completed_task.mat')
    data_fol = ('/home/mdubois/scripts/modeling_web/data/');

    fit_mod12_like_param_recovery_2sgm0_prior1normal(usermat_completed_task(ID), data_fol)

end

