
addpath('../../../8_fitmodel/holly/')
data_fol = '../../../../data/';
sim_fol=strcat(data_fol, 'sim_model_recov/');

%%%% Sim mod 12 %%%%

% variables
model = 'mod12';
n_sim = 2;

% simulation dir
sim_mod_fol = strcat(sim_fol,model,'/n_sim_',num2str(n_sim), '/');


for n_mod=1:12
    
    res_file = strcat(sim_mod_fol,'results/res_mod',num2str(n_mod),'_1_results.mat');
    
    if exist(res_file)
    
        tmp  = load(strcat(sim_mod_fol,'results/res_mod',num2str(n_mod),'_1_results.mat'));
        all_mod_fit(n_mod) = tmp;
        BIC_mat(n_mod) = all_mod_fit(n_mod).mEmle + log(all_mod_fit(n_mod).settings.task.N_games).*size(all_mod_fit(n_mod).mEparams,2);
        
    end

end

bar(1:12,BIC_mat);
xlabel('model')
ylabel('BIC')

save(strcat(sim_mod_fol,'results/all_mod_', num2str(ID), '.mat'), 'all_mod_fit');

