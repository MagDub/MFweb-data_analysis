function HOLLY_main(ID_n)

    load('usermat_completed_task.mat')
    data_fol = ('/home/mdubois/scripts/modeling_web/data/');
    
%     data_fol = ('../../data/');
%     load('../usermat_completed_task.mat')
    
    ID = usermat_completed_task(ID_n);
    
    HOLLY_cv_mod1_hybrid_4param_2Hor_1w_1Q0(ID, data_fol)
    HOLLY_cv_mod2_hybrid_4param_xi_2Hor_1w_Q01(ID, data_fol)
    HOLLY_cv_mod3_hybrid_4param_nov_both_2Hor_1w_2eta_Q01(ID, data_fol)
    HOLLY_cv_mod4_hybrid_4param_xi_nov_both_2Hor_2nov_1w_Q01(ID, data_fol)
    HOLLY_cv_mod5_UCB_2param_2Hor_Q01(ID, data_fol)
    HOLLY_cv_mod6_UCB_2param_2Hor_2nov_Q01(ID, data_fol)
    HOLLY_cv_mod7_UCB_3param_2Hor_Q01(ID, data_fol)
    HOLLY_cv_mod8_UCB_3param_noveltybonus_2Hor_2nov_Q01(ID, data_fol)
    HOLLY_cv_mod9_thompson_2param_Q01(ID, data_fol)
    HOLLY_cv_mod10_thompson_3param_2Hor_Q01(ID, data_fol)
    HOLLY_cv_mod11_thompson_2param_nov_2Hor_2nov_Q01(ID, data_fol)
    HOLLY_cv_mod12_thompson_3param_nov_2Hor_2nov_Q01(ID, data_fol)
    
end