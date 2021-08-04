
addpath('../../../8_fitmodel/holly/')
data_fol = '../../../../data/';
sim_fol=strcat(data_fol, 'sim_model_recov/');

%%%% Sim mod12 %%%%

% variables
model = 'mod12';
n_sim = 2;

% simulation dir
sim_mod_fol = strcat(sim_fol,model,'/n_sim_',num2str(n_sim), '/');

% load from run_setup (sampled from normal distrib of empirical mean)
load(strcat(sim_mod_fol,'inp_params.mat')); 
load(strcat(sim_mod_fol,'param_bounds.mat'));

%ID = 1; % TODO: loop

% load parameter values
para_vals = inp_params(ID,:);

% simulate model
[settings, data, gameIDs] = sim_mod12(ID, para_vals, param_bounds, sim_mod_fol);

% fit WITH EACH model
fit_mod1(ID, data_fol, sim_mod_fol, settings, data, gameIDs);
fit_mod2(ID, data_fol, sim_mod_fol, settings, data, gameIDs);
fit_mod3(ID, data_fol, sim_mod_fol, settings, data, gameIDs);
fit_mod4(ID, data_fol, sim_mod_fol, settings, data, gameIDs);
fit_mod5(ID, data_fol, sim_mod_fol, settings, data, gameIDs);
fit_mod6(ID, data_fol, sim_mod_fol, settings, data, gameIDs);
fit_mod7(ID, data_fol, sim_mod_fol, settings, data, gameIDs);
fit_mod8(ID, data_fol, sim_mod_fol, settings, data, gameIDs);
fit_mod9(ID, data_fol, sim_mod_fol, settings, data, gameIDs);
fit_mod10(ID, data_fol, sim_mod_fol, settings, data, gameIDs);
fit_mod11(ID, data_fol, sim_mod_fol, settings, data, gameIDs);
fit_mod12(ID, data_fol, sim_mod_fol, settings, data, gameIDs);


