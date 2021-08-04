
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_gamma = [0,4]; 
param_bounds_tau = [0.05,3];  
param_bounds_Q0 = [1,6]; 
param_bounds_eta = [0,5];
param_bounds_xi = [0,0.5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% other %%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_sgm0 = [0.01,3];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n_sim = 100;
path_ = strcat('/Users/magdadubois/MFweb/data/sim_model_recov/mod8_normal',...
                            '_Q0_',num2str(param_bounds_Q0(1)),'_',num2str(param_bounds_Q0(2)),...
                            '_gamma_',num2str(param_bounds_gamma(1)),'_',num2str(param_bounds_gamma(2)),...
                            '_tau_',num2str(param_bounds_tau(1)*100), '_',num2str(param_bounds_tau(2)*100),...
                            '_sgm0_',num2str(param_bounds_sgm0(1)*100), '_',num2str(param_bounds_sgm0(2)*100),'_highergamma/');
                        
saving_dir = strcat(path_, 'n_sim_', int2str(n_sim), '/');

load('../../../../data/modelfit/mod8/concatenated/model_parameters_mod8.mat')
load('../../../../data/modelfit/mod8/concatenated/model_parameters_mod8_desc.mat')

model_parameters([4,32,36],:)=nan;
param_mean = nanmean(model_parameters(:,2:end));
param_std = nanstd(model_parameters(:,2:end));

param_mean(1) = 5;
param_std(1) = 2;

param_mean(2) = 1;
param_std(2) = 0.5;

param_mean(3) = param_mean(2);
param_std(3) = param_std(2);

%
n_param = size(param_mean,2);

param_bounds.Q0 = param_bounds_Q0; 
param_bounds.tau = param_bounds_tau; 
param_bounds.gamma = param_bounds_gamma; 
param_bounds.xi = param_bounds_xi;
param_bounds.eta = param_bounds_eta; 

param_bounds.sgm0 = param_bounds_sgm0; 

inp_params = prep_mod8_normal(param_bounds, saving_dir, n_sim, param_mean, param_std);

save(strcat(saving_dir,'/param_bounds.mat'), 'param_bounds')



 

