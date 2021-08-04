
addpath('../../../8_fitmodel/holly/')
data_fol = '../../../../data/';
sim_fol=strcat(data_fol, 'sim_model_recov/');

%%%% Sim mod12 %%%%

% variables
model = 'test_mod8_normal_Q0fixed_gamma_0_4_tau_25_300_sgm0_1_300';
n_sim = 10;

% simulation dir
sim_mod_fol = strcat(sim_fol,model,'/n_sim_',num2str(n_sim), '/');

% param bounds
load(strcat(sim_mod_fol,'param_bounds.mat'));

% ID
for ID = 1%n_sim

    % load data
    data=load(strcat(sim_mod_fol,'results/sim_data_',num2str(ID),'.mat'),'data');
    gameIDs=load(strcat(sim_mod_fol,'results/sim_data_',num2str(ID),'.mat'),'gameIDs');
    settings=load(strcat(sim_mod_fol,'results/sim_',num2str(ID),'.mat'),'settings');
    
%     % check that beahviour changes    
%     for n=1:5
%         tmp(ID,n) = data.data(n).chosen;
%         tmp_2(ID,n) = gameIDs.gameIDs(n);
%     end

    % fit WITH EACH model
    
    % % fit_mod1(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs);
    % % fit_mod2(ID, data_fol, sim_mod_fol, settings, data, gameIDs);
    % % fit_mod3(ID, data_fol, sim_mod_fol, settings, data, gameIDs);
    % % fit_mod4(ID, data_fol, sim_mod_fol, settings, data, gameIDs);
    % % fit_mod5(ID, data_fol, sim_mod_fol, settings, data, gameIDs);
    % % fit_mod6(ID, data_fol, sim_mod_fol, settings, data, gameIDs);
    % % fit_mod7(ID, data_fol, sim_mod_fol, settings, data, gameIDs);
    fit_mod8(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
    % % fit_mod9(ID, data_fol, sim_mod_fol, settings, data, gameIDs);
    % % fit_mod10(ID, data_fol, sim_mod_fol, settings, data, gameIDs);
    % % fit_mod11(ID, data_fol, sim_mod_fol, settings, data, gameIDs);
    % % fit_mod12(ID, data_fol, sim_mod_fol, settings, data, gameIDs);

    for n_mod=1:12

    res_file = strcat(sim_mod_fol,'results/res_mod',num2str(n_mod),'_',num2str(ID),'_results.mat');

        if exist(res_file)

            tmp  = load(strcat(sim_mod_fol,'results/res_mod',num2str(n_mod),'_',num2str(ID),'_results.mat'));
            all_mod_fit(n_mod) = tmp;

        end

    end
    
    save(strcat(sim_mod_fol,'results/all_mod_', num2str(ID), '.mat'), 'all_mod_fit');

end



