
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
model = model+1;
mod.file_name{model} = '../../data/crossval/mod_9/results/aver_prob_';
mod.model_type{model} = 'thompson';
mod.name{model} = 'thompson2params1Hor';
mod.legend{model} = 'thompson';
%%%%%
% 10
model = model+1;
mod.file_name{model} = '../../data/crossval/mod_10/results/aver_prob_';
mod.model_type{model} = 'thompson';
mod.name{model} = 'thompson3params2Hor';
mod.legend{model} = 'thompson+xi'; 
%%%%%
% 11
model = model+1;
mod.file_name{model} = '../../data/crossval/mod_11/results/aver_prob_';
mod.model_type{model} = 'thompson';
mod.legend{model} = 'thompson+nov';
%%%%%
% 12
model = model+1;
mod.file_name{model} = '../../data/crossval/mod_12/results/aver_prob_';
mod.model_type{model} = 'thompson';
mod.name{model} = 'thompson3params2Hor2novQ01';
mod.legend{model} = 'thompson+nov+xi';

%%%%%%%
% UCB %
%%%%%%%
% 5
model = model+1;
mod.file_name{model} = '../../data/crossval/mod_5/results/aver_prob_';
mod.model_type{model} = 'UCB';
mod.name{model} = 'UCB2params2Hor';
mod.legend{model} = 'UCB';
%%%
% 6
model = model+1;
mod.file_name{model} = '../../data/crossval/mod_6/results/aver_prob_';
mod.model_type{model} = 'UCB';
mod.name{model} = 'UCB2params2Hor';
mod.legend{model} = 'UCB+nov';
%%%%
% 7
model = model+1;
mod.file_name{model} = '../../data/crossval/mod_7/results/aver_prob_';
mod.model_type{model} = 'UCB';
mod.name{model} = 'UCB3params2Hor';
mod.legend{model} = 'UCB+xi';
%%%%
% 8
model = model+1;
mod.file_name{model} = '../../data/crossval/mod_8/results/aver_prob_';
mod.model_type{model} = 'UCB';
mod.name{model} = 'UCBnoveltybonus3params2Hor2nov';
mod.legend{model} = 'UCB+nov+xi'; 

%%%%%%%%%%
% HYBRID %
%%%%%%%%%%
% 1
model = model+1;
mod.file_name{model} = '../../data/crossval/mod_1/results/aver_prob_';
mod.model_type{model} = 'hybrid';
mod.name{model} = 'hybrid4params2Hor1w';
mod.legend{model} = 'hybrid'; 
%%%%%%
% 2
model = model+1;
mod.file_name{model} = '../../data/crossval/mod_2/results/aver_prob_';
mod.model_type{model} = 'hybrid';
mod.name{model} = 'hybrid5params2Hor1w';
mod.legend{model} = 'hybrid+xi';
%%%%%
% 3
model = model+1;
mod.file_name{model} = '../../data/crossval/mod_3/results/aver_prob_';
mod.model_type{model} = 'hybrid';
mod.name{model} = 'hybridnovboth4params2Hor1w';
mod.legend{model} = 'hybrid+nov'; 
%%%%%
% 4
model = model+1;
mod.file_name{model} = '../../data/crossval/mod_4/results/aver_prob_';
mod.model_type{model} = 'hybrid';
mod.name{model} = 'hybridnovboth4paramsxi2Hor2nov';
mod.legend{model} = 'hybrid+nov+xi'; 

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
            tmp_part(end+1) = str2num(dirData(i).name(20:end-4));
        elseif model<9 %UCB
            tmp_part(end+1) = str2num(dirData(i).name(15:end-4));
        else %hybrid
            tmp_part(end+1) = str2num(dirData(i).name(18:end-4));
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
        
    mean_av_prob = nanmean(average_prob_mat,2); 
    
    mod.mean_pp{model} = mean_av_prob;
    mod.mean_all{model} = nanmean(mean_av_prob);
    mod.stderror_all{model} = nanstd(mean_av_prob) / sqrt(mod.number_par{model});
    
    clear mean_av_prob

    mean_all(model) = mod.mean_all{model};
    stderror_all(model) = mod.stderror_all{model};
    number_par_all(model) = mod.number_par{model};
    
end

for model = 1:12
    
    legend_all{model} = mod.legend{model};
    
    for ID = 1:number_par_all(model)
        
        tmp_ = mod.mean_pp{model};
        
        mean_all_pp(ID, model) = tmp_(ID);
        
    end
end

% % Check that all models have the same number of participants
% model_cv = [mod.participant_list{1} mod.mean_pp{1}...
%                                         mod.mean_pp{2}... 
%                                         mod.mean_pp{3}...
%                                         mod.mean_pp{4}...
%                                         mod.mean_pp{5}...
%                                         mod.mean_pp{6}...
%                                         mod.mean_pp{7}...
%                                         mod.mean_pp{8}...
%                                         mod.mean_pp{9}...
%                                         mod.mean_pp{10}...
%                                         mod.mean_pp{11}...
%                                         mod.mean_pp{12}...
%                                         ];
%                                     
% model_cv_desc = [{'ID'}, {'model1_mean'}, {'model2_mean'}, {'model3_mean'}, {'model4_mean'}, {'model5_mean'}, {'model6_mean'}, ...
%     {'model7_mean'}, {'model8_mean'}, {'model9_mean'}, {'model10_mean'}, {'model11_mean'}, {'model12_mean'}];
                                    
% save('D:\writing\MF_dev\data_for_figs\model_cv.mat', 'model_cv');
% save('D:\writing\MF_dev\data_for_figs\model_cv_desc.mat', 'model_cv_desc');

figure()

col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];


x = [1:4 6:9 11:14];

I = 1:1:size(mean_all,2); 

bar(x,mean_all(I)*100,'FaceColor',col_(1,:), 'FaceAlpha', 1); hold on;

% data points
plot(x.*ones(65,1), mean_all_pp*100,'.','MarkerEdgeColor',col_(2,:), 'MarkerSize',4); hold on;

er = errorbar(x,mean_all(I)*100,stderror_all(I)*100,stderror_all(I)*100);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
title('10-fold crossvalidation performance per model')
ylabel('Average performance accuracy [%]')
yrange = [53 55]; grid on;
% yrange = [min(min(mean_all_pp*100)) max(max(mean_all_pp*100))];
ylim(yrange)
xticks(x)
xticklabels(legend_all(I));
xtickangle(45)

for i1=1:numel(mean_all)
    text(x(i1),yrange(1)+0.01*100,num2str(number_par_all(I(i1))),...
               'HorizontalAlignment','center',...
               'VerticalAlignment','bottom')
   text(x(i1),yrange(1)+0.025*100,'n= ',...
               'HorizontalAlignment','center',...
               'VerticalAlignment','bottom')
end

hold off


%save('D:/MaggiesFarm/modeling_05_07_developmental/crossval/model_selection_mat.mat', 'mod')