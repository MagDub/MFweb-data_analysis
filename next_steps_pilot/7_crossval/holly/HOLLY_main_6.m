function HOLLY_main_6(ID_n)

    load('usermat_completed_task.mat')
    data_fol = ('/home/mdubois/scripts/modeling_web/data/');
    
    ID = usermat_completed_task(ID_n);
    
    HOLLY_cv_mod6_UCB_2param_2Hor_2nov_Q01(ID, data_fol)
    
end