
n_sim = 1000;
path_ = '/Users/magdadubois/MFweb/data/sim_model_recov/mod12_uniform/';
saving_dir = strcat(path_, 'n_sim_', int2str(n_sim), '/');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_sgm0 = [0.01,6];
param_bounds_Q0 = [1,10]; 
param_bounds_xi = [10^-8,0.5];
param_bounds_eta = [0,5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
n_param = 7;

param_bounds.xi = param_bounds_xi;
param_bounds.sgm0 = param_bounds_sgm0; 
param_bounds.Q0 = param_bounds_Q0; 
param_bounds.eta = param_bounds_eta; 

inp_params = prep_mod12_uniform(param_bounds, saving_dir, n_sim);

save(strcat(saving_dir,'/param_bounds.mat'), 'param_bounds')



 

