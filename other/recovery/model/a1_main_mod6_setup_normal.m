load('../../../../data_analysis/usermat_completed.mat')
load('../../../../data_analysis/6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

n_sim = 100;
path_ = '/Users/magdadubois/MFweb/data/sim_model_recov/mod6_normal/';
saving_dir = strcat(path_, 'n_sim_', int2str(n_sim), '/');

load('../../../../data/modelfit/mod6/concatenated/model_parameters_mod6.mat')
load('../../../../data/modelfit/mod6/concatenated/model_parameters_mod6_desc.mat')

model_parameters(to_del,:)=nan;
param_mean = nanmean(model_parameters(:,2:end));
param_std = nanstd(model_parameters(:,2:end));

model_parameters_desc = model_parameters_desc(:,2:end)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_gamma = [0,0.5]; 
param_bounds_tau = [0.2,0.7]; 
param_bounds_xi = [0,0.5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% other %%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_eta = [0,5];
param_bounds_sgm0 = [0.01,3];
param_bounds_Q0 = [1,6]; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
n_param = size(param_mean,2);


param_bounds.tau = param_bounds_tau; 
param_bounds.gamma = param_bounds_gamma; 
param_bounds.xi = param_bounds_xi;

param_bounds.eta = param_bounds_eta; 
param_bounds.sgm0 = param_bounds_sgm0; 
param_bounds.Q0 = param_bounds_Q0; 

inp_params = prep_mod6_normal_Q0fixed(param_bounds, saving_dir, n_sim, param_mean, param_std);

save(strcat(saving_dir,'/param_bounds.mat'), 'param_bounds')



 

