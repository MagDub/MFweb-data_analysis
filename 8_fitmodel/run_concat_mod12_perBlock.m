
addpath('model_fct/')

load('../usermat_completed.mat')

model_parameters_desc = [{'ID'} {'sgm0_short'} {'sgm0_long'} {'Q0'} {'eta_short'} {'eta_long'} {'xi_short'} {'xi_long'}];

save('../../data/data_for_figs/model_parameters_per_block_desc.mat','model_parameters_desc');


% Block 1

data_folder = '../../data/modelfit/mod12_block_1/';

[model_parameters, param_settings] = concatenate_all_params(strcat(data_folder,'results/'), usermat_completed);

save('../../data/data_for_figs/model_parameters_B1.mat','model_parameters');


% Block 2

data_folder = '../../data/modelfit/mod12_block_2/';

[model_parameters, param_settings] = concatenate_all_params(strcat(data_folder,'results/'), usermat_completed);

save('../../data/data_for_figs/model_parameters_B2.mat','model_parameters');


% Block 3

data_folder = '../../data/modelfit/mod12_block_3/';

[model_parameters, param_settings] = concatenate_all_params(strcat(data_folder,'results/'), usermat_completed);

save('../../data/data_for_figs/model_parameters_B3.mat','model_parameters');


% Block 4

data_folder = '../../data/modelfit/mod12_block_4/';

[model_parameters, param_settings] = concatenate_all_params(strcat(data_folder,'results/'), usermat_completed);

save('../../data/data_for_figs/model_parameters_B4.mat','model_parameters');

