function inp_params = prep_mod8_uniform(param_bounds, saving_dir, n_sim)

    param_names = {'Q0', 'gamma', 'gamma','tau', 'tau', 'xi', 'xi', 'eta', 'eta'};
        
    v_Q0        = sample_from_dist(n_sim, param_bounds.Q0);
    v_gamma_1   = sample_from_dist(n_sim, param_bounds.gamma);
    v_gamma_2   = sample_from_dist(n_sim, param_bounds.gamma);
    v_tau_1     = sample_from_dist(n_sim, param_bounds.tau);
    v_tau_2     = sample_from_dist(n_sim, param_bounds.tau);
    v_xi_1      = sample_from_dist(n_sim, param_bounds.xi);
    v_xi_2      = sample_from_dist(n_sim, param_bounds.xi);
    v_eta_1     = sample_from_dist(n_sim, param_bounds.eta);
    v_eta_2     = sample_from_dist(n_sim, param_bounds.eta);
    
    inp_params = [v_Q0, v_gamma_1, v_gamma_2, v_tau_1, v_tau_2, v_xi_1, v_xi_2, v_eta_1, v_eta_2];

    if exist(saving_dir) == 0
        mkdir(saving_dir)
    end

    save(strcat(saving_dir,'inp_params.mat'),'inp_params');

end

function samples = sample_from_dist(n_sim, bounds)


    samples = bounds(1) + (bounds(2)-bounds(1))*rand(n_sim,1);
            

end
