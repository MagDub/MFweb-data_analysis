
n_sim = 1000;
path_ = '/Users/magdadubois/MFweb/data/sim_model_recov/mod4/';
saving_dir = strcat(path_, 'n_sim_', int2str(n_sim), '/');

load('../../../../data/modelfit/mod4/concatenated/model_parameters_mod4.mat')
load('../../../../data/modelfit/mod4/concatenated/model_parameters_mod4_desc.mat')

model_parameters([4,32,36],:)=nan;
param_mean = nanmean(model_parameters(:,2:end));
param_std = nanstd(model_parameters(:,2:end));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_sgm0 = [0.01,6];
param_bounds_gamma = [10^-8,10]; 
param_bounds_tau = [10^-8,7]; 
param_bounds_Q0 = [1,10]; 
param_bounds_eta = [0,5];
param_bounds_w_hyb = [0,1];
param_bounds_xi = [0,0.5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
n_param = 12;

param_bounds.Q0 = param_bounds_Q0; 
param_bounds.tau = param_bounds_tau; 
param_bounds.gamma = param_bounds_gamma; 
param_bounds.sgm0 = param_bounds_sgm0; 
param_bounds.xi = param_bounds_xi;
param_bounds.eta = param_bounds_eta; 
param_bounds.w_hyb = param_bounds_w_hyb; 

inp_params = prep_mod4(param_bounds, saving_dir, n_sim, param_mean, param_std);

save(strcat(saving_dir,'/param_bounds.mat'), 'param_bounds')



 

