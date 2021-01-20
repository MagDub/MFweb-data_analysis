
addpath('../../../8_fitmodel/holly/')
data_fol = '../../../../data/';
sim_fol=strcat(data_fol, 'sim_model_recov/');

%%%% Sim mod8 %%%%

% variables
model = 'test_mod8';
n_sim = 1;

% simulation dir
sim_mod_fol = strcat(sim_fol,model,'/n_sim_',num2str(n_sim), '/');

% param
v_gamma_1 = 10^-7;
v_gamma_2 = 10^-8;
v_tau_1 = 0.4;
v_tau_2 = 0.6;
v_xi_1 = 0;
v_xi_2 = 0.2;
v_eta_1 = 1;
v_eta_2 = 2;


% inp_params = [v_Q0, v_gamma_1, v_gamma_2, v_tau_1, v_tau_2, v_xi_1, v_xi_2, v_eta_1, v_eta_2];
inp_params = [v_gamma_1, v_gamma_2, v_tau_1, v_tau_2, v_xi_1, v_xi_2, v_eta_1, v_eta_2];


% inp_params = [v_sgm0_1, v_sgm0_2, v_Q0, v_eta_1, v_eta_2, v_xi_1, v_xi_2];

% load from run_setup (sampled from normal distrib of empirical mean)
% load(strcat(sim_mod_fol,'inp_params.mat')); 
% load(strcat(sim_mod_fol,'param_bounds.mat'));

% param bounds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_gamma = [0,0.5]; 
param_bounds_tau = [0.2,0.7]; 
param_bounds_Q0 = [1,8]; 
param_bounds_eta = [0,5];
param_bounds_xi = [0,0.5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

param_bounds.gamma = param_bounds_gamma; 
param_bounds.tau = param_bounds_tau; 
param_bounds.xi = param_bounds_xi;
param_bounds.Q0 = param_bounds_Q0; 
param_bounds.eta = param_bounds_eta; 

% ID 
ID = 1;

% load parameter values
para_vals = inp_params(ID,:);

% simulate model
[settings, data, gameIDs] = sim_mod8_Q0fixed(ID, para_vals, param_bounds, sim_mod_fol);

% load data
data=load(strcat(sim_mod_fol,'results/sim_data_',num2str(ID),'.mat'),'data');
gameIDs=load(strcat(sim_mod_fol,'results/sim_data_',num2str(ID),'.mat'),'gameIDs');
settings=load(strcat(sim_mod_fol,'results/sim_',num2str(ID),'.mat'),'settings');

% fit with models     
% fit_mod5(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs);
% fit_mod6(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs);
% fit_mod7(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs);
% fit_mod8(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);
fit_mod8_Q0fixed(ID, data_fol, sim_mod_fol, settings.settings, data.data, gameIDs.gameIDs, param_bounds);


for n_mod=1:12

res_file = strcat(sim_mod_fol,'results/res_mod',num2str(n_mod),'_',num2str(ID),'_results.mat');

    if exist(res_file)

        tmp  = load(strcat(sim_mod_fol,'results/res_mod',num2str(n_mod),'_',num2str(ID),'_results.mat'));
        all_mod_fit(n_mod) = tmp;
        all_MLE_mat(ID, n_mod) = all_mod_fit(n_mod).mEmle;
        all_BIC_mat(ID, n_mod) = 2*all_mod_fit(n_mod).mEmle + log(400).*size(all_mod_fit(n_mod).mEparams,2);

    end

end








