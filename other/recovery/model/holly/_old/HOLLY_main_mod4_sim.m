function HOLLY_main_mod4_sim(ID)

    data_fol = '/home/mdubois/scripts/modeling_web/data/';
    sim_fol=strcat(data_fol, 'sim_model_recov/');

    %%%% Sim mod8 %%%%

    % variables
    model = 'mod4_normal_gamma_0_0.5_tau_20_70_sgm0_1_300';
    n_sim = 100;

    % simulation dir
    sim_mod_fol = strcat(sim_fol,model,'/n_sim_',num2str(n_sim), '/');

    % simulate model
    data=load(strcat(sim_mod_fol,'results/sim_data_',num2str(ID),'.mat'),'data');
    gameIDs=load(strcat(sim_mod_fol,'results/sim_data_',num2str(ID),'.mat'),'gameIDs');
    settings=load(strcat(sim_mod_fol,'results/sim_',num2str(ID),'.mat'),'settings');
    
    % param bounds
    load(strcat(sim_mod_fol,'param_bounds.mat'));

    % fit WITH EACH model
%     fit_mod1_Q0fixed(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
%     fit_mod2_Q0fixed(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
%     fit_mod3_Q0fixed(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
    fit_mod4_Q0fixed(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
    fit_mod5_Q0fixed(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
    fit_mod6_Q0fixed(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
    fit_mod7_Q0fixed(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
    fit_mod8_Q0fixed(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
    fit_mod9(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
    fit_mod10(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
    fit_mod11(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
    fit_mod12(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
    
    for n_mod=1:12
    
    res_file = strcat(sim_mod_fol,'results/res_mod',num2str(n_mod),'_',num2str(ID),'_results.mat');
    
        if exist(res_file)

            tmp  = load(strcat(sim_mod_fol,'results/res_mod',num2str(n_mod),'_',num2str(ID),'_results.mat'));
            all_mod_fit(n_mod) = tmp;
            BIC_mat(n_mod) = all_mod_fit(n_mod).mEmle + log(all_mod_fit(n_mod).settings.task.N_games).*size(all_mod_fit(n_mod).mEparams,2);

        end

    end
    
    save(strcat(sim_mod_fol,'results/all_mod_', num2str(ID), '.mat'), 'all_mod_fit');

end

