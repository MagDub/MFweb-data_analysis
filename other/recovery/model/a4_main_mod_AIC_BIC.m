
addpath('../../../8_fitmodel/holly/')
data_fol = '../../../../data/';
sim_fol=strcat(data_fol, 'sim_model_recov/');

n_sim = 100;
n_models = 16;

for sim_model = 1:12
        
    disp('------------------------------------------------')
    disp(strcat('sim model:', num2str(sim_model)))

    % variables
    model = strcat('mod',num2str(sim_model),'_normal');
    
    % simulation dir
    sim_mod_fol = strcat(sim_fol,model,'/n_sim_',num2str(n_sim), '/');

    all_BIC_mat = nan(n_sim,n_models);
    all_AIC_mat = nan(n_sim,n_models);
    all_LL_mat = nan(n_sim,n_models);

    for n_=1:n_sim
        
        %if ~(sim_model==6 && n_==49) && ~(sim_model==10 && n_==90)

        res_file = strcat(sim_mod_fol,'results/all_mod_',num2str(n_),'.mat');

        if exist(res_file)

            tmp = load(res_file);

            for n_mod = 1:size(tmp.all_mod_fit,2) % SHOULD BE 1
                
                if ~isempty(tmp.all_mod_fit(n_mod).mEmle)
                    
                    %disp(strcat('recov model:', num2str(n_mod)))
                    %disp(strcat('N params:', num2str(size(tmp.all_mod_fit(n_mod).mEparams,2))))

                    all_BIC_mat(n_, n_mod) = 2*tmp.all_mod_fit(n_mod).mEmle + log(400).*size(tmp.all_mod_fit(n_mod).mEparams,2);

                    all_AIC_mat(n_, n_mod) = 2*tmp.all_mod_fit(n_mod).mEmle + 2*size(tmp.all_mod_fit(n_mod).mEparams,2);

                    all_LL_mat(n_, n_mod) = -tmp.all_mod_fit(n_mod).mEmle;
                
                end

            end

        end
        
        %end %rm

    end
    
    if exist(strcat(sim_mod_fol,'results/'))
        
        save(strcat(sim_mod_fol,'results/all_BIC_mat.mat'), 'all_BIC_mat');
        save(strcat(sim_mod_fol,'results/all_AIC_mat.mat'), 'all_AIC_mat');
        save(strcat(sim_mod_fol,'results/all_LL_mat.mat'), 'all_LL_mat');
    
    end

end
