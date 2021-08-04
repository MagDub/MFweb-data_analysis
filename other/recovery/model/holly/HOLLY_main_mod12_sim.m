function HOLLY_main_mod12_sim(ID)

    data_fol = '/home/mdubois/scripts/modeling_web/data/';
%     data_fol = '../../../../../data/';
    sim_fol=strcat(data_fol, 'sim_model_recov/');

    %%%% Sim mod12 %%%%

    % variables
    model = 'mod12';
    n_sim = 1000;

    % simulation dir
    sim_mod_fol = strcat(sim_fol,model,'/n_sim_',num2str(n_sim), '/');

%     % load from run_setup (sampled from normal distrib of empirical mean)
%     load(strcat(sim_mod_fol,'inp_params.mat')); 
%     load(strcat(sim_mod_fol,'param_bounds.mat'));
% 
%     % load parameter values
%     para_vals = inp_params(ID,:);

    % simulate model
    % [settings.settings, data.data, gameIDs] = sim_mod12(ID, para_vals, param_bounds, sim_mod_fol);
    data=load(strcat(sim_mod_fol,'results/sim_data_',num2str(ID),'.mat'),'data');
    gameIDs=load(strcat(sim_mod_fol,'results/sim_data_',num2str(ID),'.mat'),'gameIDs');
    settings=load(strcat(sim_mod_fol,'results/sim_',num2str(ID),'.mat'),'settings');

    % fit WITH EACH model
    fit_mod1(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs);
    fit_mod2(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs);
    fit_mod3(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs);
    fit_mod4(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs);
    fit_mod5(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs);
    fit_mod6(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs);
    fit_mod7(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs);
    fit_mod8(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs);
    fit_mod9(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs);
    fit_mod10(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs);
    fit_mod11(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs);
    fit_mod12(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs);
    
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

