function inp_params = prep_mod11_normal(param_bounds, saving_dir, n_sim, param_mean, param_std)
        
    v_sgm0_1    = sample_from_dist(param_mean(1), param_std(1), n_sim, param_bounds.sgm0);
    v_sgm0_2    = sample_from_dist(param_mean(2), param_std(2), n_sim, param_bounds.sgm0);
    v_Q0        = sample_from_dist(param_mean(3), param_std(3), n_sim, param_bounds.Q0);
    v_eta_1     = sample_from_dist(param_mean(4), param_std(4), n_sim, param_bounds.eta);
    v_eta_2     = sample_from_dist(param_mean(5), param_std(5), n_sim, param_bounds.eta);
    
    inp_params = [v_sgm0_1, v_sgm0_2, v_Q0, v_eta_1, v_eta_2];

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
