
function [settings, data, gameIDs] = sim_mod12_etaB(ID, para_vals, param_bounds, sim_dir)

    % make results directory
    results_dir = strcat(sim_dir, 'results/');

    if exist(results_dir, 'dir') == 0
        mkdir(results_dir)
    end

    % settings
    settings = [];
    settings.task.N_games           = 400;
    settings.task.N_hor             = 2;
    settings.task.Ngames_per_hor    = settings.task.N_games / settings.task.N_hor;
    settings.task.N_trees           = 3;
    settings.opts.TLT               = [];
    settings.funs.decfun            = @softmax;
    settings.funs.valuefun          = @mvnorm_Thompson_noveltybonus_new; 
    settings.funs.priorfun          = [];
    settings.funs.learningfun       = @kalman_filt;
    settings.desc                   = ['thompson'];    
    settings.params.param_names     = {'sgm0', '', 'Q0', 'eta', '', 'etaB', '', 'xi', ''}; 
    settings.params.lb              = [param_bounds.sgm0(1) param_bounds.sgm0(1)  param_bounds.Q0(1)  param_bounds.eta(1) param_bounds.eta(1) param_bounds.etaB(1) param_bounds.etaB(1) param_bounds.xi(1) param_bounds.xi(1)];    
    settings.params.ub              = [param_bounds.sgm0(2) param_bounds.sgm0(2)  param_bounds.Q0(2)  param_bounds.eta(2) param_bounds.eta(2) param_bounds.etaB(2) param_bounds.etaB(2) param_bounds.xi(2) param_bounds.xi(2)];    

    % initialise model
    mo = initialise_model_MF_S0fixed_eta_2sgm0(settings);

    % fill in parameters, model-funs etc
    mo = prep_model_MF(mo,settings,para_vals,settings.params.param_names);
    
    % Generate apple sequences
    [params, user] = apple_params_for_mod();
    
    % Write the log file needed for aggregation
    for b = 1:params.task.exp.n_blocks
        for g = 1:params.task.exp.n_trialPB
            [user, params] = present_applesSIM(params, user, b, g);
        end
    end

    % aggregate data
    [data,gameIDs] = aggregateDataSIM(params, user);
    
    % generate_behaviour
    data = generate_behaviour(mo, settings, data);
   
    % save simulation
    save_sim(results_dir, ID, settings, data, gameIDs, para_vals, mo);
    
end