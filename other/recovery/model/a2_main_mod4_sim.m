
addpath('../../../8_fitmodel/holly/')
data_fol = '../../../../data/';
sim_fol=strcat(data_fol, 'sim_model_recov/');

%%%% Sim mod4 %%%%

% variables
model = 'mod4_normal_gamma_0_0.5_tau_20_70_sgm0_1_300';
n_sim = 100;

% simulation dir
sim_mod_fol = strcat(sim_fol,model,'/n_sim_',num2str(n_sim), '/');

% load from run_setup (sampled from normal distrib of empirical mean)
load(strcat(sim_mod_fol,'inp_params.mat')); 
load(strcat(sim_mod_fol,'param_bounds.mat'));
 
for ID = 1:n_sim

    % load parameter values
    para_vals = inp_params(ID,:);

    % simulate model
    [settings, data, gameIDs] = sim_mod4(ID, para_vals, param_bounds, sim_mod_fol);
    
%     % check that beahviour changes    
%     for n=1:5
%         tmp(ID,n) = data(n).chosen;
%     end

end





