
% size(usermat_completed,2)

function main_Holly_mod4(ID)

    load('usermat_completed.mat')
    data_fol = ('/home/mdubois/scripts/modeling_web/data/');

    fit_mod4_newB(usermat_completed(ID), data_fol)

end

