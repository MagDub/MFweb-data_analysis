
% size(usermat_completed,2)

function main_Holly_mod8_eta8(ID)

    load('usermat_completed.mat')
    data_fol = ('/home/mdubois/scripts/modeling_web/data/');

    fit_mod8_eta8(usermat_completed(ID), data_fol)

end

