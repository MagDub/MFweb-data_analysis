
addpath('../../../8_fitmodel/holly/')
data_fol = '../../../../data/';
sim_fol=strcat(data_fol, 'sim_model_recov/');

%%%% Sim mod12 %%%%

% variables
model = 'mod12';
n_sim = 1000;

% simulation dir
sim_mod_fol = strcat(sim_fol,model,'_uniform/n_sim_',num2str(n_sim), '/');

% load from run_setup (sampled from uniform distrib of empirical mean)
load(strcat(sim_mod_fol,'inp_params.mat')); 
load(strcat(sim_mod_fol,'param_bounds.mat'));
 
for ID = 1:n_sim

    % load parameter values
    para_vals = inp_params(ID,:);

    % simulate model
    [settings, data, gameIDs] = sim_mod12(ID, para_vals, param_bounds, sim_mod_fol);
    
%     % check that beahviour changes    
%     for n=1:5
%         tmp(ID,n) = data(n).chosen;
%     end

end





