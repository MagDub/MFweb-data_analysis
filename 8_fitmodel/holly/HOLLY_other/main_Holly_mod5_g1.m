
% size(usermat_completed,2)

function main_Holly_mod5_g1(ID)

    load('usermat_completed.mat')
    data_fol = ('/data/mdubois/scripts/modeling_web/data');

    fit_mod5_g1(usermat_completed(ID), data_fol)

end

