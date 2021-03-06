
addpath('model_fct/')
data_folder = '../../data/modelfit/mod8_newB/';

load('../usermat_completed.mat')

% load
[model_parameters, param_settings] = concatenate_all_params_UCB(strcat(data_folder,'results/'), usermat_completed);
model_parameters_desc = [{'ID'} {'gamma_short'} {'gamma_long'} {'tau_short'} {'tau_long'} {'xi_short'} {'xi_long'} {'eta_short'} {'eta_long'}];

% Save
mkdir(strcat(data_folder, 'concatenated'));
save(strcat(data_folder, 'concatenated/model_parameters_mod8_newB.mat'),'model_parameters');
save(strcat(data_folder, 'concatenated/model_parameters_mod8_newB_desc.mat'), 'model_parameters_desc');
save(strcat(data_folder, 'concatenated/param_settings_mod8_newB.mat'),'param_settings');

save('../../data/data_for_figs/model_parameters_mod8_newB.mat','model_parameters');
save('../../data/data_for_figs/model_parameters_mod8_newB_desc.mat', 'model_parameters_desc');
