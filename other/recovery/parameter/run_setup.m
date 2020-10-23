
n_sim = 20000;
thompson_file = '/Users/magdadubois/MFweb/data/sim_recov/thompson_rand/';
saving_dir = strcat(thompson_file, 'n_sim_', int2str(n_sim), '/');

load('../../data/data_for_figs/model_parameters.mat')
load('../../data/data_for_figs/model_parameters_desc.mat')

model_parameters([4,32,36],:)=nan;
param_mean = nanmean(model_parameters(:,2:end));
param_std = nanstd(model_parameters(:,2:end));

% NEED TO BE COPIED IN sim_refit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n_per_dim = 4;
param_bounds_sgm0 = [0.5,2.5];
param_bounds_Q0 = [1,6]; 
param_bounds_xi = [0,0.5];  
param_bounds_eta = [0,5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
n_param = 7;

param_bounds.xi = param_bounds_xi;
param_bounds.sgm0 = param_bounds_sgm0; 
param_bounds.Q0 = param_bounds_Q0; 
param_bounds.eta = param_bounds_eta; 

inp_params = prep_inp_params(param_bounds, saving_dir, n_sim, param_mean, param_std);

save(strcat(saving_dir,'/param_bounds.mat'), 'param_bounds')



 

