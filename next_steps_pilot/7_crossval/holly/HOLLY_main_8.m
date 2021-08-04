function HOLLY_main_8(ID_n)

    load('usermat_completed_task.mat')
    data_fol = ('/home/mdubois/scripts/modeling_web/data/');
    
    ID = usermat_completed_task(ID_n);
    
    HOLLY_cv_mod8_UCB_3param_noveltybonus_2Hor_2nov_Q01(ID, data_fol)
    
end