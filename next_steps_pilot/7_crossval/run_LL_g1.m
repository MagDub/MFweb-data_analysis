
close all;

n_model = 0;
mod = [];

load('../../data_analysis/usermat_completed.mat')
participant_list=usermat_completed;

% Models

%%%%%%%%%%%%
% Thompson %
%%%%%%%%%%%%
% 9
n_model = n_model + 1;
mod.file_name{n_model} = '../../data/modelfit/mod9/results/res_';
mod.model_type{n_model} = 'thompson';
mod.legend{n_model} = 'thompson';
%%%%%
% 10
n_model = n_model + 1;
mod.file_name{n_model} = '../../data/modelfit/mod10/results/res_';
mod.model_type{n_model} = 'thompson';
mod.legend{n_model} = 'thompson + \epsilon'; 
%%%%%
% 11
n_model = n_model + 1;
mod.file_name{n_model} = '../../data/modelfit/mod11/results/res_';
mod.model_type{n_model} = 'thompson';
mod.legend{n_model} = 'thompson + \eta';
%%%%%
% 12
n_model = n_model + 1;
mod.file_name{n_model} = '../../data/modelfit/mod12/results/res_';
mod.model_type{n_model} = 'thompson';
mod.legend{n_model} = 'thompson + \eta + \epsilon';

%%%%%%%
% UCB %
%%%%%%%
% 5
n_model = n_model + 1;
mod.file_name{n_model} = '../../data/modelfit/mod5/results/res_';
mod.model_type{n_model} = 'UCB';
mod.legend{n_model} = 'UCB';
%%%
% 6
n_model = n_model + 1;
mod.file_name{n_model} = '../../data/modelfit/mod6/results/res_';
mod.model_type{n_model} = 'UCB';
mod.legend{n_model} = 'UCB + \epsilon';
%%%%
% 7
n_model = n_model + 1;
mod.file_name{n_model} = '../../data/modelfit/mod7/results/res_';
mod.model_type{n_model} = 'UCB';
mod.legend{n_model} = 'UCB + \eta';
%%%%
% 8
n_model = n_model + 1;
mod.file_name{n_model} = '../../data/modelfit/mod8_newB/results/res_';
mod.model_type{n_model} = 'UCB';
mod.legend{n_model} = 'UCB + \epsilon + \eta'; 
 
%%%%%%%%%%
% HYBRID %
%%%%%%%%%%
% 1
n_model = n_model + 1;
mod.file_name{n_model} = '../../data/modelfit/mod1/results/res_';
mod.model_type{n_model} = 'hybrid';
mod.legend{n_model} = 'hybrid'; 
%%%%%%
% 2
n_model = n_model + 1;
mod.file_name{n_model} = '../../data/modelfit/mod2/results/res_';
mod.model_type{n_model} = 'hybrid';
mod.legend{n_model} = 'hybrid + \epsilon';
%%%%%
% 3
n_model = n_model + 1;
mod.file_name{n_model} = '../../data/modelfit/mod3/results/res_';
mod.model_type{n_model} = 'hybrid';
mod.legend{n_model} = 'hybrid + \eta'; 
%%%%%
% 4
n_model = n_model + 1;
mod.file_name{n_model} = '../../data/modelfit/mod4/results/res_';
mod.model_type{n_model} = 'hybrid';
mod.legend{n_model} = 'hybrid + \eta + \epsilon'; 

%%%%%%%%%%%%%%%
% UCB GAMMA=1 %
%%%%%%%%%%%%%%%
% 13
n_model = n_model + 1;
mod.file_name{n_model} = '../../data/modelfit/mod5_g1/results/res_';
mod.model_type{n_model} = 'UCB';
mod.legend{n_model} = 'UCB'; 
% 14
n_model = n_model + 1;
mod.file_name{n_model} = '../../data/modelfit/mod6_g1/results/res_';
mod.model_type{n_model} = 'UCB';
mod.legend{n_model} = 'UCB'; 
% 15
n_model = n_model + 1;
mod.file_name{n_model} = '../../data/modelfit/mod7_g1/results/res_';
mod.model_type{n_model} = 'UCB';
mod.legend{n_model} = 'UCB'; 
% 16
n_model = n_model + 1;
mod.file_name{n_model} = '../../data/modelfit/mod8_g1/results/res_';
mod.model_type{n_model} = 'UCB';
mod.legend{n_model} = 'UCB'; 



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
        if model<5 % thompson
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
        
    disp(strcat('participants for model', 32, int2str(model), 32,mod.legend{model}, 32, '=', 32, int2str(mod.number_par{model}),32,'selected =',32,int2str(size(mle_mat,1))));
           
    mod.mle_mat{model} = mle_mat;
    
    mle_mat_all(:,model) = mle_mat;
    
    legend_all{model} = mod.legend{model};
       
end



save('mle_mat_all_g1.mat', 'mle_mat_all');
save('../../data/data_for_figs/mle_mat_all_g1.mat', 'mle_mat_all');


