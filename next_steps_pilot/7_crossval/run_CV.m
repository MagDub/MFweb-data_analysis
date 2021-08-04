
close all;

model = 0;
mod = [];

load('../usermat_completed_task.mat')
participant_list=usermat_completed_task;

%% Models

%%%%%%%%%%%%
% Thompson %
%%%%%%%%%%%%
% 9
model = model + 1;
mod.file_name{model} = '../../data/crossval/mod_9/results/aver_prob_';
mod.model_type{model} = 'thompson';
mod.name{model} = 'thompson2params1Hor';
mod.legend{model} = 'thompson';
%%%%%
% 10
model = model + 1;
mod.file_name{model} = '../../data/crossval/mod_10/results/aver_prob_';
mod.model_type{model} = 'thompson';
mod.name{model} = 'thompson3params2Hor';
mod.legend{model} = 'thompson + \epsilon'; 
%%%%%
% 11
model = model + 1;
mod.file_name{model} = '../../data/crossval/mod_11/results/aver_prob_';
mod.model_type{model} = 'thompson';
mod.legend{model} = 'thompson + \eta';
%%%%%
% 12
model = model + 1;
mod.file_name{model} = '../../data/crossval/mod_12/results/aver_prob_';
mod.model_type{model} = 'thompson';
mod.name{model} = 'thompson3params2Hor2novQ01';
mod.legend{model} = 'thompson + \eta + \epsilon';

%%%%%%%
% UCB %
%%%%%%%
% 5
model = model + 1;
mod.file_name{model} = '../../data/crossval/mod_5/results/aver_prob_';
mod.model_type{model} = 'UCB';
mod.name{model} = 'UCB2params2Hor';
mod.legend{model} = 'UCB';
%%%
% 6
model = model + 1;
mod.file_name{model} = '../../data/crossval/mod_6/results/aver_prob_';
mod.model_type{model} = 'UCB';
mod.name{model} = 'UCB2params2Hor';
mod.legend{model} = 'UCB + \eta';
%%%%
% 7
model = model + 1;
mod.file_name{model} = '../../data/crossval/mod_7/results/aver_prob_';
mod.model_type{model} = 'UCB';
mod.name{model} = 'UCB3params2Hor';
mod.legend{model} = 'UCB + \epsilon';
%%%%
% 8
model = model + 1;
mod.file_name{model} = '../../data/crossval/mod_8/results/aver_prob_';
mod.model_type{model} = 'UCB';
mod.name{model} = 'UCBnoveltybonus3params2Hor2nov';
mod.legend{model} = 'UCB + \eta + \epsilon'; 

%%%%%%%%%%
% HYBRID %
%%%%%%%%%%
% 1
model = model + 1;
mod.file_name{model} = '../../data/crossval/mod_1/results/aver_prob_';
mod.model_type{model} = 'hybrid';
mod.name{model} = 'hybrid4params2Hor1w';
mod.legend{model} = 'hybrid'; 
%%%%%%
% 2
model = model + 1;
mod.file_name{model} = '../../data/crossval/mod_2/results/aver_prob_';
mod.model_type{model} = 'hybrid';
mod.name{model} = 'hybrid5params2Hor1w';
mod.legend{model} = 'hybrid + \epsilon';
%%%%%
% 3
model = model + 1;
mod.file_name{model} = '../../data/crossval/mod_3/results/aver_prob_';
mod.model_type{model} = 'hybrid';
mod.name{model} = 'hybridnovboth4params2Hor1w';
mod.legend{model} = 'hybrid + \eta'; 
%%%%%
% 4
model = model + 1;
mod.file_name{model} = '../../data/crossval/mod_4/results/aver_prob_';
mod.model_type{model} = 'hybrid';
mod.name{model} = 'hybridnovboth4paramsxi2Hor2nov';
mod.legend{model} = 'hybrid + \eta + \epsilon'; 

%% Plotting  
average_prob_mat = [];
mean_all=nan(1,12);
mean_all_pp=nan(length(participant_list),12);
stderror_all=nan(1,12);
number_par_all=zeros(1,12);

for model = 1:size(mod.file_name,2)
    
    dirData = dir(strcat(mod.file_name{model},'*.mat'));
    
    n_part_for_model = size(dirData,1);
    
    tmp_part = [];
    
    for i = 1:n_part_for_model
        if model<5 % thompson
            tmp_part(end + 1) = str2num(dirData(i).name(20:end-4));
        elseif model<9 %UCB
            tmp_part(end + 1) = str2num(dirData(i).name(15:end-4));
        else %hybrid
            tmp_part(end + 1) = str2num(dirData(i).name(18:end-4));
        end
    end
    
    tmp_part = sort(tmp_part);
            
    mod.participant_list{model} = tmp_part;
    mod.number_par{model} = size(tmp_part,2);
    
    average_prob_mat = nan(size(usermat_completed_task,2),10);
    
    for ID_ind = 1:size(usermat_completed_task,2)%n_part_for_model
        
        average_prob = nan(1,10);
        
        ID = usermat_completed_task(ID_ind);
        f_name = strcat(mod.file_name{model}, mod.model_type{model},'_',int2str(ID),'.mat');
        
        if exist(f_name)==2
            load(f_name);
        end
        
        average_prob_mat(ID_ind,:) = average_prob;
    end
        
    disp(strcat('participants for model', 32, int2str(model), 32,mod.legend{model}, 32, '=', 32, int2str(mod.number_par{model}),32,'selected =',32,int2str(size(average_prob_mat,1))));
        
    mean_av_prob = nanmean(average_prob_mat,2); % average over k iterations
    
    mod.mean_pp{model} = mean_av_prob;

    
    clear mean_av_prob
    
end

for model = 1:12
    
    legend_all{model} = mod.legend{model};
    
    for ID = 1:size(usermat_completed_task,2)
        
        tmp_ = mod.mean_pp{model};
        
        mean_all_pp(ID, model) = tmp_(ID);
        
    end
end

% mean_all_pp(4,:) = nan(1,12);
% mean_all_pp(32,:) = nan(1,12);
% mean_all_pp(36,:) = nan(1,12);
% 
% for model = 1:12
%     
%     mod.mean_all{model} = nanmean(mean_all_pp(:,model));
%     mod.stderror_all{model} = nanstd(mean_all_pp(:,model)) / sqrt(mod.number_par{model});
%     
%     mean_all(model) = mod.mean_all{model};
%     stderror_all(model) = mod.stderror_all{model};
%     
%     number_par_all(model) = mod.number_par{model};
%     
% end

save('../../data/data_for_figs/mod.mat', 'mod')
save('../../data/data_for_figs/mean_all_pp.mat', 'mean_all_pp')