clear;

load('../usermat_completed.mat')

%load('../../data/questionnaire/all/RT_quest_all.mat');
%load('../../data/questionnaire/all/RT_quest_desc.mat');
load('../../data/questionnaire/all/TotTimeSec_all.mat');
load('../../data/questionnaire/all/CheckPassedPerc_all.mat');

raw_fol = ('../../data/raw/');

%disp('----------------------')

for i=1:length(usermat_completed)
    
    userID = usermat_completed(i);
    
    % user
    disp(['userID:', 32, num2str(userID)])
    
    % questionnaire checks
    %disp(['Checks:', 32, num2str(CheckPassedPerc_all(i)*100), '%'])
    
    % total time
    time_interval_in_hours(i) = TotTimeSec_all(i)/3600;
    %disp(['Time (h):', 32, num2str(time_interval_in_hours(i))])
    
    % questions no
    questionsfolder = dir(strcat(raw_fol, 'user_', num2str(userID), '/questions/*.xls'));
    %disp(['Questions Repeat:', 32, num2str(size(questionsfolder,1))])   
    questions_repeat_all(i) = size(questionsfolder,1);
    
    % training no
    trainingfolder = dir(strcat(raw_fol, 'user_', num2str(userID), '/training/*.xls'));
    %disp(['Training Repeat:', 32, num2str(size(trainingfolder,1))])   
    training_repeat_all(i) = size(trainingfolder,1);
    
    % task info request
    load(strcat('../../data/concat_data/user_',num2str(userID),'.mat'))
    %disp(['Info request:', 32, num2str(user.log(1,19))])
    info_request_all(i) = user.log(1,19);

    % task RT
    load(strcat('../../data/sanity_check/user_',num2str(userID),'/RT_all_1st_trial_SH.mat'))
    load(strcat('../../data/sanity_check/user_',num2str(userID),'/RT_all_1st_trial_LH.mat'))
    task_RT = [RT_all_1st_trial_SH, RT_all_1st_trial_LH];
    mean_RT = mean([RT_all_1st_trial_SH; RT_all_1st_trial_LH]);
    %disp(['task_RT:', 32, num2str(mean_RT), 'ms'])
    task_RT_1st_in_sec(i) = mean_RT/1000;

    % pressed key
    load(strcat('../../data/sanity_check/user_',num2str(userID),'/pressed_key_all.mat'))
    a = unique(pressed_key_all);
    pressed_freq = [a,histc(pressed_key_all(:),a)]; % count occurence
    pressed_freq(:,end+1) = pressed_freq(:,2)./sum(pressed_freq(:,2));
    %disp(['pressed_freq= key1: ', 32, num2str(pressed_freq(1,3)), 32, '%', 32, 'key2: ', 32, num2str(pressed_freq(2,3)), 32, '%', 32, 'key3: ', 32, num2str(pressed_freq(3,3)), 32, '%'])
    pressed_freq_all(i,:) = pressed_freq(:,3)';

    % bandits
    load(strcat('../../data/sanity_check/user_',num2str(userID),'/hist_all.mat'))

    % task picked A
    picked_A_SH = size(find(hist_all_mat(1,:)==1),2);
    picked_A_LH = size(find(hist_all_mat(2,:)==1),2);
    picked_A = picked_A_SH + picked_A_LH;
    %disp(['A picked:', 32, num2str(picked_A/400*100), '%'])
    picked_A_mat(i) = picked_A/400*100;
    
    % task picked B
    picked_B_SH = size(find(hist_all_mat(1,:)==2),2);
    picked_B_LH = size(find(hist_all_mat(2,:)==2),2);
    picked_B = picked_B_SH + picked_B_LH;
    %disp(['B picked:', 32, num2str(picked_B/400*100), '%'])
    picked_B_mat(i) = picked_B/400*100;
    
    % task picked D
    picked_D_SH = size(find(hist_all_mat(1,:)==4),2);
    picked_D_LH = size(find(hist_all_mat(2,:)==4),2);
    picked_D = picked_D_SH + picked_D_LH;
    %disp(['D picked:', 32, num2str(picked_D/400*100), '%'])
    picked_D_mat(i) = picked_D/400*100;
    
    % task picked C
    picked_C_SH = size(find(hist_all_mat(1,:)==3),2);
    picked_C_LH = size(find(hist_all_mat(2,:)==3),2);
    picked_C = picked_C_SH + picked_C_LH;
    %disp(['C picked:', 32, num2str(picked_C/400*100), '%'])
    picked_C_mat(i) = picked_C/400*100;
    
    disp('----------------------')
    
end

%%%%% Exclusion
exclusion_criteria(:,1) = usermat_completed; 

% Attention checks (less than 90%)
exclusion_criteria(:,2) = CheckPassedPerc_all<0.9;

% Total time (more than 2.5 hours)
exclusion_criteria(:,3) = time_interval_in_hours>2.5;

