
addpath('../../../8_fitmodel/holly/')
data_fol = '../../../../data/';
sim_fol=strcat(data_fol, 'sim_model_recov/');

%%%% Sim mod 8 %%%%

% variables
model = 'mod8_normal';
n_sim = 100;
n_models = 12;

% simulation dir
sim_mod_fol = strcat(sim_fol,model,'/n_sim_',num2str(n_sim), '/');

all_BIC_mat = nan(n_sim,n_models);
all_AIC_mat = nan(n_sim,n_models);

for n_=1:n_sim
    
    res_file = strcat(sim_mod_fol,'results/all_mod_',num2str(n_),'.mat');
    
    if exist(res_file)
    
        tmp = load(res_file);
                
        for n_mod = 5:size(tmp.all_mod_fit,2) % SHOULD BE 1
        
            all_BIC_mat(n_, n_mod) = 2*tmp.all_mod_fit(n_mod).mEmle + log(400).*size(tmp.all_mod_fit(n_mod).mEparams,2);
            
            all_AIC_mat(n_, n_mod) = 2*tmp.all_mod_fit(n_mod).mEmle + 2*size(tmp.all_mod_fit(n_mod).mEparams,2);
        
        end
        
    end

end

save(strcat(sim_mod_fol,'results/all_BIC_mat.mat'), 'all_BIC_mat');
save(strcat(sim_mod_fol,'results/all_AIC_mat.mat'), 'all_AIC_mat');

