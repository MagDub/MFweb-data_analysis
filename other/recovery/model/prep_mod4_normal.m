function inp_params = prep_mod4_normal(param_bounds, saving_dir, n_sim, param_mean, param_std)

    param_names = {'Q0' 'sgm0' 'sgm0' 'gamma'  'gamma'  'tau'  'tau'  'xi'  'xi'  'eta' 'eta' 'w_hyb'};
        
    v_Q0        = sample_from_dist(param_mean(1), param_std(1), n_sim, param_bounds.Q0);
    v_sgm0_1    = sample_from_dist(param_mean(2), param_std(2), n_sim, param_bounds.sgm0);
    v_sgm0_2    = sample_from_dist(param_mean(3), param_std(3), n_sim, param_bounds.sgm0);
    v_gamma_1    = sample_from_dist(param_mean(4), param_std(4), n_sim, param_bounds.gamma);
    v_gamma_2    = sample_from_dist(param_mean(5), param_std(5), n_sim, param_bounds.gamma);
    v_tau_1      = sample_from_dist(param_mean(6), param_std(6), n_sim, param_bounds.tau);
    v_tau_2      = sample_from_dist(param_mean(7), param_std(7), n_sim, param_bounds.tau);
    v_xi_1      = sample_from_dist(param_mean(8), param_std(8), n_sim, param_bounds.xi);
    v_xi_2      = sample_from_dist(param_mean(9), param_std(9), n_sim, param_bounds.xi);
    v_eta_1     = sample_from_dist(param_mean(10), param_std(10), n_sim, param_bounds.eta);
    v_eta_2     = sample_from_dist(param_mean(11), param_std(11), n_sim, param_bounds.eta);
    v_w_hyb     = sample_from_dist(param_mean(12), param_std(12), n_sim, param_bounds.w_hyb);
    
    inp_params = [v_Q0, v_sgm0_1, v_sgm0_2, v_gamma_1, v_gamma_2, v_tau_1, v_tau_2, v_xi_1, v_xi_2, v_eta_1, v_eta_2, v_w_hyb];

    if exist(saving_dir) == 0
        mkdir(saving_dir)
    end

    save(strcat(saving_dir,'inp_params.mat'),'inp_params');

end

function samples = sample_from_dist(mean, sd, n_sim, bounds)

samples = nan(n_sim,1);

    for i=1:n_sim

        tmp=-1;
        
        while tmp<bounds(1) || tmp>bounds(2)
            tmp = sd + mean .*randn(1);
        end
        
        samples(i) = tmp;
    
    end

end