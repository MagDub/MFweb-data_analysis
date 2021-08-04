function HOLLY_main_mod12_sim_normal(ID)

    data_fol = '/home/mdubois/scripts/modeling_web/data/';
    sim_fol=strcat(data_fol, 'sim_model_recov/');

    %%%% Sim mod12 %%%%

    % variables
    model = 'mod12_normal';
    n_sim = 100;

    % simulation dir
    sim_mod_fol = strcat(sim_fol,model,'/n_sim_',num2str(n_sim), '/');

    % load simulation data
    data=load(strcat(sim_mod_fol,'results/sim_data_',num2str(ID),'.mat'),'data');
    gameIDs=load(strcat(sim_mod_fol,'results/sim_data_',num2str(ID),'.mat'),'gameIDs');
    settings=load(strcat(sim_mod_fol,'results/sim_',num2str(ID),'.mat'),'settings');
    
    % param bounds
    load(strcat(sim_mod_fol,'param_bounds.mat'));

    %%% fit WITH EACH model
    fit_mod5_Q0fixed(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
    fit_mod6_Q0fixed(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
    fit_mod7_Q0fixed(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
    fit_mod8_Q0fixed(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
    
    fit_mod5_t1_Q0fixed(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
    fit_mod6_t1_Q0fixed(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
    fit_mod7_t1_Q0fixed(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
    fit_mod8_t1_Q0fixed(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
    
    fit_mod9(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
    fit_mod10(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
    fit_mod11(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
    fit_mod12(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
    
    for n_mod=1:12
    
    res_file = strcat(sim_mod_fol,'results/res_mod',num2str(n_mod),'_',num2str(ID),'_results.mat');
    
        if exist(res_file)

            tmp  = load(strcat(sim_mod_fol,'results/res_mod',num2str(n_mod),'_',num2str(ID),'_results.mat'));
            all_mod_fit(n_mod) = tmp;

        end

    end
    
    for n_mod=5:8
    
    res_file = strcat(sim_mod_fol,'results/res_mod',num2str(n_mod),'_t1_',num2str(ID),'_results.mat');
    
        if exist(res_file)

            tmp  = load(strcat(sim_mod_fol,'results/res_mod',num2str(n_mod),'_t1_',num2str(ID),'_results.mat'));
            all_mod_fit(end+1) = tmp;

        end

    end
    
    save(strcat(sim_mod_fol,'results/all_mod_', num2str(ID), '.mat'), 'all_mod_fit');

end

