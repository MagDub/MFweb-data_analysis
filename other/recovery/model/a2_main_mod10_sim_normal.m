
addpath('../../../8_fitmodel/holly/')
data_fol = '../../../../data/';
sim_fol=strcat(data_fol, 'sim_model_recov/');

%%%% Sim mod10 %%%%

% variables
model = 'mod10_normal';
n_sim = 100;

% simulation dir
sim_mod_fol = strcat(sim_fol,model,'/n_sim_',num2str(n_sim), '/');

% load from run_setup (sampled from normal distrib of empirical mean)
load(strcat(sim_mod_fol,'inp_params.mat')); 
load(strcat(sim_mod_fol,'param_bounds.mat'));
 
for ID = 1:n_sim
    
    disp(ID)

    % load parameter values
    para_vals = inp_params(ID,:);

    % simulate model
    [settings, data, gameIDs] = sim_mod10(ID, para_vals, param_bounds, sim_mod_fol);

end



