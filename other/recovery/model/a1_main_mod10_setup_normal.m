
n_sim = 100;
path_ = '/Users/magdadubois/MFweb/data/sim_model_recov/mod10_normal/';
saving_dir = strcat(path_, 'n_sim_', int2str(n_sim), '/');

load('../../../../data/data_for_figs/model_parameters.mat')
load('../../../../data/data_for_figs/model_parameters_desc.mat')

model_parameters([4,32,36],:)=nan;
param_mean = nanmean(model_parameters(:,2:end));
param_std = nanstd(model_parameters(:,2:end));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_sgm0 = [0.01,3];
param_bounds_Q0 = [1,6]; 
param_bounds_xi = [0,0.5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_eta = [0,5];
param_bounds_gamma = [0,0.5]; 
param_bounds_tau = [0.2,0.7]; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
n_param = 5;

param_bounds.sgm0 = param_bounds_sgm0; 
param_bounds.Q0 = param_bounds_Q0; 
param_bounds.xi = param_bounds_xi; 

param_bounds.eta = param_bounds_eta; 
param_bounds.gamma = param_bounds_gamma; 
param_bounds.tau = param_bounds_tau; 

inp_params = prep_mod10_normal(param_bounds, saving_dir, n_sim, param_mean, param_std);

save(strcat(saving_dir,'/param_bounds.mat'), 'param_bounds')



 

