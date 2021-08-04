
close all;

n_model = 0;
mod = [];

load('../usermat_completed.mat')
participant_list=usermat_completed;

% Models

%%%%%%%%%%%%
% Thompson %
%%%%%%%%%%%%
% 9
n_model = n_model + 1;
mod.number{n_model} = 'mod9';
mod.file_name{n_model} = '../../data/modelfit/mod9/results/res_';
mod.model_type{n_model} = 'thompson';
mod.legend{n_model} = 'thompson';
%%%%%
% 10
n_model = n_model + 1;
mod.number{n_model} = 'mod10';
mod.file_name{n_model} = '../../data/modelfit/mod10/results/res_';
mod.model_type{n_model} = 'thompson';
mod.legend{n_model} = 'thompson + \epsilon'; 
%%%%%
% 11
n_model = n_model + 1;
mod.number{n_model} = 'mod11';
mod.file_name{n_model} = '../../data/modelfit/mod11/results/res_';
mod.model_type{n_model} = 'thompson';
mod.legend{n_model} = 'thompson + \eta';
%%%%%
% 12
n_model = n_model + 1;
mod.number{n_model} = 'mod12';
mod.file_name{n_model} = '../../data/modelfit/mod12/results/res_';
mod.model_type{n_model} = 'thompson';
mod.legend{n_model} = 'thompson + \eta + \epsilon';

%%%%%%%
% UCB %
%%%%%%%
% 5
n_model = n_model + 1;
mod.number{n_model} = 'mod5';
mod.file_name{n_model} = '../../data/modelfit/mod5/results/res_';
mod.model_type{n_model} = 'UCB';
mod.legend{n_model} = 'UCB';
%%%
% 6
n_model = n_model + 1;
mod.number{n_model} = 'mod6';
mod.file_name{n_model} = '../../data/modelfit/mod6/results/res_';
mod.model_type{n_model} = 'UCB';
mod.legend{n_model} = 'UCB + \epsilon';
%%%%
% 7
n_model = n_model + 1;
mod.number{n_model} = 'mod7';
mod.file_name{n_model} = '../../data/modelfit/mod7/results/res_';
mod.model_type{n_model} = 'UCB';
mod.legend{n_model} = 'UCB + \eta';
%%%%
% 8
n_model = n_model + 1;
mod.number{n_model} = 'mod8';
mod.file_name{n_model} = '../../data/modelfit/mod8/results/res_';
mod.model_type{n_model} = 'UCB';
mod.legend{n_model} = 'UCB + \epsilon + \eta'; 
 
%%%%%%%%%%
% HYBRID %
%%%%%%%%%%
% 1
n_model = n_model + 1;
mod.number{n_model} = 'mod1';
mod.file_name{n_model} = '../../data/modelfit/mod1/results/res_';
mod.model_type{n_model} = 'hybrid';
mod.legend{n_model} = 'hybrid'; 
%%%%%%
% 2
n_model = n_model + 1;
mod.number{n_model} = 'mod2';
mod.file_name{n_model} = '../../data/modelfit/mod2/results/res_';
mod.model_type{n_model} = 'hybrid';
mod.legend{n_model} = 'hybrid + \epsilon';
%%%%%
% 3
n_model = n_model + 1;
mod.number{n_model} = 'mod3';
mod.file_name{n_model} = '../../data/modelfit/mod3/results/res_';
mod.model_type{n_model} = 'hybrid';
mod.legend{n_model} = 'hybrid + \eta'; 
%%%%%
% 4
n_model = n_model + 1;
mod.number{n_model} = 'mod4';
mod.file_name{n_model} = '../../data/modelfit/mod4_newB/results/res_';
mod.model_type{n_model} = 'hybrid';
mod.legend{n_model} = 'hybrid + \eta + \epsilon'; 

%%%%%%%%%%%%%%%
% UCB TAU=1 %
%%%%%%%%%%%%%%%
% 13
n_model = n_model + 1;
mod.number{n_model} = 'mod5_t1';
mod.file_name{n_model} = '../../data/modelfit/mod5_t1/results/res_';
mod.model_type{n_model} = 'UCB';
mod.legend{n_model} = 'UCB'; 
% 14
n_model = n_model + 1;
mod.number{n_model} = 'mod6_t1';
mod.file_name{n_model} = '../../data/modelfit/mod6_t1/results/res_';
mod.model_type{n_model} = 'UCB';
mod.legend{n_model} = 'UCB'; 
% 15
n_model = n_model + 1;
mod.number{n_model} = 'mod7_t1';
mod.file_name{n_model} = '../../data/modelfit/mod7_t1/results/res_';
mod.model_type{n_model} = 'UCB';
mod.legend{n_model} = 'UCB'; 
% 16
n_model = n_model + 1;
mod.number{n_model} = 'mod8_t1';
mod.file_name{n_model} = '../../data/modelfit/mod8_t1/results/res_';
mod.model_type{n_model} = 'UCB';
mod.legend{n_model} = 'UCB'; 

