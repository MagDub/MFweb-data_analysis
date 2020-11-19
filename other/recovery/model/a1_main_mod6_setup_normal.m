
n_sim = 100;
path_ = '/Users/magdadubois/MFweb/data/sim_model_recov/mod6_normal/';
saving_dir = strcat(path_, 'n_sim_', int2str(n_sim), '/');

load('../../../../data/modelfit/mod6/concatenated/model_parameters_mod6.mat')
load('../../../../data/modelfit/mod6/concatenated/model_parameters_mod6_desc.mat')

model_parameters([4,32,36],:)=nan;
param_mean = nanmean(model_parameters(:,2:end));
param_std = nanstd(model_parameters(:,2:end));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_gamma = [10^-8,2]; 
param_bounds_tau = [0.25,1.75];  
param_bounds_Q0 = [1,10]; 
param_bounds_xi = [0,0.5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
n_param = size(param_mean,2);

param_bounds.Q0 = param_bounds_Q0; 
param_bounds.tau = param_bounds_tau; 
param_bounds.gamma = param_bounds_gamma; 
param_bounds.xi = param_bounds_xi;

inp_params = prep_mod6_normal(param_bounds, saving_dir, n_sim, param_mean, param_std);

save(strcat(saving_dir,'/param_bounds.mat'), 'param_bounds')



 

