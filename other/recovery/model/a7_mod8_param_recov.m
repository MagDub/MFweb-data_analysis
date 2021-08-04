

data_fol = '../../../../data/';
sim_fol=strcat(data_fol, 'sim_model_recov/');

% variables
model = 'mod8_normal_Q0fixed_gamma_0_0.5_tau_20_70_sgm0_1_300_Q055_sgm014_newB';
n_sim = 100;

% simulation dir
sim_mod_fol = strcat(sim_fol,model,'/n_sim_',num2str(n_sim), '/');

% load generative
load(strcat(sim_mod_fol,'inp_params.mat')); 
load(strcat(sim_mod_fol,'param_bounds.mat'));

out.org = inp_params;

% concatenate fitted params
concat_params = nan(size(inp_params));
for ID=1:n_sim
    res_name = strcat(sim_mod_fol,'results/res_mod8_', num2str(ID), '_results.mat');
    tmp = load(res_name, 'mEparams');
    concat_params(ID,:) = tmp.mEparams;
end

out.fitted = concat_params;

save(strcat(sim_mod_fol, 'out_sim.mat'), 'out');
