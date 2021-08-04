function inp_params = prep_mod12_uniform(param_bounds, saving_dir, n_sim)

    param_names = {'sgm0', 'sgm0', 'Q0' ,'eta', 'eta','xi', 'xi'};
        
    v_sgm0_1    = sample_from_dist(n_sim, param_bounds.sgm0);
    v_sgm0_2    = sample_from_dist(n_sim, param_bounds.sgm0);
    v_Q0        = sample_from_dist(n_sim, param_bounds.Q0);
    v_eta_1     = sample_from_dist(n_sim, param_bounds.eta);
    v_eta_2     = sample_from_dist(n_sim, param_bounds.eta);
    v_xi_1      = sample_from_dist(n_sim, param_bounds.xi);
    v_xi_2      = sample_from_dist(n_sim, param_bounds.xi);

    
    inp_params = [v_sgm0_1, v_sgm0_2, v_Q0, v_eta_1, v_eta_2, v_xi_1, v_xi_2];

    if exist(saving_dir) == 0
        mkdir(saving_dir)
    end

    save(strcat(saving_dir,'inp_params.mat'),'inp_params');

end

function samples = sample_from_dist(n_sim, bounds)


    samples = bounds(1) + (bounds(2)-bounds(1))*rand(n_sim,1);
            

end
