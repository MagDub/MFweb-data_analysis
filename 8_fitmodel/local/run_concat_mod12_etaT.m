
addpath('model_fct/')
data_folder = '../../data/modelfit/mod12_etaT/';

load('../usermat_completed.mat')

% load
[model_parameters, param_settings] = concatenate_all_params(strcat(data_folder,'results/'), usermat_completed);
model_parameters_desc = [{'ID'} {'sgm0_short'} {'sgm0_long'} {'Q0'} {'eta_short'} {'eta_long'} {'etaT_short'} {'etaT_long'} {'xi_short'} {'xi_long'}];

mean(model_parameters(:,[9,10]))

% Save
mkdir(strcat(data_folder, 'concatenated'));
save(strcat(data_folder, 'concatenated/model_parameters_mod12_etaT.mat'),'model_parameters');
save(strcat(data_folder, 'concatenated/model_parameters_mod12_etaT_desc.mat'), 'model_parameters_desc');
save(strcat(data_folder, 'concatenated/param_settings_mod12_etaT.mat'),'param_settings');

save('../../data/data_for_figs/model_parameters_mod12_etaT.mat','model_parameters');
save('../../data/data_for_figs/model_parameters_mod12_etaT_desc.mat', 'model_parameters_desc');
