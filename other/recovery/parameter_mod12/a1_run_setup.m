
sim_Nb = 20000;
thompson_file = '/Users/magdadubois/MFweb/data/sim_recov/thompson_rand_part_values/';
saving_dir = strcat(thompson_file, 'n_sim_', int2str(sim_Nb), '/');

if ~exist(saving_dir)
    mkdir(saving_dir)
end
    
load('../../../../data/data_for_figs/model_parameters.mat')
load('../../../../data/data_for_figs/model_parameters_desc.mat')

model_parameters([4,32,36],:)=[];
param_val_data = model_parameters(:,2:end);

% n_subj = size(param_val_data,1);
% sim_Nb = n_subj;
% 
% [m,n] = size(param_val_data) ;
% param_val_data_permuted = param_val_data ;
% for i=1:n
%     param_val_data_permuted(randperm(m),n) = param_val_data(:,n);
% end


n_subj = size(param_val_data,1);
n_param = size(param_val_data,2);

param_val_sim = [];

for sim_No = 1:sim_Nb 
    rand_ = randi([1 n_subj],1,n_param); % select value of random subject for each param
    param_val_sim(sim_No,:) = [param_val_data(rand_(1),1), param_val_data(rand_(2),2),...
                                param_val_data(rand_(3),3), param_val_data(rand_(4),4),...
                                param_val_data(rand_(5),5), param_val_data(rand_(6),6),...
                                param_val_data(rand_(7),7)];
end

inp_params = param_val_sim;

close all;
for s = 1:n_param
    subplot(2,4,s)
    hist(param_val_sim(:,s))
end

save(strcat(saving_dir,'inp_params_thompson.mat'),'inp_params');




 

