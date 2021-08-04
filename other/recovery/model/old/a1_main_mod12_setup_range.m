
n_per_dim = 3;
path_ = '/Users/magdadubois/MFweb/data/sim_model_recov/mod12_range/';
saving_dir = strcat(path_, 'n_per_dim_', int2str(n_per_dim), '/');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_sgm0 = [0.01,6];
param_bounds_Q0 = [1,10]; 
param_bounds_eta = [0,5];
param_bounds_xi = [10^-8,0.5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
n_param = 7;

param_bounds.xi = param_bounds_xi;
param_bounds.sgm0 = param_bounds_sgm0; 
param_bounds.Q0 = param_bounds_Q0; 
param_bounds.eta = param_bounds_eta; 

inp_params = prep_mod12_range(param_bounds, saving_dir, n_per_dim);

save(strcat(saving_dir,'/param_bounds.mat'), 'param_bounds')



 

