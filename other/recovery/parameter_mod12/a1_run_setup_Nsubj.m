
n_sim = 6100;
thompson_file = '/Users/magdadubois/MFweb/data/sim_recov/thompson_rand_part_values/';
saving_dir = strcat(thompson_file, 'n_sim_', int2str(n_sim), '/');

if ~exist(saving_dir)
    mkdir(saving_dir)
end
    
load('../../../../data/data_for_figs/model_parameters.mat')
load('../../../../data/data_for_figs/model_parameters_desc.mat')

model_parameters([4,32,36],:)=[];
param_val_data = model_parameters(:,2:end);

n_subj = size(param_val_data,1);
sim_Nb = n_subj;

N_samples = n_sim/n_subj;

concat_param_val_data = [];
for i=1:N_samples
concat_param_val_data = [param_val_data; param_val_data; param_val_data; param_val_data];
end

[m,n] = size(param_val_data) ;
param_val_data_permuted = param_val_data ;
for i=1:n
    param_val_data_permuted(randperm(m),n) = param_val_data(:,n);
end

inp_params = param_val_data_permuted;

close all;
for s = 1:n_param
    subplot(2,4,s)
    hist(param_val_data_permuted(:,s))
end

save(strcat(saving_dir,'inp_params_thompson.mat'),'inp_params');




 