%%%%%
% 17
n_model = n_model + 1;
mod.number{n_model} = 'mod12_etaB';
mod.file_name{n_model} = '../../data/modelfit/mod12_etaB/results/res_';
mod.model_type{n_model} = 'thompson';
mod.legend{n_model} = 'thompson + \eta + \eta_B + \epsilon';


%%%%%%%%%%%%%%%%%%%%%
% Plotting  
mle_mat = [];
mean_all_pp=nan(length(participant_list),n_model);
number_par_all=zeros(1,n_model);

mle_mat_all = nan(size(usermat_completed,2),n_model);

for model = 1:n_model
    
    dirData = dir(strcat(mod.file_name{model},'*_results.mat'));
    
    n_part_for_model = size(dirData,1);
    
    tmp_part = [];
    
    for i = 1:n_part_for_model
        if model<5 || model == 17 % thompson
            tmp_part(end + 1) = str2num(dirData(i).name(14:end-12));
        elseif model<9 || model>12 %UCB
            tmp_part(end + 1) = str2num(dirData(i).name(9:end-12));
        else %hybrid
            tmp_part(end + 1) = str2num(dirData(i).name(12:end-12));
        end
    end
    
    tmp_part = sort(tmp_part);
            
    mod.participant_list{model} = tmp_part;
    mod.number_par{model} = size(tmp_part,2);
    
    mle_mat = nan(size(usermat_completed,2),1);
        
    for ID_ind = 1:size(usermat_completed,2)%n_part_for_model
                
        ID = usermat_completed(ID_ind);
        f_name = strcat(mod.file_name{model}, mod.model_type{model},'_',int2str(ID),'_results.mat');
        
        if exist(f_name)==2
            
            load(f_name);
            
            mle_mat(ID_ind,:) = mEmle;
       
        end
   
    end
    
    %%% Missing
    missingUsers=[];
    for i = 1:size(usermat_completed,2)
       tmp_id=usermat_completed(i);
       if isempty(find(tmp_part==tmp_id))
           missingUsers(end+1)=tmp_id;
       end
    end
    
    mod.missing{model} = missingUsers;

    disp(strcat('participants for ', 32, mod.number{model},':', 32,mod.legend{model}, 32, '=', 32, int2str(mod.number_par{model}),',',32,'total =',32,int2str(size(mle_mat,1)), ',', 32, 'missingIDs =', 32, num2str(missingUsers)));
    
    mod.mle_mat{model} = mle_mat;
    
    mle_mat_all(:,model) = mle_mat;
    
    legend_all{model} = mod.legend{model};
       
end

ind_=[];
for i=1:size(missingUsers,2)
    ind_(end+1)=find(usermat_completed==missingUsers(i));
end
disp(ind_)

mle_mat_all_desc = {'mle_thompson', 'mle_thompson_eps', 'mle_thompson_eta', 'mle_thompson_eps_eta',...
        'mle_UCB', 'mle_UCB_eps', 'mle_UCB_eta', 'mle_UCB_eps_eta',...
        'mle_hybrid', 'mle_hybrid_eps', 'mle_hybrid_eta', 'mle_hybrid_eps_eta',...
        'mle_UCB_t1', 'mle_UCB_t1_eps', 'mle_UCB_t1_eta', 'mle_UCB_t1_eps_eta', 'mle_thompson_eps_eta_etaB'};
    
BIC_all_desc = {'BIC_thompson', 'BIC_thompson_eps', 'BIC_thompson_eta', 'BIC_thompson_eps_eta',...
        'BIC_UCB', 'BIC_UCB_eps', 'BIC_UCB_eta', 'BIC_UCB_eps_eta',...
        'BIC_hybrid', 'BIC_hybrid_eps', 'BIC_hybrid_eta', 'BIC_hybrid_eps_eta',...
        'BIC_UCB_t1', 'BIC_UCB_t1_eps', 'BIC_UCB_t1_eta', 'BIC_UCB_t1_eps_eta', 'BIC_thompson_eps_eta_etaB'};
    
BIC_all = 2*mle_mat_all + log(400).*[3, 5, 5, 7,    5, 7, 7, 9,     8, 10, 10, 12,      3, 5, 5, 7,    9];

save('mle_mat_all_t1_etaB.mat', 'mle_mat_all');
save('mle_mat_all_t1_etaB_desc.mat', 'mle_mat_all_desc');
save('../../data/data_for_figs/mle_mat_all_etaB_t1.mat', 'mle_mat_all');
save('../../data/data_for_figs/mle_mat_all_etaB_t1_desc.mat', 'mle_mat_all_desc');

save('../../data/data_for_figs/BIC_all_etaB.mat', 'BIC_all');
save('../../data/data_for_figs/BIC_all_etaB_desc.mat', 'BIC_all_desc');


