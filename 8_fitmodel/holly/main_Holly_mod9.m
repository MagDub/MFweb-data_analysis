
% size(usermat_completed,2)

function main_Holly_mod9(ID)

    load('usermat_completed.mat')
    data_fol = ('/home/mdubois/scripts/modeling_web/data/');

    fit_mod9(usermat_completed(ID), data_fol)

end