% Questions repeated (more than 5 times)
exclusion_criteria(:,4) = questions_repeat_all>5;

% Training repeated (more than 5 times)
exclusion_criteria(:,5) = training_repeat_all>5;

% RT on task (less than 1 second)
exclusion_criteria(:,6) = task_RT_1st_in_sec<1;

% Pressed key (one key pressed more than 50% of the time)
exclusion_criteria(:,7) = max(pressed_freq_all')'>0.5;

% Chosen bandit (A, B, C, D chosen between 20 and 30% of the time)
exclusion_criteria(:,8) = ((picked_B_mat>20) .* (picked_B_mat<30)) .* ...
                            ((picked_D_mat>20) .* (picked_D_mat<30)) .* ...
                                ((picked_C_mat>20) .* (picked_C_mat<30)) .* ...
                                    ((picked_A_mat>20) .* (picked_A_mat<30));
% Final excluded or not
exclusion_criteria(:,9) = sum(exclusion_criteria(:,2:8),2);

exclusion_criteria_desc = {'user', 'CheckPassedPerc_all<0.9', 'time_interval_in_hours>2.5'...
                            'questions_repeat_all>5', 'training_repeat_all>5', 'task_RT_1st_in_sec<1'...
                            'max(pressed_freq_all)>0.5', 'bandit chosen 20-30% of time', 'sum'};

% Save
save('../../data/questionnaire/demographics/raw/exclusion_criteria_desc.mat', 'exclusion_criteria_desc')
save('../../data/questionnaire/demographics/raw/exclusion_criteria.mat', 'exclusion_criteria')
save('../../data/data_for_figs/task_RT_1st_in_sec.mat', 'task_RT_1st_in_sec')

% Remove the ones that failed attention checks
usermat_completed_attentive = exclusion_criteria(find(exclusion_criteria(:,2)==0),1)';
save('../usermat_completed_attentive.mat', 'usermat_completed_attentive')

% Figures
addpath('../../export_fig')

% % RT on questionnaires
% figure('Color','w');
% set(gcf,'Unit','centimeters','OuterPosition',[0 0 20 20]);
% set(gca,'FontName','Arial','FontSize',10)
% hold on
% 
% for q_num = 1:8
%     subplot(4,2,q_num)
%     plot(RT_quest_all(:,q_num)/(1000*60), 'o')
%     grid on;
%     xlim([0 length(usermat_completed)+1])
%     xticks(1:1:length(usermat_completed))
%     xticklabels(usermat_completed)
%     xlabel('user')
%     ylabel('time (min)')
%     title(RT_quest_desc(q_num))
% end
% 
% export_fig(['Fig_time_questionnaires.tif'],'-nocrop','-r200')

col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

%%%%% Time plot

% time_interval_in_hours = time_interval_in_hours(2:end); % remove user 2

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

n = size(time_interval_in_hours,2);

noise_plot = (rand(1,n)-0.5)/5;

% mean
bar_plot = bar(1,nanmean(time_interval_in_hours), 'FaceAlpha', 1, 'BarWidth',.5, 'FaceColor',col_(1,:)); hold on;

% individual dots
plot(ones(1,n)+noise_plot, time_interval_in_hours,'.','MarkerSize',5,'MarkerEdgeColor',col_(2,:));

% variance
h = errorbar(1,[nanmean(time_interval_in_hours)],...
    [nanstd(time_interval_in_hours)./sqrt(n)],'.','color','k');
set(h,'Marker','none')

% parameters
ylim([0 3])
ylabel('Time (hours)')
xticks('')
xlim([1-0.75 1+0.75])   

export_fig(['Fig_time_all.tif'],'-nocrop','-r200')

save('../../data/data_for_figs/time_interval_in_hours.mat','time_interval_in_hours')

%%%%% RT task plot

%task_RT_all = task_RT_1st_in_sec; 
 
% figure('Color','w');
% set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
% set(gca,'FontName','Arial','FontSize',10)
% hold on
% 
% n = size(task_RT_all,2);
% 
% noise_plot = (rand(1,n)-0.5)/5;
% 
% % mean
% bar_plot = bar(1,nanmean(task_RT_all), 'FaceAlpha', 1, 'BarWidth',.5, 'FaceColor',col_(1,:)); hold on;
% 
% % individual dots
% plot(ones(1,n)+noise_plot, task_RT_all,'.','MarkerSize',2,'MarkerEdgeColor',col_(2,:));
% 
% % variance
% h = errorbar(1,[nanmean(task_RT_all)],...
%     [nanstd(task_RT_all)./sqrt(n)],'.','color','k');
% set(h,'Marker','none')
% 
% % parameters
% xlim([1-0.75 1+0.75])   
% % ylim([0 ceil(max(task_RT_all))])
% ylim([0 7])
% ylabel('Time (seconds)')
% xticks('')
% 
% export_fig(['Fig_RT_all.tif'],'-nocrop','-r200')
 
