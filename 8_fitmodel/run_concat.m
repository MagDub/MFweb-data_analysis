
addpath('model_fct/')
data_folder = '../../data/modelfit/thompson_prior1normal/';

% load
[model_parameters, param_settings] = concatenate_all_params(strcat(data_folder,'results/'));
model_parameters_desc = [{'ID'} {'sgm0_short'} {'sgm0_long'} {'Q0'} {'xi_short'} {'xi_long'} {'eta_short'} {'eta_long'}];

% Save
mkdir(strcat(data_folder, 'concatenated'));
save(strcat(data_folder, 'concatenated/model_parameters.mat'),'model_parameters');
save(strcat(data_folder, 'concatenated/model_parameters_desc.mat'), 'model_parameters_desc');
save(strcat(data_folder, 'concatenated/param_settings.mat'),'param_settings');

save('../../data/data_for_figs/model_parameters.mat','model_parameters');
save('../../data/data_for_figs/model_parameters_desc.mat', 'model_parameters_desc');
