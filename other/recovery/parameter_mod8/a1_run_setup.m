
addpath('../model/')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_gamma = [0,4]; 
param_bounds_tau = [0.25,2];  
param_bounds_Q0 = [3,7]; 
param_bounds_eta = [0,5];
param_bounds_xi = [0,0.5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n_sim = 5;
mod_file = '../../../../data/sim_recov/mod_8/';
saving_dir = strcat(mod_file, 'n_sim_', int2str(n_sim), '/');

load('../../../../data/modelfit/mod8/concatenated/model_parameters_mod8.mat')
load('../../../../data/modelfit/mod8/concatenated/model_parameters_mod8_desc.mat')

model_parameters([4,32,36],:)=nan;
param_mean = nanmean(model_parameters(:,2:end));
param_std = nanstd(model_parameters(:,2:end));

%
n_param = size(param_mean,2);

param_bounds.Q0 = param_bounds_Q0; 
param_bounds.tau = param_bounds_tau; 
param_bounds.gamma = param_bounds_gamma; 
param_bounds.xi = param_bounds_xi;
param_bounds.eta = param_bounds_eta; 

inp_params = prep_mod8_normal(param_bounds, saving_dir, n_sim, param_mean, param_std);

save(strcat(saving_dir,'/param_bounds.mat'), 'param_bounds')



 

