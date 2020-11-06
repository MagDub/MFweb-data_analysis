
addpath('../../../8_fitmodel/holly/')
data_fol = '../../../../data/';
sim_fol=strcat(data_fol, 'sim_model_recov/');

%%%% Sim mod 12 %%%%

% variables
model = 'mod12';
n_sim = 10;
n_models = 12;

% simulation dir
sim_mod_fol = strcat(sim_fol,model,'/n_sim_',num2str(n_sim), '/');

n_sim = 5;

BIC_mat = nan(n_sim,n_models);

for n_=1:n_sim
    
    res_file = strcat(sim_mod_fol,'results/all_mod_',num2str(n_),'.mat');
    
    if exist(res_file)
    
        tmp = load(res_file);
                
        for n_mod = 1:size(tmp.all_mod_fit,2)
        
            BIC_mat(n_, n_mod) = tmp.all_mod_fit(n_mod).mEmle ;%+ log(tmp.all_mod_fit(n_mod).settings.task.N_games).*size(tmp.all_mod_fit(n_mod).mEparams,2);
        
        end
        
    end

end

% bar(1:12,BIC_mat);
% xlabel('model')
% ylabel('BIC')

% save(strcat(sim_mod_fol,'results/all_mod_', num2str(ID), '.mat'), 'all_mod_fit');

