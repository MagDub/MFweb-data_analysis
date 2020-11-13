
n_sim = 100;
path_ = '/Users/magdadubois/MFweb/data/sim_model_recov/mod8_uniform/';
saving_dir = strcat(path_, 'n_sim_', int2str(n_sim), '/');

load('../../../../data/modelfit/mod8/concatenated/model_parameters_mod8.mat')
load('../../../../data/modelfit/mod8/concatenated/model_parameters_mod8_desc.mat')

model_parameters([4,32,36],:)=nan;
param_mean = nanmean(model_parameters(:,2:end));
param_std = nanstd(model_parameters(:,2:end));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_gamma = [10^-8,2]; 
param_bounds_tau = [0.25,1.75];  
param_bounds_Q0 = [1,5]; 
param_bounds_eta = [0,5];
param_bounds_xi = [0,0.5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
n_param = 9;

param_bounds.Q0 = param_bounds_Q0; 
param_bounds.tau = param_bounds_tau; 
param_bounds.gamma = param_bounds_gamma; 
param_bounds.xi = param_bounds_xi;
param_bounds.eta = param_bounds_eta; 

inp_params = prep_mod8_uniform(param_bounds, saving_dir, n_sim);

save(strcat(saving_dir,'/param_bounds.mat'), 'param_bounds')



 

