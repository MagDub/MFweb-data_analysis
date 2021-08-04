
thompson_file = 'D:\MaggiesFarm\modeling_28_02\simulation_data\thompson\';

addpath('D:\MaggiesFarm\modeling_28_02\plot_param_recovery\')

%% NEED TO BE COPIED IN sim_refit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n_per_dim = 3;
param_bounds_sgm0 = [0.5,2.5];
param_bounds_Q0 = [1,6]; 
param_bounds_xi = [0,0.5];  
param_bounds_eta = [0,5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
algo = 'thompson';
n_param = 7;

param_bounds.xi = param_bounds_xi;
param_bounds.sgm0 = param_bounds_sgm0; 
param_bounds.Q0 = param_bounds_Q0; 
param_bounds.eta = param_bounds_eta; 


saving_dir = strcat(thompson_file, 'parhor_MAP\test\', int2str(n_per_dim), 'perdim_newbounds\');

prep_inp_params_perhor_MAP(n_per_dim,algo, param_bounds, saving_dir);

save(strcat(saving_dir,'\param_bounds.mat'), 'param_bounds')
  
parfor ID=1:n_per_dim^n_param

    disp(strcat((int2str(ID)),32, 'of', 32, int2str(n_per_dim^(n_param))))

    sim_refit_thompson_3param_noveltybonus_parhor_MAP(ID, saving_dir)

end
 
aggregate_simResults_perHorMAP(saving_dir)
plot_correlation_perHor(saving_dir)

