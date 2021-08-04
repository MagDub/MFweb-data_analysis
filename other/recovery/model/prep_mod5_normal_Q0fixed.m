function inp_params = prep_mod5_normal_Q0fixed(param_bounds, saving_dir, n_sim, param_mean, param_std)

    param_names = {'gamma', 'gamma','tau', 'tau'};
        
    v_gamma_1   = sample_from_dist(param_mean(2), param_std(2), n_sim, param_bounds.gamma);
    v_gamma_2   = sample_from_dist(param_mean(3), param_std(3), n_sim, param_bounds.gamma);
    v_tau_1     = sample_from_dist(param_mean(4), param_std(4), n_sim, param_bounds.tau);
    v_tau_2     = sample_from_dist(param_mean(5), param_std(5), n_sim, param_bounds.tau);
    
    inp_params = [v_gamma_1, v_gamma_2, v_tau_1, v_tau_2];

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
