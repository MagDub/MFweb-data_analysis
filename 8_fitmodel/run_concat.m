
addpath('model_fct/')
data_folder = '/Users/magdadubois/MF/data/modelfit/thompson_prior1normal/';

% load
[model_parameters, param_settings] = concatenate_all_params(strcat(data_folder,'results/'));
model_parameters_desc = [{'ID'} {'sgm0_short'} {'sgm0_long'} {'Q0'} {'xi_short'} {'xi_long'} {'eta_short'} {'eta_lon'}];

% Save
mkdir(strcat(data_folder, 'concatenated'));
save(strcat(data_folder, 'concatenated/model_parameters.mat'),'model_parameters');
save(strcat(data_folder, 'concatenated/model_parameters_desc.mat'), 'model_parameters_desc');
save(strcat(data_folder, 'concatenated/param_settings.mat'),'param_settings');
