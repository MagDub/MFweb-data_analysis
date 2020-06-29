
% size(usermat,2)

function main_Holly(ID)

    load('usermat.mat')
    data_fol = ('/home/mdubois/scripts/modeling_web/data/');

    fit_mod12_like_param_recovery_2sgm0_prior1normal(usermat(ID), data_fol)

end

