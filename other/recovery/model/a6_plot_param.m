
data_fol = '../../../../data/';
sim_fol=strcat(data_fol, 'sim_model_recov/');

% variables
model = 'mod8_normal_Q0fixed_gamma_0_0.5_tau_20_70_sgm0_1_300_Q055_sgm014';
n_sim = 100;

% simulation dir
sim_mod_fol = strcat(sim_fol,model,'/n_sim_',num2str(n_sim), '/');

% load from run_setup (sampled from normal distrib of empirical mean)
load(strcat(sim_mod_fol,'inp_params.mat')); 
load(strcat(sim_mod_fol,'param_bounds.mat'));
 
mod_recov = 12;

for ID = 1:n_sim
    
    res_file = strcat(sim_mod_fol, 'results/res_mod', num2str(mod_recov), '_', num2str(ID), '_results.mat');
    
    tmp = load(res_file);
    
    out_params(ID,:) = tmp.mEparams;

end

param_names_inp = {'Q0', 'gamma_1', 'gamma_2','tau_1', 'tau_2', 'xi_1', 'xi_2', 'eta_1', 'eta_2'};
param_names_out = {'sgm0_1', 'sgm0_2', 'Q0', 'eta_1', 'eta_2', 'xi_1','xi_2'};

figure()
for i=1:9
    subplot(3,3,i);
    hist(inp_params(:,i));
    title(param_names_inp{i});
end

figure()
for i=1:7
    subplot(3,3,i);
    hist(out_params(:,i));
    title(param_names_out{i});
end

